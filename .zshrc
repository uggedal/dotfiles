### X

command -v startx >/dev/null && [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ] &&
  exec startx

### ENVIRONMENT

export EDITOR=$(command -v vim)
export VISUAL=$EDITOR

export PAGER=$(command -v less)

# Make less:
#   - quit if paged content fits in one screen
#   - not clear the screen when exiting
#   - output raw ANSI control characters (used for coloring below)
#   - use smart case insensitive search
export LESS="-FXRi"

# Colored man pages:
export LESS_TERMCAP_md=$'\e[1;31m'     # start bold
export LESS_TERMCAP_so=$'\e[1;40;37m'  # start standout
export LESS_TERMCAP_se=$'\e[0m'        # end standout
export LESS_TERMCAP_us=$'\e[0;34m'     # start underlining
export LESS_TERMCAP_ue=$'\e[0m'        # end underlining
export LESS_TERMCAP_me=$'\e[0m'        # end all modes

export MANWIDTH=80

# Colorized grep matches:
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
export GREP_COLORS='ms=1;32'

# Use ls with:
#   - list files in one column
#   - human readable format for file sizes
#   - append indicators to directories (/), executables (*), symlinks (@),
#     sockets (=), and FIFOs (|)
#   - list dates for long listings in full iso format (if supported)
#   - list directories before files (if supported)
ls_flags='-1hF --color=auto'
gnu_ls_flags='--time-style=long-iso --group-directories-first'
if command ls $gnu_ls_flags / >/dev/null 2>&1; then
  ls_flags="$ls_flags $gnu_ls_flags"
fi
alias ls="ls $ls_flags"
unset ls_flags
unset LS_COLORS

# Local bin
[ -d $HOME/.local/bin ] && [[ :$PATH: != *:$HOME/.local/bin:* ]] &&
  PATH=$HOME/.local/bin:$PATH

#  Gruvbox colors:
[ -x $HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh ] &&
  $HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh

### HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

### JOB CONTROL

setopt LONG_LIST_JOBS

### GLOBBING
#
setopt NO_NOMATCH

### DIR STACK

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

alias d=dirs\ -v
for _i ({1..9}); do
  alias $_i=cd\ +$_i
done
unset _i

### EDITING

bindkey -v

# Make backspace work after leaving command mode:
bindkey '^?' backward-delete-char

# Prefix history search:
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Substring history search:
bindkey -M vicmd '?' history-incremental-pattern-search-backward
bindkey -M vicmd '/' history-incremental-pattern-search-forward

# emacs history search:
bindkey '^R' history-incremental-pattern-search-backward

# Undo:
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo

# Edit cmdline in $EDITOR:
zle -N edit-command-line
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

for _m in viins vicmd; do
    # No arrow keys:
    bindkey -M $_m '^[[C' beep
    bindkey -M $_m '^[[D' beep

    # No annoying PGUP/DOWN bindings:
    bindkey -M $_m '^[[5~' beep
    bindkey -M $_m '^[[6~' beep
done
unset _m

KEYTIMEOUT=1

# Toggle fg/suspend:
_fg() { fg 2>/dev/null; }
zle -N _fg
bindkey '^Z' _fg

### COMPLETION

zmodload zsh/complist
autoload -Uz compinit && compinit

zstyle ':completion::complete:*' use-cache true

# Allow completing .. to ../:
zstyle ':completion:*' special-dirs ..
# Do not treat // as /*/:
zstyle ':completion:*' squeeze-slashes true
# Ambiguity color:
zstyle ':completion:*' show-ambiguity '32'
# Scrollable completion lists:
zstyle ':completion:*' list-prompt ''
# No completion for completion functions:
zstyle ':completion:*:functions' ignored-patterns '_*'

### OUTPUT

MAILCHECK=0
LISTMAX=0
REPORTTIME=60
autoload -Uz colors && colors
TIMEFMT="
%J

wall: $fg[green]%*E$reset_color
user: $fg[yellow]%U$reset_color
sys:  $fg[yellow]%S$reset_color
cpu:  $fg[blue]%P$reset_color
mem:  $fg[blue]%MM$reset_color"

# URL auto quote:
autoload -U url-quote-magic
zstyle ':urlglobber' url-other-schema git http https
zstyle ':url-quote-magic:*' url-metas '?^#='
zle -N self-insert url-quote-magic

### PROMPT

_prompt_host() {
  [ "$SSH_CONNECTION" ] || return

  local host=$(hostname)
  local element="${host%%.*}"

  typeset -A _e
  _e[hydrogen]=h;_e[helium]=he;_e[lithium]=li;_e[beryllium]=be;_e[boron]=b;_e[carbon]=c;_e[nitrogen]=n;_e[oxygen]=o;_e[fluorine]=f;_e[neon]=ne;_e[sodium]=na;_e[magnesium]=mg;_e[aluminium]=al;_e[silicon]=si;_e[phosphorus]=p;_e[sulfur]=s;_e[chlorine]=cl;_e[argon]=ar;_e[potassium]=k;_e[calcium]=ca;_e[scandium]=sc;_e[titanium]=ti;_e[vanadium]=v;_e[chromium]=cr;_e[manganese]=mn;_e[iron]=fe;_e[cobalt]=co;_e[nickel]=ni;_e[copper]=cu;_e[zinc]=zn;_e[gallium]=ga;_e[germanium]=ge;_e[arsenic]=as;_e[selenium]=se;_e[bromine]=br;_e[krypton]=kr;_e[rubidium]=rb;_e[strontium]=sr;_e[yttrium]=y;_e[zirconium]=zr;_e[niobium]=nb;_e[molybdenum]=mo;_e[technetium]=tc;_e[ruthenium]=ru;_e[rhodium]=rh;_e[palladium]=pd;_e[silver]=ag;_e[cadmium]=cd;_e[indium]=in;_e[tin]=sn;_e[antimony]=sb;_e[tellurium]=te;_e[iodine]=i;_e[xenon]=xe;_e[cesium]=cs;_e[barium]=ba;_e[lanthanum]=la;_e[cerium]=ce;_e[praseodymium]=pr;_e[neodymium]=nd;_e[promethium]=pm;_e[samarium]=sm;_e[europium]=eu;_e[gadolinium]=gd;_e[terbium]=tb;_e[dysprosium]=dy;_e[holmium]=ho;_e[erbium]=er;_e[thulium]=tm;_e[ytterbium]=yb;_e[lutetium]=lu;_e[hafnium]=hf;_e[tantalum]=ta;_e[tungsten]=w;_e[rhenium]=re;_e[osmium]=os;_e[iridium]=ir;_e[platinum]=pt;_e[gold]=au;_e[mercury]=hg;_e[thallium]=tl;_e[lead]=pb;_e[bismuth]=bi;_e[polonium]=po;_e[astatine]=at;_e[radon]=rn;_e[francium]=fr;_e[radium]=ra;_e[actinium]=ac;_e[thorium]=th;_e[protactinium]=pa;_e[uranium]=u;_e[neptunium]=np;_e[plutonium]=pu;_e[americium]=am;_e[curium]=cm;_e[berkelium]=bk;_e[californium]=cf;_e[einsteinium]=es;_e[fermium]=fm;_e[mendelevium]=md;_e[nobelium]=no;_e[lawrencium]=lr;_e[rutherfordium]=rf;_e[dubnium]=db;_e[seaborgium]=sg;_e[bohrium]=bh;_e[hassium]=hs;_e[meitnerium]=mt;_e[darmstadtium]=ds;_e[roentgenium]=rg;_e[copernicium]=cn;_e[ununtrium]=uut;_e[flerovium]=fl;_e[ununpentium]=uup;_e[livermorium]=lv;_e[ununseptium]=uus;_e[ununoctium]=uuo

  local match=${_e[$element]}

  if [ "$match" ]; then
    printf -- '%s ' $match
  else
    printf -- '%s ' $element
  fi
}

_HOST="$(_prompt_host)"
_DIR='%(?..%{%F{red}%})%~%{%f%}'

PS1="${_HOST}$_DIR "

function zle-line-init zle-keymap-select {
  if [ "$KEYMAP" = vicmd ]; then
    PS1="$_HOST%{%F{blue}%}%~%{%f%} "
  else
    PS1="${_HOST}$_DIR "
  fi
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

### TITLE

precmd() {
  local fmt='%~'
  case "$TERM" in
    xterm*|rxvt*) print -Pn "\e]2;$fmt\a";;
    screen*) print -Pn "\ek$fmt\e\\";;
  esac
}

preexec() {
  local fmt
  case "$TERM" in
    xterm*|rxvt*) fmt='\e]2;%s %s\a';;
    screen*) fmt='\ek%s %s\e\\';;
    *) return;;
  esac
  printf -- "$fmt" "${${PWD/#%$HOME/~}/#$HOME\//~/}" ${2%% *}
}

### PLUGINS

_plugin() {
  local f=/usr/share/zsh/plugins/$1/$1.zsh

  [ -r $f ] && . $f
}

_plugin zsh-syntax-highlighting
if [ "$ZSH_HIGHLIGHT_STYLES" ]; then
  ZSH_HIGHLIGHT_STYLES[default]=none
  ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=black,bg=red
  ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=red
  ZSH_HIGHLIGHT_STYLES[alias]=fg=red
  ZSH_HIGHLIGHT_STYLES[builtin]=fg=red
  ZSH_HIGHLIGHT_STYLES[function]=fg=green
  ZSH_HIGHLIGHT_STYLES[command]=fg=red
  ZSH_HIGHLIGHT_STYLES[precommand]=fg=green
  ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=none
  ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=red
  ZSH_HIGHLIGHT_STYLES[path]=fg=yellow
  ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=yellow
  ZSH_HIGHLIGHT_STYLES[path_approx]=fg=none
  ZSH_HIGHLIGHT_STYLES[globbing]=fg=none
  ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=none
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
  ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=green
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=green
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
  ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
  ZSH_HIGHLIGHT_STYLES[assign]=none
fi

### SSH

_tmux_update_ssh_auth_sock() {
  [ -n "$TMUX" ] || return

  local sock=$(tmux showenv | grep '^SSH_AUTH_SOCK' | cut -d= -f2)

  [ "$SSH_AUTH_SOCK" = "$sock" ] && return

  if [ -S "$sock" ]; then
    SSH_AUTH_SOCK=$sock
  fi
}

_wrap_ssh() {
  [ "$SSH_CONNECTION" ] && return

  if ! ssh-add -l >/dev/null; then
    ssh-add $(grep -l 'ENCRYPTED$' .ssh/*id_rsa)
  fi
}

ssh() {
  _wrap_ssh "$@"
  _tmux_update_ssh_auth_sock
  command ssh "$@"
}

scp() {
  _wrap_ssh "$@"
  _tmux_update_ssh_auth_sock
  command scp "$@"
}

git() {
  case $1 in
    push|pull|fetch)
      _tmux_update_ssh_auth_sock
      _wrap_ssh git "$@"
      ;;
  esac

  command git "$@"
}

_ssh_agent() {
  command -v ssh-agent >/dev/null || return
  [ "$SSH_CONNECTION" ] && return

  local agent_info=$HOME/.cache/ssh-agent-info

  [ -f $agent_info ] && . $agent_info >/dev/null
  [ "$SSH_AGENT_PID" ] && kill -0 $SSH_AGENT_PID 2>/dev/null || {
    ssh-agent > $agent_info
    . $agent_info >/dev/null
  }
}

_ssh_agent

### GPG

_gpg() {
  local agent_info=$HOME/.cache/gpg-agent-info

  export GPG_TTY=$(tty)

  gpg-agent --version 2>/dev/null |
    fgrep -q 'gpg-agent (GnuPG) 2.0' 2>/dev/null || return

  if [ -f $agent_info ] &&
    kill -0 $(head -n1 $agent_info | cut -d: -f2) 2>/dev/null; then
    . $agent_info
  else
    eval $(gpg-agent --daemon --write-env-file $agent_info)
  fi

  export GPG_AGENT_INFO
}

_gpg
