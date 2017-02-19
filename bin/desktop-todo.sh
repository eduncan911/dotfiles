#/bin/bash

# This little script is a handy way of parsing todo.txt formats and displaying
# the results on your desktop (e.g. with GeekTool for macOS).
#
# My personal todo.txt is split between work projects (+gig) and home 
# (everything else). With that said, this script splits up +gig tasks from 
# everything else and displays them with +gig first, and a count.  Then 
# followed by everything else with another count.
#

# display todo-txt list
if [[ -s /usr/local/bin/todo.sh ]]; then
    TODO=`/usr/local/bin/todo.sh -d /Users/eric/sync/todo/config`
    if [ $? -ne 0 ]; then
        echo $TODO
        echo 
        echo 
        exit 99
    fi
    if [[ $TODO == *"0 of 0 tasks shown"* ]]; then
        echo "Nothing to do. Yay!"
        echo 
        echo 
        exit 1
    fi
    
    # display +gig project first
    TODO_GIG=`echo "$TODO" | egrep '\+gig'`
    TODO_GIG_COUNT="`echo "$TODO_GIG" | wc -l`"
    echo "$TODO_GIG"
    echo "--"
    echo "TODO: $TODO_GIG_COUNT tasks shown"
    echo
    echo

    # now dispaly all other tasks.
    # this continues to use the order you specify in your .todo/config file.
    TODO_HOME=`echo "$TODO" | egrep -v '\+gig|\-\-|tasks shown'`
    TODO_HOME_COUNT="`echo "$TODO_HOME" | wc -l`"
    echo "$TODO_HOME"
    echo "--"
    echo "TODO: $TODO_HOME_COUNT tasks shown"
    echo
    echo
fi

