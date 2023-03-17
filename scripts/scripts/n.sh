#!/bin/sh
# install pnpm to install updated node for nvim lsp
curl -fsSL https://get.pnpm.io/install.sh | sh -
source ~/.bashrc
pnpm env use --global latest

