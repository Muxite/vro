#!/bin/bash
"""
Build and flash ESP32 firmware from Raspberry Pi
:param port: Serial port (default: /dev/ttyUSB0)
:param baud: Baud rate (default: 921600)
"""
set -e

PORT="${1:-/dev/ttyUSB0}"
BAUD="${2:-921600}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ESP32_DIR="$PROJECT_ROOT/esp32"
ESP_IDF_DIR="${ESP_IDF_DIR:-$HOME/esp/esp-idf}"

if [ ! -d "$ESP32_DIR" ]; then
    echo "Error: ESP32 directory not found at $ESP32_DIR"
    exit 1
fi

if [ ! -f "$ESP_IDF_DIR/export.sh" ]; then
    echo "Error: ESP-IDF export.sh not found at $ESP_IDF_DIR/export.sh"
    echo "Run ./scripts/setup_esp_idf.sh first."
    exit 1
fi

. "$ESP_IDF_DIR/export.sh"

cd "$ESP32_DIR"

echo "Building ESP32 firmware..."
idf.py build

echo "Flashing ESP32 on port $PORT at baud rate $BAUD..."
idf.py -p "$PORT" -b "$BAUD" flash

echo "Build and flash completed successfully!"
