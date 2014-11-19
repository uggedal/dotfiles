_ssh_agent() {
  command -v ssh-agent >/dev/null || return
  [ "$SSH_CONNECTION" ] && return

  local agent_info=$HOME/.cache/ssh-agent-info

  if [ -f $agent_info ] && . $agent_info >/dev/null && kill -0 $SSH_AGENT_PID 2>/dev/null; then
    :
  else
    ssh-agent > $agent_info
    . $agent_info >/dev/null
  fi
}

_ssh_agent

_tmux_update_ssh_auth_sock() {
  [ -n "$TMUX" ] || return

  local sock=$(tmux showenv | grep '^SSH_AUTH_SOCK' | cut -d= -f2)

  [ "$SSH_AUTH_SOCK" = "$sock" ] && return

  if [ -S "$sock" ]; then
    SSH_AUTH_SOCK=$sock
  fi
}

_wrap_ssh() {
  [ "$SSH_CONNECTION" ] && return

  if ! ssh-add -l >/dev/null; then
    ssh-add $(grep -l 'ENCRYPTED$' .ssh/*id_rsa)
  fi
}

ssh() {
  _wrap_ssh "$@"
  _tmux_update_ssh_auth_sock
  command ssh "$@"
}

scp() {
  _wrap_ssh "$@"
  _tmux_update_ssh_auth_sock
  command scp "$@"
}

git() {
  case $1 in
    push|pull|fetch)
      _tmux_update_ssh_auth_sock
      _wrap_ssh git "$@"
      ;;
  esac

  command git "$@"
}
