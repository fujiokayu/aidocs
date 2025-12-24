# ============================================================================
# Oh My Zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

# Theme (Powerlevel10k recommended for modern look, or use default)
# ZSH_THEME="robbyrussell"

# Oh My Zsh Plugins
# git: Git aliases and functions
# z: Directory jumping (similar to fish's z plugin)
# zsh-autosuggestions: Fish-like autosuggestions
# zsh-syntax-highlighting: Fish-like syntax highlighting
plugins=(
    git
    z
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ============================================================================
# Starship Prompt
# ============================================================================
# Initialize Starship prompt (https://starship.rs)
eval "$(starship init zsh)"

# ============================================================================
# PATH Configuration (from fish config)
# ============================================================================
# CodeQL
export PATH="$HOME/repo/codeql:$PATH"

# pipx
export PATH="$PATH:$HOME/.local/bin"

# Ruby gems
export PATH="$PATH:$HOME/.gem/ruby/3.3.0/bin"

# NVM
export PATH="$PATH:$HOME/.nvm"

# Nodebrew
export PATH="$PATH:$HOME/.nodebrew/current/bin"

# Homebrew (Apple Silicon)
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ============================================================================
# Tool Initialization
# ============================================================================
# rbenv (Ruby version manager)
if command -v rbenv &> /dev/null; then
    eval "$(rbenv init - zsh)"
fi

# NVM (Node.js version manager)
export NVM_DIR="$HOME/.nvm"
# Lazy load NVM to speed up shell startup
if [ -s "$NVM_DIR/nvm.sh" ]; then
    # Load nvm only when needed
    alias nvm='unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@'
    alias node='unalias node; unalias npm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; node $@'
    alias npm='unalias node; unalias npm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; npm $@'
fi

# ============================================================================
# Peco Integration (from fish plugin-peco)
# ============================================================================
# Ctrl+R: History search with peco
if command -v peco &> /dev/null; then
    function peco-select-history() {
        BUFFER=$(history -n -r 1 | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-select-history
    bindkey '^R' peco-select-history

    # Ctrl+X Ctrl+K: Kill process with peco
    function peco-kill() {
        local pid=$(ps aux | peco | awk '{print $2}')
        if [ -n "$pid" ]; then
            echo "Killing PID: $pid"
            kill $pid
        fi
    }
    zle -N peco-kill
    bindkey '^X^K' peco-kill
fi

# ============================================================================
# Kiro Shell Integration
# ============================================================================
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# ============================================================================
# Zsh-specific Enhancements (Fish-like features)
# ============================================================================
# Enable fish-like features in zsh
setopt AUTO_CD              # cd by typing directory name
setopt AUTO_PUSHD           # pushd automatically
setopt PUSHD_IGNORE_DUPS    # ignore duplicate directories
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate commands in history
setopt HIST_FIND_NO_DUPS    # don't show duplicates in search
setopt SHARE_HISTORY        # share history between sessions
setopt HIST_REDUCE_BLANKS   # remove unnecessary blanks

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Case-insensitive completion (fish-like)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Fish-like history search with up/down arrows
# Type a command prefix and use up/down to search matching history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # Up arrow
bindkey "^[[B" down-line-or-beginning-search  # Down arrow

# ============================================================================
# Additional Plugin Installation Instructions
# ============================================================================
# To get fish-like autosuggestions and syntax highlighting, install:
#
# 1. zsh-autosuggestions:
#    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#
# 2. zsh-syntax-highlighting:
#    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
# Then add them to plugins array above:
#    plugins=(git z colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)
#
# Note: Plugins are now automatically loaded by Oh My Zsh via the plugins array.

# ============================================================================
# Aliases
# ============================================================================
# Add your custom aliases here
alias ll='ls -lah'
# alias ..='cd ..'
alias h='history | peco' 

# ============================================================================
# Custom Functions
# ============================================================================

# URL encode
function url-encode() {
  python3 -c "import urllib.parse as ul; print(ul.quote_plus('$*'))"
}

# URL decode
function url-decode() {
  python3 -c "import urllib.parse as ul; print(ul.unquote_plus('$*'))"
}
