#
# ~/.aliases
#

# general
alias nvlc='nvlc --no-color --browse-dir /media/sf_media/'
alias ack='ack --color --passthru'
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# more intuitive options, and add a touch of color
alias grep='grep --color=auto --exclude-dir=\.git --exclude-dir=\.svn --exclude-dir=\.cache'

# enable color support of ls and also add handy aliases
# this requires the coreutils system package installed (for dircolors)
#
type dircolors >/dev/null 2>&1 && DIRCOLORS=1
if [ -n "$DIRCOLORS" ]; then
  test -r ~/.dircolors && eval `dircolors -b ~/.dircolors`
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
else
  # always force colorful ls, regardless if dircolors is install
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# gitpending will traverse directories 1 level deep looking for repos
# with pending work
gitpending() {
  for d in */ ; do
    pushd "$d" > /dev/null || continue
    DIRNAME=$(basename "$d")

    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
      echo "$DIRNAME"
    fi

    popd > /dev/null
  done
}

# cpstat returns the progress of the first found "cp" process 
cpstat() {
  local pid="${1:-$(pgrep -xn cp 2>/dev/null)}" src dst
  [[ "$pid" ]] || return
  while [[ -f "/proc/$pid/fd/3" ]]; do
    read src dst < <(stat -L --printf '%s ' "/proc/$pid/fd/"{3,4} 2>/dev/null)
    (( src )) || break
    printf 'cp %d%%\r' $((dst*100/src))
    sleep 1
  done
  echo
}
