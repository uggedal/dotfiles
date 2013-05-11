# Display keychain prompt if ssh-agent holds no keys
function keychain_prompt
  if not status --is-interactive
    return
  end

  set -l privkey $HOME/.ssh/id_rsa

  if begin; _which keychain; and test -e $privkey; end
    command keychain -q -Q --agents ssh $privkey
    keychain_init_env
  end
end

