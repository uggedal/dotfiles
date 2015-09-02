# Expand font path
for p in /usr/share/fonts/misc /usr/share/fonts/local; do
  [ -d $p ] || continue
  xset +fp $p
  xset fp rehash
done

# Load local .Xresources
xrdb -merge $HOME/.Xresources
if [ -e $HOME/.Xresources-$(hostname -s) ]; then
  xrdb -merge $HOME/.Xresources-$(hostname -s)
fi

# VBox sync
if command -v VBoxClient-all >/dev/null; then
  VBoxClient-all &
fi

# Enable compose key
setxkbmap -option compose:ralt

# Root window background and nicer pointer over root window
xsetroot -solid '#282828' -cursor_name left_ptr &

# Hide cursor after 5 seconds of idling
if command -v unclutter >/dev/null; then
  unclutter -noevents -root &
fi

# Start urxvt daemon bound to this screen session
urxvtd -q -o -f

# Clipboard sync
if command -v autocutsel >/dev/null; then
  autocutsel -selection CLIPBOARD -fork
  autocutsel -selection PRIMARY -fork
fi

# Screen lock
if command -v xautolock >/dev/null && command -v slock >/dev/null; then
  xautolock -time 10 -locker slock &
fi

exec herbstluftwm --locked
