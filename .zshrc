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
