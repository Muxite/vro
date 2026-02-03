#!/bin/bash
# Flash ESP32 firmware from Raspberry Pi
# :param port: Serial port (default: /dev/ttyUSB0)
# :param baud: Baud rate (default: 921600)
set -e

PORT="${1:-/dev/ttyUSB0}"
BAUD="${2:-921600}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ESP32_DIR="$PROJECT_ROOT/esp32"

if [ ! -d "$ESP32_DIR" ]; then
    echo "Error: ESP32 directory not found at $ESP32_DIR"
    exit 1
fi

if [ ! -f "$ESP32_DIR/sdkconfig" ]; then
    echo "Error: ESP32 project not configured. Run 'idf.py build' first."
    exit 1
fi

cd "$ESP32_DIR"

if ! command -v idf.py &> /dev/null; then
    echo "Error: ESP-IDF environment not set up. Run setup_esp_idf.sh first."
    exit 1
fi

echo "Flashing ESP32 on port $PORT at baud rate $BAUD..."
idf.py -p "$PORT" -b "$BAUD" flash

echo "Flash completed successfully!"
