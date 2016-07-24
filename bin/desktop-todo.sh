#/bin/bash

# display todo-txt list
if [[ -s /usr/local/bin/todo.sh ]]; then
	TODO=`/usr/local/bin/todo.sh -d /Users/eric/.todo/config`
    
    TODO_HOME=`echo "$TODO" | egrep -v '\+jw|\+livevote|\-\-|tasks shown'`
    TODO_HOME_COUNT="`echo "$TODO_HOME" | wc -l`"
	echo "$TODO_HOME"
	echo "--"
	echo "TODO: $TODO_HOME_COUNT tasks shown"
	echo
	echo

    TODO_JW=`echo "$TODO" | egrep '\+jw'`
	TODO_JW_COUNT="`echo "$TODO_JW" | wc -l`"
	echo "$TODO_JW"
	echo "--"
	echo "TODO: $TODO_JW_COUNT tasks shown"
	echo
	echo
fi
