#
# Helpers
#

function _which
  which "$argv[1]" >- ^-;
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


#
# Aliases
#

function ls; ls -hF --color=auto $argv; end
