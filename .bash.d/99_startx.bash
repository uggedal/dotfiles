# Automagically start X if we don't have a display and is on TTY 1

command -v startx >/dev/null || return

[ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ] && startx
