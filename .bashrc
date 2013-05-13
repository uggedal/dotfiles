# Bail if not running interactively:
[ -z "$PS1" ] && return

#
# Environment
#

[ -d $HOME/bin ] && PATH="$HOME/bin:${PATH}"

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
