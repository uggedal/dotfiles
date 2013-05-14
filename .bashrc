# Bail if not running interactively:
[ -z "$PS1" ] && return

#
# Environment
#

[ -d $HOME/bin ] && PATH="$HOME/bin:$PATH"

if command -v vim >/dev/null; then
  EDITOR=$(command -v vim)
  VISUAL="$EDITOR"
  export EDITOR VISUAL
fi

if command -v less >/dev/null; then
  PAGER=$(command -v less)

  # Make less:
  #   - quit if paged content fits in one screen
  #   - not clear the screen when exiting
  #   - output raw ANSI control characters (used for coloring below)
  #   - use smart case insensitive search
  LESS="-FXRi"

  # colored man pages:
  LESS_TERMCAP_md=$'\e[1;31m'     # start bold
  LESS_TERMCAP_so=$'\e[1;40;37m'  # start standout
  LESS_TERMCAP_se=$'\e[0m'        # end standout
  LESS_TERMCAP_us=$'\e[0;34m'     # start underlining
  LESS_TERMCAP_ue=$'\e[0m'        # end underlining
  LESS_TERMCAP_me=$'\e[0m'        # end all modes

  export PAGER LESS LESS_TERMCAP_md LESS_TERMCAP_so LESS_TERMCAP_se \
         LESS_TERMCAP_us LESS_TERMCAP_ue LESS_TERMCAP_me
fi

# Make man pages more readable:
MANWIDTH=80
export MANWIDTH

# Coloring of grep matches:
GREP_OPTIONS='--color=auto'
GREP_COLORS='ms=1;31'
export GREP_OPTIONS GREP_COLORS

# Go:
if [ -d $HOME/dev/go ]; then
  GOPATH=$HOME/dev/go
  export GOPATH
  [ -d $GOPATH/bin ] && PATH="$PATH:$GOPATH/bin"
fi

# Local Ruby gems:
if command -v gem >/dev/null; then
  GEM_HOME=$HOME/.gem
  export GEM_HOME
  [ -d $GEM_HOME/bin ] && PATH="$PATH:$GEM_HOME/bin"
fi

# Local node modules:
[ -d ~/node_modules/.bin ] && PATH="$PATH:~/node_modules/.bin"

# Disable default virtualenv prompt:
if command -v virtualenv >/dev/null; then
  VIRTUAL_ENV_DISABLE_PROMPT=true
  export VIRTUAL_ENV_DISABLE_PROMPT
fi


#
# Aliases
#

# Use ls with:
#   - human readable format for file sizes
#   - append indicators to directories (/), executables (*), symlinks (@),
#     sockets (=), and FIFOs (|)
#   - list dates for long listings in full iso format
alias ls='command ls -hF --time-style=long-iso --color=auto'

# Surpress bc welcome msg and load math lib with 20 as default scale:
alias bc='command bc -ql'

# Start cal week on monday:
alias cal='command cal -m'

# Tmux is notoriously bad at detecting UTF-8 support, so we force it:
alias tmux='command tmux -u'


#
# Components
#   - activate/deactivate by making the component file executable or not
#

if [ -d ~/.bash.d ]; then
  for component in ~/.bash.d/*.bash; do
    [ -x $component ] && . $component
  done
  unset component
fi
