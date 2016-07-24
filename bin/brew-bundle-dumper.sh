# script to dump installed top-level formula with installed options.
#
# to use:
#   $ bin/brew-bundle-dump.sh   # this creates a local file called .Brewfile
#
if [[ ! $(brew tap | grep "homebrew/bundle") ]]; then
    echo "You need to tap Homebrew/bundle before continuing:"
    echo "  $ brew tap Homebrew/bundle"
    exit 1
fi

# get a list of top-level formulas installed (this doesn't show options though)
FORMULAS=$(brew leaves)

# dump the installed formulas with options
brew bundle dump --force --file=.Brewfile.tmp

IFS=$'\n'       # make newlines the only separator
for f in `cat ./.Brewfile.tmp`; do
    for l in $FORMULAS; do
        if [[ "$f" == *"$l"* ]]; then
            echo "$f" >> .Brewfile
        fi
    done
done

# cleanup
unset IFS
rm .Brewfile.tmp

# instructions
echo "New .Brewfile is ready.  Install with:"
echo "  $ brew bundle --file=.Brewfile"
echo 
echo "Additionally, you can move this file to your root and use it globally:"
echo "  $ mv .Brewfile ~/"
echo "  $ brew bundle --global"
echo 

