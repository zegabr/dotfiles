# UPDATE NPM VERSION FOR NVIM
# TODO(important): this must be run after apps.sh + terminal reset
# TODO: check if this works and if comment above is garbage
nvm install --latest-npm
npm i -g yarn
nvm ls
npm install npm@latest -g
