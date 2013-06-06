# Find file with the given name and optional context dir and edit it.
vimf() {
  local d='.'

  if [ $# -ne 1 -a $# -ne 2 ]; then
    printf 'Usage: %s [context] <file>\n' $(basename $0) >&2
    return 64
  fi

  if [ $# -eq 2 ]; then
    d=$1
    shift;
  fi

  local f=$(find $d -name "$1" -type f -print -quit)

  [ -n "$f" ] && $EDITOR "$f"
}
