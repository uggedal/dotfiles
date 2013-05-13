C_RED=$'\033[0;31m'
C_GREEN=$'\033[0;32m'
C_GREY=$'\033[1;34m'
C_RESET=$'\033[m'

# Only show hostname when connected over ssh:
if [ -n "$SSH_CONNECTION" ]; then
  HOSTNAME_SYMBOL=$(_chemical_element_to_symbol $HOSTNAME)' '
fi

# Color prompt symbol red when last command had a non-zero exit code:
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

# Custom virtualenv marker:
_prompt_virtualenv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    printf '%s%s%s ' $C_GREEN $(basename $VIRTUAL_ENV) $C_RESET
  fi
}

PS1='$(_prompt_virtualenv)$HOSTNAME_SYMBOL\w $(_prompt_symbol $?) '
