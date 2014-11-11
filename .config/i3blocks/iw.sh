#!/bin/sh

. $(dirname $0)/colors.sh

color() {
  local perc=$1
  local c=$GREEN

  # Max quality is 70
  [ "$perc" -lt 52 ] && c=$YELLOW
  [ "$perc" -lt 37 ] && c=$ORANGE
  [ "$perc" -lt 18 ] && c=$RED

  printf '%s' $c
}

status() {
  local if=$1

  command -v iw >/dev/null || return

  local ssid=$(iw $if link | awk '/SSID: / { print $2 }')
  local quality=$(awk /$if:' / { gsub(/\./, "", $3); print $3 }' /proc/net/wireless)

  printf -- '%s\n\n%s\n' $ssid $(color $quality)
}

status "$@"
