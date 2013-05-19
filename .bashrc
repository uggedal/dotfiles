# Bail if not running interactively:
[ -z "$PS1" ] && return

#
# Options
#

# Append rather than overwrite history when shell exits:
shopt -s histappend

# Enable extended pattern matching during pathname expansion:
shopt -s extglob


#
# Environment
#

[ -d $HOME/bin ] && PATH="$HOME/bin:$PATH"

# Sane hisotry length and ignoring dupes and space prefixed commands:
HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoreboth

# Never check for mail:
unset MAILCHECK

# Make man pages more readable:
MANWIDTH=80
export MANWIDTH

# Coloring of grep matches:
GREP_OPTIONS='--color=auto'
GREP_COLORS='ms=1;31'
export GREP_OPTIONS GREP_COLORS

# Go:
if [ -d $HOME/dev/go ]; then
  GOPATH=$HOME/dev/go
  export GOPATH
  [ -d $GOPATH/bin ] && PATH="$PATH:$GOPATH/bin"
fi

# Local Ruby gems:
if command -v gem >/dev/null; then
  GEM_HOME=$HOME/.gem
  export GEM_HOME
  [ -d $GEM_HOME/bin ] && PATH="$PATH:$GEM_HOME/bin"
fi

# Local node modules:
[ -d ~/node_modules/.bin ] && PATH="$PATH:~/node_modules/.bin"


#
# Aliases
#

# Use ls with:
#   - human readable format for file sizes
#   - append indicators to directories (/), executables (*), symlinks (@),
#     sockets (=), and FIFOs (|)
#   - list dates for long listings in full iso format
alias ls='command ls -hF --time-style=long-iso --color=auto'

# Surpress bc welcome msg and load math lib with 20 as default scale:
alias bc='command bc -ql'

# Start cal week on monday:
alias cal='command cal -m'


#
# Components
#   - activate/deactivate by making the component file executable or not
#

if [ -d ~/.bash.d ]; then
  for component in ~/.bash.d/*.bash; do
    [ -x $component ] && . $component
  done
  unset component
fi
