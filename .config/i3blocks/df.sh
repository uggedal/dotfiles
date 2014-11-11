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

_df() {
  df -h $1 | awk '
  /^\// {
    free=$4
    used=$5
    exit 0
  }
  END {
    gsub(/%$/, "", used)
    printf "%s %s", free, used
  }'
}

status() {
  local mp=$1
  local stats="$(_df $mp)"

  local free=${stats% *}
  local used=${stats#* }

  printf -- '%s\n\n%s\n' $free $(color $used)
}

status "$@"
