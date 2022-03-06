import RPi.GPIO as GPIO

class Valve:
    def __init__(self,pin):
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(pin, GPIO.OUT)
        self.pin = pin
        self._value = 0

    @property
    def normalized_value(self):
        return self._value

    @normalized_value.setter
    def normalized_value(self,value):
        tmp = round(value)
        if tmp >1 or tmp<0:
            raise("Value not accepted")
        else:
            self._value = tmp
            GPIO.output(self.pin, self._value)
            # print("Setting valve to ", tmp)