#
# Helpers
#

function _which
  which "$argv[1]" >&- ^&-
end


#
# Env
#

set fish_greeting ''

set -gx HOSTNAME (hostname)

# Local bin dir:
if test -d "$HOME/bin"
  set -gx PATH "$HOME/bin" $PATH
end

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


#
# Aliases
#

function ls
  command ls -hF --color=auto $argv
end


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
# Colors
#

# Command:
set fish_color_command purple --bold
set fish_color_param normal

# Tokens:
set fish_color_quote green
set fish_color_operator red
set fish_color_escape red

# Comment:
set fish_color_comment aaa

# Auto suggestion:
set fish_color_autosuggestion aaa

# History search matches:
set fish_color_search_match --background=yellow


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
