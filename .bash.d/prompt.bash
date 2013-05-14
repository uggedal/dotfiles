C_RED='\[\e[31m\]'
C_GREEN='\[\e[32m\]'
C_GREY='\[\e[1;34m\]'
C_RESET='\[\e[0m\]'

PS1=''

# Show hostname when connected over ssh:
if [ -n "$SSH_CONNECTION" ]; then
  PS1=$(_chemical_element_to_symbol $HOSTNAME)' '
fi

# Show $CWD:
PS1="$PS1"'\w '

# Color prompt symbol red when last command had a non-zero exit code:
_ok_status() {
  [ $1 -eq 0 -o $1 -eq 130 ]
}
PS1="$PS1"'$(_ok_status $? && printf "'${C_GREY}'" || printf "'${C_RED}'")'
PS1="${PS1}❯${C_RESET} "


# Custom virtualenv marker:
if command -v virtualenv >/dev/null; then
  _prompt_virtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
      printf $(basename $VIRTUAL_ENV)
    fi
  }

  PS1='${C_GREEN}$(_prompt_virtualenv)${C_RESET} '"$PS1"
fi
