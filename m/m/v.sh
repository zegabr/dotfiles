# v for (neo)vim

CURR_DIR=$(pwd)
# dependencies
sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y

mkdir ~/nvim-deps

#install nvim from source
cd ~/nvim-deps
git clone https://github.com/neovim/neovim
cd neovim && git pull
rm -rf build && make distclean
# build and install
make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install

# install vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo && nvim --version
cd $CURR_DIR



