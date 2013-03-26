#
# env shared between bash and zsh
#

_which() {
  which "$1" &>/dev/null;
}

_root() {
  [ "$EUID" = "0" ]
}

# path
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# secrets
if [ -d "$HOME/.secrets" ]; then
  . "$HOME/.secrets"
fi

# keychain
if [ -e $HOME/.ssh/id_rsa -a -x /usr/bin/keychain ];then
  eval $(keychain --eval --agents ssh --quick --quiet id_rsa)
fi

# go
if [ -d "$HOME/dev/go" ]; then
  export GOPATH=$HOME/dev/go
  export PATH=$PATH:$GOPATH/bin
fi

# ruby
if [ -d "$HOME/.gem" ]; then
  export GEM_HOME=$HOME/.gem
  export PATH=$PATH:$GEM_HOME/bin
fi

# node
if [ -d "$HOME/node_modules" ]; then
  export PATH=$PATH:$HOME/node_modules/.bin
fi

# editor
if _which vim; then
  export EDITOR="$(which vim)"
  export VISUAL="$EDITOR"
fi

# pager
if _which less; then
  export PAGER=less

  export LESS="-F -X -R"
  export LESS_TERMCAP_mb=$'\E[01;31m'
  export LESS_TERMCAP_md=$'\E[01;31m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[01;44;33m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[01;32m'
fi

# grep
alias grep='grep --color=auto'
export GREP_COLOR="1;33"

# aliases
alias ls='ls -hF --color'
alias rmpyc='find . -name \*.pyc -exec rm -v {} \;'
if _which bc; then
  alias bc='bc -ql'
fi
if _which lsof; then
  alias ports='lsof -i -P -sTCP:LISTEN'
fi
if _root; then
  if _which pacman; then
    alias pacman-orphans='pacman -Qtdq && pacman -Rs $(pacman -Qtdq)'
  fi
fi
if _which cloc; then
  alias cloc="cloc --exclude-dir=.git,.hg"
fi
if _which dig; then
  alias extip="dig +short myip.opendns.com @resolver1.opendns.com"
fi
if _which free; then
  alias free="free -m"
fi
if _which vmstat; then
  alias iostat="vmstat 1"
fi
if _which iostat; then
  alias iostat="iostat -xkdz 1"
fi
if _which mpstat; then
  alias iostat="mpstat -P ALL 1"
fi

# functions

function f() {
  local opts="-I"
  if $(echo "$@" | grep -ve "[A-Z]" > /dev/null); then
    local opts="${opts}i"
  fi
  if [ "$1" = '-v' ]; then
    local opts="${opts}n"
    shift
  else
    local opts="${opts}l"
  fi
  find . -path '*/.git' -prune \
  -o -path '*/.hg' -prune \
  -o -path '*/.svn' -prune \
  -o -name '*.swp' -prune \
  -o -name '*.pyc' -prune \
  -o -type f -print0 | xargs -0 grep $opts --color=auto "$@"
}

function replace() {
  find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/$1/$2/g"
}
