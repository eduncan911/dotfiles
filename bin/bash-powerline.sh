#!/usr/bin/env bash

# Sourced from: https://github.com/riobard/bash-powerline

__powerline() {

    # Unicode symbols
    PS_SYMBOL_DARWIN=''
    PS_SYMBOL_LINUX='$'
    PS_SYMBOL_OTHER='%'
    GIT_BRANCH_SYMBOL='⑂ '
    GIT_BRANCH_CHANGED_SYMBOL='+'
    GIT_NEED_PUSH_SYMBOL='⇡'
    GIT_NEED_PULL_SYMBOL='⇣'

    # Solarized colorscheme
    FG_BASE03="\[$(tput setaf 8)\]"
    FG_BASE02="\[$(tput setaf 0)\]"
    FG_BASE01="\[$(tput setaf 10)\]"
    FG_BASE00="\[$(tput setaf 11)\]"
    FG_BASE0="\[$(tput setaf 12)\]"
    FG_BASE1="\[$(tput setaf 14)\]"
    FG_BASE2="\[$(tput setaf 7)\]"
    FG_BASE3="\[$(tput setaf 15)\]"

    BG_BASE03="\[$(tput setab 8)\]"
    BG_BASE02="\[$(tput setab 0)\]"
    BG_BASE01="\[$(tput setab 10)\]"
    BG_BASE00="\[$(tput setab 11)\]"
    BG_BASE0="\[$(tput setab 12)\]"
    BG_BASE1="\[$(tput setab 14)\]"
    BG_BASE2="\[$(tput setab 7)\]"
    BG_BASE3="\[$(tput setab 15)\]"

    FG_YELLOW="\[$(tput setaf 3)\]"
    FG_ORANGE="\[$(tput setaf 9)\]"
    FG_RED="\[$(tput setaf 1)\]"
    FG_MAGENTA="\[$(tput setaf 5)\]"
    FG_VIOLET="\[$(tput setaf 13)\]"
    FG_BLUE="\[$(tput setaf 4)\]"
    FG_CYAN="\[$(tput setaf 6)\]"
    FG_GREEN="\[$(tput setaf 2)\]"

    BG_YELLOW="\[$(tput setab 3)\]"
    BG_ORANGE="\[$(tput setab 9)\]"
    BG_RED="\[$(tput setab 1)\]"
    BG_MAGENTA="\[$(tput setab 5)\]"
    BG_VIOLET="\[$(tput setab 13)\]"
    BG_BLUE="\[$(tput setab 4)\]"
    BG_CYAN="\[$(tput setab 6)\]"
    BG_GREEN="\[$(tput setab 2)\]"

    DIM="\[$(tput dim)\]"
    REVERSE="\[$(tput rev)\]"
    RESET="\[$(tput sgr0)\]"
    BOLD="\[$(tput bold)\]"

    # what OS?
    case "$(uname)" in
        Darwin)
            PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            PS_SYMBOL=$PS_SYMBOL_OTHER
    esac

    __pwd_info() {
        printf $(pwd | sed "s:$HOME/go/src/github.com/:/g/s/g/:" | sed "s:$HOME:~:" )
    }

    __virtualenv_info() {
        local venv
        if [[ -n "$VIRTUAL_ENV" ]]; then
            # Strip out the path and just leave the env name
            venv="${VIRTUAL_ENV##*/}"   
        else
            # In case you don't have one activated
            venv=''
        fi
        [[ -n "$venv" ]] && printf " $venv "
    }

    __rbenv_info() {
        [[ -n "$RBENV_VERSION" ]] && printf " $RBENV_VERSION "
    }

    __git_info() { 
        [ -x "$(which git)" ] || return    # git not found

        local git_eng="env LANG=C git"   # force git output in English to make our work easier
        # get current branch name or short SHA1 hash for detached head
        local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks
        local bgcolor="$BG_CYAN"

        # branch is modified?
        if [ -n "$($git_eng status --porcelain)" ]; then
            marks+=" $GIT_BRANCH_CHANGED_SYMBOL"
            bgcolor="$BG_YELLOW"
        fi

        # how many commits local branch is ahead/behind of remote?
        local stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        local behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"

        # what bg color
        if [ -n "$aheadN" ]; then
            bgcolor="$BG_BLUE"
            marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        fi
        if [ -n "$behindN" ]; then 
            bgcolor="$BG_MAGENTA"
            marks+=" $GIT_NEED_PULL_SYMBOL$behindN"
        fi
        if [ -n "$aheadN" ] && [ -n "$behindN" ]; then
            bgcolor="$BG_RED"
        fi

        # print the git branch segment without a trailing newline
        printf "$bgcolor $GIT_BRANCH_SYMBOL$branch$marks "
    }

    ps1() {
        if [ ! $? -eq 0 ]; then
            local BG_EXIT="$BG_RED$FG_BASE3 $? $RESET"
        fi

        #PS1="$FG_BASE3$BG_YELLOW YELLOW $BG_ORANGE ORANGE $BG_RED RED $BG_MAGENTA MAGENTA $BG_VIOLET VIOLET $BG_BLUE BLUE $BG_CYAN CYAN $BG_GREEN GREEN $RESET\n\n\n"
        PS1="$BG_BASE00$FG_BASE2 \u@\h $RESET"
        PS1+="$BG_BASE01$FG_BASE2 \w $RESET"
        PS1+="$FG_BASE3$(__git_info)$RESET"
        PS1+="$BG_BASE00$FG_BASE2 media-api$(__virtualenv_info) $RESET"
        PS1+="$BG_BASE01$FG_BASE2 r1.9.33$(__rbenv_info) $RESET"
        #PS1+="$BG_YELLOW$FG_BASE3 $PS_SYMBOL $RESET"
        PS1+="$BG_EXIT"
        PS1+="\n\$ " # i prefer two lines... my eyes train easier
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline
