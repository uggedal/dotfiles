# Bail if not running interactively:
[ -z "$PS1" ] && return

#
# Environment
#

[ -d $HOME/bin ] && PATH="$HOME/bin:$PATH"


#
# Aliases
#

# Use human readable format for file sizes of ls and append indicators to
# directories (/), executables (*), symlinks (@), sockets (=), and FIFOs (|):
alias ls='command ls -hF --color=auto'


#
# Plugins
#   - activate/deactivate by making the plugin file executable or not
#

if [ -d ~/.bash.d ]; then
  for plugin in ~/.bash.d/*.sh; do
    [ -x $plugin ] && . $plugin
  done
  unset plugin
fi
