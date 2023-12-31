ls -ld /proc/device-tree #is a symbolioc link
ls /sys/firmware/devicetree/base

cat /sys/firmware/devicetree/base/model # prints device model
# ex: Raspberry Pi 4 Model B
ls /boot/ | grep 4
# workaround to get bcm number



# install dt compiler to compile dts to stb
# it can reverse compile dtb to dts
sudo apt-get install device-tree-compiler

# dtc : device tree compiler command
dtc --help


# reverse compile rpi dtb to dts
cp /boot/bcm2711-rpi-4-b.dtb ~/workspace
dtc -I dtb -o file.ts bcm2711-rpi-4-b.dtb
# for ex: edit led label
# compile dts to dtb with the same name
# copy new dtb to /boot 
# sync and reboot 
# now your system is running with new dtb configurations



########### How to add a linux produced device tree to your kit #################
    
    # To avoid any versions mismatching when using files from linux kernel
    # you need to check out the exact version as your raspberry pi 
    # How to get raspberry pi version
    apt-cache policy raspberrypi-kernel-headers	
    # You will find you version copy it and replace this one
    git tag -l 
    git checkout 1.20230405	
    git describe --tag
    # Tools for cross compiling
    sudo apt install crossbuild-essential-armhf
    sudo apt install git bc bison flex libssl-dev make libc6-dev libncurses5-dev
    
########### FROM DOC ###########
# You may find the raw dts in rpi linux repo
find arch/ -iname bcm2711-rpi-4-b.dts
vi ~/workspace/rpi-linux/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
# Notice here dts is still not preprocessored and uses many .h 
# files which has many used macros


# 1 Find the .yaml instructions of the device tree you want to bring up
cd ~/workspace/linux/Documentation/devicetree/bindings/
find . -iname dht11
find . -iname leds
git grep "Charachter LCD Controller"

####    For example we get 
####    /Documentation/devicetree/bindings/leds/leds-gpio.yaml ::  compatible = "gpio-leds";
####    we check for the .compatible variable to try and find supported drivers

# 2 Find the drivers that are compatiable with your device tree
cd ~/workspace/linux/drivers
git grep "gpio-leds" # searching for all driver that has the .compatible variable I found in .yaml

# 3 once you have your desired driver.c , check the required configurations for makefile 
cat leds/leds-gpio.c | grep .compatible     # compatible = "gpio-leds"
cat leds/Makefile | grep "leds-gpio"        # obj-$(CONFIG_LEDS_GPIO) += leds-gpio.o
vi  leds/Kconfig                            # search for other dependencies to be configured
    #### config LEDS_GPIO \	depends on LEDS_CLASS \ depends on GPIOLIB || COMPILE_TEST ####

# 4 check if required configurations of kconfig are set in installed kernel image configurations
cat /usr/lib/modules/$(uname -r)/build/.config | grep "LEDS_GPIO" | grep "LEDS_CLASS" | grep "GPIOLIB" 
    # If CONGIF_xx=y  goto finish_up

    # elif CONFIG_xx is not set


# 5 Finish up  
    # a. Bring up the example from .yaml to your .dts  
    #
dtc 
replace new bcm.dtb with /boot/bcm.dtb 

