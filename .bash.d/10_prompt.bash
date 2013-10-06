C_RED='\[\e[31m\]'
C_RESET='\[\e[0m\]'

# Save the last commands exit code:
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'_prompt_status=$?'

PS1=''

# Show hostname when connected over ssh:
if [ -n "$SSH_CONNECTION" ]; then
  PS1=$(_chemical_element_to_symbol $HOSTNAME)' '
fi

# Color prompt symbol red when last command had a non-zero exit code:
_ok_status() {
  local rc=$_prompt_status
  unset _prompt_status
  [ $rc -eq 0 -o $rc -eq 130 ]
}
PS1="$PS1"'$(_ok_status || printf "'${C_RED}'")\w'"${C_RESET} "

unset prompt_symbol
