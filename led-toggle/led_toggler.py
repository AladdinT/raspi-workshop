import RPi.GPIO as GPIO
# sudo apt-get install python-rpi.gpio

import time
import signal
import sys

def free_pin(pin):
    print(f"Unexporting Pin {pin}")
    GPIO.output(pin, GPIO.LOW)
    time.sleep(1)
    GPIO.cleanup()
    time.sleep(1)
    sys.exit(0)

print("Welcome to led toggler")
pin = int(input("Enter GPIO pin number: "))

# GPIO pin initialization
try:
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(pin, GPIO.OUT, initial=GPIO.LOW)

    print("Toggler is toggling")

    # Free GPIO pin before exiting
    def signal_handler(sig, frame):
        free_pin(pin)

    signal.signal(signal.SIGINT, signal_handler)

    # Toggle LED
    while True:
        GPIO.output(pin, GPIO.HIGH)
        time.sleep(1)
        GPIO.output(pin, GPIO.LOW)
        time.sleep(1)

except Exception as e:
    print(f"Error: {e}")
    free_pin(pin)

