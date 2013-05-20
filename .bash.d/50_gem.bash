# User local Ruby gems

command -v gem >/dev/null || return

GEM_HOME=$HOME/.gem
export GEM_HOME
[ -d $GEM_HOME/bin ] && PATH="$PATH:$GEM_HOME/bin"
