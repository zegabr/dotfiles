#!/bin/sh
############TIME CORRECTION FOR DUAL BOOT WITH WINDOWS#####################
read -p "Type y if you are having issues with dual-boot clocks (windows-linux)? (y/n): " ans
if [ "$ans" == "y" ]; then
    sudo timedatectl set-local-rtc 1 --adjust-system-clock
    echo "Now go to windows, set right time and you're done with clock setup"
    sudo update-grub
else
    echo "Ok, then we'll jump this part"
fi