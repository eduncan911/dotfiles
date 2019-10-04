#!/bin/bash
set -o errexit

# Install Chrome
# Sign into Github, add SSH key for this machine.
# download colors: git clone https://github.com/mbadolato/iTerm2-Color-Schemes
# download fonts:  git clone https://github.com/powerline/fonts ~/code/

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

# setup tmux and neovim
git submodule init && git submodule update
ln -sf ~/.dotfiles/.vim ~/.config/nvim

# TODO: detect macOS
#

echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Brew bundler and installing packages"
brew tap Homebrew/bundle
brew bundle --global

echo "Setting Brew's bash as default"
sudo echo /usr/local/bin/bash >> /etc/shells 
chsh -s /usr/local/bin/bash 

echo "Setting up Golang"
mkdir ~/.go
mkdir -p ~/go/src ~/go/bin ~/go/pkg
~/bin/upgrade-go.sh

#echo "Docker detected. Install and run base containers"
#pushd ./docker
#docker-compose up -d
#popd
#
# linux (is there no package for this already?)
#curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
#curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker > /etc/bash_completion.d/docker
#
# macos
#ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
#ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
#ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose


echo 
echo "DONE"
echo 
echo "You will want to close this terminal and open a new one."
