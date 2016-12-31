#!/bin/bash

echo "Upgrading go tools ..."
go get -v -u golang.org/x/tools/...
go get -v -u golang.org/x/tools/cmd/gorename
go get -v -u github.com/golang/lint/golint
go get -v -u github.com/redefiance/go-find-references
go get -v -u github.com/jstemmer/gotags
go get -v -u github.com/client9/misspell/cmd/misspell
go get -v -u github.com/redefiance/go-find-references
go get -v -u github.com/adjust/go-wrk
go get -v -u github.com/uber/go-torch
go get -v -u github.com/nsf/gocode && gocode close

echo "Upgrading vim-go binaries ..."
vim +GoUpdateBinaries +qall

echo "Upgrading gometalinter tools ..."
gometalinter --install --update

