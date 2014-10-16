#
# Wraps ssh/scp/git to ensure an ssh-agent is running using
# keychain. Also makes sure that an active ssh auth socket
# is defined in the environment when using ssh/scp/git inside tmux.
#


_keychain_init() {
  command -v keychain >/dev/null || return

  local private_key=$HOME/.ssh/id_rsa
  [ -e $private_key ] || return 1
  eval $(keychain --quiet --quick --agents ssh --eval $private_key)
}

_tmux_update_ssh_auth_sock() {
  [ -n "$TMUX" ] || return

  local updated_sock=$(tmux showenv | grep '^SSH_AUTH_SOCK' | cut -d= -f2)

  [ "$SSH_AUTH_SOCK" = "$updated_sock" ] && return

  if [ -S "$updated_sock" ]; then
    SSH_AUTH_SOCK=$updated_sock
  fi
}

if command -v ssh >/dev/null; then
  ssh() {
    _keychain_init
    _tmux_update_ssh_auth_sock
    command ssh "$@"
  }
fi

if command -v scp >/dev/null; then
  scp() {
    _keychain_init
    _tmux_update_ssh_auth_sock
    command scp "$@"
  }
fi

if command -v git >/dev/null; then
  git() {
    local network_actions='(push|pull|fetch)'
    local binary=git

    if [[ $1 =~ $network_actions ]]; then
      _keychain_init
      _tmux_update_ssh_auth_sock
    fi

    command -v hub >/dev/null && binary=hub

    command $binary "$@"
  }
fi
