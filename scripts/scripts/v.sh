# v for (neo)vim

CURR_DIR=$(pwd)
# dependencies
sudo apt update && sudo apt upgrade
sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen xsel -y

mkdir ~/nvim-deps

#install nvim from source
cd ~/nvim-deps
git clone https://github.com/neovim/neovim
cd neovim && rm -rf build && make distclean && git pull
# build and install
make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install

cd $CURR_DIR

# python plugin dependencies
python3 -m pip install --user --upgrade pynvim

