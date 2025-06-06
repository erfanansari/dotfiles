# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set the history file to a specific location
HISTFILE=~/dev/dotfiles/.zsh_history
# Set the maximum number of commands to store in the history file
HISTSIZE=10000000
# Save the last 10,000,000 commands to the history file when you exit ZSH
SAVEHIST=10000000
# Only append new commands to the history file if they are different from the previous command
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt SHARE_HISTORY
# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST    
# Do not display a line previously found.
setopt HIST_FIND_NO_DUPS         
# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE         
# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS         
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS        
# Don't execute immediately upon history expansion.
setopt HIST_VERIFY               
# Beep when accessing nonexistent history.
setopt HIST_BEEP                 
# Treat the '!' character specially during expansion.
setopt BANG_HIST                 


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="dstufft"
# ZSH_THEME="terminalparty"
# ZSH_THEME="cloud"
# ZSH_THEME="af-magic"
# ZSH_THEME="wezm+"
# ZSH_THEME="norm"

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
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 14

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
# plugins=(git zsh-wakatime macos zsh-autosuggestions colored-man-pages)
# Note that zsh-syntax-highlighting should be the last
plugins=(git forgit zsh-wakatime zsh-autosuggestions colored-man-pages autojump you-should-use zsh-syntax-highlighting eza web-search macos)

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
alias count='cloc --fullpath --not-match-d="(node_modules|App/ios|App/android|.next)" --not-match-f="(yarn\.lock|package\-lock\.json)"'
alias dus='du -ch -d 1 . | sort -h' # display the disk usage of directories in the current directory in a human-readable format and sorted by size
alias zshconf="nvim ~/.zshrc"
alias sshconf="nvim ~/.ssh/config"
alias gvv="git branch -vv"
alias gfb="git branch | fzf --preview 'git show --color=always {-1}' \
                 --bind 'enter:become(git checkout {-1})' \
                 --height 100% --layout reverse"
alias glf="git ls-files | fzf | xargs git log"
alias gdis="git reset . && git restore . && git clean -dff"
alias gd="git diff --name-only --relative --diff-filter=d | xargs bat --diff"
alias glogf="git log --oneline --graph --color=always | nl |
    fzf --ansi --track --no-sort --layout=reverse-list"
alias reload="source ~/.zshrc"
# Make help commands highlighted with bat
alias -g -- -bh='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --bhelp='--help 2>&1 | bat --language=help --style=plain'
alias pbc="pbcopy"
alias pbp="pbpaste"
alias c="clear"
alias sf="tmux-session-switcher"
alias cip="curl -S https://ipconfig.io/json | jq"
alias pn=pnpm
alias px=pnpx

# Overwrite forgit plugin default aliases
forgit_checkout_branch="gcbi"
forgit_checkout_commit="gcoi"
forgit_rebase=grbi
forgit_diff="gdi"


tmux-session-switcher() {
  # Get the current session (if inside tmux)
  local current_session=$(tmux display-message -p '#S' 2>/dev/null)

  # List all sessions, exclude the current one (if any), and pass them to fzf with tmux-popup-like options
  local session=$(tmux list-sessions | sed -E 's/:.*$//' | grep -v "^$current_session\$" | \
    fzf --reverse --border --height=40% --min-height=10 \
    --layout=reverse --border=rounded \
    --color='border:white' --margin=5% --tmux=55%)

  # If a session is selected
  if [[ -n "$session" ]]; then
    # Unset $TMUX to allow switching between sessions, and then attach
    if [[ -n "$TMUX" ]]; then
      tmux switch-client -t "$session"
    else
      tmux attach-session -t "$session"
    fi
  fi
}

#   display-popup -E "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"

# function sl() {
#   {
#     exec </dev/tty
#     exec <&1
#     local session
#     local current_session
#
#     # Check if we are currently in a tmux session
#     if [ -n "$TMUX" ]; then
#       # We are inside a tmux session
#       current_session=$(tmux display-message -p '#S')
#       # List all sessions except the current one
#       session=$(tmux ls | awk -F: -v current="$current_session" '$1 != current {print $1}' | fzf --height 40% --reverse)
#     else
#       # We are not inside a tmux session
#       session=$(tmux ls | awk -F: '{print $1}' | fzf --height 40% --reverse)
#     fi
#
#     # Check if a session was selected
#     if [ -z "$session" ]; then
#       return
#     fi
#
#     # Attach to the selected session
#     tmux a -t "$session"
#   }
# }
#



minify() {
   ffmpeg -i $1 -vcodec libx265 -crf 28 $2
}


jira() {
   curl -u erfan.ansari:123456789 -X GET -H "Content-Type: application/json" http://pm.squadshop.net:8080/rest/greenhopper/1.0/xboard/plan/backlog/data.json\?rapidViewId\=6\&activeQuickFilters\=11\&selectedProjectKey\=COMMUNITY\&issueLimit\=100\&_\=1659285255189 | jq -r '.issues | .[] | select(.assignee == "erfan.ansari") | {'summary', 'assigneeName', 'done', 'key'}'
}

cnl() {
   networksetup -connectpppoeservice nl
}

dcnl() {
   networksetup -disconnectpppoeservice nl
}

cuk() {
   networksetup -connectpppoeservice uk
}

dcuk() {
   networksetup -disconnectpppoeservice uk
}


cus() {
   networksetup -connectpppoeservice us
}

dcus() {
   networksetup -disconnectpppoeservice us
}

gcj() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}



fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    IFS=$'\n'; set -f
    lines=($(<<< "$out"))
    unset IFS; set +f
    q="${lines[0]}"
    k="${lines[1]}"
    sha="${lines[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git -c color.ui=always stash show -p $sha | less -+F
    fi
  done
}


export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
# export PATH=$PATH:$GOBIN
export PATH=$PATH:/usr/local/mongodb/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export ZSH_WAKATIME_PROJECT_DETECTION=false
export EDITOR='nvim'



eval $(thefuck --alias)

# set -o vi
# set -o emacs



# pnpm
export PNPM_HOME="/Users/erfan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"
source /Users/erfan/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/erfan/.docker/init-zsh.sh || true # Added by Docker Desktop
source <(fzf --zsh)


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
