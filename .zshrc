# env
export EDITOR=/usr/bin/vim
export PATH="$HOME/bin:$PATH"
export LESS="-F -X -R"
export GREP_COLOR="1;33"

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt hist_verify
setopt hist_ignore_dups
setopt append_history

# keybindings
bindkey -e

# completion
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' special-dirs ..
autoload -Uz compinit
compinit

# ssh agent forwarding inside tmux
function preexec() {
  if [[ -n $TMUX ]]; then
    NEW_SSH_AUTH_SOCK=`tmux showenv|grep ^SSH_AUTH_SOCK|cut -d = -f 2`
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then
      SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
    fi
  fi
}

# colorized manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# aliases
alias ls='ls -hF --color'
alias grep='grep --color=auto'
alias bc='bc -ql'
alias ports='lsof -i -P -sTCP:LISTEN'
alias rmpyc='find . -name \*.pyc -exec rm -v {} \;'

# prompt
autoload -U colors
colors
setopt prompt_subst
if (( EUID == 0 )); then
  PROMPT='%{$fg[red]%}$(short_hostname)%{$reset_color%} %~ '
else
  PROMPT='$(short_hostname) %~ '
fi
RPROMPT="%(?,,%{$fg[red]%}%?%{$reset_color%})"

# functions

function f()
{
  find . -path '*/.git' -prune \
  -o -path '*/.hg' -prune \
  -o -path '*/.svn' -prune \
  -o -name '*.swp' -prune \
  -o -name '*.pyc' -prune \
  -o -type f -print | xargs grep -l $1
}

function replace()
{
  find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/$1/$2/g"
}

function short_hostname() {
  local host=$(hostname -s)
  typeset -A elements
  elements=(hydrogen h helium he lithium li beryllium be boron b carbon c nitrogen n oxygen o fluorine f neon ne sodium na magnesium mg aluminum al silicon si phosphorus p sulfur s chlorine cl argon ar potassium k calcium ca scandium sc titanium ti vanadium v chromium cr manganese mn iron fe cobalt co nickel ni copper cu zinc zn gallium ga germanium ge arsenic as selenium se bromine br krypton kr rubidium rb strontium sr yttrium y zirconium zr niobium nb molybdenum mo technetium tc ruthenium ru rhodium rh palladium pd silver ag cadmium cd indium in tin sn antimony sb tellurium te iodine i xenon xe cesium cs barium ba lanthanum la cerium ce praseodymium pr neodymium nd promethium pm samarium sm europium eu gadolinium gd terbium tb dysprosium dy holmium ho erbium er thulium tm ytterbium yb lutetium lu hafnium hf tantalum ta wolfram w rhenium re osmium os iridium ir platinum pt gold au mercury hg thallium tl lead pb bismuth bi polonium po astatine at radon rn francium fr radium ra actinium ac thorium th protactinium pa uranium u neptunium np plutonium pu americium am curium cm berkelium bk californium cf einsteinium es fermium fm mendelevium md nobelium no lawrencium lr)
  if (( ${+elements[$host]} )); then
    echo "${elements[$host]}"
  else
    echo $host
  fi
}

