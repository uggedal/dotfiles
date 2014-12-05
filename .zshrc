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
alias grep='command grep --color=auto'
alias fgrep='command fgrep --color=auto'
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
alias ls="command ls $ls_flags"
unset ls_flags
unset LS_COLORS

# Local bin
[ -d $HOME/.local/bin ] && [[ :$PATH: != *:$HOME/.local/bin:* ]] &&
  PATH=$HOME/.local/bin:$PATH

### HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

### EDITING

bindkey -v

# Make backspace work after leaving command mode:
bindkey '^?' backward-delete-char

# Prefix history search:
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

KEYTIMEOUT=1

# Toggle fg/suspend:
_fg() { fg; }
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

zstyle ':completion:*' show-ambiguity '32'

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
    PS1="$_HOST%{%F{green}%}%~%{%f%} "
  else
    PS1="${_HOST}$_DIR "
  fi
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

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
  printf -- "$fmt" "${${PWD/#%$HOME/~}/#$HOME\//~/}" \
    "${(r:20::.::.:)${2[1,18]}}"
}
