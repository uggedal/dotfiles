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

# Surpress bc welcome msg and load math lib with 20 as default scale:
alias bc='command bc -ql'

# Start cal week on monday:
alias cal='command cal -m'


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
