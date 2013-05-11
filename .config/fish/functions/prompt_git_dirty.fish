function prompt_git_dirty
  if git rev-parse --is-inside-work-tree >&- ^&-
    git diff --quiet --ignore-submodules HEAD >&- ^&-
    if test $status -eq 1
      return 0
    end
  end
  return 1
end
