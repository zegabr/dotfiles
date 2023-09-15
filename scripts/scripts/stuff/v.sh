# v for (neo)vim TODO: yo udon't need this if the package manager has neovim 0.9.x

(
# dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install ninja-build gettext libtool-bin cmake g++ pkg-config unzip xsel -y

mkdir ~/nvim-deps

#install nvim from source
cd ~/nvim-deps
git clone https://github.com/neovim/neovim
cd neovim && rm -rf build && make distclean && git pull
# temporary fix for telescope TODO: try removing this after next release
git checkout b641fc3
# build and install
make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
)

