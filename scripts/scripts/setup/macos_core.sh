#!/bin/bash
set -euo pipefail

mkdir -p ~/Downloads
cd ~/Downloads

if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew install bash -y
brew install stow -y
brew install btop -y
brew install neovim -y
brew install fd -y
brew install rg -y
brew install fzf -y
brew install node -y

if [ "$SHELL" != "/opt/homebrew/bin/bash" ] && [ -f /opt/homebrew/bin/bash ]; then
    chsh -s /opt/homebrew/bin/bash
fi

# symlinks dotfiles
/bin/bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/installers/install_dotfiles.sh)

if [ -f ~/.ssh/config ] && grep -q zegabr ~/.ssh/config; then
    cd ~/
    # For personal note taking
    if [ ! -d ~/notes ]; then
        git clone git@github.com:zegabr/notes.git
    fi
fi

if [ ! -f "$HOME/.bash_aliases_work" ]; then
    echo -e "#!/bin/bash\n" > "$HOME/.bash_aliases_work"
fi


if ! grep -Fxq "source .bash_aliases" "$HOME/.bash_profile"; then
    echo -e "\nsource .bash_aliases" >> "$HOME/.bash_profile"
fi

cd ~/dotfiles

echo ""
echo "=========================================================================="
echo "macOS core setup complete!"
echo "git was already installed. Install tmux, iterm2 and aerospace via internal link"
echo "To configure macOS system defaults (show hidden files in Finder, etc.),"
echo "run the one-time setup script later when ready:"
echo "bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup/macos_defaults.sh)"
echo "=========================================================================="
