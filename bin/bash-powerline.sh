#!/usr/bin/env bash

# Sourced from: https://github.com/riobard/bash-powerline

__powerline() {

    # Unicode symbols
    PS_SYMBOL_DARWIN=''
    PS_SYMBOL_LINUX='$'
    PS_SYMBOL_OTHER='%'
    GIT_BRANCH_SYMBOL='⑂'
    GIT_BRANCH_CHANGED_SYMBOL='+'
    GIT_STASHED_SYMBOL="✹"
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
    #case "$(uname)" in
    #    Darwin)
    #        PS_SYMBOL=$PS_SYMBOL_DARWIN
    #        ;;
    #    Linux)
    #        PS_SYMBOL=$PS_SYMBOL_LINUX
    #        ;;
    #    *)
    #        PS_SYMBOL=$PS_SYMBOL_OTHER
    #esac

    __pwd_info() {
        printf $( pwd | \
            sed -E -e 's@/([^/])[^/]*@/\1@g' -e 's/.$//' | \
            tr -d \\n; basename $(pwd); ) | \
            sed -E -e 's@^/U/(e|eric)/*@~/@g' 
    }

    __pwd_info2 () {
        local path="$PWD"
        path="${path//~/\~}"
        local out=""
        for (( i=0; i<${#path}; i++ )); do
            case "${path:i:1}" in
                \~) out+="${path:i:1}" ;;
                /) out+="${path:i:2}"; continue ;;
                *) continue ;;
            esac
        done
        local fout="${out:0:-1}${path##*/}"
        if [[ -z "${fout// }" ]]; then
            fout="/"
        elif [[ "$fout" == "~" ]]; then
            fout="~/"
        fi
        printf $fout
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
        local status="$($git_eng status --porcelain --branch)"
        
        # branch is modified?
        local modified=$(echo "$status" | wc -l)
        if [ "$modified" -ne 1 ]; then
        #    marks+=" $GIT_BRANCH_CHANGED_SYMBOL"
            bgcolor="$BG_YELLOW"
        fi

        # do we have anything unstaged or staged
        local staging
        local uadd=$(grep -c '^??' <<< "$status")
        local umod=$(grep -c '^ M' <<< "$status")
        local udel=$(grep -c '^ D' <<< "$status")
        local sadd=$(grep -c '^A ' <<< "$status")
        local smod=$(grep -c '^M ' <<< "$status")
        local sdel=$(grep -c '^D ' <<< "$status")
        if [ "$uadd" -ne 0 ] || [ "$umod" -ne 0 ] || [ "$udel" -ne 0 ]; then
            staging=" (+$uadd ~$umod -$udel"
        fi
        if [ "$sadd" != 0 ] || [ "$smod" != 0 ] || [ "$sdel" != 0 ]; then
            if [ -n "$staging" ]; then
                staging+="|+$sadd ~$smod -$sdel)"
            else
                staging=" (+0 ~0 -0|+$sadd ~$smod -$sdel)"
            fi
        else
            if [ -n "$staging" ]; then
                staging+=")"
            fi
        fi
 
        # do we have any stashes?
        local stashed
        local stash="$($git_eng stash list | wc -l)"
        if [ "$stash" != 0 ]; then
            #marks+=" $GIT_STASHED_SYMBOL"
            stashed=" [$stash]"
        fi

        # how many commits local branch is ahead/behind of remote?
        local bstatus=$(echo "$status" | grep '^##' | grep -o '\[.\+\]$')
        local aheadN=$(echo "$bstatus" | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')
        local behindN=$(echo "$bstatus" | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')

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
        printf "$bgcolor $branch$staging$stashed$marks "
    }

    ps1() {
        local LAST_ERROR=$?
        if [ ! $LAST_ERROR -eq 0 ]; then
            local BG_EXIT="$BG_RED$FG_BASE3 $LAST_ERROR $RESET"
        fi

        #PS1="$FG_BASE3$BG_YELLOW YELLOW $BG_ORANGE ORANGE $BG_RED RED $BG_MAGENTA MAGENTA $BG_VIOLET VIOLET $BG_BLUE BLUE $BG_CYAN CYAN $BG_GREEN GREEN $RESET\n\n\n"
        PS1="$BG_MAGENTA$FG_BASE02$(__virtualenv_info)$RESET"
        PS1+="$BG_VIOLET$FG_BASE02$(__rbenv_info)$RESET"
        PS1+="$BG_BASE03$FG_BASE2 \u@\h $RESET"
        PS1+="$BG_BASE2$FG_BASE03 $(__pwd_info2) $RESET"
        PS1+="$FG_BASE02$(__git_info)$RESET"
        #PS1+="$BG_YELLOW$FG_BASE3 $PS_SYMBOL $RESET"
        PS1+="$BG_EXIT"
        PS1+="\n\$ " # i prefer two lines... my eyes train easier
    }

    PROMPT_COMMAND="history -a;ps1"
}

__powerline
unset __powerline
