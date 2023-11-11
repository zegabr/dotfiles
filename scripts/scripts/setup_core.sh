#!/bin/bash

mkdir ~/Downloads
cd ~/Downloads

sudo apt update -y

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git
brew install stow
brew install htop
brew install tree
brew install neovim
brew install tmux
brew install --cask rectangle
brew install --cask devtoys

# FZF with install script
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install <<<"y\nn\ny\n"

# rust and cargo and cargo tools
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash

# Cheat sheet
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# simlinks dotfiles
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/d.sh)

cd ~/
#for personal note taking
git clone git@github.com:zegabr/notes.git
# for instant note taking
cd ~/dotfiles
