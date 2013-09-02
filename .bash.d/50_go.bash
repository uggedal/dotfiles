# Local go path

command -v go >/dev/null || return

GOPATH=$HOME/src/go
export GOPATH

gobin=$GOPATH/.bin

[ -d $gobin ] && [[ $PATH != *$gobin* ]] && PATH="$PATH:$gobin"

unset gobin
