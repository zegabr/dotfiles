#!/bin/bash

mkdir ~/Downloads
cd ~/Downloads

sudo apt update -y

sudo apt install -y btop
sudo apt install -y cmake
sudo apt install -y curl
sudo apt install -y diodon
sudo apt install -y fd-find
sudo apt install -y git
sudo apt install -y jq
sudo apt install -y neofetch
sudo apt install -y ripgrep
sudo apt install -y stow
sudo apt install -y tidy
sudo apt install -y tree
sudo apt install -y unar
sudo apt install -y unzip
sudo apt install -y wget
sudo apt install -y zip
sudo apt install -y gnome-shell-extension-manager


# install and update tldr
sudo apt install tldr && tldr -u

sudo apt install python3-full -y

# FZF with install script
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install <<<"y\nn\ny\n"

# tmux
sudo apt install libevent-dev libncurses-dev build-essential xclip tmux -y

bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/v.sh)

# simlinks dotfiles
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/d.sh)

if grep zegabr ~/.ssh/config; then
    cd ~/
    # For personal note taking
    git clone git@github.com:zegabr/notes.git
fi

source ~/.bashrc

if [ ! -e "~/.bash_aliases_work" ]; then
    echo "#!/bin/bash\n" > ~/.bash_aliases_work
else

cd ~/dotfiles

