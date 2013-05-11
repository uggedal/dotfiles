function prompt_git_dirty
  if git rev-parse --is-inside-work-tree >&- ^&-
    if not git diff --quiet --ignore-submodules HEAD >&- ^&-
      return 0
    end
  end
  return 1
end
