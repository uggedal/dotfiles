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

  if not command git diff --quiet --ignore-submodules HEAD >&- ^&-
    set_color $__fish_color_prompt_git_dirty
    printf '*'
    set_color normal
  end

  if test $git_branch != master
    set_color $__fish_color_prompt_git_branch
    printf $git_branch
    set_color normal
  end
end
