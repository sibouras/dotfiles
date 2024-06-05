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
set -x EDITOR 'hx'

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x MANROFFOPT '-c'

# aliases
abbr -a v 'nvim'
abbr -a y 'yazi'
abbr -a gu 'gitui'
abbr -a lg 'lazygit'
alias reload='source ~/.config/fish/config.fish'
alias start='/mnt/c/Windows/explorer.exe'

# confirm before overwriting something
abbr -a cp "cp -i"
abbr -a mv "mv -i"
abbr -a rm "rm -i"

alias l='eza -la -s Name --binary --git --group-directories-first --icons'
alias ll='eza -l --group-directories-first --icons' # long format
alias lt='eza -T --group-directories-first --icons' # tree listing
 
# Add this to the end of your config file
zoxide init fish | source
