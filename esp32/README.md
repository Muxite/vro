# ESP32 Firmware

This directory contains the ESP32 firmware project with a blinking LED program.

## Project Structure

- `main/main.c` - Main application that blinks an LED on GPIO 2
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

## Configuration

The LED is configured to blink on GPIO 2 (built-in LED on most ESP32 boards) with a 500ms delay. Edit `main/main.c` to change:
- `BLINK_GPIO` - GPIO pin number
- `BLINK_DELAY_MS` - Blink delay in milliseconds
