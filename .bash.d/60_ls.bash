# Use ls with:
#   - list files in one column
#   - human readable format for file sizes
#   - append indicators to directories (/), executables (*), symlinks (@),
#     sockets (=), and FIFOs (|)
#   - list dates for long listings in full iso format (if supported)
#   - list directories before files (if supported)

ls_flags='-1hF --color=auto'

# Check for GNU specific options:
if command ls --time-style=long-iso --group-directories-first / &>/dev/null; then
  ls_flags="$ls_flags --time-style=long-iso --group-directories-first"
fi

alias ls="command ls $ls_flags"

unset ls_flags
unset LS_COLORS
