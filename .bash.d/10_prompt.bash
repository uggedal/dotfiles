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

# Use unicode prompt symbol in when:
#   - running with UTF-8 locale and
#   - not in real console where fonts are limited to ASCII
if tty | grep -F /dev/pts >/dev/null && [[ $LANG == *UTF-8* ]]; then
  prompt_symbol='❯'
else
  prompt_symbol='>'
fi

# Color prompt symbol red when last command had a non-zero exit code:
_ok_status() {
  [ $1 -eq 0 -o $1 -eq 130 ]
}
PS1="$PS1"'$(_ok_status $? && printf "'${C_GREY}'" || printf "'${C_RED}'")'
PS1="${PS1}${prompt_symbol}${C_RESET} "

PS2="${C_GREY}${prompt_symbol}${C_RESET} "

unset prompt_symbol
