#!/bin/bash
# modified script from https://gist.github.com/codenoid/4806365032bb4ed62f381d8a76ddb8e6
set -euo pipefail

curr="$(pwd)"
printf "Removing last go installation...\n"
rm -rf "$HOME/go"

printf "Checking latest Go version...\n"
LATEST_GO_VERSION="$(curl --silent https://go.dev/VERSION?m=text | head -n 1)"
LATEST_GO_DOWNLOAD_URL="https://golang.org/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz"

printf "cd to home ($HOME) directory...\n"
cd "$HOME"

printf "Downloading ${LATEST_GO_DOWNLOAD_URL}...\n\n"
curl -OJ -L --progress-bar "https://golang.org/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz"

printf "Extracting file...\n"
tar -xf "${LATEST_GO_VERSION}.linux-amd64.tar.gz"
rm -rf "${LATEST_GO_VERSION}.linux-amd64.tar.gz"

if ! grep -q 'export GOROOT="$HOME/go"' ~/.bashrc; then
    printf '
export GOROOT="$HOME/go"
export GOPATH="$HOME/go/packages"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
\n' >> ~/.bashrc
fi

printf "You are ready to Go!\n"
"$HOME/go/bin/go" version || true

cd "$curr"
