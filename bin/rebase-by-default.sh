#!/bin/bash

for d in */ ; do
  if [[ -d $d ]]; then
    # change directory 
    pushd "$d" > /dev/null 2>&1
    # set it
    git config branch.master.rebase true
    popd > /dev/null 2>&1
  fi
done

echo "Completed."
exit
