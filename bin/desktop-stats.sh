#/bin/bash

# display todo-txt list
if [[ -s /usr/local/bin/todo.sh ]]; then
	TODO_HOME=`/usr/local/bin/todo.sh -d /Users/eric/.todo/config | egrep -v "\+livevote|\-\-|tasks shown"`
	TODO_HOME_COUNT="`echo "$TODO_HOME" | wc -l`"
	echo "$TODO_HOME"
	echo "--"
	echo "TODO: $TODO_HOME_COUNT tasks shown"
	echo 
	echo 
	TODO_LV=`/usr/local/bin/todo.sh -d /Users/eric/.todo/config | grep "+livevote"`
	TODO_LV_COUNT="`echo "$TODO_LV" | wc -l`"
	echo "$TODO_LV"
	echo "--"
	echo "TODO: $TODO_LV_COUNT tasks shown"
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


