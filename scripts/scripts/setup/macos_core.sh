#!/bin/bash
set -euo pipefail

mkdir -p ~/Downloads
cd ~/Downloads

if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew install bash
brew install git
brew install stow
brew install btop
brew install tree
brew install neovim
brew install tmux
brew install fd
brew install fzf
brew install --cask devtoys || true
brew install --cask iterm2 || true
brew install --cask maccy || true

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

cd ~/dotfiles

echo ""
echo "=========================================================================="
echo "macOS core setup complete!"
echo "To configure macOS system defaults (show hidden files in Finder, etc.),"
echo "run the one-time setup script later when ready:"
echo "bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup/macos_defaults.sh)"
echo "=========================================================================="
