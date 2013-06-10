# Use ls with:
#   - list files in one column
#   - list directories before files
#   - human readable format for file sizes
#   - append indicators to directories (/), executables (*), symlinks (@),
#     sockets (=), and FIFOs (|)
#   - list dates for long listings in full iso format

# Check for newer capabilities:
command ls --group-directories-first / &>/dev/null || return

alias ls="command ls \
  -1 \
  --group-directories-first \
  --human-readable \
  --classify \
  --time-style=long-iso \
  --color=auto"
