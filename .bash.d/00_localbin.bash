# User local bin path

localbin=$HOME/.local/bin

[ -d $localbin ] && [[ $PATH != *$localbin* ]] && PATH="$localbin:$PATH"

unset localbin
