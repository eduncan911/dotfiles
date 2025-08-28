# 
# ~/.zshrc
# 
# Used for interactive zsh sessions.  Aliases, functions, and other
# interactive tools.
# 
# It's taken me far too long to switch.
#

# manjaro default config
# 
USE_POWERLINE="true"
HAS_WIDECHARS="false"
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# modify options from defaults
# 
setopt AUTO_CD              # correct 'cd' misspellings
setopt CORRECT              # correct 'cd' misspellings (better)
setopt GLOB_STAR_SHORT      # allow bash-like **/ globs
setopt GLOB_DOTS            # include .hidden files in globs
setopt NUMERIC_GLOB_SORT    # sort globs numerically when possible

# unlimited history, write to disk
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000000                 # Unlimited in-memory history size
SAVEHIST=10000000000                 # Unlimited history file size
setopt APPEND_HISTORY       # Append history instead of overwriting
setopt SHARE_HISTORY        # Share history across sessions
setopt INC_APPEND_HISTORY   # Write to history file incrementally
setopt EXTENDED_HISTORY     # timestamps

# sort ls hidden files first
LC_COLLATE="C"; export LC_COLLATE

# if we have neovim, set the default editor to that
if which nvim >/dev/null 2>&1; then
  export VISUAL=nvim; EDITOR="$VISUAL"
elif which vim >/dev/null 2>&1; then
  export VISUAL=vim; EDITOR="$VISUAL"
elif which nano >/dev/null 2>&1; then
  export VISUAL=nano; EDITOR="$VISUAL"
fi

# setup a color terminal
TERM=screen-256color; export TERM

# use tty prompt for all gnupg2 exclusively
export GPG_TTY=$(tty)

# setup our CDPATH
CDPATH=:${HOME}       # to output relative cd, use CDPATH=.:${HOME}
# uncomment the below to CD to golang source files
#[[ -z "$GOROOT" ]] && CDPATH=$CDPATH:$GOROOT/src
#[[ -z "$GOPATH" ]] && CDPATH=$CDPATH:$GOPATH/src
#[[ -d "$GOPATH/src/golang.org" ]]       && CDPATH=$CDPATH:$GOPATH/src/golang.org
[[ -d "$GOPATH/src/github.com" ]]       && CDPATH=$CDPATH:$GOPATH/src/github.com
#[[ -d "$GOPATH/src/bitbucket.org" ]]    && CDPATH=$CDPATH:$GOPATH/src/bitbucket.org
export CDPATH

# source scripts
[[ -f "${HOME}/.aliases" ]]                           && source ${HOME}/.aliases
[[ -d "${HOME}/.rbenv" ]]                             && eval "$(rbenv init -)"
[[ -f "${HOME}/.aws-tools/aws.sh" ]]                  && source "${HOME}/.aws-tools/aws.sh"
[[ -x "/usr/bin/lesspipe" ]]                          && eval "$(SHELL=/bin/sh lesspipe)"
[[ -f "/usr/bin/virtualenvwrapper_lazy.sh" ]]         && source /usr/bin/virtualenvwrapper_lazy.sh
[[ -f "/usr/local/bin/virtualenvwrapper_lazy.sh" ]]   && source /usr/local/bin/virtualenvwrapper_lazy.sh
[[ -x "/usr/local/bin/aws_completer" ]]               && complete -C /usr/local/bin/aws_completer aws

# nodejs's NVM
if [[ -f "${HOME}/.nvm/nvm.sh" ]]; then
  export NVM_DIR="${HOME}/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"
fi

# not under version control
[[ -f "${HOME}/.profile.private" ]]                         && source "${HOME}/.profile.private"
