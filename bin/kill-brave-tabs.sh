# kill-brave-tabs.sh
# Copyright eduncan911
# 
# This will kill all processes across all tabs running within Brave, rendering
# zero CPU activity and near 0 memory across all tabs, while perserving the
# actual webpage url in the tab.  A simple ctrl-f5 and you're back!
#
# Why?  For those with a dozen windows open and over 100 tabs, and you want to
# maximize battery life.
#
# Why not enable Chromium's "Memory Saver" to suspend tabs?  Because it doesn't
# work, and does not itch that "do it now" need.
# 
# This can also be used for any Chrome-based browser as well, replacing "brave"
# with the executable for your browser (chromium, chrome, etc).
# 
pgrep -f -a 'brave' | grep 'type=renderer' | grep -v "extension" | grep -o -E '^[0-9]{0,}' | while read pid; do kill $pid; done

