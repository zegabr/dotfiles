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
btop \
jq \
tidy \
neofetch \
cmake \
zip \
unzip \
unar \
diodon \
-y

sudo apt install tldr && tldr -u

sudo apt install python3-full -y

# FZF with install script
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install <<<"y\nn\ny\n"

# tmux
sudo apt install libevent-dev libncurses-dev build-essential xclip tmux -y

# install nvim building from source TODO: chekc if this is still needed
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/v.sh)

# simlinks dotfiles
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/d.sh)

if grep zegabr ~/.ssh/config; then
    cd ~/
    # For personal note taking
    git clone git@github.com:zegabr/notes.git
fi

source ~/.bashrc

if [ ! -e "~/.bash_aliases_work" ]; then
    echo "#!/bin/bash\n" > ~/.bash_aliases_work
else

cd ~/dotfiles
