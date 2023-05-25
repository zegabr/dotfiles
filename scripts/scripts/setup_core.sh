#!/bin/sh

mkdir ~/Downloads
cd ~/Downloads

sudo apt update -y

sudo apt install \
git \
stow \
tree \
wget \
curl \
gawk \
htop \
jq \
python3-pip \
neofetch \
-y

sudo apt install python3-pip -y
pip install repren

# rust and cargo and cargo tools

# Cheat sheet
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# tmux
sudo apt install libevent-dev libncurses-dev build-essential xclip tmux -y

# install nvim building from source
curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/v.sh | bash

# pnpm for nvim lsp
curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/n.sh | bash

# simlinks dotfiles
curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/d.sh | bash

#for work note taking
mkdir ~/notes

cd ~/dotfiles
