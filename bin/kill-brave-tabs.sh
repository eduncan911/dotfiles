pgrep -f -a 'brave' | grep 'type=renderer' | grep -v "extension" | grep -o -E '^[0-9]{0,}' | while read pid; do kill $pid; done
