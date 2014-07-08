# Wrapper around mpv which enables streaming of content from RAR files.

command -v mpv >/dev/null || return

mpv() {
  local flags='--vo vaapi --hwdec vaapi'

  case "$1" in
    *.rar) unrar p -inul "$1" 2>/dev/null | /usr/bin/mpv $flags "$@" -;;
    *) /usr/bin/mpv $flags "$@";;
  esac
}
