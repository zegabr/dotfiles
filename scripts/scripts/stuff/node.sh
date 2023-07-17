sudo rm -rf /usr/bin/node
sudo apt purge nodejs -y && sudo rm -r /etc/apt/sources.list.d/nodesource.list
sudo apt update -y && sudo apt autoremove -y
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt install -y nodejs
