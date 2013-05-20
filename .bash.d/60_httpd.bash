# Poor man's httpd

command -v httpd >/dev/null && return

if [ $(python -c 'import sys; print(sys.version_info[0])') -eq 2 ]; then
  alias httpd='python -m SimpleHTTPServer'
else
  alias httpd='python -m http.server'
fi
