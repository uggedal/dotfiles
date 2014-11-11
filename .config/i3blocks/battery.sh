#!/bin/sh

. $(dirname $0)/colors.sh

color() {
  local state=$1
  local perc=$2
  local c=$GREEN

  [ "$perc" -lt 75 ] && c=$YELLOW
  [ "$perc" -lt 50 ] && c=$ORANGE
  [ "$perc" -lt 25 ] && c=$RED
  [ "$state" -eq 1 ] && c=$CYAN

  printf '%s' $c
}

status() {
  local sys=/sys/class/power_supply
  local ac=$sys/AC
  local bat=$sys/BAT$1

  [ -d $ac ] || return
  [ -d "$bat" ] || return

  [ "$2" = label ] && {
    printf 'B%d\n' $1
  }

  local now=$(cat $bat/energy_now)
  local full=$(cat $bat/energy_full)
  local perc=$(expr \( 100 \* $now \) / $full)
  local state=$(cat $ac/online)

  printf -- '%s%% \n\n%s\n' $perc $(color $state $perc)
}

status "$@"
