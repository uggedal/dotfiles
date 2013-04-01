# env shared between bash and zsh
if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt hist_verify
setopt hist_ignore_dups
setopt hist_ignore_space
setopt append_history

# keybindings
bindkey -e
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# prompt
autoload -U colors
colors
setopt prompt_subst
if (( EUID == 0 )); then
  PROMPT='%{$fg[red]%}$(_short_hostname)%{$reset_color%} %~ '
else
  PROMPT='$(_short_hostname) %~ '
fi
RPROMPT="%(?,,%{$fg[red]%}%?%{$reset_color%})"

# ssh agent forwarding inside tmux
function preexec() {
  if [[ -n $TMUX ]]; then
    NEW_SSH_AUTH_SOCK=`tmux showenv|grep ^SSH_AUTH_SOCK|cut -d = -f 2`
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then
      SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
    fi
  fi
}

function _short_hostname() {
  local host=$(hostname)
  typeset -A elements
  elements=(hydrogen h helium he lithium li beryllium be boron b carbon c nitrogen n oxygen o fluorine f neon ne sodium na magnesium mg aluminum al silicon si phosphorus p sulfur s chlorine cl argon ar potassium k calcium ca scandium sc titanium ti vanadium v chromium cr manganese mn iron fe cobalt co nickel ni copper cu zinc zn gallium ga germanium ge arsenic as selenium se bromine br krypton kr rubidium rb strontium sr yttrium y zirconium zr niobium nb molybdenum mo technetium tc ruthenium ru rhodium rh palladium pd silver ag cadmium cd indium in tin sn antimony sb tellurium te iodine i xenon xe cesium cs barium ba lanthanum la cerium ce praseodymium pr neodymium nd promethium pm samarium sm europium eu gadolinium gd terbium tb dysprosium dy holmium ho erbium er thulium tm ytterbium yb lutetium lu hafnium hf tantalum ta wolfram w rhenium re osmium os iridium ir platinum pt gold au mercury hg thallium tl lead pb bismuth bi polonium po astatine at radon rn francium fr radium ra actinium ac thorium th protactinium pa uranium u neptunium np plutonium pu americium am curium cm berkelium bk californium cf einsteinium es fermium fm mendelevium md nobelium no lawrencium lr)
  if (( ${+elements[$host]} )); then
    echo "${elements[$host]}"
  else
    echo $host
  fi
}

if [ -f "$HOME/.zsh/plugins.zsh" ]; then
  source "$HOME/.zsh/plugins.zsh"
fi

# completion
zstyle :compinstall filename '$HOME/.zshrc'

zstyle ':completion:*' special-dirs ..
zstyle ':completion:*:mplayer:argument*' tag-order - '! urls'

autoload -Uz compinit
compinit

# fast man page access (accessed with <Esc-h>)
autoload run-help
