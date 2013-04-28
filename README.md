Uggedal's dotfiles
==================

These dotfiles are used on Linux but should be usable on other
UNIX-like systems.

Installation
------------

I keep my whole home directory in git without using symlinking as often
found in OS X specific dotfiles. Installation is therefore as simple as:

    cd ~
    git init
    git remote add origin https://github.com/uggedal/dotfiles.git
    git pull

Third party dependencies are synchronized using a [custom script][dotfiles]
(since git submodules are a PITA):

    dotfiles sync

Dependencies
------------

The essential utilities needed are:

* git
* zsh
* vim
* tmux

For a usable X environment the following dependencies are also needed:

* i3
* i3status
* urxvt
* unclutter
* autocutsel

Other non-essential applications are also configured:

* mercurial
* jshint
* mplayer
* rtorrent


[dotfiles]: https://github.com/uggedal/dotfiles/tree/master/bin/dotfiles
