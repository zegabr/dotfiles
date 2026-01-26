#!/bin/bash

mkdir ~/Downloads
cd ~/Downloads

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew install bash
chsh -s /opt/homebrew/bin/bash
brew install git
brew install stow
brew install btop
brew install tree
brew install neovim
brew install tmux
brew install fd
brew install rectangle
brew install devtoys
brew install iterm2
brew install fzf

# simlinks dotfiles
/bin/bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/d.sh)

if grep zegabr ~/.ssh/config; then
    cd ~/
    # For personal note taking
    git clone git@github.com:zegabr/notes.git
fi
cd ~/dotfiles

