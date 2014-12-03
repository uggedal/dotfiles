# Environment
export PAGER=$(command -v less)

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# Editing
bindkey -v

_fg() { fg; }
zle -N _fg
bindkey '^Z' _fg

# Completion
autoload -Uz compinit && compinit

# Mail
MAILCHECK=0

# Prompt
_chemical_element_to_symbol() {
  local element="${1%%.*}"

  typeset -A _e
  _e[hydrogen]=h
  _e[helium]=he
  _e[lithium]=li
  _e[beryllium]=be
  _e[boron]=b
  _e[carbon]=c
  _e[nitrogen]=n
  _e[oxygen]=o
  _e[fluorine]=f
  _e[neon]=ne
  _e[sodium]=na
  _e[magnesium]=mg
  _e[aluminium]=al
  _e[silicon]=si
  _e[phosphorus]=p
  _e[sulfur]=s
  _e[chlorine]=cl
  _e[argon]=ar
  _e[potassium]=k
  _e[calcium]=ca
  _e[scandium]=sc
  _e[titanium]=ti
  _e[vanadium]=v
  _e[chromium]=cr
  _e[manganese]=mn
  _e[iron]=fe
  _e[cobalt]=co
  _e[nickel]=ni
  _e[copper]=cu
  _e[zinc]=zn
  _e[gallium]=ga
  _e[germanium]=ge
  _e[arsenic]=as
  _e[selenium]=se
  _e[bromine]=br
  _e[krypton]=kr
  _e[rubidium]=rb
  _e[strontium]=sr
  _e[yttrium]=y
  _e[zirconium]=zr
  _e[niobium]=nb
  _e[molybdenum]=mo
  _e[technetium]=tc
  _e[ruthenium]=ru
  _e[rhodium]=rh
  _e[palladium]=pd
  _e[silver]=ag
  _e[cadmium]=cd
  _e[indium]=in
  _e[tin]=sn
  _e[antimony]=sb
  _e[tellurium]=te
  _e[iodine]=i
  _e[xenon]=xe
  _e[cesium]=cs
  _e[barium]=ba
  _e[lanthanum]=la
  _e[cerium]=ce
  _e[praseodymium]=pr
  _e[neodymium]=nd
  _e[promethium]=pm
  _e[samarium]=sm
  _e[europium]=eu
  _e[gadolinium]=gd
  _e[terbium]=tb
  _e[dysprosium]=dy
  _e[holmium]=ho
  _e[erbium]=er
  _e[thulium]=tm
  _e[ytterbium]=yb
  _e[lutetium]=lu
  _e[hafnium]=hf
  _e[tantalum]=ta
  _e[tungsten]=w
  _e[rhenium]=re
  _e[osmium]=os
  _e[iridium]=ir
  _e[platinum]=pt
  _e[gold]=au
  _e[mercury]=hg
  _e[thallium]=tl
  _e[lead]=pb
  _e[bismuth]=bi
  _e[polonium]=po
  _e[astatine]=at
  _e[radon]=rn
  _e[francium]=fr
  _e[radium]=ra
  _e[actinium]=ac
  _e[thorium]=th
  _e[protactinium]=pa
  _e[uranium]=u
  _e[neptunium]=np
  _e[plutonium]=pu
  _e[americium]=am
  _e[curium]=cm
  _e[berkelium]=bk
  _e[californium]=cf
  _e[einsteinium]=es
  _e[fermium]=fm
  _e[mendelevium]=md
  _e[nobelium]=no
  _e[lawrencium]=lr
  _e[rutherfordium]=rf
  _e[dubnium]=db
  _e[seaborgium]=sg
  _e[bohrium]=bh
  _e[hassium]=hs
  _e[meitnerium]=mt
  _e[darmstadtium]=ds
  _e[roentgenium]=rg
  _e[copernicium]=cn
  _e[ununtrium]=uut
  _e[flerovium]=fl
  _e[ununpentium]=uup
  _e[livermorium]=lv
  _e[ununseptium]=uus
  _e[ununoctium]=uuo

  local match=${_e[$element]}

  if [ "$match" ]; then
    echo $match
  else
    echo $element
  fi
}

# TODO: cache symbol and hostname lookup

setopt PROMPT_SUBST
PS1='$(_chemical_element_to_symbol $(hostname)) %~ '
