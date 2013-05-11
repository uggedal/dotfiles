function scp
  keychain_prompt
  tmux_update_ssh_auth_sock
  command scp $argv
end
