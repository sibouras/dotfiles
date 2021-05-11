# neofetch

PATH="$HOME/.cargo/bin${PATH:+:${PATH}}"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### SET MANPAGER
### Uncomment only one of these!

### "bat" as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
export MANPAGER="nvim -c 'set ft=man' -"


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/bouras/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting autojump wd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# for vimv
export PATH=$PATH:~/bin

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="code ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias dt='cd /mnt/c/Users/marzouk/Desktop'
alias home='cd /mnt/c/Users/marzouk/'
alias open='/mnt/c/Windows/explorer.exe'
alias ii="cmd.exe /C start"
alias np='/mnt/c/Program\ Files/Notepad++/notepad++.exe'
alias chrome='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
alias vlc='/mnt/c/Program\ Files/VideoLAN/VLC/vlc.exe'
alias mpv='/mnt/c/ProgramData/chocolatey/lib/mpv.install/tools/mpv.exe'
alias gvim='/mnt/c/tools/vim/vim82/gvim.exe'
alias code='/mnt/c/Users/marzouk/Appdata/Local/Programs/Microsoft\ VS\ Code/Code.exe'
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias mkd="mkdir -pv"
alias dirs='dirs -v | head -10'
alias vim="nvim"
alias vi="nvim"
alias myip="curl ipinfo.io/ip"
alias lm="ls -shtr1"
alias yt="youtube-dl --add-metadata -i"
alias yta="yt -x -f bestaudio/best"
alias ytF="youtube-dl -F"
alias yt4="youtube-dl -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'"

# alias ls="exa -al --color=always --group-directories-first"
alias ls="exa --color=always --group-directories-first"
alias c:="cd /mnt/c"
alias d:="cd /mnt/d"
alias fd="fdfind"
alias wn="dict -d wn"

# from the tuxi guy
alias fpath="find -type f | fzf | sed 's/^..//g' | perl -pe 'chomp' | clip.exe"
alias dpath="find -type d | fzf | sed 's/^..//g' | perl -pe 'chomp' | clip.exe"
alias cpath="pwd | perl -pe 'chomp' | clip.exe"
alias neovide="neovide.exe --geometry=200x56"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias winconfig="/usr/bin/git --git-dir=/mnt/c/users/marzouk/.dotfiles/ --work-tree=/mnt/c/Users/marzouk"

# ZSH_HIGHLIGHT_STYLES[suffix-acias]=fg=cyan,underline
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,underline
# ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=cyan,underline
# ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan

# export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
LS_COLORS=$LS_COLORS:'ow=1;34:' ; export LS_COLORS

# not so blue
# export LS_COLORS="ow=01;36;40"

# remove all colors from zsh tab completeion
# zstyle ':completion:*' list-colors

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# for colored man
export PAGER="/usr/bin/most -s"

# for control backspace
# bindkey '^H' backward-kill-word
# bindkey '^?' backward-kill-word
# bindkey '^\x7f' backward-kill-word


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export TUXI_LANG='en_US'
