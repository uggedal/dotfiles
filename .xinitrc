# Expand font path
xset +fp /usr/share/fonts/local
xset fp rehash

# Load local .Xresources
xrdb -merge $HOME/.Xresources

if lsmod | grep ^vboxguest >/dev/null; then
  # VBox sync
  if [ -x /usr/bin/VBoxClient-all ]; then
    VBoxClient-all&
  fi
else
  # Swap option and command buttons for Mac when not in a vbox guest
  setxkbmap -option altwin:swap_alt_win
fi

# Enable compose key
setxkbmap -option compose:rwin

if [ -x /usr/bin/xmodmap -a -f $HOME/.Xmodmap ]; then
  /usr/bin/xmodmap $HOME/.Xmodmap
fi

# Root window background
xsetroot -solid '#f5f5f5'

# Nicer pointer over root window
xsetroot -cursor_name left_ptr &

# Hide cursor after 5 seconds of idling
/usr/bin/unclutter -noevents -root &

# Start urxvt daemon bound to this screen session
/usr/bin/urxvtd -q -o -f

# Clipboard sync
/usr/bin/autocutsel -selection CLIPBOARD -fork
/usr/bin/autocutsel -selection PRIMARY -fork

exec i3
