#!/bin/bash
set -e

# default version
VERSION=$1
VERSION=${VERSION:-1.20.5}

PLATFORM=$2
PLATFORM=${PLATFORM:-mac}

GOROOT="/usr/local/go"
GOPATH=$HOME/gopath
GO_DOWNLOAD_URL="https://golang.org/dl"
ENV_FILE=""

# download and install
case ${PLATFORM} in
"linux")
    ENV_FILE="$HOME/.bashrc"
    wget ${GO_DOWNLOAD_URL}/go${VERSION}.${PLATFORM}-amd64.tar.gz
    tar -C /usr/local -xzf go${VERSION}.${PLATFORM}-amd64.tar.gz
    ;;
"mac")
    ENV_FILE="$HOME/.zshrc"
    PLATFORM="darwin"
    wget ${GO_DOWNLOAD_URL}/go${VERSION}.${PLATFORM}-amd64.tar.gz
    tar -C /usr/local -xzf go${VERSION}.${PLATFORM}-amd64.tar.gz
    ;;
*)
    echo "platform not found"
    ;;
esac    

# set golang env
cat >> $ENV_FILE << EOF 
# Golang env
export GOROOT=/usr/local/go
export GOPATH=\$HOME/gopath
export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin
EOF

source $ENV_FILE

# mkdir gopath
mkdir -p $GOPATH/src $GOPATH/pkg $GOPATH/bin
