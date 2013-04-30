#
# Helpers
#

function _which
  which "$argv[1]" >&- ^&-;
end


#
# Env
#


if test -d "$HOME/bin"
  set -gx PATH "$HOME/bin" $PATH
end

if _which vim
  set -gx EDITOR (which vim)
  set -gx VISUAL "$EDITOR"
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
    printf '%s ' (hostname)
  end

  printf '%s ' (prompt_pwd)
end

function fish_right_prompt
  set -l last_status $status

  if test $last_status -ne 0
    set_color red
    printf '%d ' $last_status
    set_color normal
  end
end
