#!/bin/sh
# FULL LINUX SETUP
bash stuff/apps.sh # for app instalation

bash stuff/custom-keybindings.sh # will ask to override keyboard shortcuts

sudo apt update && sudo apt upgrade -y

read -p "Type y if you want GRUB to be updated (y/n): " ans
if [ "$ans" == "y" ]; then
    sudo chmod 777 /etc/default/grub
    sudo echo "GRUB_DEFAULT=saved" >> /etc/default/grub
    sudo echo "GRUB_SAVEDEFAULT=true" >> /etc/default/grub
    sudo update-grub
fi

#for working note taking
mkdir ~/notes

bash stuff/dual-boot-clock.sh # will ask if you have dual boot time problems (and solve it)
