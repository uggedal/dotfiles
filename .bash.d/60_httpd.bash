# Poor man's httpd

command -v httpd >/dev/null && return
command -v python >/dev/null && return

httpd() {
  if [ "$(python -c 'import sys; print(sys.version_info[0])')" -eq 2 ]; then
    python -m SimpleHTTPServer "$@"
  else
    python -m http.server "$@"
  fi
}
