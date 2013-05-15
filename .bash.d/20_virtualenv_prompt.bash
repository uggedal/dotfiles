command -v virtualenv >/dev/null || return

VIRTUAL_ENV_DISABLE_PROMPT=true
export VIRTUAL_ENV_DISABLE_PROMPT

_prompt_virtualenv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    printf '%s ' $(basename $VIRTUAL_ENV)
  fi
}

PS1=${C_GREEN}'$(_prompt_virtualenv)'${C_RESET}"$PS1"
