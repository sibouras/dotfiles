# https://wiki.archlinux.org/title/Zsh
typeset -U path PATH
path=(
    ~/.local/bin
    ~/.local/wsl-scripts
    ~/.cargo/bin
    ~/src/fzf/bin
    ~/src/nvim/bin
    ~/.local/share/nvim/mason/bin
    $path
)
export PATH

# the completion scripts have to be in a path that belongs to `$fpath`:
typeset -U fpath FPATH
fpath=("$HOME/.local/share/zsh-completion" /usr/share/zsh/site-functions $fpath)
export FPATH

# Set up the prompt

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%} %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# bind xoff to ctrl+p (and ctrl+q still unfreezes)
# This automatically frees up ctrl+s for forward-search-history
stty stop '^p'

# edit line in editor with ctrl-o:
autoload edit-command-line; zle -N edit-command-line
bindkey '^o' edit-command-line

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000

# --------------------
# Command completion
# --------------------

# Use modern completion system
autoload -Uz compinit
compinit

# GLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# key bindings

# Mapping CTRl + [left|right] arrow to move between words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# --------------------
# Aliases, functions and private configs
# --------------------

# eza aliases
if [ -x ~/.local/bin/eza ]; then
    alias ls='eza'
    alias l='eza -la -s Name --binary --git --group-directories-first --icons'
    alias ll='eza -l --group-directories-first --icons'
    alias lt='eza --tree --group-directories-first --icons'
fi

# use single quotes ' to prevent bash from expanding the variable when creating the alias
alias mypath='echo "$PATH" | sed "s/:/\n/g"'
alias y=yazi
alias reload="source ~/.config/zsh/.zshrc"

# --------------------
# Tools & Plugins
# --------------------

# Set up fzf key bindings and fuzzy completion
if command -v fzf > /dev/null; then
    source <(fzf --zsh)
fi

# setup zoxide
# [ -x ~/.local/bin/zoxide ] && eval "$(zoxide init zsh)"
if command -v zoxide > /dev/null; then
    eval "$(zoxide init zsh)"
fi
