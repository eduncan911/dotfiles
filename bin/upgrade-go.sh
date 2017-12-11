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
    if [[ -d "~/.go/$GO_LATEST_VERSION" ]]; then
        echo "Lastest version of Go already installed, skipping upgrade."
        return
    fi

    [[ $(hash go 2>/dev/null) ]] && go version
    echo "Upgrading to $GO_LATEST_VERSION"

    # compatible with Linux and Darwin (maybe windows too)
    local GO_LATEST_FILENAME="$GO_LATEST_VERSION.$(uname -s | \
        tr '[:upper:]' '[:lower:]')-amd64.tar.gz"
    echo "Downloading $GO_LATEST_FILENAME to ~/.go/$GO_LATEST_FILENAME"
    wget https://storage.googleapis.com/golang/$GO_LATEST_FILENAME -O ~/.go/$GO_LATEST_FILENAME

    echo "Installing $GO_LATEST_FILENAME" 
    cd ~/.go
    tar zxf $GO_LATEST_FILENAME
    rm $GO_LATEST_FILENAME
    mv go $GO_LATEST_VERSION
    ln -sfn ~/.go/$GO_LATEST_VERSION ~/.go/current

    go version
}
if [[ -d ~/.go ]]; then 
    #_upgrade_go_binary
    echo "Skipped upgrading binary. source is now paged."
else
    echo "No custom ~/.go/ detected.  Using system installed version."
fi
unset _upgrade_go_binary

if [[ ! -x "$(which go)" ]]; then
    echo "Go is not installed. Exiting."
    exit 3
fi

echo "Upgrading go tools used by IDEs and vim..."
go get -u golang.org/x/tools/...
go get -u golang.org/x/tools/cmd/...
go get -u github.com/golang/lint/golint
#go get -u github.com/redefiance/go-find-references
go get -u github.com/jstemmer/gotags
go get -u github.com/client9/misspell/cmd/misspell
go get -u github.com/adjust/go-wrk
go get -u github.com/uber/go-torch
go get -u github.com/rogpeppe/godef
go get -u github.com/cweill/gotests/...
go get -u github.com/lukehoban/go-outline
go get -u github.com/nsf/gocode && gocode close
go get -u github.com/ramya-rao-a/go-outline
go get -u github.com/sourcegraph/go-langserver

echo "Upgrading gometalinter linter tools used by IDEs and vim ..."
go get -u github.com/alecthomas/gometalinter
gometalinter --install --update

echo "Upgrading vim-go binaries ..."
vim +GoUpdateBinaries +qall

echo "Upgrade personal utilities built with Go ..."
echo "  godoc2ghmd          # converts go docs to GitHub README.md markdown"
go get -u github.com/eduncan911/godoc2ghmd
echo "  godoc2md            # converts go docs to README.md markdown"
go get -u github.com/davecheney/godoc2md
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
