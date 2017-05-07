#
# ~/.bash_aliases
#
# Sourced from .bashrc for Interactive Bash sessions.

# make possibly distructive commands more interactive
#alias rm='rm -i'
#alias mv='mv -i'
#alias cp='cp -i'

# more intuitive options, and add a touch of color
alias grep='grep --color=auto --exclude-dir=\.git --exclude-dir=\.svn --exclude-dir=\.cache'

# enable color support of ls and also add handy aliases
# this requires the coreutils system package installed (for dircolors)
type dircolors >/dev/null 2>&1 && DIRCOLORS=1
if [ -n $DIRCOLORS ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
else
  # always force colorful ls, regardless if dircolors is install
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# general
alias nvlc='nvlc --no-color --browse-dir /media/sf_media/'
alias ack='ack --color --passthru'
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# gitpending will transverse directories 1 level deep looking for repos
# with pending work
function gitpending() {
  for d in */ ; do
    pushd $d > /dev/null
    DIRNAME=$(basename "$d")

    if ! git diff-index --quiet HEAD --; then
      echo $DIRNAME
    fi

    popd > /dev/null
  done
}

# cpstat returns the progress of the first found "cp" process 
function cpstat() {
  local pid="${1:-$(pgrep -xn cp)}" src dst
  [[ "$pid" ]] || return
  while [[ -f "/proc/$pid/fd/3" ]]; do
    read src dst < <(stat -L --printf '%s ' "/proc/$pid/fd/"{3,4})
    (( src )) || break
    printf 'cp %d%%\r' $((dst*100/src))
    sleep 1
  done
  echo
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# todo-txt alias
alias t='todo.sh -d ~/.todo/config'

# docker shortcuts
alias doco='docker-compose'
alias docker-clean='\
    docker rm -v $(docker ps -a -q -f status=exited);\
    docker rmi $(docker images -f "dangling=true" -q);\
    docker network prune -f'
alias docker-clean-everything='\
    docker rm -v $(docker ps -a -q -f status=exited);\
    docker rmi -f $(docker images -q);\
    docker volume rm -f $(docker volume ls | awk "{print $2}");\
    docker network rm -f $(docker network ls | awk "{print $2}")'

