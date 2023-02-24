# UPDATE NPM VERSION FOR NVIM
# remove node npm and nodejs
sudo apt remove nodejs -y
sudo apt remove npm -y
sudo apt update -y
sudo rm -rf $(which node)
sudo rm -rf $(which nodejs)
sudo rm -rf $(which npm)
# install nvm to install updated node for nvim lsp
# https://www.freecodecamp.org/news/how-to-install-node-js-on-ubuntu-and-update-npm-to-the-latest-version/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# TODO: after above, need to run below in a new terminal (why source ~/.bashrc isn't enough?)

source ~/.bashrc
nvm install --latest-npm
npm i -g yarn
nvm ls
npm install npm@latest -g
