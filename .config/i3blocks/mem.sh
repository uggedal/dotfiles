#!/bin/sh

. $(dirname $0)/colors.sh

color() {
  local perc=$1
  local c=$RED

  [ "$perc" -lt 75 ] && c=$ORANGE
  [ "$perc" -lt 50 ] && c=$YELLOW
  [ "$perc" -lt 25 ] && c=$GREEN

  printf '%s' $c
}

_mem() {
  awk '
/^MemTotal:/ {
  total=$2
}
/^MemFree:/ {
  free=$2
}
/^Buffers:/ {
  buffers=$2
}
/^Cached:/ {
  cached=$2
}
END {
  unused=free+buffers+cached
  printf "%.1fG %.0f", (unused/1024/1024), ((total-unused)/total*100)
}
' /proc/meminfo
}

status() {
  local stats="$(_mem)"

  local free=${stats% *}
  local used=${stats#* }

  echo $used 1>&2

  printf -- '%s\n\n%s\n' $free $(color $used)
}

status "$@"
