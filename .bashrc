#
# ~/.bashrc
#
# Used for Interactive Bash sessions.  Bash aliases, setting favorite editor and bash prompt, etc.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable bash aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# enable bash completion
if [ -f $BREW_PREFIX/etc/bash_completion ]; then
    source $BREW_PREFIX/etc/bash_completion
fi

# modify bash behavior
#
# requires homebrew's bash on macos.  install with:
# https://johndjameson.com/blog/updating-your-shell-with-homebrew/
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s dirspell
shopt -s cmdhist
shopt -s globstar

# history: setting to unlimited
# HISTCONTROL=erasedups" to cleanup any existing history (note, can be slow)
# ignoreboth = ignorespace:ignoredups
HISTCONTROL=ignoreboth
HISTIGNORE="pwd:ls:ls -la:exit"
HISTFILESIZE=
HISTSIZE=
HISTTIMEFORMAT="[%F %T] "
HISTFILE=~/.bash_history_unlimited

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# sort ls hidden files first
LC_COLLATE="C"; export LC_COLLATE

# if we have neovim, set the default editor to that
if [[ -x "nvim" ]]; then
	EDITOR=nvim
	export EDITOR
fi

# homebrew api token
[[ -s "$HOME/.profile.private" ]] && source "$HOME/.profile.private"

# source external scripts
[[ -s "/usr/bin/virtualenvwrapper.sh" ]] && source /usr/bin/virtualenvwrapper.sh    # PROMPT: Python VirtualEnvWrapper
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source /usr/local/bin/virtualenvwrapper.sh
[[ -s "$HOME/bin/posh-git-prompt.sh" ]] && source "$HOME/bin/posh-git-prompt.sh"	# PROMPT: POSH-stype Git Prompt
[[ -d "$HOME/.rbenv" ]] && eval "$(rbenv init -)"	                                # Ruby rbenv
[[ -s "/usr/local/bin/aws_completer" ]] && complete -C aws_completer aws            # aws autocompletion
[[ -s "$HOME/.aws-tools/aws.sh" ]] && source "$HOME/.aws-tools/aws.sh"

# todo-txt
if [[ -s "$HOME/bin/todo_completion" ]]; then
	source "$HOME/bin/todo_completion"
	complete -F _todo t
	export TODOTXT_DEFAULT_ACTION=ls 	# list tasks with just "t"
	export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n' 	# sort by priority, then by number
fi

# custom bash prompt
if [[ -s "$HOME/bin/bash-powerline.sh" ]]; then
    source $HOME/bin/bash-powerline.sh
fi

