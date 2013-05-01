#
# Helpers
#

function _which
  which "$argv[1]" >&- ^&-;
end


#
# Env
#

set -gx HOSTNAME (hostname)

if test -d "$HOME/bin"
  set -gx PATH "$HOME/bin" $PATH
end

if _which vim
  set -gx EDITOR (which vim)
  set -gx VISUAL "$EDITOR"
end

if _which less
  set -gx PAGER (which less)
end

if _which chromium
  set -gx BROWSER (which chromium)
end

set fish_greeting ''


#
# Aliases
#

function ls; command ls -hF --color=auto $argv; end


#
# Prompt
#

function fish_prompt
  if test -n "$SSH_CONNECTION"
    printf '%s ' $HOSTNAME
  end

  printf '%s ' (prompt_pwd)
end

function fish_right_prompt
  set -l last_status $status

  if test $last_status -ne 0
    set_color red
    printf '%d' $last_status
    set_color normal
  end
end


#
# Keychain
#

function _keychain_init_env
  set -l keyenv $HOME/.keychain/$HOSTNAME-fish

  if test -e $keyenv
    # Need to have these vars set due to a bug in keychain env file for fish:
    set -xU SSH_AUTH_SOCK
    set -xU SSH_AGENT_PID

    . $keyenv
  end
end

_keychain_init_env

function _keychain_prompt
  set -l privkey $HOME/.ssh/id_rsa

  if _which keychain; and test -e $privkey; and status --is-interactive
    command keychain -q -Q --agents ssh $privkey
    _keychain_init_env
  end
end

function ssh
  _keychain_prompt
  command ssh $argv
end

function scp
  _keychain_prompt
  command scp $argv
end
