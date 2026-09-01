#!/bin/bash
set -euo pipefail

UPDATEGRUB=0
read -p "Type y if you want GRUB to be updated (you want it if you use a dual boot)(y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    UPDATEGRUB=1
fi

AMDGPU=0
read -p "Type y if you are using amd gpu (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    AMDGPU=1
fi

STEAM=0
read -p "Type y if you want steam to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    STEAM=1
fi

CHROME=0
read -p "Type y if you want Google Chrome to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    CHROME=1
fi

ALACRITTY=0
read -p "Type y if you want ALACRITTY to be installed (y/<anything else>): " ans
if [ "$ans" == "y" ]; then
    ALACRITTY=1
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
    echo "GRUB_DEFAULT=saved" | sudo tee -a /etc/default/grub > /dev/null
    echo "GRUB_SAVEDEFAULT=true" | sudo tee -a /etc/default/grub > /dev/null
    sudo timedatectl set-local-rtc 1 --adjust-system-clock
    sudo update-grub
fi

mkdir -p ~/Downloads
cd ~/Downloads

# discord
if [ "$DISCORD" == 1 ]; then
    sudo apt install -y flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub com.discordapp.Discord
fi

# amd
if [ "$AMDGPU" == 1 ]; then
    echo " ----- checking amd gpu is recognized ----"
    lspci | grep VGA || true
    sudo apt install -y \
      dkms \
      libdrm-amdgpu1 \
      libdrm2:i386 \
      libgl1-mesa-dri:i386 \
      libgl1:i386 \
      libglu1-mesa:i386 \
      libvulkan1 \
      libvulkan1:i386 \
      linux-generic \
      mesa-utils \
      mesa-utils-extra \
      mesa-va-drivers \
      mesa-vdpau-drivers \
      mesa-vulkan-drivers \
      mesa-vulkan-drivers:i386 \
      radeontop \
      vainfo \
      vdpauinfo \
      vulkan-tools \
      vulkan-validationlayers
fi

# steam
if [ "$STEAM" == 1 ]; then
    sudo apt install -y \
      libc6:i386 \
      libncurses6:i386 \
      libstdc++6:i386 \
      libx11-6:i386 \
      libxext6:i386 \
      libxrandr2:i386 \
      lutris \
      steam \
      wine-stable \
      wine32 \
      wine64 \
      winetricks \
      flatpak \
      gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub net.davidotek.pupgui2 || true
    # Enable fsync and futex2 if kernel supports it
    if uname -r | grep -qE '6\.'; then
      echo "Your kernel likely supports fsync/futex2 (good for Proton). MUST INSTALL MANUALLY VIA UI"
    else
      echo "Consider upgrading to a newer kernel for better gaming performance."
    fi
fi

# libreoffice
if [ "$LIBREOFFICE" == 1 ]; then
    sudo add-apt-repository -y ppa:libreoffice/ppa
    sudo apt update -y
    sudo apt install -y libreoffice
fi

# qbittorrent
if [ "$QBITTORRENT" == 1 ]; then
    sudo apt install -y qbittorrent
fi

# telegram
if [ "$TELEGRAM" == 1 ]; then
    sudo snap install telegram-desktop
fi

# pandoc
if [ "$PANDOC" == 1 ]; then
    sudo apt install -y pandoc
fi

# mintstick
if [ "$MINTSTICK" == 1 ]; then
    sudo apt install -y mintstick
fi

if [ "$CHROME" == 1 ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo rm -rf google-chrome-stable_current_amd64.deb
    sensible-browser 'chrome://flags/#enable-force-dark' || true
fi

if [ "$ALACRITTY" == 1 ]; then
    sudo apt install -y alacritty
fi

# DOCKER
if [ "$DOCKER" == 1 ]; then
    (
    cd ~/Downloads/
    sudo apt install -y docker-compose uidmap
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    dockerd-rootless-setuptool.sh install
    )
fi
