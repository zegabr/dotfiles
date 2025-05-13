#!/bin/sh

# TODO: must be run with source

# rust tools
# source "$HOME/.cargo/env"
rustc --version
rustup component add rust-docs
rustup component add rust-analyzer
$HOME/.cargo/bin/cargo install bacon

# alacritty
sai libfontconfig-dev
$HOME/.cargo/bin/cargo install alacritty
cat <<EOF > ~/Desktop/Alacritty.desktop
[Desktop Entry]
Type=Application
TryExec=alacritty
Exec=~/.cargo/bin/alacritty
Icon=Alacritty
Terminal=false
Categories=System;TerminalEmulator;
Name=Alacritty
GenericName=Terminal
Comment=A cross-platform, GPU enhanced terminal emulator
EOF

# utils
$HOME/.cargo/bin/cargo install bat exa tree-sitter-cli

# starship
$HOME/.cargo/bin/cargo install starship
# if starship is not being started, add it to bashrc
if ! grep -q 'eval "$(starship init bash)"' ~/.bashrc; then
    echo 'export STARSHIP_LOG=error' >> ~/.bashrc
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

if ! grep -q 'export STARSHIP_LOG=error' ~/.bashrc; then
    echo 'export STARSHIP_LOG=error' >> ~/.bashrc
fi

# sccache
# check if RUSTC_WRAPPER is not an exported variable
# if ! grep -q 'export RUSTC_WRAPPER=~/.cargo/bin/sccache' ~/.bashrc; then
#     sudo apt install libssl-dev -y
#     cargo install sccache
#     echo 'export RUSTC_WRAPPER=~/.cargo/bin/sccache' >> ~/.bashrc
# else
#     # get RUSTC_WRAPPER value and show to the user
#     echo "RUSTC_WRAPPER is already set to " "$RUSTC_WRAPPER"
#     echo "If you want to change it, please do it manually."
# fi

# for vimtex neovim plugin
 # sudo apt install texlive-extra-utils -y
 # sudo apt install libicu-dev -y
 # sudo apt install libgraphite2-dev -y
 # sudo apt install libfontconfig-dev -y
 # sudo apt install zathura biber -y
 # cargo install tectonic

