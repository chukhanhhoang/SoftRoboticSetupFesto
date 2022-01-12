import multiprocessing
import time
from baseSoftrobot import baseSoftRobot, baseSensor
import numpy as np

from VEABcontrolboard import VEABcontrolboard

class SoftRobot(baseSoftRobot):
    def __init__(self,i2c=[1],sensorFreq = 250,actuatorFreq = 250,port = 8888):
        self.IMUadded = False
        self.port = port
        # self.nSensors = len(i2c)
        self.channels = i2c
        self.sensor_frequency = sensorFreq
        self.sensor_period = 1.0/sensorFreq
        self.actuator_frequency = actuatorFreq
        self.actuator_period = 1.0/actuatorFreq
        ## Set up VEABboard(s)
        boards = [VEABcontrolboard(chan) for chan in self.channels]

        ## Set up sensors
        self.sensors = []
        for board in boards:
            self.sensors = self.sensors + board.sensors
        self.nSensors = len(self.sensors)
        self.sensorsValues = multiprocessing.Array('d',[0.0]*(self.nSensors))

        ## Set up actuators
        self.actuators = []
        for board in boards:
            self.actuators = self.actuators + board.actuators
        self.nActuators = len(self.actuators)
        self.actuatorsValues = multiprocessing.Array('d',[0.5]*self.nActuators)
        # print(self.actuators)
        ## Call __init__ of the parent class (Set up multi-processes and TCP comm)
        super().__init__(self.nSensors, self.port)

    def readSensors(self,index):
        while not self.stopFlag.value:
            try:
                self.sensorsValues[index] = self.sensors[index].readSensor()
                self.sensorsUpdated[index] = True
                # print('Pressure at port ',self.channels[index],' is ',self.sensorsValues[index], ', at time ',now)
                time.sleep(self.sensor_period - time.time() * self.sensor_frequency % 1 / self.sensor_frequency)
            except Exception as e:
                print('Error in readSensors:',e)
                self.stopFlag.value = True

    def resetActuators(self):
        for i,p in enumerate(range(self.nActuators)):
            self.actuators[p].set_value = 0.5

    def controlActuators(self):
        while not self.stopFlag.value:
            try:           
                # print(self.actuatorsValues[:])
                for i,p in enumerate(range(self.nActuators)):
                    self.actuators[p].normalized_value = self.actuatorsValues[i]
                # print('Control actuators at time ',time.time())
                time.sleep(self.actuator_period - time.time() * self.actuator_frequency % 1 / self.actuator_frequency)
            except Exception as e:
                print('Error in control Actuators:',e)
                self.stopFlag.value = True
        self.resetActuators()