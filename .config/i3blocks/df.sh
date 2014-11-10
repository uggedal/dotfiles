#!/bin/sh

. $(dirname $0)/colors.sh

color() {
  local perc=$1
  local c=$GREEN

  [ "$perc" -lt 75 ] && c=$YELLOW
  [ "$perc" -lt 50 ] && c=$ORANGE
  [ "$perc" -lt 25 ] && c=$RED

  printf '%s' $c
}

_df() {
  df -h $1 | tail -1 | awk "{ print \$$2 }"
}

status() {
  local mp=$1

  local free=$(_df $mp 4)
  local use=$(_df $mp 5)
  use=${use%%%}

  printf -- ' %s \n\n%s\n' $free $(color $use)
}

status "$@"
