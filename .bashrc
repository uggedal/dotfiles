# Bail if not running interactively:
[ -z "$PS1" ] && return

#
# Plugins
#
#   Activated/deactivated by making the plugin file executable or not

if [ -d ~/.bash.d ]; then
  for plugin in ~/.bash.d/*.sh; do
    [ -x $plugin ] && . $plugin
  done
  unset plugin
fi
