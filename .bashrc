#
# ~/.bashrc
#
# Used for Interactive Bash sessions.  Bash aliases, setting favorite editor and bash prompt, etc.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# modify bash behavior
#
# macos: requires homebrew's bash.  configure your bash with:
# https://johndjameson.com/blog/updating-your-shell-with-homebrew/
#
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s dirspell
shopt -s cmdhist
shopt -s globstar
shopt -s dotglob

# history: setting to unlimited
# HISTCONTROL=erasedups" to cleanup any existing history (note, can be slow)
# ignoreboth = ignorespace:ignoredups
#
HISTCONTROL=ignoreboth
HISTIGNORE="pwd:exit"
HISTFILESIZE=
HISTSIZE=
HISTTIMEFORMAT="[%F %T] "
HISTFILE=~/.bash_history_unlimited

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
[[ -f "${HOME}/.bash_aliases" ]]                            && source ${HOME}/.bash_aliases
[[ -d "${HOME}/.rbenv" ]]                                   && eval "$(rbenv init -)"
[[ -f "${HOME}/.aws-tools/aws.sh" ]]                        && source "${HOME}/.aws-tools/aws.sh"
[[ -f "${HOME}/.iterm2_shell_integration.bash" ]]           && source "${HOME}/.iterm2_shell_integration.bash"
[[ -f "${HOME}/bin/bash-powerline.sh" ]]                    && source "${HOME}/bin/bash-powerline.sh"
[[ -f "${BREW_PREFIX}/etc/bash_completion" ]]               && source "${BREW_PREFIX}/etc/bash_completion"
[[ -x "/usr/bin/lesspipe" ]]                                && eval "$(SHELL=/bin/sh lesspipe)"
[[ -f "/usr/bin/virtualenvwrapper_lazy.sh" ]]                    && source /usr/bin/virtualenvwrapper_lazy.sh
[[ -f "/usr/share/bash-completion/bash_completion" ]]       && source /usr/share/bash-completion/bash_completion
[[ -f "/usr/local/share/bash-completion/bash_completion" ]] && source /usr/local/share/bash-completion/bash_completion
[[ -f "/usr/local/bin/virtualenvwrapper_lazy.sh" ]]              && source /usr/local/bin/virtualenvwrapper_lazy.sh
[[ -x "/usr/local/bin/aws_completer" ]]                     && complete -C /usr/local/bin/aws_completer aws

# nodejs's NVM
if [[ -f "${HOME}/.nvm/nvm.sh" ]]; then
  export NVM_DIR="${HOME}/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# not under version control
[[ -f "${HOME}/.profile.private" ]]                         && source "${HOME}/.profile.private"
