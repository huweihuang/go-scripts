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

# backup old version
oldVersion=$(go version |awk '{print $3}')
sudo mv /usr/local/go /usr/local/${oldVersion}

# download and install
case ${PLATFORM} in
"linux")
    wget ${GO_DOWNLOAD_URL}/go${VERSION}.${PLATFORM}-amd64.tar.gz
    tar -C /usr/local -xzf go${VERSION}.${PLATFORM}-amd64.tar.gz
    ;;
"mac")
    PLATFORM="darwin"
    wget ${GO_DOWNLOAD_URL}/go${VERSION}.${PLATFORM}-amd64.tar.gz
    tar -C /usr/local -xzf go${VERSION}.${PLATFORM}-amd64.tar.gz
    ;;
*)
    echo "platform not found"
    ;;
esac    
