# Use human readable format for file sizes and append indicators to
# directories (/), executables (*), symlinks (@), sockets (=), and FIFOs (|).
function ls
  command ls -hF --color=auto $argv
end
