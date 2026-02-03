"""
Main entry point for Raspberry Pi application
"""
import sys
import time

def main():
    """
    Main application function
    :returns: Exit code
    """
    print("Raspberry Pi application started")
    
    try:
        while True:
            print(f"Running... {time.strftime('%Y-%m-%d %H:%M:%S')}")
            time.sleep(5)
    except KeyboardInterrupt:
        print("\nShutting down...")
        return 0
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1

if __name__ == "__main__":
    sys.exit(main())
