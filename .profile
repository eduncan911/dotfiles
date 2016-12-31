#
# ~/.profile
#
# Used for things not related to bash. Environment vars, PATH and related. 
# Should be available anytime.  Loaded by GUIs, Sublime, etc.

# Ruby rbenv
[[ -d "$HOME/.rbenv" ]] && PATH="$HOME/.rbenv/bin:$PATH"

# Python
if [[ -d "$HOME/.virtualenvs" ]]; then 
  WORKON_HOME="$HOME/.virtualenvs"; export WORKON_HOME
  PROJECT_HOME="$HOME/code"; export PROJECT_HOME
  VIRTUAL_ENV_DISABLE_PROMPT=1; export VIRTUAL_ENV_DISABLE_PROMPT
  #VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
fi

# GNU coreutils and more, overriding OS X natives
PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# GO stuff
#GOROOT="$(brew --prefix)/opt/go/libexec/bin"; export GOROOT
GOROOT="$HOME/.go/current"; export GOROOT # allows dif. versions, downgrades, portability, etc
GOPATH="$HOME/go"; export GOPATH
PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# setup my personal bin to override all
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

# since PATH was modified several times, export it here
export PATH

# setup our CDPATH
CDPATH=.:$HOME
[[ -z "$GOROOT" ]] && CDPATH=$CDPATH:$GOROOT/src
[[ -z "$GOPATH" ]] && CDPATH=$CDPATH:$GOPATH/src
[[ -d "$GOPATH/src/golang.org" ]] && CDPATH=$CDPATH:$GOPATH/src/golang.org
[[ -d "$GOPATH/src/github.com" ]] && CDPATH=$CDPATH:$GOPATH/src/github.com
[[ -d "$GOPATH/src/bitbucket.org" ]] && CDPATH=$CDPATH:$GOPATH/src/bitbucket.org
export CDPATH

# setup a terminal (i3's sensible terminal)
#TERM=xterm-256color
#export TERM

# pretty colors
[[ -s "/usr/bin/dircolors" ]] && eval `dircolors ~/.dircolors`

# iterm2 for OSX integration

[[ -e "${HOME}/.iterm2_shell_integration.bash" ]] && source "${HOME}/.iterm2_shell_integration.bash"

