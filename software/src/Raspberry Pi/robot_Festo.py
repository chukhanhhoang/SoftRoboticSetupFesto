import multiprocessing
import time
from baseSoftrobot import baseSoftRobot, baseSensor
import numpy as np

from adafruit_extended_bus import ExtendedI2C as I2C
import adafruit_mcp4725
import adafruit_ads1x15.ads1015 as ADS
from adafruit_ads1x15.analog_in import AnalogIn
from adafruit_ads1x15.ads1x15 import Mode
from adafruit_mprls import MPRLS

## IMU
import RTIMU
import os.path
import math
import sys

# RATE = 3300

class PressureSensor(baseSensor):
    def __init__(self, i2c=1):
        MPR = MPRLS(I2C(i2c), psi_min=0, psi_max=25)
        super().__init__(MPR)
    def readSensor(self):
        return self.instance.pressure

class VeabSensor(baseSensor):
    def __init__(self, i2c=1, address=(0x48),RATE = 490):
        ads = ADS.ADS1015(I2C(i2c),address=address)
        # ADC Configuration
        ads.mode = Mode.CONTINUOUS
        ads.data_rate = RATE
        ads.gain = 1
        chan = AnalogIn(ads, ADS.P0)
        super().__init__(chan)
    def readSensor(self):
        return self.instance.voltage*3

class SoftRobot(baseSoftRobot):
    def __init__(self,i2c=[5],sensorFreq = 250,motorFreq = 250,port = 8888):
        self.IMUadded = False
        self.port = port
        self.nSensors = len(i2c)
        self.channels = i2c
        self.sensor_frequency = sensorFreq
        self.sensor_period = 1.0/sensorFreq
        self.motor_frequency = motorFreq
        self.motor_period = 1.0/motorFreq
        ## Set up sensors
        self.sensorsValues = multiprocessing.Array('d',[0.0]*(self.nSensors))
        self.sensors = []
        for i in range(self.nSensors):
            self.sensors.append(VeabSensor(i2c=self.channels[i]))

        ## Set up actuators
        self.nMotors = len(i2c)
        self.motors = []
        for i in range(self.nMotors):
            self.motors.append(adafruit_mcp4725.MCP4725(I2C(self.channels[i]),address=0x60))
        self.motorsValues = multiprocessing.Array('d',[0.5]*self.nMotors)

        ## Call __init__ of the parent class (Set up multi-processes and TCP comm)
        super().__init__(self.nSensors, self.port)

    def addMPR(self,i2c = 1):
        if self.IMUadded == False:
            self.nSensors = self.nSensors+1
            self.sensors.append(PressureSensor())
            self.sensorsValues = multiprocessing.Array('d',[0.0]*(self.nSensors))
            super().__init__(self.nSensors, self.port)
            print("Adding one MPR sensor on I2C channel ", i2c)
        else:
            raise Exception("IMU added, cannot add pressure sensors.")

    def readIMU(self):
        ### IMU
        SETTINGS_FILE = "RTIMULib"

        print("Using settings file " + SETTINGS_FILE + ".ini")
        if not os.path.exists(SETTINGS_FILE + ".ini"):
            print("Settings file does not exist, will be created")

        s = RTIMU.Settings(SETTINGS_FILE)
        imu = RTIMU.RTIMU(s)

        print("IMU Name: " + imu.IMUName())

        if (not imu.IMUInit()):
            print("IMU Init Failed")
            sys.exit(1)
        else:
            print("IMU Init Succeeded")
        imu.setGyroEnable(True)
        imu.setAccelEnable(True)
        imu.setCompassEnable(False)

        poll_interval = imu.IMUGetPollInterval()
        print("Recommended Poll Interval: %dmS\n" % poll_interval)
        while not self.stopFlag.value:
            try:
                imu.IMURead()
                data = imu.getIMUData()
                fusionPose = data["fusionPose"]
                for i in range(3): ##get roll pitch yaw
                    self.sensorsValues[self.nSensors-1+i] = math.degrees(fusionPose[i])
                self.sensorsUpdated[self.nSensors-1] = True
                time.sleep(self.sensor_period - time.time() * self.sensor_frequency % 1 / self.sensor_frequency)
            except Exception as e:
                print('Error in IMU read: ',e)
                self.stopFlag.value = True

    def addIMU(self):
        self.sensorsValues = multiprocessing.Array('d',[0.0]*(self.nSensors+3))
        self.nSensors = self.nSensors+1
        super().__init__(self.nSensors, self.port)
        self.nSensorsToRead = self.nSensors - 1
        self.processes.append(multiprocessing.Process(target=self.readIMU))

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
        for i,p in enumerate(range(self.nMotors)):
            self.motors[p].normalized_value = 0.5

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
        self.resetActuators()