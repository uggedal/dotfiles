# GPG agent

gpg-agent --version 2>/dev/null | fgrep -q 'gpg-agent (GnuPG) 2.0' 2>/dev/null || return

GPG_TTY=$(tty)
export GPG_TTY

agent_info=$HOME/.cache/gpg-agent-info

if [ -f $agent_info ] && kill -0 $(head -n1 $agent_info | cut -d: -f2) 2>/dev/null; then
  . $agent_info
else
  eval $(gpg-agent --daemon --write-env-file $agent_info)
fi

export GPG_AGENT_INFO

unset agent_info
