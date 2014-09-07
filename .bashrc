# Bail if not running interactively:
[ -z "$PS1" ] && return

# Source system profile
if [ -f /etc/profile ]; then
  . /etc/profile
fi


#
# Options
#

# Append rather than overwrite history when shell exits:
shopt -s histappend

# Enable extended pattern matching during pathname expansion:
shopt -s extglob

# Enable recursive globbing with `**`:
shopt -s globstar 2>/dev/null


#
# Shell variables
#

# Sane history length and ignoring dupes and space prefixed commands:
HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoreboth

# Never check for mail:
unset MAILCHECK


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
