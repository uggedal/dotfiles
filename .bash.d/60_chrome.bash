command -v chromium >/dev/null && return
command -v google-chrome >/dev/null || return

alias chromium='google-chrome'
