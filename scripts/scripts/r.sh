#!/bin/sh
# rust tools
source "$HOME/.cargo/env"
rustc --version
rustup component add rust-docs
rustup component add rust-analyzer
cargo install ripgrep exa bat starship

# if starship is not being started, add it to bashrc
if [ -f ~/.bashrc ] && ! grep -q 'eval "$(starship init bash)"' ~/.bashrc; then
   echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi
