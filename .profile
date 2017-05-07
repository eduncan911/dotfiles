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

# trigger to know if we are on macos w/homebrew (used in bashrc as well)
if [ -x /usr/local/bin/brew ]; then
  BREW_PREFIX="$(brew --prefix)"
  export BREW_PREFIX
fi

# GNU coreutils overriding OS X natives
if [[ $BREW_PREFIX != "" ]]; then
  BREW_COREUTILS=$(brew --prefix coreutils) > /dev/null 2>&1
  if [ -n $BREW_COREUTILS ]; then
    PATH="$BREW_COREUTILS/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"
    MANPATH="$BREW_COREUTILS/libexec/gnuman:$MANPATH"
  fi
fi

# GO stuff
# allows for multiple versions, diffing upgrades, downgrades and portable copies.
# change which is in use with: ln -sfn ~/.go/go1.7.3 ~/.go/current
GOROOT="$HOME/.go/current"; export GOROOT
GOPATH="$HOME/go"; export GOPATH
PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# setup my personal bin to override all
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

# since PATH was modified several times, export it here
export PATH

# setup our CDPATH
CDPATH=:$HOME       # to output relative cd, use CDPATH=.:$HOME 
# uncomment the below to CD to golang source files
#[[ -z "$GOROOT" ]] && CDPATH=$CDPATH:$GOROOT/src
#[[ -z "$GOPATH" ]] && CDPATH=$CDPATH:$GOPATH/src
#[[ -d "$GOPATH/src/golang.org" ]]       && CDPATH=$CDPATH:$GOPATH/src/golang.org
[[ -d "$GOPATH/src/github.com" ]]       && CDPATH=$CDPATH:$GOPATH/src/github.com
[[ -d "$GOPATH/src/bitbucket.org" ]]    && CDPATH=$CDPATH:$GOPATH/src/bitbucket.org
export CDPATH

# setup a terminal (i3's sensible terminal)
#TERM=xterm-256color
#export TERM

# pretty colors
[ -s "/usr/bin/dircolors" ] && [ -d "~/.dircolors" ] && eval `dircolors ~/.dircolors`

# iterm2 for OSX integration
[[ -e "${HOME}/.iterm2_shell_integration.bash" ]] && source "${HOME}/.iterm2_shell_integration.bash"

