if status is-interactive
    # Commands to run in interactive sessions can go here
end

# fish_config prompt choose arrow

### Adding to path
fish_add_path ~/.local/bin
fish_add_path ~/.local/wsl-scripts
fish_add_path ~/.cargo/bin
fish_add_path ~/src/fzf/bin
fish_add_path ~/src/nvim/bin
fish_add_path ~/.local/share/nvim/mason/bin

### Environment variables
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

set fish_greeting # Supresses fish's intro message
set -x HELIX_RUNTIME ~/src/helix/runtime
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
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH

### bindings
bind \co __fish_preview_current_file # ctrl+o
bind \e\[17\;8~ __fish_list_current_token # ctrl+i

### abbreviations
abbr -a :q exit
abbr -a v nvim
abbr -a y yazi
abbr -a gu gitui
abbr -a lg lazygit

# confirm before overwriting something
abbr -a cp "cp -i"
abbr -a mv "mv -i"
abbr -a rm "rm -i"

# Git abbreviations
abbr -a ga 'git add'
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gp 'git push'
abbr -a gb 'git branch'
abbr -a gst 'git status'
abbr -a gr 'cd (git rev-parse --show-toplevel)'

### aliases
alias g 'git --no-pager'
alias ls eza
alias l 'eza -la -s Name --binary --git --group-directories-first --icons'
alias ll 'eza -l --group-directories-first --icons'
alias lt 'eza --tree --group-directories-first --icons'
alias reload 'source ~/.config/fish/config.fish'
alias start '/mnt/c/Windows/explorer.exe'
alias mypath 'echo "$PATH" | sed "s/:/\n/g"'

### functions
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# setup zoxide
command -q zoxide && zoxide init fish | source
