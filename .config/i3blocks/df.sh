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
  df -h $1 | tail -1 | awk "{ print \$$2 }"
}

status() {
  local mp=$1

  local free=$(_df $mp 4)
  local used=$(_df $mp 5)
  used=${used%%%}

  printf -- ' %s \n\n%s\n' $free $(color $used)
}

status "$@"
