"""
Serial communication with ESP32
"""
import serial
import time
import sys
from config import ESP32_PORT, ESP32_BAUD

def init_serial():
    """
    Initialize serial connection to ESP32
    :returns: Serial object or None on error
    """
    try:
        ser = serial.Serial(ESP32_PORT, ESP32_BAUD, timeout=1)
        time.sleep(2)
        return ser
    except serial.SerialException as e:
        print(f"Error opening serial port: {e}")
        return None

def send_data(ser, data):
    """
    Send data to ESP32
    :param ser: Serial object
    :param data: String or bytes to send
    """
    if ser and ser.is_open:
        if isinstance(data, str):
            data = data.encode('utf-8')
        ser.write(data)
        ser.write(b'\n')

def receive_data(ser):
    """
    Receive data from ESP32
    :param ser: Serial object
    :returns: Received string or None
    """
    if ser and ser.in_waiting > 0:
        try:
            data = ser.readline().decode('utf-8').strip()
            return data
        except UnicodeDecodeError:
            return None
    return None

def main():
    ser = init_serial()
    if not ser:
        sys.exit(1)
    
    print(f"Connected to ESP32 on {ESP32_PORT} at {ESP32_BAUD} baud")
    
    try:
        while True:
            data = receive_data(ser)
            if data:
                print(f"Received: {data}")
            
            time.sleep(0.1)
    except KeyboardInterrupt:
        print("\nClosing connection...")
        ser.close()

if __name__ == "__main__":
    main()
