if [ -z "$HOSTNAME_SYMBOL" ]; then
  HOSTNAME_SYMBOL=$(_chemical_element_to_symbol $HOSTNAME)
fi

C_RED=$'\033[0;31m'
C_GREY=$'\033[1;34m'
C_RESET=$'\033[m'

_prompt_symbol() {
  local last_status=$1

  if [ $last_status -eq 0 ]; then
    printf $C_GREY
  else
    printf $C_RED
  fi
  printf '❯'
  printf $C_RESET
}

PS1='$HOSTNAME_SYMBOL \w $(_prompt_symbol $?) '
