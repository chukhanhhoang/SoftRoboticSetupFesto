import multiprocessing
import time
from baseSoftrobot import baseSoftRobot
import numpy as np

from adafruit_extended_bus import ExtendedI2C as I2C
import adafruit_mcp4725
import adafruit_ads1x15.ads1015 as ADS
from adafruit_ads1x15.analog_in import AnalogIn
from adafruit_ads1x15.ads1x15 import Mode

RATE = 3300

class SoftRobot(baseSoftRobot):
    def __init__(self,i2c=[5],sensorFreq = 125,motorFreq = 250,port = 8888):
        self.nSensors = len(i2c)
        self.channels = i2c
        self.sensor_frequency = sensorFreq
        self.sensor_period = 1.0/sensorFreq
        self.motor_frequency = motorFreq
        self.motor_period = 1.0/motorFreq
        ## Set up sensors
        self.sensorsValues = multiprocessing.Array('d',[0.0]*self.nSensors)
        self.sensors = []
        for i in range(self.nSensors):
            ads = ADS.ADS1015(I2C(self.channels[i]))
            # ADC Configuration
            ads.mode = Mode.CONTINUOUS
            ads.data_rate = RATE
            ads.gain = 1
            chan = AnalogIn(ads, ADS.P0)
            self.sensors.append(chan)

        ## Set up actuators
        self.nMotors = self.nSensors
        self.motors = []
        for i in range(self.nMotors):
            self.motors.append(adafruit_mcp4725.MCP4725(I2C(self.channels[i]),address=0x60))
        self.motorsValues = multiprocessing.Array('d',[0.5]*self.nMotors)

        ## Call __init__ of the parent class (Set up multi-processes and TCP comm)
        super().__init__(self.nSensors, port)

    def readSensors(self,index):
        while not self.stopFlag.value:
            try:
                # now = time.time()
                # self.sensorsValues[index] = np.random.normal(1010,10)
                self.sensorsValues[index] = self.sensors[index].voltage*3
                self.sensorsUpdated[index] = True
                # print('Pressure at port ',self.channels[index],' is ',self.sensorsValues[index], ', at time ',now)
                time.sleep(self.sensor_period - time.time() * self.sensor_frequency % 1 / self.sensor_frequency)
            except Exception as e:
                print('Error in readSensors:',e)
                self.stopFlag.value = True

    def controlActuators(self):
        while not self.stopFlag.value:
            try:           
                # print(self.motorsValues[:])
                for i,p in enumerate(range(self.nMotors)):
                    self.motors[p].normalized_value = self.motorsValues[i]
                # print('Control motors at time ',time.time())
                time.sleep(self.motor_period - time.time() * self.motor_frequency % 1 / self.motor_frequency)
            except Exception as e:
                print('Error in control Actuators:',e)
                self.stopFlag.value = True