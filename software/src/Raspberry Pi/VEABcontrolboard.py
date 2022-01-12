from baseSoftrobot import baseSensor

from adafruit_extended_bus import ExtendedI2C as I2C
import adafruit_mcp4725
import adafruit_ads1x15.ads1015 as ADS
from adafruit_ads1x15.analog_in import AnalogIn
from adafruit_ads1x15.ads1x15 import Mode

class VeabSensor(baseSensor):
    def __init__(self, i2c, addr=(0x48),RATE = 490):
        ads = ADS.ADS1015(I2C(i2c),address=addr)
        # ADC Configuration
        ads.mode = Mode.CONTINUOUS
        ads.data_rate = RATE
        ads.gain = 2
        chan = AnalogIn(ads, ADS.P0)
        super().__init__(chan)
    def readSensor(self):
        return self.instance.voltage*5

# class VeabRegulator:
#     def __init__(self, i2c, addr=(0x60)):
#         self.mcp = adafruit_mcp4725.MCP4725(I2C(i2c),address=addr)
#         if addr == 0x60:
#             self.name = "Actuator 0"
#         else:
#             self.name = "Actuator 1"
    
#     def set_value(self,value):
#         print("Setting ", self.name, " to ",value)
#         self.mcp.normalized_value = value

class VEABcontrolboard:
    def __init__(self,i2c):
        ## ADC&DAC pair 0 and 1 addresses: 48&60 and 49&61
        # self.sensors = [VeabSensor(i2c,addr=0x48),VeabSensor(i2c,addr=0x49)]
        # self.actuators = [VeabRegulator(i2c, addr=0x60),VeabRegulator(i2c, addr=0x61)]
        self.sensors = [VeabSensor(i2c,addr=0x48),VeabSensor(i2c,addr=0x49)]
        self.actuators = [adafruit_mcp4725.MCP4725(I2C(i2c), address=0x60),adafruit_mcp4725.MCP4725(I2C(i2c), address=0x61)]