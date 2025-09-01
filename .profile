#
# ~/.profile
#
# Used for things not related to interactive shells. 
# 
# Environment vars, PATH, and related.
# 
# Should be available anytime.  Loaded by GUIs, Sublime, etc.

# Ruby rbenv
[ -d "${HOME}/.rbenv" ] && PATH="${HOME}/.rbenv/bin:$PATH"

# Python
if [ -d "${HOME}/.virtualenvs" ]; then
  WORKON_HOME="${HOME}/.virtualenvs"; export WORKON_HOME
  PROJECT_HOME="${HOME}/code"; export PROJECT_HOME
  VIRTUAL_ENV_DISABLE_PROMPT=1; export VIRTUAL_ENV_DISABLE_PROMPT
  VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3; export VIRTUALENVWRAPPER_PYTHON
fi

# trigger to know if we are on macos w/homebrew (used in bashrc as well)
if [ -x /usr/local/bin/brew ]; then
  BREW_PREFIX="$(brew --prefix)"
  export BREW_PREFIX
  HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_AUTO_UPDATE
fi

# GNU coreutils overriding OS X natives
if [ "$BREW_PREFIX" != "" ]; then
  # handle most utils
  BREW_COREUTILS=$(brew --prefix coreutils 2>/dev/null)
  if [ -n "$BREW_COREUTILS" ]; then
    PATH="$BREW_COREUTILS/libexec/gnubin:$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
    MANPATH="$BREW_COREUTILS/libexec/gnuman:$MANPATH"
  fi
  # sed
  if [ -d "$BREW_PREFIX/opt/gnu-sed/libexec/gnubin/" ]; then
    PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
  fi
  # grep
  if [ -d "$BREW_PREFIX/opt/grep/libexec/gnubin/" ]; then
    PATH="$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
  fi
fi

# GO stuff
# allows for multiple versions, diffing upgrades, downgrades and portable copies.
# change which is in use with: ln -sfn ~/.go/go1.7.3 ~/.go/current
if [ -d "${HOME}/.go" ]; then
  GOROOT="${HOME}/.go/current"
  export GOROOT
  PATH="$GOROOT/bin:$PATH"
fi
if [ -d "${HOME}/go" ]; then
  GOPATH="${HOME}/go"
  export GOPATH
  PATH="$GOPATH/bin:$PATH"
fi
export FLATPAK_ENABLE_SDK_EXT=golang

# Android ADB
if [ -d "${HOME}/adb-fastboot/platform-tools" ] ; then
     PATH="${HOME}/adb-fastboot/platform-tools:$PATH"
fi

# package bins (linux only)
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:$PATH"

# setup my personal bin to override all
[ -d "${HOME}/bin" ] && PATH="${HOME}/bin:$PATH"

# since PATH was modified several times, export it here
export PATH
