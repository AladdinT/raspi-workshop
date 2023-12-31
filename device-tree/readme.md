# Device Tree Binaries

### Directory

```bash
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

    


```
