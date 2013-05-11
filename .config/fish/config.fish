#
# Helpers
#

function _which
  which "$argv[1]" >&- ^&-
end

function _prepend_path
  if begin; test -d $argv[1]; and not contains $argv[1] $PATH; end
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

# Keychain:
keychain_init_env

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

# Man:
set -gx MANWIDTH 80

# Grep highlight color:
# Fish itself aliases grep to grep --color=auto
set -gx GREP_COLORS 'ms=1;31'

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

# Prompt:
set fish_color_cwd normal
set fish_color_cwd_root red
set __fish_color_prompt_character b0b0b0
set __fish_color_prompt_error red
set __fish_color_prompt_git_dirty b0b0b0
set __fish_color_prompt_virtualenv green

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

function ssh
  keychain_prompt
  tmux_update_ssh_auth_sock
  command ssh $argv
end

function scp
  keychain_prompt
  tmux_update_ssh_auth_sock
  command scp $argv
end

function git
  set -l network_actions push pull fetch

  if contains $argv[1] $network_actions
    keychain_prompt
    tmux_update_ssh_auth_sock
  end

  command git $argv
end
