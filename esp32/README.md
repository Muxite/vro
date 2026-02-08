# ESP32 Firmware

This directory contains the ESP32 firmware project with UART communication to Raspberry Pi.

## Project Structure

- `main/main.c` - Main application with UART communication
- `main/uart_comm.c/h` - UART communication utilities
- `CMakeLists.txt` - Root CMake configuration for ESP-IDF
- `main/CMakeLists.txt` - Component CMake configuration
- `sdkconfig.defaults` - Default ESP-IDF configuration

## Build and Flash

1. Set up ESP-IDF environment:
   ```bash
   ../scripts/setup_esp_idf.sh
   source ~/esp/esp-idf/export.sh
   ```

2. Configure the project (first time only):
   ```bash
   cd esp32
   idf.py set-target esp32
   ```

3. Build the project:
   ```bash
   idf.py build
   ```

4. Flash from Raspberry Pi:
   ```bash
   cd ..
   ./scripts/flash_esp32.sh [port] [baud]
   ```

   Or flash directly:
   ```bash
   cd esp32
   idf.py -p /dev/ttyUSB0 flash
   ```

## UART Communication

The ESP32 communicates with the Raspberry Pi via UART at 115200 baud.

**ESP32 side:**
- Receives data from Pi and prints it
- Echoes received data back to Pi with "ESP32 received: " prefix

**Raspberry Pi side:**
- Use `pi/serial_comm.py` to communicate with ESP32
- Or use any serial terminal at 115200 baud

## Usage

The ESP32 will:
1. Initialize UART communication
2. Wait for data from Raspberry Pi
3. Print received data to console
4. Echo data back to Pi
