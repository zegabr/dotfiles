#!/bin/bash

mkdir ~/Downloads
cd ~/Downloads

sudo apt update -y

sudo apt install \
git \
stow \
tree \
ripgrep \
fd-find \
wget \
curl \
gawk \
btop \
jq \
tidy \
neofetch \
cmake \
parallel \
zip \
unzip \
unar \
diodon \
-y

sudo apt install tldr && tldr -u

sudo apt install python3-full -y

# FZF with install script
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install <<<"y\nn\ny\n"

# Cheat sheet
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# tmux
sudo apt install libevent-dev libncurses-dev build-essential xclip tmux -y

# install nvim building from source
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/v.sh)

# simlinks dotfiles
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/d.sh)

# install lazygit
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/lazygit.sh)

if grep zegabr ~/.ssh/config; then
    cd ~/
    # For personal note taking
    git clone git@github.com:zegabr/notes.git
fi

### For extra desktop applications on desktpp debian distros (this if checks if it is not a wsl nor a macos, if chatpt is right)
[[ "$XDG_SESSION_TYPE" == "wayland" || "$XDG_SESSION_TYPE" == "x11" ]] && \
    [[ -z "$WSL_DISTRO_NAME" ]] && \
    [[ "$(uname)" != "Darwin" ]] && \
    bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup_extra.sh)

source ~/.bashrc

if [ ! -e "~/.bash_aliases_work" ]; then
    echo "#!/bin/bash\n" > ~/.bash_aliases_work
else

cd ~/dotfiles
