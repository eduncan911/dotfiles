#!/bin/bash

casks=( $(brew cask list) )

for cask in ${casks[@]}
do
    # in the first line there is version
    current="$(brew cask info $cask | sed -n '1p' | sed -n 's/^.*: \(.*\)$/\1/p')"

    installed=( $(ls /opt/homebrew-cask/Caskroom/$cask))
    if (! [[ " ${installed[@]} " == *" $current "* ]]); then
        (set -x; brew cask install $cask --force;)
    fi
done

