#!/bin/bash

# Function to clean up and exit
free_pin () {
  echo "Unexporting pwm0"
  echo 0 > "/sys/class/pwm/pwmchip0/unexport"
  sleep 1  
  exit 0
}

echo "Welcome to pwm app"


result=$(echo 0 > "/sys/class/pwm/pwmchip0/export")
if [ $? -ne 0 ]; then 
  exit 0
fi

sleep 1   # Wait for file to be created


if [ ! -e "/sys/class/pwm/pwmchip0/pwm0" ]; then
  #File doesn't exist
  free_pin
fi

read -p "Enter signal period: " period
echo $period > "/sys/class/pwm/pwmchip0/pwm0/period"
sleep 1

# free gpio pin before exiting
trap free_pin SIGINT

read -p "Enter signal duty cycle: " duty_cycle
$(echo $duty_cycle > "/sys/class/pwm/pwmchip0/pwm0/duty_cycle")
sleep 1
$(echo 1 > "/sys/class/pwm/pwmchip0/pwm0/enable")
sleep 1
echo "PWM0 is now enabled"

# Toggle LED 
while true; do
    read -p "Enter signal duty cycle: " duty_cycle
    $(echo $duty_cycle > "/sys/class/pwm/pwmchip0/pwm0/duty_cycle")
    sleep 1
done
