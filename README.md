Uggedal's dotfiles
==================

This is an opinionated and minimalistic dotfiles repo. You will find no
superfluous shell aliases or obscure vim plugins here. The essential programs
I use in my daily workflow are:

* bash
* ssh
* git
* vim
* tmux
* weechat
* [pass][]

In addition the following programs are used to form an ideal graphical
experience:

* [i3][]
* urxvt
* unclutter
* autocutsel

Lastly this repo contains a few useful scripts:

* `dotfiles` handles syncing of third party depdendencies as described
  below.
* `f` searches recursively in files for the given string. Prints matches when
  given the `-v` flag.
* `inotifier` is a wrapper around `inotifywait` which runs the given command
  whenever any file in the current directory or below changes.
* `p3` is a less verbose wrapper around mplayer and NRK P3's radio stream.
* `replace` is a recursive global search and replace helper.

Installation
------------

I keep my whole home directory in git without using symlinking as often
found in other dotfile repos. Installation is therefore as simple as:

```sh
cd ~
git init
git remote add origin https://github.com/uggedal/dotfiles.git
git pull
```

Third-party dependencies are synchronized using a custom script
(since git submodules are a PITA):

```sh
dotfiles sync
```

[pass]: http://www.passwordstore.org/
[i3]: http://i3wm.org/
