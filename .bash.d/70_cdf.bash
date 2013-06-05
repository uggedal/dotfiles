# Find subdirectory with the given name and cd to it.
cdf() {

  local d=$(find . -name "$1" -type d -print -quit)

  [ -n "$d" ] && cd "$d"
}