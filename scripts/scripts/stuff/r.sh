#!/bin/sh
# dependencies for rust tools
sudo apt install \
    pkg-config \
    libssh-dev \
    cmake \
    librust-alsa-sys-dev \
    -y

# rust tools
source "$HOME/.cargo/env"
rustc --version
rustup component add rust-docs
rustup component add rust-analyzer
cargo install \
    bacon \
    ripgrep \
    starship \
    bat \
    speedtest-rs \
    --message-format short

# if starship is not being started, add it to bashrc
if ! grep -q 'eval "$(starship init bash)"' ~/.bashrc; then
    echo 'export STARSHIP_LOG=error' >> ~/.bashrc
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

if ! grep -q 'export STARSHIP_LOG=error' ~/.bashrc; then
    echo 'export STARSHIP_LOG=error' >> ~/.bashrc
fi


# for vimtex neovim plugin
 # sudo apt install texlive-extra-utils -y
 # sudo apt install libicu-dev -y
 # sudo apt install libgraphite2-dev -y
 # sudo apt install libfontconfig-dev -y
 # sudo apt install zathura biber -y
 # cargo install tectonic

