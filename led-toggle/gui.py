import tkinter as tk
import RPi.GPIO as GPIO
from threading import Thread
import time

LED_PIN = 21

def led_on():
    GPIO.output(LED_PIN, GPIO.HIGH)

def led_off():
    GPIO.output(LED_PIN, GPIO.LOW)

def blink_led():
    while is_blinking.get():
        led_on()
        time.sleep(1)
        led_off()
        time.sleep(1)

def start_stop_blink():
    if blink_var.get():
        is_blinking.set(True)
        blink_thread = Thread(target=blink_led)
        blink_thread.start()
    else:
        is_blinking.set(False)

def quit_app():
    if blink_thread.is_alive():
        blink_thread.join()
    GPIO.cleanup()
    root.destroy()

if __name__ == "__main__":
    root = tk.Tk()
    root.title("GPIO Control App")

    GPIO.setmode(GPIO.BCM)
    GPIO.setup(LED_PIN, GPIO.OUT)

    blink_var = tk.BooleanVar(value=True)
    is_blinking = tk.BooleanVar()

    btn_on = tk.Button(root, text="Turn On", command=led_on)
    btn_on.pack(pady=10)

    btn_off = tk.Button(root, text="Turn Off", command=led_off)
    btn_off.pack(pady=10)

    blink_switch = tk.Checkbutton(root, text="Blink LED", variable=blink_var, command=start_stop_blink)
    blink_switch.pack(pady=10)
    start_stop_blink()

    # Thread for blinking LED
    blink_thread = Thread(target=blink_led)

    root.protocol("WM_DELETE_WINDOW", quit_app)
    root.geometry("300x300+150+150")
    root.mainloop()
