#!/bin/sh

# standard utils
sudo apt update && sudo apt install -y \
	gnupg2 \
	vim \
	neovim \
	tree \
	tmux \
	htop \
	p7zip-full \
	qt5-style-plugins\
	syncthing

# dircolors
/usr/bin/dircolors -p > ~/.dircolors

# fonts w/powerline
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# TLP power savings
sudo apt install -y \
	tlp \
	tlp-rdw --no-install-recommends \
	# tp-smapi-dkms \
	acpi-call-dkms

# snap
sudo apt install snapd
sudo snap install --channel=edge \
	simple-scan \
	vlc \
	#anbox

# docker
sudo apt install -y \
	docker.io \
	docker-compose
sudo systemctl start docker
sudo systemctl enable docker

# Brave browser
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ `lsb_release -sc` main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-`lsb_release -sc`.list
sudo apt update && apt install -y \
	brave-browser \
	brave-keyring

# howdy - IR Facial recognition for Linux
sudo add-apt-repository ppa:boltgolt/howdy
sudo apt update
sudo apt install howdy

