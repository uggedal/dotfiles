command -v git >/dev/null || return

alias diff='git --no-pager diff --color=auto --no-ext-diff --no-index'
