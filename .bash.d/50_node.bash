# Local node modules

nodebin=$HOME/node_modules/.bin

[ -d $nodebin ] && [[ $PATH != *$nodebin* ]] && PATH="$PATH:$nodebin"

unset nodebin
