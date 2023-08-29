#!/bin/bash
#
UPDATEGRUB=0
read -p "Type y if you want GRUB to be updated (you want it if you use a dual boot)(y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    UPDATEGRUB=1
fi

SLACK=0
read -p "Type y if you want Slack to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    SLACK=1
fi

BRAVE=0
read -p "Type y if you want Brave to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    BRAVE=1
fi

CHROME=0
read -p "Type y if you want Google Chrome to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    CHROME=1
fi

DOCKER=0
read -p "Type y if you want Docker to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    DOCKER=1
fi

DISCORD=0
read -p "Type y if you want Discord to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    DISCORD=1
fi

SPOTIFY=0
read -p "Type y if you want Spotify to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    SPOTIFY=1
fi

LIBREOFFICE=0
read -p "Type y if you want Libreoffice to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    LIBREOFFICE=1
fi

# DUAL BOOT FIX
if [ "$UPDATEGRUB" == 1 ]; then
    sudo chmod 777 /etc/default/grub
    sudo echo "GRUB_DEFAULT=saved" >> /etc/default/grub
    sudo echo "GRUB_SAVEDEFAULT=true" >> /etc/default/grub
    sudo timedatectl set-local-rtc 1 --adjust-system-clock
    sudo update-grub
fi

mkdir ~/Downloads
cd ~/Downloads

# discord
if [ "$DISCORD" == 1 ]; then
    wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
    sudo apt install -y ./discord.deb
    rm ./discord.deb
fi

# spotify
if [ "$SPOTIFY" == 1 ]; then
    curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt install spotify-client -y
fi

# libreoffice
if [ "$LIBREOFFICE" == 1 ]; then
    sudo add-apt-repository ppa:libreoffice/ppa
    sudo apt install libreoffice -y
fi

sudo apt update -y

sudo apt install \
flameshot \
pandoc \
mypaint \
telegram-desktop \
qbittorrent \
-y

sudo apt install mintstick -y

if [ "$SLACK" == 1 ]; then
    slack_version=4.32.122
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-"$slack_version"-amd64.deb
    sudo apt install ./slack-desktop-"$slack_version"-amd64.deb
fi

if [ "$BRAVE" == 1 ]; then
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update -y
    sudo apt install brave-browser -y
fi

if [ "$CHROME" == 1 ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo rm -rf google-chrome-stable_current_amd64.deb
    sensible-browser 'chrome://flags/#enable-force-dark'
fi

# DOCKER
if [ "$DOCKER" == 1 ]; then
    (
    cd ~/Downloads/
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    )
fi
