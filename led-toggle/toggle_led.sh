#!/bin/bash

# Function to clean up and exit
free_pin () {
  echo "Unexporting Pin ${pin}"
  sleep 1  
  echo 0 > "/sys/class/gpio/gpio${pin}/value"
  sleep 1  
  echo "$pin" > "/sys/class/gpio/unexport" 
  exit 0
}

echo "Welcome to led toggler"
read -p "Enter GPIO pin number: " pin

# GPIO pin init
result=$(echo "$pin" > "/sys/class/gpio/export")
if [ $? -ne 0 ]; then 
  exit 0
fi

sleep 2   # Wait for file to be created


if [ ! -e "/sys/class/gpio/gpio${pin}/direction" ]; then
  #File doesn't exist
  free_pin
fi

echo "out" > "/sys/class/gpio/gpio${pin}/direction"
sleep 1
echo "Toggler is toggling"

# free gpio pin before exiting
trap free_pin SIGINT

# Toggle LED 
while true; do
  echo 1 > "/sys/class/gpio/gpio${pin}/value"
  sleep 1
  echo 0 > "/sys/class/gpio/gpio${pin}/value"
  sleep 1
done
