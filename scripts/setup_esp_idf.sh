#!/bin/bash
# Set up ESP-IDF environment for Raspberry Pi
# Installs ESP-IDF if not present and sets up environment variables
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ESP_IDF_DIR="${ESP_IDF_DIR:-$HOME/esp/esp-idf}"
ESP_IDF_VERSION="${ESP_IDF_VERSION:-v5.1}"

if [ -d "$ESP_IDF_DIR" ]; then
    echo "ESP-IDF already installed at $ESP_IDF_DIR"
    
    if [ ! -f "$ESP_IDF_DIR/export.sh" ]; then
        echo "Error: ESP-IDF installation incomplete. export.sh not found."
        exit 1
    fi
    
    echo "Checking Python virtual environment..."
    set +e
    ERROR_OUTPUT=$(source "$ESP_IDF_DIR/export.sh" 2>&1)
    EXIT_CODE=$?
    set -e
    
    if echo "$ERROR_OUTPUT" | grep -q "ERROR.*Python virtual environment.*not found"; then
        echo "Python virtual environment missing. Setting up..."
        cd "$ESP_IDF_DIR"
        ./install.sh esp32
    elif [ $EXIT_CODE -ne 0 ]; then
        echo "Error setting up ESP-IDF environment:"
        echo "$ERROR_OUTPUT"
        exit 1
    fi
else
    echo "ESP-IDF not found. Installing..."
    
    mkdir -p "$(dirname "$ESP_IDF_DIR")"
    cd "$(dirname "$ESP_IDF_DIR")"
    
    if ! command -v git &> /dev/null; then
        echo "Error: git is not installed. Please install it first:"
        echo "  sudo apt-get update && sudo apt-get install -y git"
        exit 1
    fi
    
    git clone --recursive https://github.com/espressif/esp-idf.git -b "$ESP_IDF_VERSION"
    cd esp-idf
    ./install.sh esp32
fi

if [ ! -f "$ESP_IDF_DIR/export.sh" ]; then
    echo "Error: ESP-IDF installation incomplete. export.sh not found."
    exit 1
fi

echo "Setting up ESP-IDF environment..."
source "$ESP_IDF_DIR/export.sh"

echo ""
echo "ESP-IDF environment setup complete!"
echo ""
echo "To use ESP-IDF in this shell session, run:"
echo "  source $ESP_IDF_DIR/export.sh"
echo ""
echo "Or add to your ~/.bashrc:"
echo "  alias get_idf='. $ESP_IDF_DIR/export.sh'"
echo ""
