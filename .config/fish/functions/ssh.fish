function ssh
  keychain_prompt
  tmux_update_ssh_auth_sock
  command ssh $argv
end
