#!/bin/bash
#
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
    sudo apt update -y
    sudo apt install -y flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub com.discordapp.Discord
fi

# amd
if [ "$AMDGPU" == 1 ]; then
    echo " ----- checking amd gpu is recognized ----"
    lspci | grep VGA
    sudo apt update -y && sudo apt full-upgrade -y
    sudo apt install -y dkms
    sudo apt install -y libdrm-amdgpu1
    sudo apt install -y libdrm2:i386
    sudo apt install -y libgl1-mesa-dri:i386
    sudo apt install -y libgl1:i386
    sudo apt install -y libglu1-mesa:i386
    sudo apt install -y libvulkan1
    sudo apt install -y libvulkan1:i386
    sudo apt install -y linux-generic
    sudo apt install -y mesa-utils
    sudo apt install -y mesa-utils-extra
    sudo apt install -y mesa-va-drivers
    sudo apt install -y mesa-vdpau-drivers
    sudo apt install -y mesa-vulkan-drivers
    sudo apt install -y mesa-vulkan-drivers:i386
    sudo apt install -y radeontop
    sudo apt install -y vainfo
    sudo apt install -y vdpauinfo
    sudo apt install -y vulkan-tools
    sudo apt install -y vulkan-validationlayers
fi

# steam
if [ "$STEAM" == 1 ]; then
    sudo apt update -y && sudo apt full-upgrade -y
    sudo apt install -y libc6:i386
    sudo apt install -y libncurses6:i386
    sudo apt install -y libstdc++6:i386
    sudo apt install -y libx11-6:i386
    sudo apt install -y libxext6:i386
    sudo apt install -y libxrandr2:i386
    sudo apt install -y lutris
    sudo apt install -y steam
    sudo apt install -y wine-stable
    sudo apt install -y wine32
    sudo apt install -y wine64
    sudo apt install -y winetricks

    sudo apt install -y flatpak
    sudo apt install -y gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub net.davidotek.pupgui2
    # Enable fsync and futex2 if kernel supports it
    if uname -r | grep -qE '6\.'; then
      echo "Your kernel likely supports fsync/futex2 (good for Proton). MUST INSTALL MANUALLY VIA UI"
    else
      echo "Consider upgrading to a newer kernel for better gaming performance."
    fi
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
    snap install telegram-desktop
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

if [ "$ALACRITTY" == 1 ]; then
    sudo apt update -y
    sudo apt install alacritty -y
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
