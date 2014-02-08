# Wrapper around mpv which enables vaapi or vdpau if we're on a machine
# with support. Also handles streaming content from RAR files.

command -v mpv >/dev/null || return

mpv() {
  local xlog=/var/log/Xorg.0.log
  local flags='--vo vaapi --hwdec vaapi'

  case "$1" in
    *.rar) unrar p -inul "$1" 2>/dev/null | /usr/bin/mpv $flags "$@" -;;
    *) /usr/bin/mpv $flags "$@";;
  esac
}
