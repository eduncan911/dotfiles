#!/bin/bash
set -o errexit

# Install Chrome
# Sign into Github, add SSH key for this machine.
# download colors: git clone https://github.com/mbadolato/iTerm2-Color-Schemes

# run setup script 

# todo
echo "Create aliases? [Y/n]"

cd ~/
ln -sf .dotfiles/.Brewfile
ln -sf .dotfiles/.bashrc
ln -sf .dotfiles/.bash_aliases
ln -sf .dotfiles/.bash_profile
ln -sf .dotfiles/.gitconfig
ln -sf .dotfiles/.gitignore
ln -sf .dotfiles/.go-debug.json
ln -sf .dotfiles/.gometalinter.conf
ln -sf .dotfiles/.profile
ln -sf .dotfiles/.tmux
ln -sf .dotfiles/.tmux.conf
ln -sf .dotfiles/.vim
ln -sf .dotfiles/.vimrc
ln -sf .dotfiles/bin

echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Brew bundler and installing packages"
brew tap Homebrew/bundle
brew bundle --global

echo "Setting up Golang"
mkdir ~/.go
mkdir -p ~/go/src ~/go/bin ~/go/pkg
~/bin/upgrade-go.sh

echo 
echo "DONE"
echo 
echo "You will want to close this terminal and open a new one."
