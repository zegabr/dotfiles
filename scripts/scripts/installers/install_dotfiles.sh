#!/bin/sh
#
(
cd ~

if grep zegabr ~/.ssh/config; then
    git clone git@github.com:zegabr/dotfiles.git
else
    git clone https://github.com/zegabr/dotfiles.git
fi

cd ~/dotfiles/
source install.sh
)
