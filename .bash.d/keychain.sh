# Bail if we don't have keychain on the path:
command -v keychain >/dev/null || return

keychain_init() {
  local private_key=$HOME/.ssh/id_rsa

  [ -e $private_key ] || return 1
  eval $(keychain --quiet --quick --agents ssh --eval $private_key)
}

if command -v ssh >/dev/null; then
  ssh() {
    keychain_init
    command ssh "$@"
  }
fi

if command -v scp >/dev/null; then
  ssh() {
    keychain_init
    command scp "$@"
  }
fi

if command -v git >/dev/null; then
  git() {
    local network_actions='(push|pull|fetch)'

    if [[ $1 =~ $network_actions ]]; then
      keychain_init
    fi

    command git "$@"
  }
fi
