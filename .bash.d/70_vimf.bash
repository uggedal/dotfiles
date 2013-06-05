# Find file with the given name and edit it.
vimf() {

  local f=$(find . -name "$1" -type f -print -quit)

  [ -n "$f" ] && $EDITOR "$f"
}
