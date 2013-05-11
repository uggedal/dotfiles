function prompt_git_tree
  git rev-parse --is-inside-work-tree >&- ^&-
end
