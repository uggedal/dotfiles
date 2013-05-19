command -v vim >/dev/null || return

EDITOR=$(command -v vim)
VISUAL="$EDITOR"
export EDITOR VISUAL
