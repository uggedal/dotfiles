function git
  set -l network_actions push pull fetch

  if contains $argv[1] $network_actions
    keychain_prompt
    tmux_update_ssh_auth_sock
  end

  command git $argv
end
