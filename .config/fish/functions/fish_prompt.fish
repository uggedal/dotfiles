function fish_prompt
  if test -n "$VIRTUAL_ENV"
    set_color green
    printf '%s ' (basename $VIRTUAL_ENV)
    set_color normal
  end

  if test -n "$SSH_CONNECTION"
    printf '%s ' (chemical_element_to_symbol $HOSTNAME)
  end

  set_color $fish_color_cwd
  printf '%s ' (prompt_pwd)
  set_color normal
end

