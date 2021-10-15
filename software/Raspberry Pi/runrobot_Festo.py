import sys, getopt
from robot_Festo  import SoftRobot
import h5py
import numpy as np

def usage():
    print('Usage:\ntestFesto.py -i <[I2C channels]> -p <Port>\nOr\ntestFesto.py -f <Path to config file>\nNow exiting...')

def main(argv):
    try:
      opts, args = getopt.getopt(argv,"h:f:i:p:")
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
                print('testFesto.py -i <[I2C channels]> -p <Port>\nOr\ntestFesto.py -f <Path to config file>')
                sys.exit()
            elif opt in ("-f", "--file"):
                print('Reading config file: ',arg)
                f = h5py.File(arg,'r')
                i2c = f['i2c_channels']
                i2c = np.array(i2c).astype('int').reshape(-1).tolist()
                mot = f['motors']
                mot = np.array(mot).astype('int').reshape(-1).tolist()
                port = f['portPi']
                port = np.array(port).astype('int').reshape(-1)[0]
                # print(list(f.keys()))
                
            elif opt in ("-i", "--i2c"):
                arg_list = arg.split(',')
                int_converted = map(int, arg_list)
                i2c = list(int_converted)
                
            # elif opt in ("-m", "--motors"):
            #     arg_list = arg.split(',')
            #     int_converted = map(int, arg_list)
            #     mot = list(int_converted)
                
            if opt in ("-p", "--port"):
                port = int(arg)


    print('Using I2C channels: ',i2c)
    # print('Using motors: ',mot)
    print('Using port:',port)

    # exit()
    robot = SoftRobot(i2c=i2c,port=port)
    robot.addMPR()
    # robot.addIMU()
    print(robot.nSensors," sensor(s) initialized")
    robot.waitForClient() # Can be called many times to connect more clients
    robot.createProcesses() # Initialize all the processes needed for I2C sensors, motors, TCP/IP comm
    robot.run() # Start the processes
    robot.waitForProcesses() # Wait for the processes to end
    robot.socket_TCP.close()

if __name__ == "__main__":
    main(sys.argv[1:])