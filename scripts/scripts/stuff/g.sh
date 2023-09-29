# modified script from https://gist.github.com/codenoid/4806365032bb4ed62f381d8a76ddb8e6

curr="$(pwd)"
printf "Removing last go installation"
rm -rf /home/$USER/go
https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
printf "Checking latest Go version...\n";
LATEST_GO_VERSION="$(curl --silent https://go.dev/VERSION?m=text | head -n 1)";
LATEST_GO_DOWNLOAD_URL="https://golang.org/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz"
# uncomment line belwo to set a different local go version
# LATEST_GO_VERSION=1.20.1

printf "cd to home ($USER) directory \n"
cd "/home/$USER"

printf "Downloading ${LATEST_GO_DOWNLOAD_URL}\n\n";
curl -OJ -L --progress-bar https://golang.org/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz

printf "Extracting file...\n"
tar -xf ${LATEST_GO_VERSION}.linux-amd64.tar.gz
rm -rf ${LATEST_GO_VERSION}.linux-amd64.tar.gz

if ! grep -q 'export GOROOT="/home/$USER/go"' ~/.bashrc; then
    printf '
export GOROOT="/home/$USER/go"
export GOPATH="/home/$USER/go/packages"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
\n' >> ~/.bashrc
source ~/.bashrc
fi

printf "You are ready to Go!\n";
go version

cd "$curr"

