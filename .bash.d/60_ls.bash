# Use ls with:
#   - list directories before files
#   - human readable format for file sizes
#   - append indicators to directories (/), executables (*), symlinks (@),
#     sockets (=), and FIFOs (|)
#   - list dates for long listings in full iso format

alias ls='command ls \
  --group-directories-first \
  --human-readable \
  --classify \
  --time-style=long-iso \
  --color=auto'
