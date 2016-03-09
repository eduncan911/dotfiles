```
           _                            ___  __ __ 
		             | |                          / _ \/_ /_ |
					    ___  __| |_   _ _ __   ___ __ _ _ _| (_) || || |
						  / _ \/ _` | | | | '_ \ / __/ _` | '_ \__, || || |
						   |  __/ (_| | |_| | | | | (_| (_| | | | |/ / | || |
						     \___|\__,_|\__,_|_| |_|\___\__,_|_| |_/_/  |_||_|
```

# dotfiles

`dotfiles` are the files used to customize your machine to your liking.  They are a set of highly opinionated configurating files, options and plugins.

These are mine.

This repo is a collection of dotfiles used to setup my Macbook Pro running OS X.  It was adopted from my years old Linux dotfile repo and carefully tweaked for Darwin's needs.

# Can you use it?

Why, sure you can.  But like anything a stranger gives you, read through each file first before utilizing.  

# What's all in here?

This machine is mostly used for development purposes.  Therefore, these dotfiles center around that.  

There's a lot and it is ever changing.  But a short list:

* `golang, ruby and python`  
* conditional setup scripts (won't load `rbenv` unless it exists)
* propper `bash` dotfiles (bashrc, profile, bash_aliases, etc)
* `bash` unlimited history and behavior to my liking 
* `POSHgit` prompt (kind of heavy, needs a replacement/overhaul)
* prompt supporting ruby and python virtual environments
* `vim` and `sensible defaults` as primary editor (`neovim` soon)
* `tmux` as a tiling replacement of my beloved `i3wm` in linux
* auto-saving, auto-restore, auto-backup of `vim` and `tmux` sessions
* `iterm2`, `vim`, `tmux` and `airline` setup for solarized dark

...and a lot more tweaks.  It's far from perfect and is in constant flux; but, it's livable for now.

# How do you use it?

That's a topic requiring a larger blog post.  But in short you clone the repo and create symlinks to the files:

```
$ cd ~/
$ git clone git@github.com:eduncan911/dotfiles.git .dotfiles
$ ln -s .dotfiles/.bashrc
$ ln -s .dotfiles/.profile
...
```

# Why post it online if it is only for you?

Backups.

Always share with others.


