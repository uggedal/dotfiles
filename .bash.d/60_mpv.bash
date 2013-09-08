# Wrapper around mpv which enables vaapi or vdpau if we're on a machine
# with support.

command -v mpv >/dev/null || return

mpv() {
  local xlog=/var/log/Xorg.0.log
  local flags=

  if test -f $xlog && grep -q 'VDPAU driver' $xlog; then
    echo VDPAU
    flags='--vo vdpau --hwdec vdpau'
  elif command -v vainfo >/dev/null && vainfo &>/dev/null; then
    echo VAAPI
    flags='--vo vaapi --hwdec vaapi'
  fi

  /usr/bin/mpv $flags "$@"
}
