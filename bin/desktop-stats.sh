#/bin/bash

# istats
if [[ -s /usr/local/bin/istats ]]; then
	/usr/local/bin/istats extra
	/usr/local/bin/istats fan speed
	echo
	echo
fi

# top's output
#top -o cpu -l 1 -i 1 -n 20 | head -n 10
top -l 1 -n 0 | head -n 10
echo
echo

# file system stats
df -h | egrep "disk|Filesystem"
echo
echo
