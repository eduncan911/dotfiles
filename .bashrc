#
# ~/.bashrc
#
# Used for Interactive Bash sessions.  Bash aliases, setting favorite editor and bash prompt, etc.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# modify bash behavior
#
# requires homebrew's bash on macos.  configure your bash with:
# https://johndjameson.com/blog/updating-your-shell-with-homebrew/
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
	export VISUAL=nvim
else
    export VISUAL=vim
fi
export EDITOR="$VISUAL"


# source scripts
[[ -x "~/.bash_aliases" ]]                              && source ~/.bash_aliases                               # enable bash aliases
[[ -x "/usr/share/bash-completion/bash_completion" ]]   && source /usr/share/bash-completion/bash_completion    # bash completion
[[ -x "${BREW_PREFIX}/etc/bash_completion" ]]           && source "${BREW_PREFIX}/etc/bash_completion"          # bash completion
[[ -x "/usr/bin/lesspipe" ]]                            && eval "$(SHELL=/bin/sh lesspipe)"                     # less for non-text files
[[ -x "/usr/bin/virtualenvwrapper.sh" ]]                && source /usr/bin/virtualenvwrapper.sh                 # Python VirtualEnvWrapper (linux)
[[ -x "/usr/local/bin/virtualenvwrapper.sh" ]]          && source /usr/local/bin/virtualenvwrapper.sh           # Python VirtualEnvWrapper (macos)
[[ -d "${HOME}/.rbenv" ]]                               && eval "$(rbenv init -)"	                            # Ruby rbenv
[[ -x "${HOME}/.aws-tools/aws.sh" ]]                    && source "${HOME}/.aws-tools/aws.sh"                   # AWS custom scripting
[[ -x "/usr/local/bin/aws_completer" ]]                 && complete -C aws_completer aws                        # AWS autocompletion (macos)
[[ -x "${HOME}/.iterm2_shell_integration.bash" ]]       && source "${HOME}/.iterm2_shell_integration.bash"      # iterm2 shell integration (macos)
[[ -x "${HOME}/.profile.private" ]]                     && source "${HOME}/.profile.private"                    # homebrew api token
[[ -x "${HOME}/bin/bash-powerline.sh" ]]                && source "${HOME}/bin/bash-powerline.sh"               # PROMPT

# todo-txt
if [[ -x "${HOME}/bin/todo_completion" ]]; then
	source "${HOME}/bin/todo_completion"
	complete -F _todo t
	export TODOTXT_DEFAULT_ACTION=ls 	# list tasks with just "t"
	export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n' 	# sort by priority, then by number
fi

