# SSH agent

command -v ssh-agent >/dev/null || return

agent_info=$HOME/.cache/ssh-agent-info

if [ -f $agent_info ] && . $agent_info >/dev/null && kill -0 $SSH_AGENT_PID 2>/dev/null; then
  :
else
  ssh-agent > $agent_info
  . $agent_info >/dev/null
fi

unset agent_info

_wrap_ssh() {
  local cmd=$1
  shift

  if ssh-add -l >/dev/null; then
    unset -f $cmd
  else
    ssh-add
  fi

  command $cmd "$@"
}

ssh() {
  _wrap_ssh ssh "$@"
}

scp() {
  _wrap_ssh scp "$@"
}

git() {
  case $1 in
    push|pull|fetch)
      _wrap_ssh git "$@"
      ;;
    *)
      command git "$@"
      ;;
  esac
}
