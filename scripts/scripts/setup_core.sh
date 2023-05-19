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

# FZF with install script
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install <<< $'y\nn\nn\n'

# rust and cargo and cargo tools
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# golang
source ~/dotfiles/scripts/scripts/stuff/g.sh

# Cheat sheet
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# tmux
sudo apt install libevent-dev libncurses-dev build-essential xclip tmux -y

# install nvim building from source
source ~/dotfiles/scripts/scripts/stuff/v.sh

# simlinks dotfiles
source ~/dotfiles/scripts/scripts/stuff/d.sh

#for work note taking
mkdir ~/notes

cd ~/dotfiles
