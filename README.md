# dotfiles

my dotfiles manager

## What it has?
- neovim (as an fully featured IDE) + tmux 

## if you want an adventure, here is how to use it
- look at this [readme](https://github.com/zegabr/dotfiles/blob/main/scripts/scripts/README.md) to see what scripts do you want to run first
- inside a ubuntu 22.04+ or WLS2 default ubuntu, run `source scripts/scripts/m.sh`
  - open nvim 1 to 3 times to have the plugins installed automatically
    - nice tip: since I use [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim), you can manage (list/install/uninstall) language servers by running `:Mason` inside neovim
- look around [my neovim files](https://github.com/zegabr/dotfiles/tree/main/nvim/.config/nvim) to see how I setup my remaps (maybe one day I will document here how the workflow with these configurations should look like)

## TODO:
- try to build a minimal vimrc to use with big tech internal vscodes?
- learn how to use and setup debbuger for new languages like go and rust
- learn ansible


## reminder to the creator
- should add flameshot shortcut manually
