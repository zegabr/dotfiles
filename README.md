# dotfiles

my dotfiles manager

## What it has?
- neovim (as a fully featured IDE) + tmux + rust useful CLIs

## Here is how to use it
### Essential: make sure curls is installed
`sudo apt install -y curl`

### For ssh default key setup
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/ssh.sh)`

#### For additional ssh key setup (useful for multiple ssh keys in same computer, ie. personal and work)
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/add-ssh.sh)`

## You only need one of the following
###  1- For debian based desktops core features like tmux, nvim, and CLI tools,
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup_core.sh)`

### 2- For WSL setup with core features
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/wsl.sh)`

### 3- For macos setup with core features
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/macos_core.sh)`

## TODO:
- should reassign print to flameshot custom shortcut, dconf doesn't seems to work 100% 

### 4- For other rust cool tools
`sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash`
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/r.sh)`

