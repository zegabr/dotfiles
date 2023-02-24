# dotfiles

my dotfiles manager

## What it has?
- neovim (as an fully featured IDE) + zsh + tmux (trying to migrate to be full regular bash, no zsh (its probably possible))

## if you want an adventure, here is how to use it
- look at this [readme](https://github.com/zegabr/dotfiles/blob/main/scripts/scripts/README.md) to see what scripts do you want to run first
- inside a ubuntu 20.04+ or WLS2 default ubuntu, run `source scripts/scripts/m.sh`
  - open nvim 1 to 3 times to have the plugins installed automatically 
    - nice tip: since I use [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim), you can manage (list/install/uninstall) language servers by running `:Mason` inside neovim
- look around [my neovim files](https://github.com/zegabr/dotfiles/tree/main/nvim/.config/nvim) to see how I setup my remaps (maybe one day I will document here how the workflow with these configurations should look like)

## TODO:
- try to build a minimal vimrc to use with big tech internal vscode
- learn how to use and setup debbuger for non old languages like C (on vscode was kinda easier than clion for C, but go and rust should be fine here)


## reminder to the creator
- custom shortcuts script doesn't work anymore so I removed it, please do it manually (probably for flameshot)
- for minimal setup, delete/comment unwanted lines in scripts/stuff/apps.sh
