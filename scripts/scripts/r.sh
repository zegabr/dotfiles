#!/bin/sh
# rust tools
source "$HOME/.cargo/env"
rustc --version
rustup component add rust-docs
rustup component add rust-analyzer
cargo install ripgrep exa du-dust bat
alias l='exa'
alias cat='bat'
