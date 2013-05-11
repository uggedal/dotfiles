function fish_right_prompt
  set -l last_status $status

  if test $last_status -ne 0
    set_color $__fish_color_prompt_error
    printf '%d' $last_status
    set_color normal
  end

  if prompt_git_dirty
    printf '*'
  end
end
