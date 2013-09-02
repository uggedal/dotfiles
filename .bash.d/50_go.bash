# Local go path

command -v go >/dev/null || return

GOPATH=$HOME/src/go
export GOPATH
