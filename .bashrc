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


#
# Aliases
#

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
