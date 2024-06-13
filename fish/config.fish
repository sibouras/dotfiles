if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_config prompt choose arrow

### Adding to path
fish_add_path ~/.local/bin
fish_add_path ~/.local/wsl-scripts
fish_add_path ~/.local/share/bob/nvim-bin
fish_add_path ~/.local/share/nvim/mason/bin

### Environment variables
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x ZDOTDIR $XDG_CONFIG_HOME/zsh

set fish_greeting # Supresses fish's intro message
set -x EDITOR hx

set -x MOAR '--no-statusbar --style=github-dark'
set -x PAGER 'moar --no-linenumbers -quit-if-one-screen'
# bat as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x MANROFFOPT -c

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

### aliases
abbr -a v nvim
abbr -a y yazi
abbr -a gu gitui
abbr -a lg lazygit
alias reload 'source ~/.config/fish/config.fish'
alias start '/mnt/c/Windows/explorer.exe'
alias gr 'cd (git rev-parse --show-toplevel)'

# confirm before overwriting something
abbr -a cp "cp -i"
abbr -a mv "mv -i"
abbr -a rm "rm -i"

alias ls eza
alias l 'eza -la -s Name --binary --git --group-directories-first --icons'
alias ll 'eza -l --group-directories-first --icons'
alias lt 'eza --tree --group-directories-first --icons'

### functions
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Add this to the end of your config file
zoxide init fish | source
