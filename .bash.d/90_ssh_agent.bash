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
