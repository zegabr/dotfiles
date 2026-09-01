# dotfiles

My dotfiles manager.

## What it has?
- Neovim (as a fully featured IDE) + tmux + rust useful CLIs

## Here is how to use it
### Essential: make sure curl is installed
`sudo apt install -y curl`

### For ssh default key setup
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/installers/setup_ssh.sh)`

#### For additional ssh key setup (useful for multiple ssh keys in same computer, i.e. personal and work)
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/installers/add_ssh_key.sh)`

## You only need one of the following
### 1- For debian based desktops core features like tmux, nvim, and CLI tools:
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup/core.sh)`

### 2- For WSL setup with core features:
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup/wsl.sh)`

### 3- For macOS setup with core features:
`bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup/macos_core.sh)`

## TODO:
- should reassign 'print to flameshot' and 'diodon' to custom shortcut

### 4- For other rust cool tools:
`sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash`

`source <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/installers/install_rust_tools.sh)`
