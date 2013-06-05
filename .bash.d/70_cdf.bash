# Find subdirectory with the given name and cd to it.
cdf() {

  local d=$(find . -name "$1" -type d | head -n1)

  [ -n "$d" ] && cd "$d"
}
