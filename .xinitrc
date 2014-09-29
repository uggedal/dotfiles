# Expand font path
for p in /usr/share/fonts/misc /usr/share/fonts/local; do
  [ -d $p ] || continue
  xset +fp $p
  xset fp rehash
done

# Load local .Xresources
xrdb -merge $HOME/.Xresources

# VBox sync
if command -v VBoxClient-all >/dev/null; then
  VBoxClient-all&
fi

# Swap option and command buttons for Mac
if [ -d /sys/class/backlight/gmux_backlight ]; then
  setxkbmap -option altwin:swap_alt_win
fi

# Enable compose key
setxkbmap -option compose:ralt

if command -v xmodmap >/dev/null && [ -f $HOME/.Xmodmap ]; then
  xmodmap $HOME/.Xmodmap
fi

# Root window background and nicer pointer over root window
xsetroot -solid '#eee8d5' -cursor_name left_ptr &

# Hide cursor after 5 seconds of idling
if command -v unclutter >/dev/null; then
  unclutter -noevents -root &
fi

# Hide cursor when typing
if command -v xbanish >/dev/null; then
  xbanish &
fi

# Start urxvt daemon bound to this screen session
urxvtd -q -o -f

# Clipboard sync
if command -v autocutsel >/dev/null; then
  autocutsel -selection CLIPBOARD -fork
  autocutsel -selection PRIMARY -fork
fi

# Numlock
if command -v numlockx >/dev/null; then
  numlockx
fi

exec $HOME/.config/bspwm/init
