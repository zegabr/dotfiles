#!/bin/sh
# m for main

bash setup.sh #install apps and docker
source v.sh # install nvim building from source
bash g.sh # gnome
bash ssh.sh # setup ssh
source z.sh # add updates zshrc, has to be called before dotfiles
rm ~/.zshrc
source d.sh # remove zshrc and create a symlink to dotfile zshrc

