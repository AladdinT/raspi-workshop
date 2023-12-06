#!/bin/bash
# sudo apt-get install gpiod

echo "Hi Iam gpiod tool"
read -p "What pin is the led on : " LED_PIN
echo "Toggling gpio pin ${LED_PIN} .. " 
while [ 1 ]; do
    gpioset --mode=time  -s 1 gpiochip0 ${LED_PIN}=1
    gpioset --mode=time  -s 1 gpiochip0 ${LED_PIN}=0
done