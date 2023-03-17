#!/bin/sh
mkdir ~/Downloads
cd ~/Downloads

sudo apt update -y

sudo apt install \
tree \
flameshot \
mypaint \
gawk \
git \
build-essential \
wget \
curl \
jq \
bat \
fzf \
stow \
tmux \
htop \
screenfetch \
fd-find \
python3-pip \
usb-creator-gtk \
-y

# tmux
sudo apt install libevent-dev libncurses-dev build-essential xclip tmux -y

sudo snap install discord
sudo snap install telegram-desktop
sudo snap install spotify
sudo snap install libreoffice
sudo snap install slack --classic

# rust and cargo and cargo tools
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
gnome-terminal --wait -- bash -c "source ~/dotfiles/scripts/scripts/r.sh"

# UPDATE NPM VERSION FOR NVIM
# remove node npm and nodejs
sudo apt remove nodejs -y
sudo apt remove npm -y
sudo apt update -y
sudo rm -rf $(which node)
sudo rm -rf $(which nodejs)
sudo rm -rf $(which npm)
# install nvm to install updated node for nvim lsp
# https://www.freecodecamp.org/news/how-to-install-node-js-on-ubuntu-and-update-npm-to-the-latest-version/
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
gnome-terminal --wait -- bash -c "source ~/dotfiles/scripts/scripts/n.sh"

# DOCKER
read -p "Type y if you want Docker to be installed (y/n): " ans
if [ "$ans" == "y" ]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
    sudo usermod -aG docker $USER

    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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

