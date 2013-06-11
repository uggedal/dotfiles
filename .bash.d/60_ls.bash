# Use ls with:
#   - list files in one column
#   - list directories before files
#   - human readable format for file sizes
#   - append indicators to directories (/), executables (*), symlinks (@),
#     sockets (=), and FIFOs (|)
#   - list dates for long listings in full iso format

ls_flags='-1 --human-readable --classify --time-style=long-iso --color=auto'

# ls --group-directories-first was introduced in coreutils 6.0 (2006-08-15).
# Since RHEL 5.x uses 5.97 we need to check for it:
if command ls --group-directories-first / &>/dev/null; then
  ls_flags="$ls_flags --group-directories-first"
fi

alias ls="command ls $ls_flags"

unset ls_flags
