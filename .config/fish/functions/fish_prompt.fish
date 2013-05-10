function fish_prompt
  if test -n "$VIRTUAL_ENV"
    set_color green
    printf '%s ' (basename $VIRTUAL_ENV)
    set_color normal
  end

  if test -n "$SSH_CONNECTION"
    printf '%s ' $HOSTNAME
  end

  printf '%s ' (prompt_pwd)
end

