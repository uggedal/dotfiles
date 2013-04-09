local zsh_plugins="$HOME/.zsh/plugins"

function _has_plugin() {
  [ -d "$zsh_plugins/$1" ] && find "$zsh_plugins/$1" -maxdepth 0 -empty | read
}

function _source_plugin() {
  source $zsh_plugins/$1/$1.zsh
}

if _has_plugin zsh-completions; then
  fpath=($zsh_plugins/zsh-completions/src $fpath)
fi

if _has_plugin zsh-syntax-highlighting; then
  _source_plugin zsh-syntax-highlighting

  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

  # colors matching solarized light color scheme:
  ZSH_HIGHLIGHT_STYLES[path]='fg=magenta,bold'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'

  ZSH_HIGHLIGHT_STYLES[command]="fg=blue"
  ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=blue"
  ZSH_HIGHLIGHT_STYLES[builtin]="fg=blue"

  ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'

  ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=green"
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=green"
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=green"
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=yellow"
  ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=yellow"
fi
