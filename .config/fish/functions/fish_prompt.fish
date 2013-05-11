function fish_prompt
  set -l last_status $status

  if test -n "$VIRTUAL_ENV"
    set_color $__fish_color_prompt_virtualenv
    printf '%s ' (basename $VIRTUAL_ENV)
    set_color normal
  end

  if test -n "$SSH_CONNECTION"
    printf '%s ' (chemical_element_to_symbol $HOSTNAME)
  end

  if test $USER = root
    set_color $fish_color_cwd_root
  else
    set_color $fish_color_cwd
  end
  printf '%s ' (prompt_pwd)
  set_color normal

  if test $last_status -eq 0
    set_color $__fish_color_prompt_character
  else
    set_color $__fish_color_prompt_error
  end

  printf '❯ '
  set_color normal
end

