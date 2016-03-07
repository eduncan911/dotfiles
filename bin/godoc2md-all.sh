#!/bin/bash

# bash script to create a GoLang README.md in the current and all sub-directories.  
#
# it is recommended to have a doc.go for each package, that allows for samples and
# additional instructions.
#
# it iterate over all sub-directories looking for at least one Go file.  if one 
# exists, it executes godoc2md and saves the output to that directory.
#
# NOTE: this script expects to be run on packages and tools within your $GOPATH/src
# directory as that is what it attempts to parse out of the package name.  if your
# code lives somewhere else outside of your $GOPATH, consider updating your GOPATH
# and/or run godoc2md manually.
#

# TODO: Perhaps handle a README.template file to allow for custom text that will won't
# be parsed by the godoc2md tool.

# test that godoc2md is installed
if [[ ! "hash godoc2md 2>/dev/null" ]]; then
	echo "Dave Cheney's 'godoc2md' is required before running this script. Run this first:"
	echo "   go install github.com/davecheney/godoc2md"
	exit 1
fi

# _handler parses the specified $1 for godoc2md parsing
function _handler() {

	if [[ ! -d "$1" ]]; then
		echo "WARN: Was passed a non-directory"
		exit
	fi

	pushd "$d" > /dev/null 2>&1
	if [ $? -ne 0 ]; then
    	continue
    fi

	# check for any go files here
	count=`ls -1 *.go 2>/dev/null | wc -l`
	if [[ $count != 0 ]]; then

		dd=$1

		# strip the path to remove the $GOPATH/src
		IFS=";"
		for path in $GOPATH; do
			eval path=$path
			dd=${1//$path\/src\//}
		done

		# godoc2md
		echo "godoc2md ${dd%/} > README.md"
		godoc2md ${dd%/} > README.md
		if [ $? -ne 0 ]; then
    		echo "Error occured with godoc2md. Exit 2"
    		exit 9
    	fi
	fi

	popd > /dev/null 2>&1
}

# _walkdirs walks all directories and calls the handler
function _walkdir() {
	
	location=$1

	for d in $location/* ; do

		# if not a dir, skip it
		if [[ ! -d "$d" ]]; then
			continue
		fi

	    # call the handler 
		_handler $d

		# walk the sub directories
		_walkdir $d

	done
}

# execute on current dir
_handler $PWD
if [ $? -ne 0 ]; then
	exit $?
fi
_walkdir $PWD
if [ $? -ne 0 ]; then
	exit $?
fi