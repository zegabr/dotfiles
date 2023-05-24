#!/bin/sh
#
(
cd ~
git clone git@github.com:zegabr/dotfiles.git
cd ~/dotfiles/
source install.sh
)
