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

# FZF with install script
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# rust and cargo and cargo tools
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
gnome-terminal --wait -- bash -c "bash ~/dotfiles/scripts/scripts/stuff/r.sh" &

# Cheat sheet
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# tmux
sudo apt install libevent-dev libncurses-dev build-essential xclip tmux -y

# install nvim building from source
source v.sh

# simlinks dotfiles
source d.sh

#for work note taking
mkdir ~/notes
