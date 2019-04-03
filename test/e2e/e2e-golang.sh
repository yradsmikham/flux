#!/usr/bin/env bash

set -o errexit

source $(dirname $0)/e2e-paths.env

GO_VERSION=1.11.4

echo ">>> Installing go ${GO_VERSION} to $GOBASE/go"
curl -O https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz
tar -xf go1.11.4.linux-amd64.tar.gz
rm -rf $GOBASE/go
mv go $GOBASE/

mkdir -p $GOPATH/bin
mkdir -p $GOPATH/src

go version
