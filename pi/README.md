# Raspberry Pi Code

This directory contains code and scripts that run on the Raspberry Pi.

## Setup

1. Install Python dependencies:
   ```bash
   pip3 install -r requirements.txt
   ```

2. Run the application:
   ```bash
   python3 main.py
   ```

## Configuration

Edit `config.py` to adjust settings, or set environment variables:
- `ESP32_PORT`: Serial port for ESP32 (default: `/dev/ttyUSB0`)
- `ESP32_BAUD`: Baud rate (default: `115200`)
- `LOG_LEVEL`: Logging level (default: `INFO`)
- `DEBUG`: Enable debug mode (default: `False`)

## Project Structure

- `main.py` - Main application entry point
- `config.py` - Configuration settings
- `requirements.txt` - Python dependencies
