# dotfiles

my dotfiles manager

## What it has?
- neovim (as an fully featured IDE) + zsh + tmux configuration
- some scripts I use to setup my linux environment (install apps, fix dual boot problems, setup aliases etc.)
    - maybe I should use ansible?

## if you want an adventure, here is how to use it
- look at this [readme](https://github.com/zegabr/dotfiles/blob/main/scripts/scripts/README.md) to see what scripts do you want to run first
  - I recommend running z.sh and v.sh to install zsh and neovim
- run the install.sh script to get the neovim + zsh + tmux files on the right places (you must have stow installed for that to work)
  - open nvim to have the plugins installed automatically (you may see some errors until all plugins are installed)
    - nice tip: since I use [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer), you can manage (list/install/uninstall) language servers by running `:LspInstallInfo`
- look around [my neovim files](https://github.com/zegabr/dotfiles/tree/main/nvim/.config/nvim) to see how I setup my remaps (maybe one day I will document here how the workflow with these configurations should look like)
