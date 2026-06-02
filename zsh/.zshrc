# set vi keybindings
set -o vi

bindkey -s ^f "tmux-sessionizer\n"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# zstyle ':omz:plugins:nvm' lazy yes

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

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
plugins=(
	git
	zsh-autosuggestions
    zsh-syntax-highlighting
	fzf
    z
    # nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export GPG_TTY=$(tty)
# source /home/aidos/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="/home/aidos/.local/bin:$PATH"

export PATH="/snap/bin:$PATH"

export PATH="$PATH:/opt/nvim-linux64/bin"

# export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export PATH=/usr/local/bin/:$PATH

alias c='clear'

alias vim="nvim"
alias ts="tmux-sessionizer"
alias ta="tmux a"
alias p="pnpm"
alias v="nvim"
alias lg="lazygit"
alias nh="nethogs"

alias sal="aws sso login --profile savings_sandbox"
alias t="task"

# openvpn andersen
alias vpn="/home/aidos/dev/personal/ovpn-andersen/openvpn-connect.exp"

# faster chrome opening
alias chrome='google-chrome-stable --no-sandbox --disable-gpu --disable-dev-shm-usage --disable-extensions --disable-plugins --disable-background-timer-throttling --disable-backgrounding-occluded-windows --disable-renderer-backgrounding'
alias mlrc='mlr --ijson --opprint --barred cat'
alias mlrcv='mlr --icsv --opprint --barred cat'
alias notify='win-notify'


alias sview='wslview $(gh run list --json url -q ".[0].url" --workflow $(fd -H sandbox | rg -v delete | rev | cut --delimiter=/ --fields=1 | rev))'
alias srun='gh workflow run --ref $(git branch --show-current) $(fd -H sandbox | rg -v delete | rev | cut --delimiter=/ --fields=1 | rev)'
alias slist='gh run list --workflow $(fd -H -tf sandbox | rg -v delete | rev | cut --delimiter=/ --fields=1 | rev)'

# fancy preview with syntax color highlighting
export FZF_CTRL_R_OPTS='--ansi --preview-window=nohidden:wrap --preview "bash -c '\''printf \"%b\" \"$1\" | sed -E \"s/\\\\\\\\n/\\n/g; s/\\\\\\\\t/\\t/g\"'\'' -- {}"'

export MANPAGER='nvim +Man!'

eval "$(zoxide init zsh)"

# # pnpm
# export PNPM_HOME="/home/aidos/.local/share/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# # pnpm end

# export BROWSER=wslview
export GH_PAGER=
export GLAB_PAGER=
export AWS_PAGER=
# export AWS_PROFILE=savings_sandbox

export JQ_COLORS="0;34:0;31:0;32:0;33:0;32:0;35:0;35:0;36"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# eval "$(starship init zsh)"
# . "$HOME/.cargo/env"

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

eval "$(gh completion -s zsh)"

# Bind 'v' in normal mode to edit the command line in your external editor
export EDITOR='nvim'
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

fpath=($HOME/.zsh-complete $fpath)

# eval "$(starship init zsh)"

# opencode
export PATH=/home/aidos/.opencode/bin:$PATH

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi


# faah
# play_fail_sound() {
#   local exit_code=$?
#   if [[ $exit_code -ne 0 ]]; then
#     powershell.exe -NoProfile -Command \
#       "(New-Object Media.SoundPlayer 'C:\Users\a.kanapyanov\Downloads\Faah sound effect.wav').PlaySync()" \
#       >/dev/null 2>&1 &!
#   fi
# }
# precmd_functions+=(play_fail_sound)

bindkey "ç" fzf-cd-widget

# use fnm because nvm is super slow :/
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"

# fzf sourcing
source <(fzf --zsh)

[[ -f /root/.sh_functions_wf ]] && . /root/.sh_functions_wf
