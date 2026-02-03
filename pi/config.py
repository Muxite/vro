"""
Configuration settings for Raspberry Pi application
"""
import os

# Serial port configuration for ESP32 communication
ESP32_PORT = os.getenv("ESP32_PORT", "/dev/ttyUSB0")
ESP32_BAUD = int(os.getenv("ESP32_BAUD", "115200"))

# Application settings
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
DEBUG = os.getenv("DEBUG", "False").lower() == "true"
