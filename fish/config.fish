if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_config prompt choose arrow

### Adding to path
fish_add_path ~/.local/bin
fish_add_path ~/.local/share/bob/nvim-bin
fish_add_path ~/.local/share/nvim/mason/bin

### EXPORT ###
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x ZDOTDIR $XDG_CONFIG_HOME/zsh

set fish_greeting # Supresses fish's intro message
set -x EDITOR "hx"

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# aliases
alias v='nvim'
alias y='yazi'
alias gu='gitui'
alias lg='lazygit'
alias reload='source ~/.config/fish/config.fish'
alias start='/mnt/c/Windows/explorer.exe'

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Changing "ls" to "exa"
alias l='exa -al --color=always --group-directories-first --icons'  # my preferred listing
alias ls='exa -al --color=always --group-directories-first --icons' # my preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
 
# Add this to the end of your config file
zoxide init fish | source
