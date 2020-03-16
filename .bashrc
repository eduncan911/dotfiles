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
if [[ -x "nvim" ]]; then
  export VISUAL=nvim; EDITOR="$VISUAL"
elif [[ -x "vim" ]]; then
  export VISUAL=vim; EDITOR="$VISUAL"
elif [[ -x "nano" ]]; then
  export VISUAL=nano; EDITOR="$VISUAL"
fi

# setup a color terminal
TERM=screen-256color; export TERM

# use tty prompt for all gnupg2 exclusively
export GPG_TTY=$(tty)

# setup our CDPATH
CDPATH=:$HOME       # to output relative cd, use CDPATH=.:$HOME 
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
[[ -f "${HOME}/.profile.private" ]]                         && source "${HOME}/.profile.private"
[[ -f "${HOME}/bin/bash-powerline.sh" ]]                    && source "${HOME}/bin/bash-powerline.sh"
[[ -f "${BREW_PREFIX}/etc/bash_completion" ]]               && source "${BREW_PREFIX}/etc/bash_completion"
[[ -x "/usr/bin/lesspipe" ]]                                && eval "$(SHELL=/bin/sh lesspipe)"
[[ -f "/usr/bin/virtualenvwrapper.sh" ]]                    && source /usr/bin/virtualenvwrapper.sh
[[ -f "/usr/share/bash-completion/bash_completion" ]]       && source /usr/share/bash-completion/bash_completion
[[ -f "/usr/local/share/bash-completion/bash_completion" ]] && source /usr/local/share/bash-completion/bash_completion
[[ -f "/usr/local/bin/virtualenvwrapper.sh" ]]              && source /usr/local/bin/virtualenvwrapper.sh
[[ -x "/usr/local/bin/aws_completer" ]]                     && complete -C /usr/local/bin/aws_completer aws

# todo-txt
if [[ -f "${HOME}/bin/todo_completion" ]]; then
  source "${HOME}/bin/todo_completion"
  complete -F _todo t
  export TODOTXT_DEFAULT_ACTION=ls 	# list tasks with just "t"
  export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n' 	# sort by priority, then by number
fi

