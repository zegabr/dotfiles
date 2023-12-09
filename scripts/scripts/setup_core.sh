#!/bin/bash

mkdir ~/Downloads
cd ~/Downloads

sudo apt update -y

sudo apt install \
git \
stow \
tree \
wget \
curl \
gawk \
htop \
jq \
neofetch \
cmake \
parallel \
-y

sudo apt install python3-full -y

# FZF with install script
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install <<<"y\nn\ny\n"

# rust and cargo and cargo tools
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash

# Cheat sheet
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# Check if GPU command is available
if command_exists lspci; then
    # Check if the output of lspci contains "VGA"
    if lspci | grep -i -q "VGA"; then
        echo "GPU found on this system."
        # ollama local llms
        bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/llm.sh)
    else
        echo "No GPU found on this system."
    fi
else
    echo "lspci command not found. Unable to check for GPU."
fi

# tmux
sudo apt install libevent-dev libncurses-dev build-essential xclip tmux -y

# install nvim building from source
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/v.sh)

# simlinks dotfiles
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/d.sh)

if grep -q 'zegabr' "~/.ssh/config"; then
    cd ~/
    # For personal note taking
    git clone git@github.com:zegabr/notes.git
fi

### For extra desktop applications on desktpp debian distros (this if checks if it is not a wsl nor a macos, if chatpt is right)
[[ "$XDG_SESSION_TYPE" == "wayland" || "$XDG_SESSION_TYPE" == "x11" ]] && \
    [[ -z "$WSL_DISTRO_NAME" ]] && \
    [[ "$(uname)" != "Darwin" ]] && \
    bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup_extra.sh)

cd ~/dotfiles
