#!/bin/bash
set -euo pipefail

mkdir -p ~/Downloads
cd ~/Downloads

sudo apt update -y

sudo apt install -y \
  btop \
  cmake \
  curl \
  diodon \
  fd-find \
  git \
  gnome-shell-extension-manager \
  jq \
  neofetch \
  npm \
  ripgrep \
  starship \
  stow \
  tidy \
  tree \
  unar \
  unzip \
  wget \
  zip

# install and update tldr
sudo apt install -y tldr && tldr -u || true

sudo apt install -y python3-full

# FZF with install script
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install <<<"y\nn\ny\n"
fi

# tmux
sudo apt install -y libevent-dev libncurses-dev build-essential xclip tmux

# if 0.9.x is not enough, use this script:
# bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/installers/build_neovim.sh)
sudo apt install -y nvim

# symlinks dotfiles
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/installers/install_dotfiles.sh)

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
