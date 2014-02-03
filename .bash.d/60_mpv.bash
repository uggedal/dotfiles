# Wrapper around mpv which enables vaapi or vdpau if we're on a machine
# with support. Also handles streaming content from RAR files.

command -v mpv >/dev/null || return

mpv() {
  local xlog=/var/log/Xorg.0.log
  local flags=

  if test -f $xlog && grep -q 'VDPAU driver' $xlog; then
    flags='--vo vdpau --hwdec vdpau'
  elif command -v vainfo >/dev/null && vainfo &>/dev/null; then
    flags='--vo vaapi --hwdec vaapi'
  fi

  case $1 in
    *.rar) unrar p -inul $1 2>/dev/null | /usr/bin/mpv $flags "$@" -;;
    *) /usr/bin/mpv $flags "$@";;
  esac
}
