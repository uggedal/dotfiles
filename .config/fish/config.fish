#
# Helpers
#

function _which
  which "$argv[1]" >&- ^&-
end

function _prepend_path
  if test -d $argv[1]; and not contains $argv[1] $PATH
    set -gx PATH $argv[1] $PATH
  end
end


#
# Env
#

set -e fish_greeting

set -gx HOSTNAME (hostname -s)

# Local bin dir:
_prepend_path $HOME/bin

# Editor:
if _which vim
  set -gx EDITOR (which vim)
  set -gx VISUAL "$EDITOR"
end

# Pager:
if _which less
  set -gx PAGER (which less)
  set -gx LESS "-F -X -R"

  # colored man pages:
  set -gx LESS_TERMCAP_md (printf \e\[1\;31m)     # start bold
  set -gx LESS_TERMCAP_so (printf \e\[1\;40\;37m) # start standout
  set -gx LESS_TERMCAP_se (printf \e\[0m)         # end standout
  set -gx LESS_TERMCAP_us (printf \e\[0\;34m)     # start underlining
  set -gx LESS_TERMCAP_ue (printf \e\[0m)         # end underlining
  set -gx LESS_TERMCAP_me (printf \e\[0m)         # end all modes
end

# Grep highlight color:
# Fish itself aliases grep to grep --color=auto
set -gx GREP_COLOR '1;32'

# Browser:
if _which chromium
  set -gx BROWSER (which chromium)
end

# Go:
if test -d $HOME/dev/go
  set -gx GOPATH $HOME/dev/go
  _prepend_path $GOPATH/bin
end

# Ruby
if _which gem
  set -gx GEM_HOME $HOME/.gem
  _prepend_path $GEM_HOME/bin
end

# Node
_prepend_path $HOME/node_modules/.bin

# Python
if _which virtualenv
  set -gx VIRTUAL_ENV_DISABLE_PROMPT true
end


#
# Colors
#

# Command:
set fish_color_command aa759f --bold
set fish_color_param normal

# Tokens:
set fish_color_quote green
set fish_color_operator red
set fish_color_escape red

# Comment:
set fish_color_comment b0b0b0

# Auto suggestion:
set fish_color_autosuggestion b0b0b0

# History search matches:
set fish_color_search_match normal --background=yellow

# Pager:
set fish_pager_color_prefix blue
set fish_pager_color_description b0b0b0
set fish_pager_color_progress black


#
# Lazily update keychain and agent fowarding when using ssh, scp and git
#

# Source keychain env if it's available
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

# Display keychain prompt if ssh-agent holds no keys
function _keychain_prompt
  set -l privkey $HOME/.ssh/id_rsa

  if _which keychain; and test -e $privkey; and status --is-interactive
    command keychain -q -Q --agents ssh $privkey
    _keychain_init_env
  end
end

# Check for updated ssh auth sock if we're inside tmux
function _update_ssh_auth_sock
  if test -z $TMUX
    return
  end

  set -l updated_sock (tmux showenv | grep '^SSH_AUTH_SOCK' | cut -d= -f2)

  if test $SSH_AUTH_SOCK = $updated_sock
    return
  end

  if test -n $updated_sock; and test -S $updated_sock
    set SSH_AUTH_SOCK $updated_sock
  end
end

function ssh
  _keychain_prompt
  _update_ssh_auth_sock
  command ssh $argv
end

function scp
  _keychain_prompt
  _update_ssh_auth_sock
  command scp $argv
end

function git
  set -l network_actions push pull fetch

  if contains $argv[1] $network_actions
    _keychain_prompt
    _update_ssh_auth_sock
  end

  command git $argv
end
