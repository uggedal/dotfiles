# Check for updated ssh auth sock if we're inside tmux
function tmux_update_ssh_auth_sock
  if test -z $TMUX
    return
  end

  set -l updated_sock (tmux showenv | grep '^SSH_AUTH_SOCK' | cut -d= -f2)

  if test $SSH_AUTH_SOCK = $updated_sock
    return
  end

  if begin; test -n $updated_sock; and test -S $updated_sock; end
    set SSH_AUTH_SOCK $updated_sock
  end
end
