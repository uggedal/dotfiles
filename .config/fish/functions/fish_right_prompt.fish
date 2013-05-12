function fish_right_prompt
  set -l last_status $status

  if test $last_status -ne 0
    set_color $__fish_color_prompt_error
    printf '%d' $last_status
    set_color normal
    return
  end

  set -l git_branch (command git rev-parse --abbrev-ref HEAD ^&-)

  if test -z $git_branch
    return
  end

  if not git diff --quiet --ignore-submodules HEAD >&- ^&-
    set_color $__fish_color_prompt_git_dirty
    printf '*'
    set_color normal
  end

  set_color $__fish_color_prompt_git_branch
  if test $git_branch = master
    printf 'm'
  else
    printf $git_branch
  end
  set_color normal
end
