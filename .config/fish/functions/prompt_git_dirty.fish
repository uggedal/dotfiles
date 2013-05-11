function prompt_git_dirty
  if not git diff --quiet --ignore-submodules HEAD >&- ^&-
    return 0
  end
  return 1
end
