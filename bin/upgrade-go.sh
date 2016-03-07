#!/bin/bash

echo "Upgrading go tools ..."
go get -v -u golang.org/x/tools/...
go get -v -u golang.org/x/tools/cmd/gorename
go get -v -u github.com/golang/lint/golint
go get -v -u github.com/redefiance/go-find-references
go get -v -u github.com/jstemmer/gotags

echo "Upgrading vim-go binaries ..."
vim +GoUpdateBinaries +qall

echo "Upgrading gometalinter tools ..."
gometalinter --install --update

