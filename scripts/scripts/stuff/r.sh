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
    fd-find \
    starship \
    bat \
    exa \
    gitui \
    speedtest-rs \
    porsmo \
    --message-format short

# if starship is not being started, add it to bashrc
if [ -f ~/.bashrc ] && ! grep -q 'eval "$(starship init bash)"' ~/.bashrc; then
   echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

# check if RUSTC_WRAPPER is not an exported variable
if ! grep -q 'export RUSTC_WRAPPER=~/.cargo/bin/sccache' ~/.bashrc; then
    cargo install sccache
    echo 'export RUSTC_WRAPPER=~/.cargo/bin/sccache' >> ~/.bashrc
else
    # get RUSTC_WRAPPER value and show to the user
    echo "RUSTC_WRAPPER is already set to " "$RUSTC_WRAPPER"
    echo "If you want to change it, please do it manually."
fi
