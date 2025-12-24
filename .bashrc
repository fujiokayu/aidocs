# ============================================================================
# Bash Configuration
# ============================================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ============================================================================
# PATH Configuration
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

# Yarn global
export PATH="$PATH:$(yarn global bin 2>/dev/null)"

# Google Cloud SDK
if [ -d "$HOME/google-cloud-sdk/bin" ]; then
    export PATH="$PATH:$HOME/google-cloud-sdk/bin"
fi

# Homebrew (Apple Silicon)
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Cargo (Rust)
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# ============================================================================
# Tool Initialization
# ============================================================================
# rbenv (Ruby version manager)
if command -v rbenv &> /dev/null; then
    eval "$(rbenv init - bash)"
fi

# NVM (Node.js version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ============================================================================
# Bash Completion
# ============================================================================
# Enable bash completion (macOS with Homebrew)
if [ -f /opt/homebrew/etc/bash_completion ]; then
    . /opt/homebrew/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# ============================================================================
# History Configuration
# ============================================================================
HISTSIZE=10000
HISTFILESIZE=10000
HISTFILE=~/.bash_history
HISTCONTROL=ignoredups:erasedups  # Ignore duplicate commands
HISTTIMEFORMAT='%F %T '           # Add timestamp to history
shopt -s histappend               # Append to history file, don't overwrite
shopt -s cmdhist                  # Save multi-line commands in one entry

# ============================================================================
# Shell Options
# ============================================================================
shopt -s autocd 2>/dev/null       # Auto cd by typing directory name
shopt -s cdspell                  # Auto-correct typos in cd command
shopt -s checkwinsize             # Check window size after each command
shopt -s nocaseglob               # Case-insensitive globbing

# ============================================================================
# Fish-like History Search
# ============================================================================
# Type a command prefix and use up/down arrows to search matching history
bind '"\e[A": history-search-backward'   # Up arrow
bind '"\e[B": history-search-forward'    # Down arrow

# ============================================================================
# Peco Integration
# ============================================================================
# Ctrl+R: History search with peco
if command -v peco &> /dev/null; then
    function peco-select-history() {
        local selected=$(history | sort -r | awk '{$1=""; print substr($0,2)}' | peco --query "$READLINE_LINE")
        if [ -n "$selected" ]; then
            READLINE_LINE="$selected"
            READLINE_POINT=${#READLINE_LINE}
        fi
    }
    bind -x '"\C-r": peco-select-history'

    # Ctrl+X Ctrl+K: Kill process with peco
    function peco-kill() {
        local pid=$(ps aux | peco | awk '{print $2}')
        if [ -n "$pid" ]; then
            echo "Killing PID: $pid"
            kill "$pid"
        fi
    }
    bind -x '"\C-x\C-k": peco-kill'
fi

# ============================================================================
# Directory Navigation (z alternative)
# ============================================================================
# Install z for bash: brew install z
# Or: git clone https://github.com/rupa/z.git ~/.z
if [ -f /opt/homebrew/etc/profile.d/z.sh ]; then
    . /opt/homebrew/etc/profile.d/z.sh
elif [ -f ~/.z/z.sh ]; then
    . ~/.z/z.sh
fi

# ============================================================================
# Kiro Shell Integration
# ============================================================================
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"

# ============================================================================
# Starship Prompt
# ============================================================================
# Initialize Starship prompt (https://starship.rs)
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

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

# ============================================================================
# Additional Setup Instructions
# ============================================================================
# To get additional bash features:
#
# 1. Install bash-completion (if not already installed):
#    brew install bash-completion@2
#
# 2. Install z for directory jumping:
#    brew install z
#
# 3. Install Starship prompt:
#    brew install starship
#
# 4. Install peco for interactive filtering:
#    brew install peco
#
# 5. Starship configuration is shared with zsh at:
#    ~/.config/starship.toml
