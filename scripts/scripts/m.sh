#!/bin/sh
# m for main

# setup ssh for github
curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/ssh.sh | bash

# core
curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup_core.sh | bash

# extra
curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup_extra.sh | bash


