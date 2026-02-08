# ESP32 ↔ Raspberry Pi Communication

## Overview

The ESP32 can communicate with a Raspberry Pi through several methods:

## 1. USB Serial (UART over USB) - **Most Common**

### How It Works

The ESP32 uses a **USB-to-UART bridge chip** (CP2102, CH340, or built-in USB on ESP32-S2/S3) that creates a virtual serial port on the Raspberry Pi.

**Hardware:**
- ESP32 connects to Pi via USB cable
- Pi sees it as `/dev/ttyUSB0` (or `/dev/ttyACM0` for native USB ESP32-S2/S3)
- Standard baud rates: 115200, 921600, etc.

**Advantages:**
- Simple setup (just USB cable)
- No additional hardware needed
- Reliable and well-supported
- Can be used for both programming and communication

**Limitations:**
- Requires physical USB connection
- Limited to serial data (text/binary)

### Example Setup

**ESP32 Side (C):**
```c
#include "driver/uart.h"
#include <string.h>

#define UART_NUM UART_NUM_0
#define BUF_SIZE 1024

void uart_init() {
    uart_config_t uart_config = {
        .baud_rate = 115200,
        .data_bits = UART_DATA_8_BITS,
        .parity = UART_PARITY_DISABLE,
        .stop_bits = UART_STOP_BITS_1,
        .flow_ctrl = UART_HW_FLOWCTRL_DISABLE
    };
    uart_param_config(UART_NUM, &uart_config);
    uart_set_pin(UART_NUM, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE, 
                 UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
    uart_driver_install(UART_NUM, BUF_SIZE * 2, 0, 0, NULL, 0);
}

void send_to_pi(const char* data) {
    uart_write_bytes(UART_NUM, data, strlen(data));
}

void receive_from_pi(char* buffer, int len) {
    int length = uart_read_bytes(UART_NUM, buffer, len - 1, 100);
    buffer[length] = '\0';
}
```

**Raspberry Pi Side (Python):**
```python
import serial
import time

ser = serial.Serial('/dev/ttyUSB0', 115200, timeout=1)

# Send data to ESP32
ser.write(b"Hello ESP32\n")

# Receive data from ESP32
if ser.in_waiting > 0:
    data = ser.readline().decode('utf-8').strip()
    print(f"Received: {data}")
```

## 2. WiFi Communication

### How It Works

ESP32 acts as WiFi client or access point, communicates via TCP/UDP sockets.

**Advantages:**
- Wireless (no cables)
- Can communicate over network
- Multiple devices can connect

**Limitations:**
- Requires WiFi network
- More complex setup
- Higher power consumption

### Example: ESP32 as WiFi Client

**ESP32 connects to Pi's WiFi network:**
```c
#include "esp_wifi.h"
#include "esp_netif.h"
#include "lwip/sockets.h"

// ESP32 connects to Pi's WiFi and sends data via TCP
```

**Pi runs a TCP server:**
```python
import socket

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('0.0.0.0', 8080))
server.listen(1)
client, addr = server.accept()
data = client.recv(1024)
```

## 3. Bluetooth (BLE or Classic)

### How It Works

ESP32 has built-in Bluetooth, can communicate via BLE or Classic Bluetooth.

**Advantages:**
- Wireless
- Low power (BLE)
- Good for IoT applications

**Limitations:**
- Range limited (~10m)
- More complex protocol

## 4. Direct GPIO (I2C/SPI/UART)

### How It Works

Connect ESP32 GPIO pins directly to Pi GPIO pins.

**Advantages:**
- Fast communication
- No USB needed
- Multiple protocols available

**Limitations:**
- Requires wiring
- Limited distance
- More complex setup

## Recommended: USB Serial for Your Project

For your current setup, **USB Serial is the best choice** because:

1. **Already configured**: Your `pi/config.py` has `ESP32_PORT` and `ESP32_BAUD`
2. **Simple**: Just connect USB cable
3. **Reliable**: Used for flashing, can also be used for data
4. **No extra hardware**: Works with standard ESP32 boards

### Quick Start

**ESP32 sends data:**
- Use `printf()` - automatically goes to UART
- Or use UART driver for more control

**Pi receives data:**
- Use `pyserial` library
- Read from `/dev/ttyUSB0` (or port from config)
