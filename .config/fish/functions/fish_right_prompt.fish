function fish_right_prompt
  set -l last_status $status

  if test $last_status -ne 0
    set_color $__fish_color_prompt_error
    printf '%d' $last_status
    set_color normal
    return
  end

  if begin; prompt_git_tree; and prompt_git_dirty; end
    set_color $__fish_color_prompt_git_dirty
    printf '*'
    set_color normal
  end
end
