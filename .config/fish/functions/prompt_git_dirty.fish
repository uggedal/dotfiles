function prompt_git_dirty
  not git diff --quiet --ignore-submodules HEAD >&- ^&-
end
