#/bin/bash

# display todo-txt list
if [[ -s /usr/local/bin/todo.sh ]]; then
	/usr/local/bin/todo.sh -d /Users/eric/.todo/config
	echo 
	echo 
fi

# print tmux info:
# 	SAVED/NOT SAVED and resurrect plugin's last save
# 	^- because resurrect keeps stopping for some reason
if /usr/local/bin/tmux info &> /dev/null; then 
	TMUX_SESSIONS=`/usr/local/bin/tmux list-sessions -F "#{session_name},(#{session_windows} windows),last active: #{session_activity_string}" | column -t -s ','`
	TMUX_SESSIONS_COUNT=" `echo "$TMUX_SESSIONS" | wc -l`"
#	TMUX_SESSIONS=`/usr/local/bin/tmux list-windows -a`
#	TMUX_SESSIONS_COUNT=``
	echo "$TMUX_SESSIONS"
	echo "--"
	if test "`find ~/.tmux/resurrect/last -mmin +16`"; then
		echo "TMUX:\033[1;31m$TMUX_SESSIONS_COUNT session(s) not saved \033[0m - $(readlink ~/.tmux/resurrect/last)"
	else
		echo "TMUX:$TMUX_SESSIONS_COUNT session(s) saved - $(readlink ~/.tmux/resurrect/last)"
	fi
	echo 
	echo 
fi

# vim's swap files (note, you must have specified the directory setting to read from)
VIM_SWAPS="`ls -t -1 ~/.vim/swp | sed 's/%/\//g' | sed 's/\/Users\/eric/~/g' | sed 's/\/Volumes\/IMG_PORTABLE/~/g'`"
VIM_SWAPS_COUNT=`echo "$VIM_SWAPS" | wc -l`
#VIM_SWAPS_COUNT=`awk '{n+=1} END {print n} < ${VIM_SWAPS}' `
if [ -n "$VIM_SWAPS" ]; then
	echo "$VIM_SWAPS"
	echo "--"
	echo "VIM: $VIM_SWAPS_COUNT swap files"
	echo 
	echo 
fi

# istats
/usr/local/bin/istats extra
/usr/local/bin/istats fan speed
echo 
echo 

# top's output 
#top -o cpu -l 1 -i 1 -n 20 | head -n 10
top -l 1 -n 0 | head -n 10
echo 
echo 

# file system stats
df -h | egrep "disk|Filesystem"
echo 
echo 


