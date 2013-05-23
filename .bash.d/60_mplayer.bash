# Wrapper around mplayer which enables vaapi if we're on a machine
# with support. Also handles streaming content from RAR files.

command -v mplayer >/dev/null || return

mplayer() {
  local opt=""

  if command -v vainfo >/dev/null && vainfo &>/dev/null; then
    opt="-vo vaapi"
  fi

  case $1 in
    *.rar) 7z x -so $1 2>/dev/null | /usr/bin/mplayer $opt -;;
    *) /usr/bin/mplayer $opt "$@";;
  esac
}
