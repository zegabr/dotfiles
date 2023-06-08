#!/bin/bash

# DUAL BOOT FIX
read -p "Type y if you want GRUB to be updated (you want it if you use a dual boot)(y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    sudo chmod 777 /etc/default/grub
    sudo echo "GRUB_DEFAULT=saved" >> /etc/default/grub
    sudo echo "GRUB_SAVEDEFAULT=true" >> /etc/default/grub
    sudo timedatectl set-local-rtc 1 --adjust-system-clock
    sudo update-grub
fi

sudo snap remove firefox

mkdir ~/Downloads
cd ~/Downloads

# discord
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt install -y ./discord.deb

# spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# libreoffice
sudo add-apt-repository ppa:libreoffice/ppa

sudo apt update -y

sudo apt install \
flameshot \
pandoc \
mypaint \
libreoffice \
spotify-client \
usb-creator-gtk \
telegram-desktop \
-y
# alternative to usb-creator-gtk : https://unetbootin.github.io/ (this one will actually download the version for me)

read -p "Type y if you want slack to be installed (y/n): " ans
if [ "$ans" == "y" ]; then
    slack_version=4.32.122
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-"$slack_version"-amd64.deb
    sudo apt install ./slack-desktop-"$slack_version"-amd64.deb
fi

# DOCKER
read -p "Type y if you want Docker to be installed (y/n): " ans
if [ "$ans" == "y" ]; then
    # docker
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt install docker-ce -y
    sudo usermod -aG docker ${USER}
    su - ${USER}

    # docker compose
    sudo apt install docker-compose -y
fi

read -p "Type y if you want Brave to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update -y
    sudo apt install brave-browser -y
fi

# GOOGLE CHROME
read -p "Type y if you want Google Chrome to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo rm -rf google-chrome-stable_current_amd64.deb
    sensible-browser 'chrome://flags/#enable-force-dark'
fi
