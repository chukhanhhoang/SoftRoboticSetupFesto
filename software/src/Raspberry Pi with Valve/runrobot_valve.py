import sys, getopt
from robot_valve  import SoftRobot
import numpy as np

def usage():
    print('Usage:\ntestFesto.py -i <[I2C channels]> -p <Port>\nOr\ntestFesto.py\nNow exiting...')

def main(argv):
    i2c = []
    try:
      opts, args = getopt.getopt(argv,"h:i:p:v:")
    except getopt.GetoptError as err:
        print(err)
        usage()
        sys.exit(2)
    if len(opts) == 0:
        print("No argument is passed.")
        usage()
        sys.exit(2)
    else:
        for opt, arg in opts:
            if opt in ("-h", "--help"):
                print('testFesto.py -i <[I2C channels]> -p <Port>\nOr\ntestFesto.py')
                sys.exit()
                
            if opt in ("-i", "--i2c"):
                arg_list = arg.split(',')
                int_converted = map(int, arg_list)
                i2c = list(int_converted)
                
            if opt in ("-p", "--port"):
                port = int(arg)

            if opt in ("-v", "--valve"):
                valve = int(arg)

    # print('Using I2C channels: ',i2c)
    print('Using port:',port)
    print('Using valve at pin:',valve)

    # exit()
    robot = SoftRobot(i2c=i2c,pin=valve,port=port)
    print(robot.nSensors," sensor(s) initialized")
    robot.waitForClient() # Can be called many times to connect more clients
    robot.createProcesses() # Initialize all the processes needed for I2C sensors, motors, TCP/IP comm
    robot.run() # Start the processes
    robot.waitForProcesses() # Wait for the processes to end
    robot.socket_TCP.close()

if __name__ == "__main__":
    main(sys.argv[1:])
