#!/bin/sh
# FULL LINUX SETUP
bash stuff/apps.sh # for app instalation

# DUAL BOOT FIX
read -p "Type y if you want GRUB to be updated (you want it if you use a dual boot)(y/n): " ans
if [ "$ans" == "y" ]; then
    sudo chmod 777 /etc/default/grub
    sudo echo "GRUB_DEFAULT=saved" >> /etc/default/grub
    sudo echo "GRUB_SAVEDEFAULT=true" >> /etc/default/grub
    sudo timedatectl set-local-rtc 1 --adjust-system-clock
    sudo update-grub
fi

sudo apt update && sudo apt upgrade -y && sudo apt --fix-broken install -y

#for working note taking
mkdir ~/notes
