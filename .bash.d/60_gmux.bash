# Function for adjusting the display brightness on Macs with a gmux

[ -d /sys/class/backlight/gmux_backlight ] || return
command -v bc >/dev/null || return

gmux() {
  local gmux=/sys/class/backlight/gmux_backlight
  local cur=$gmux/brightness
  local max=$gmux/max_brightness
  local elevator='su root -c'

  if [ $# -eq 0 ]; then
    printf '%s%%\n' $(printf 'scale=0; (%s*100)/%s\n' $(<$cur) $(<$max) | bc)
  elif [ $# -eq 1 ]; then
    command -v sudo >/dev/null && elevator='sudo'
    $elevator "printf 'scale=0; (%s/100)*%s\n' $(<$max) $1 | bc > $cur"
  fi
}
