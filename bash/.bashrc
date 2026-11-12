export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export MPD_HOST="$XDG_RUNTIME_DIR/mpd/socket"
export TERMINAL=kitty
export EDITOR=nvim

append_paths() {
  for d in "$@"; do
    [[ -d "$d" && ! "$PATH" =~ (^|:)$d(:|$) ]] && PATH="$d:$PATH"
  done
}
paths=(
  $PNPM_HOME/bin
  $CARGO_HOME/bin
  ~/.deno/bin
  ~/src/fzf/bin
  ~/.local/bin
)
append_paths "${paths[@]}"

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# make tab completion case-insensitive
bind 'set completion-ignore-case on'

# bind xoff to ctrl+p (and ctrl+q still unfreezes)
# This automatically frees up ctrl+s for forward-search-history
stty stop '^p'

# use single quotes ' to prevent bash from expanding the variable when creating the alias
alias mypath='echo "$PATH" | sed "s/:/\n/g"'
alias v='nvim'
alias y='yazi'
alias lg='lazygit'
alias l='ls -la'
alias reload="source ~/.bashrc"
