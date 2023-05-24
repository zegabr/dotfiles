#!/bin/sh
# m for main

# core
bash ~/dotfiles/scripts/scripts/setup_core.sh

# extra
bash ~/dotfiles/scripts/scripts/setup_extra.sh

# setup ssh for github TODO: add this to readme so I remember how to run it before everything using curl | bash
bash ~/dotfiles/scripts/scripts/stuff/ssh.sh

# pnpm for nvim lsp
bash ~/dotfiles/scripts/scripts/stuff/n.sh
