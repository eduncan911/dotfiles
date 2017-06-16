#!/bin/bash
set -o errexit

# todo
echo "Create aliases? [Y/n]"

cd ~/
ln -s .dotfiles/.Brewfile
ln -s .dotfiles/.bashrc
ln -s .dotfiles/.bash_aliases
ln -s .dotfiles/.bash_profile
ln -s .dotfiles/.gitconfig
ln -s .dotfiles/.gitignore
ln -s .dotfiles/.go-debug.json
ln -s .dotfiles/.gometalinter.conf
ln -s .dotfiles/.profile
ln -s .dotfiles/.tmux
ln -s .dotfiles/.tmux.conf
ln -s .dotfiles/.vim
ln -s .dotfiles/.vimrc
ln -s .dotfiles/bin

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
