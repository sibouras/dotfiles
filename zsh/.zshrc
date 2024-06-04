[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# bind xoff to ctrl+p (and ctrl+q still unfreezes)
# This automatically frees up ctrl+s for forward-search-history
stty stop '^p'

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

# aliases
alias ls='exa --group-directories-first --icons'
alias ll='ls -lah'
alias tree='ll --tree --level=2'

# Setup fzf
source <(fzf --zsh)

# zoxide config
eval "$(zoxide init zsh)"
