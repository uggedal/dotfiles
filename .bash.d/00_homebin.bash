# User local bin path

localbin=$HOME/bin

[ -d $localbin ] && [[ $PATH != *$localbin* ]] && PATH="$localbin:$PATH"

unset localbin
