# GPG agent

command -v gpg-agent >/dev/null || return

agent_info=$XDG_RUNTIME_DIR/gpg-agent-info

if [ -f $agent_info ] && kill -0 $(head -n1 $agent_info | cut -d: -f2) 2>/dev/null; then
  . $agent_info
  export GPG_AGENT_INFO SSH_AUTH_SOCK
else
  eval $(gpg-agent --daemon --enable-ssh-support --write-env-file $agent_info)
fi

unset agent_info
