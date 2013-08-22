# Wrapper around mplayer which enables vaapi if we're on a machine
# with support. Also handles streaming content from RAR files.

command -v mplayer >/dev/null || return

mplayer() {
  case $1 in
    *.rar) unrar p -inul $1 2>/dev/null | /usr/bin/mplayer "$@" -;;
    *) /usr/bin/mplayer "$@";;
  esac
}
