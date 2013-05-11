# Source keychain env if it's available
function keychain_init_env
  set -l keyenv $HOME/.keychain/$HOSTNAME-fish

  if test -e $keyenv
    # Need to have these vars set due to a bug in keychain env file for fish:
    set -xU SSH_AUTH_SOCK
    set -xU SSH_AGENT_PID

    . $keyenv
  end
end
