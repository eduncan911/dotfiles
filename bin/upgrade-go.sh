#!/bin/bash
set -o errexit

# WARNING: while this script should be safe to run on normal Go installs, it will
# only upgrade the Go binaries of a special non-standard path - that I use on my
# machines.  basially, the Go binary upgrade script performs a non-standard 
# installation of GoLang.  it places the go binaries in:
#
#   ~/.go/      # note the leading "." hidden directive.
#
# but, it will skip this process if you do not have this path.
function _upgrade_go_binary {
    local GO_LATEST_VERSION=`curl --silent https://golang.org/VERSION?m=text`
    if [[ "$GO_LATEST_VERSION" == "" ]]; then
        echo "Skipping Go binary upgrade (no version found)."
        return
    fi
    if [[ -d "$HOME/.go/$GO_LATEST_VERSION" ]]; then
        echo "go version $GO_LATEST_VERSION already installed, skipping upgrade."
        return
    fi

    [[ $(hash go 2>/dev/null) ]] && go version
    echo "Upgrading to $GO_LATEST_VERSION"

    # compatible with Linux and Darwin (maybe windows too)
    local GO_LATEST_FILENAME="$GO_LATEST_VERSION.$(uname -s | \
        tr '[:upper:]' '[:lower:]')-amd64.tar.gz"
    echo "Downloading $GO_LATEST_FILENAME to $HOME/.go/$GO_LATEST_FILENAME"
    wget -q https://dl.google.com/go/$GO_LATEST_FILENAME -O $HOME/.go/$GO_LATEST_FILENAME

    echo "Installing $GO_LATEST_FILENAME into $HOME/.go/$GO_LATEST_VERSION" 
    cd $HOME/.go
    tar zxf $GO_LATEST_FILENAME
    rm $GO_LATEST_FILENAME
    mv go $GO_LATEST_VERSION
    ln -sfn $HOME/.go/$GO_LATEST_VERSION $HOME/.go/current

    go version
}
if [[ -d $HOME/.go ]]; then 
    _upgrade_go_binary
else
    echo "No custom $HOME/.go/ detected.  Using system installed version."
fi
unset _upgrade_go_binary

if [[ ! -x "$(which go)" ]]; then
    echo "Go is not installed. Exiting."
    exit 3
fi

echo "Upgrading go tools used by IDEs and vim..."
printf "# golang.org/x/tools/...\n"
go get -u golang.org/x/tools/...
printf "# golang.org/x/tools/cmd/...\n"
go get -u golang.org/x/tools/cmd/...
# go get -u golang.org/x/lint/golint
# go get -u github.com/golang/lint/golint
# go get -u github.com/redefiance/go-find-references
printf "# github.com/jstemmer/gotags\n"
go get -u github.com/jstemmer/gotags
printf "# github.com/client9/misspell/cmd/misspell\n"
go get -u github.com/client9/misspell/cmd/misspell
printf "# github.com/adjust/go-wrk\n"
go get -u github.com/adjust/go-wrk
printf "# github.com/rogpeppe/godef\n"
go get -u github.com/rogpeppe/godef
printf "# github.com/cweill/gotests/...\n"
go get -u github.com/cweill/gotests/...
printf "# github.com/lukehoban/go-outline\n"
go get -u github.com/lukehoban/go-outline
#printf "# github.com/nsf/gocode && gocode close\n"
#go get -u github.com/nsf/gocode && gocode close
printf "# github.com/ramya-rao-a/go-outline\n"
go get -u github.com/ramya-rao-a/go-outline
printf "# github.com/sourcegraph/go-langserver\n"
go get -u github.com/sourcegraph/go-langserver

echo "Upgrading golangci-lint tools used by IDEs and vim ..."
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.23.3

echo "Upgrading vim-go binaries ..."
vim +GoUpdateBinaries +qall

echo "Upgrade personal utilities built with Go ..."
#echo "  godoc2ghmd          # converts go docs to GitHub README.md markdown"
#go get -u github.com/eduncan911/godoc2ghmd
echo "  gostatus            # checks status of packages in GOPATH"
go get -u github.com/shurcooL/gostatus
echo "  gofresh             # checks status of packages in GOPATH"
go get -u github.com/divan/gofresh
echo "  wuzz                # command line http inspector"
go get -u github.com/asciimoo/wuzz
echo "  goveralls           # coveralls utility"
go get -u github.com/mattn/goveralls
echo "  go-junit-report     # converts 'go test' format to junit for Jenkins"
go get -u github.com/jstemmer/go-junit-report
echo "  go-torch            # runtime visualizer"
go get -u github.com/uber/go-torch
echo "  go-fuzz             # fuzzy-input tester"
go get -u github.com/dvyukov/go-fuzz/go-fuzz
echo "  go-fuzz-build       # fuzzy-input tester"
go get -u github.com/dvyukov/go-fuzz/go-fuzz-build
echo "  hugo                # static site generator (skipped)"
#go get -u github.com/spf13/hugo
echo "  godep               # dependency manager"
go get -u github.com/tools/godep
echo "  govendor            # dependency manager"
go get -u github.com/kardianos/govendor
echo "  callgraph           # displays the callgraph of a program"
go get -u golang.org/x/tools/cmd/callgraph

echo "Done. \
Not upgraded as part of this script:
    * packages in $GOPATH/src/* (use gostatus and gofresh for that)
    * delve debugger (macOS: update w/homebrew; linux: update per directions)
"
