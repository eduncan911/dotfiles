#!/bin/bash

# WARNING: while this script should be safe to run on normal Go installs, it will
# only upgrade the Go binaries of a special non-standard path - that I use on my
# machines.  basially, the Go binary upgrade script performs a non-standard 
# installation of GoLang.  it places the go binaries in:
#
#   ~/.go/      # note the leading "." hidden directive.
#
# but, it will skip this process if you do not have this path.
function _upgrade_go_binary {
    local GO_LATEST_VERSION=`curl -silent https://storage.googleapis.com/golang/ | \
        grep -Eo '<Key>[^<]*</Key>' | \
        cut -d'>' -f2 | \
        cut -d'<' -f1 | \
        grep '.src.tar.gz$' | \
        grep -Ev '(rc|beta)[0-9]' | \
        sed 's/\.src\.tar\.gz//' | \
        sort -n -r | \
        head -n 1`
    if [[ "$GO_LATEST_VERSION" == "" ]]; then
        echo "Skipping Go binary upgrade (no version found)."
        return
    fi
    if [[ -d "$HOME/.go/$GO_LATEST_VERSION" ]]; then
        echo "Lastest version of Go already installed, skipping upgrade."
        return
    fi

    go version
    echo "Upgrading to $GO_LATEST_VERSION"

    # compatible with Linux and Darwin (maybe windows too)
    local GO_LATEST_FILENAME="$GO_LATEST_VERSION.$(uname -s | \
        tr '[:upper:]' '[:lower:]')-amd64.tar.gz"
    echo "Downloading $GO_LATEST_FILENAME"
    wget -q https://storage.googleapis.com/golang/$GO_LATEST_FILENAME \ -O $HOME/.go/$GO_LATEST_FILENAME

    echo "Installing $GO_LATEST_FILENAME"
    cd $HOME/.go/ 
    tar zxf $GO_LATEST_FILENAME
    rm $GO_LATEST_FILENAME
    mv go $GO_LATEST_VERSION
    ln -sfn ~/.go/$GO_LATEST_VERSION ~/.go/current

    go version
}
[[ -d "$HOME/.go" ]] && _upgrade_go_binary
unset _upgrade_go_binary

echo "Upgrading go tools ..."
go get -u golang.org/x/tools/...
go get -u golang.org/x/tools/cmd/gorename
go get -u github.com/golang/lint/golint
go get -u github.com/redefiance/go-find-references
go get -u github.com/jstemmer/gotags
go get -u github.com/client9/misspell/cmd/misspell
go get -u github.com/redefiance/go-find-references
go get -u github.com/adjust/go-wrk
go get -u github.com/uber/go-torch
go get -u github.com/rogpeppe/godef
go get -u github.com/cweill/gotests/...
go get -u github.com/lukehoban/go-outline
go get -u github.com/nsf/gocode && gocode close
go get -u github.com/ramya-rao-a/go-outline

echo "Upgrading vim-go binaries ..."
vim +GoUpdateBinaries +qall

echo "Upgrading gometalinter tools ..."
go get -u github.com/alecthomas/gometalinter
gometalinter --install --update

