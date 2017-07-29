```
           _                            ___  __ __ 
          | |                          / _ \/_ /_ |
   ___  __| |_   _ _ __   ___ __ _ _ _| (_) || || |
  / _ \/ _` | | | | '_ \ / __/ _` | '_ \__, || || |
 |  __/ (_| | |_| | | | | (_| (_| | | | |/ / | || |
  \___|\__,_|\__,_|_| |_|\___\__,_|_| |_/_/  |_||_|
                                                   
```

# dotfiles

`dotfiles` are the files used to customize your machine to your liking. They
are a set of highly opinionated configuration files, options and plugins.

These are mine.

These machine-agnostic `dotfiles` are used to setup my various Linux, 
Apple, Raspberry Pi and QubesOS machines I have running around.

They are conditionally written to work across several platforms,
maximizing their utility.

The concept was adopted from my previous `Linux` dotfile repos, merged 
into one and carefully tweaked to Darwin's needs.

# Can you use it?

Why, sure you can.  But like anything a stranger gives you, read through
each file first before utilizing.  

# What OS is this for?

The goal is to be OS agnostic.  I currently shoot for complete 
compatibility across:

* Linux (non-BSD, mostly ArchLinux, Debian and Ubuntu)
* Darwin (macOS)
* Raspberry Pi operating systems (Pixel, NOOB, debian/arch based)

`Bash on Windows` is a bit limited for me mostly because of the tty redraw
and color issues.  I'm still tinkering with this though and will keep
updating as I find issues.

# What's all in here?

My machnies are mostly used for development purposes and maintenance
of various remote systems.  Therefore, these `dotfiles` center around
functionality that enables me to `clone->link->use` quickly.

There's a lot and it is ever changing.  But a short list:

* primarily for `docker` & `golang` along with `ruby`, `python` and more  
* conditional setup scripts (e.g. won't load `rbenv` unless it exists)
* proper `bash` dotfiles ordering (bashrc, profile, bash_aliases, etc)
* `bash` unlimited history and behavior to my liking 
* custom prompt with vim-like prefixed path names like `/a/b/c/d/eric`
* custom prompt showing ruby (`rbenv`) and python (`virtualenv`) info
* `tmux` as an macos tiling replacement of my beloved `i3wm` in linux
* `vim/nvim` and sensible defaults as primary editor
* `vim/nvim/tmux` sessions auto-saved and auto-restored
* `vim/nvim/tmux/airline/iterm2` color sync w/256 colors (non-Windows)
* same scripts work across non-BSD `Linux` and `macOS` operating systems

...and a lot more tweaks.  It's far from perfect and is in constant flux; 
but, it's livable for now.

# How do you use it?

That's a topic requiring a larger blog post.  But in short you clone the repo
and create symlinks to the files:

```
$ cd ~/
$ git clone git@github.com:eduncan911/dotfiles.git .dotfiles
$ ln -s .dotfiles/.bash_profile
$ ln -s .dotfiles/.bashrc
$ ln -s .dotfiles/.profile
$ ln -s .dotfiles/bin
...and so on
```

There's also a `setup.sh` I am starting to populate as I build out new 
machines to cut down on the setup time.  It's not finished yet; but, 
you can evaluate how one would use this repo by viewing that file.

# Why post it online if it is only for you?

Backups.

Always share with others.


