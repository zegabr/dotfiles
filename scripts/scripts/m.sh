#!/bin/sh
# m for main

# core
bash ~/dotfiles/scripts/scripts/setup_core.sh

# extra
bash ~/dotfiles/scripts/scripts/setup_extra.sh

# setup ssh for github
bash ~/dotfiles/scripts/scripts/stuff/ssh.sh

# pnpm for nvim lsp
bash ~/dotfiles/scripts/scripts/stuff/n.sh"
