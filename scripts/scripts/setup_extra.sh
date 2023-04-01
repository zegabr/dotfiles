#!/bin/sh

mkdir ~/Downloads
cd ~/Downloads

sudo apt update -y

sudo apt install \
flameshot \
mypaint \
usb-creator-gtk \
-y

# alternative to usb-creator-gtk : https://unetbootin.github.io/ (this one will actually download the version for me)

sudo snap remove firefox
sudo snap install discord
sudo snap install telegram-desktop
sudo snap install spotify
sudo snap install libreoffice
sudo snap install slack --classic

gsettings set org.gnome.shell.ubuntu color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme Yaru-dark
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# DOCKER
read -p "Type y if you want Docker to be installed (y/n): " ans
if [ "$ans" == "y" ]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh --dry-run
    rm get-docker.sh
    # sudo usermod -aG docker $USER # this is not in the installation page anymore?

    # from https://docs.docker.com/compose/install/other/
    COMPOSE_VERSION=v2.16.0
    sudo curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# GOOGLE CHROME
read -p "Type y if you want Google Chrome to be installed (y/n): " ans
if [ "$ans" == "y" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo rm -rf google-chrome-stable_current_amd64.deb
    sensible-browser 'chrome://flags/#enable-force-dark'
fi

# Cheat sheet
read -p "Type y if you want cheat.sh to be installed (y/n): " ans
if [ "$ans" == "y" ]; then
    curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
    sudo chmod +x /usr/local/bin/cht.sh
fi

# for windows WSL neovim to work with clipboard
if [[ $(uname -a | grep microsoft) ]]; then
    sudo apt install xdg-utils -y
    sudo curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    sudo unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    sudo chmod +x /tmp/win32yank.exe
    sudo sudo mv /tmp/win32yank.exe /usr/local/bin/
fi

# DUAL BOOT FIX
read -p "Type y if you want GRUB to be updated (you want it if you use a dual boot)(y/n): " ans
if [ "$ans" == "y" ]; then
    sudo chmod 777 /etc/default/grub
    sudo echo "GRUB_DEFAULT=saved" >> /etc/default/grub
    sudo echo "GRUB_SAVEDEFAULT=true" >> /etc/default/grub
    sudo timedatectl set-local-rtc 1 --adjust-system-clock
    sudo update-grub
fi

# pnpm for nvim lsp
gnome-terminal --wait -- bash -c "bash ~/dotfiles/scripts/scripts/stuff/n.sh"
