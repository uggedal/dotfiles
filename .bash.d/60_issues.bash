# Alias for listing GitHub issues created by me

command -v ghi >/dev/null || return

alias issues='ghi list --all --filter created'
