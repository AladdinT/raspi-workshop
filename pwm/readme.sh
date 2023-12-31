#!/bin/bash
read -p "Display entire overlays readme ? [y/n] " ans
case $ans in 
    y|yes|YES|Yes|Y)
    cat /boot/overlays/README | less
    ;;
    *)
    cat /boot/overlays/README | grep -C 10 "PWM0" | less
    ;;
esac

read -p "Enable pwm0 pin12 and Update config.txt ? [y/n] " ans
case $ans in 
    y|yes|YES|Yes|Y)
    echo "writing:   dtoverlay=pwm-2chan,pin=12,func=4"
    sudo echo "dtoverlay=pwm-2chan,pin=12,func=4" >> /boot/config.txt
    sleep 1
    echo "You need to reboot"
    ;;
esac

