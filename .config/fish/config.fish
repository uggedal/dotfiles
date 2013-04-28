# Helpers
function _which
  which "$argv[1]" 2>/dev/null;
end

# Local bin dir
if test -d "$HOME/bin"
  set -gx PATH "$HOME/bin" $PATH
end

# Editor
if _which vim
  set -gx EDITOR (which vim)
  set -gx VISUAL "$EDITOR"
end
