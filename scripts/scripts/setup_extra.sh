#!/bin/bash
#
UPDATEGRUB=0
read -p "Type y if you want GRUB to be updated (you want it if you use a dual boot)(y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    UPDATEGRUB=1
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

TELEGRAM=0
read -p "Type y if you want telegram to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    TELEGRAM=1
fi

QBITTORRENT=0
read -p "[DON'T INSTALL IN CORP DEVICES]Type y if you want qbittorrent to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    QBITTORRENT=1
fi
FLAMESHOT=0
read -p "Type y if you want FLAMESHOT to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    FLAMESHOT=1
fi
PANDOC=0
read -p "Type y if you want PANDOC to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    PANDOC=1
fi
MINTSTICK=0
read -p "Type y if you want MINTSTICK to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    MINTSTICK=1
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
    sudo apt update -y
    sudo apt install spotify-client -y
fi

# libreoffice
if [ "$LIBREOFFICE" == 1 ]; then
    sudo add-apt-repository ppa:libreoffice/ppa
    sudo apt update -y
    sudo apt install libreoffice -y
fi

# qbittorret
if [ "$QBITTORRENT" == 1 ]; then
    sudo apt update -y
    sudo apt install qbittorrent -y
fi

# telegram
if [ "$TELEGRAM" == 1 ]; then
    sudo apt update -y
    sudo apt install -y telegram-desktop
fi

# flameshow
if [ "$FLAMESHOT" == 1 ]; then
    sudo apt update -y
    sudo apt install -y flameshot
fi
# pandoc
if [ "$PANDOC" == 1 ]; then
    sudo apt update -y
    sudo apt install -y pandoc
fi
# mintstick
if [ "$MINTSTICK" == 1 ]; then
    sudo apt update -y
    sudo apt install -y mintstick
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
    sudo apt install docker-compose -y
    sudo apt install uidmap -y
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    dockerd-rootless-setuptool.sh install
    )
fi


# qmk setup
  # 735  sai python3-pip
  # 736  python3 -m pip install --user qmk
  # 737  qmk setup
  # 738  /home/ze/.local/bin/qmk setup
