# ===========================================

# Performance: Start timing shell startup (uncomment to debug)
# zmodload zsh/zprof

# Core configuration directory
ZCONF="${HOME}/.config/zsh"

if [ ! -d "$ZCONF/zshrc.d" ]; then
  mkdir -p "$ZCONF/zshrc.d"
fi

# Configuration: Enable per-command history (set to 0 to disable)
ENABLE_PER_COMMAND_HISTORY=${ENABLE_PER_COMMAND_HISTORY:-1}

# ============================================================================
# PERFORMANCE OPTIMIZATIONS
# ============================================================================

# Skip global compinit for faster startup (Homebrew compatibility)
skip_global_compinit=1

# Lazy load expensive functions
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# ============================================================================
# HISTORY CONFIGURATION
# ============================================================================

export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$ZCONF/.zsh_history"

# History options for better experience
setopt APPEND_HISTORY           # Append to history file
setopt SHARE_HISTORY           # Share history between sessions
setopt EXTENDED_HISTORY        # Record timestamp and duration
setopt HIST_IGNORE_SPACE       # Ignore commands starting with space
setopt HIST_IGNORE_DUPS        # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicate entries
setopt HIST_SAVE_NO_DUPS       # Don't save duplicates
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks
setopt HIST_VERIFY             # Show command with history expansion before running

# ============================================================================
# ZSH OPTIONS FOR BETTER UX
# ============================================================================

# Directory navigation
setopt AUTO_CD                 # Auto change to directory
setopt AUTO_PUSHD             # Push directory to stack
setopt PUSHD_IGNORE_DUPS      # Don't push duplicate directories
setopt PUSHD_SILENT           # Don't print directory stack

# Globbing
setopt EXTENDED_GLOB          # Extended globbing patterns
setopt GLOB_DOTS              # Match dotfiles without explicit dot
setopt NUMERIC_GLOB_SORT      # Sort filenames numerically

# Job control
setopt NO_HUP                 # Don't send HUP signal to jobs on shell exit
setopt CHECK_JOBS             # Check jobs before exiting

# Miscellaneous
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shell
setopt NO_BEEP               # Disable beep
setopt PROMPT_SUBST          # Enable parameter expansion in prompts

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

# Editor configuration
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export PAGER="${PAGER:-less}"

# Less configuration with colors
export LESS='-R -i -M -F -X'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline

# ============================================================================
# KEY BINDINGS
# ============================================================================

# Use emacs-style key bindings
bindkey -e

# Enhanced key bindings for better navigation
bindkey '^[[H'    beginning-of-line      # Home
bindkey '^[[F'    end-of-line           # End
bindkey '^[[3~'   delete-char           # Delete
bindkey '^[[2~'   overwrite-mode        # Insert
bindkey '^[[5~'   up-line-or-history    # Page Up
bindkey '^[[6~'   down-line-or-history  # Page Down

# Word navigation
bindkey '^[[1;5C' forward-word          # Ctrl+Right
bindkey '^[[1;5D' backward-word         # Ctrl+Left
bindkey '^H'      backward-kill-word    # Ctrl+Backspace
bindkey '^[[3;5~' kill-word             # Ctrl+Delete

# Per-command history navigation (up/down arrows) - configurable
if [[ "$ENABLE_PER_COMMAND_HISTORY" -eq 1 ]]; then
    bindkey '^[[A' history-search-backward       # Up arrow
    bindkey '^[[B' history-search-forward        # Down arrow
    bindkey '^P' history-search-backward         # Ctrl+P
    bindkey '^N' history-search-forward          # Ctrl+N
else
    # Standard history navigation
    bindkey '^[[A' up-line-or-history            # Up arrow
    bindkey '^[[B' down-line-or-history          # Down arrow
    bindkey '^P' up-line-or-history              # Ctrl+P
    bindkey '^N' down-line-or-history            # Ctrl+N
fi

# Keep original history search available with Alt+Up/Down
bindkey '^[[1;3A' up-line-or-search          # Alt+Up arrow
bindkey '^[[1;3B' down-line-or-search        # Alt+Down arrow

# Standard history search
bindkey '^R' history-incremental-search-backward # Ctrl+R
bindkey '^S' history-incremental-search-forward  # Ctrl+S

# Undo
bindkey '^[[Z' undo                     # Shift+Tab
bindkey '^_'   undo                     # Ctrl+_

# ============================================================================
# COLOR SUPPORT DETECTION
# ============================================================================

# Detect color support for various commands
typeset -ga ls_options
typeset -ga grep_options

# Colors for ls
if ls --color=auto / >/dev/null 2>&1; then
    ls_options+=( --color=auto )
elif ls -G / >/dev/null 2>&1; then
    ls_options+=( -G )
fi

# Natural sorting for GNU ls
if ls --version 2>/dev/null | grep -q 'GNU' && ls -v / >/dev/null 2>&1; then
    ls_options+=( -v )
fi

# Colors for grep
if grep --color=auto -q "a" <<< "a" >/dev/null 2>&1; then
    grep_options+=( --color=auto )
fi

# Setup dircolors if available
if command -v dircolors >/dev/null 2>&1; then
    if [[ -f ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi

# ============================================================================
# ALIASES
# ============================================================================

# Core correction
NOCOR=${NOCOR:-0}

# Directory listing aliases
if [[ "$TERM" != "dumb" ]]; then
    alias ls="command ls ${ls_options[*]}"
    alias la="command ls -la ${ls_options[*]}"
    alias ll="command ls -l ${ls_options[*]}"
    alias lh="command ls -hAl ${ls_options[*]}"
    alias l="command ls -l ${ls_options[*]}"
    alias lt="command ls -lAtrh ${ls_options[*]}"  # Sort by time
    alias lS="command ls -lAhrS ${ls_options[*]}"  # Sort by size
else
    alias ls='command ls'
    alias la='command ls -la'
    alias ll='command ls -l'
    alias lh='command ls -hAl'
    alias l='command ls -l'
    alias lt='command ls -lAtrh'
    alias lS='command ls -lAhrS'
fi

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# Grep with color support
if (( ${#grep_options} > 0 )); then
    alias grep="grep ${grep_options[*]}"
    alias egrep="egrep ${grep_options[*]}"
    alias fgrep="fgrep ${grep_options[*]}"
fi

# Network tools with color support
if ip -color=auto addr show dev lo >/dev/null 2>&1; then
    alias ip='command ip -color=auto'
fi

# System information
[[ -r /proc/mdstat ]] && alias mdstat='cat /proc/mdstat'

# Safety aliases
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Modern alternatives (install them for better experience)
# command -v bat >/dev/null && alias cat='bat --paging=never'
# command -v exa >/dev/null && alias ls='exa' && alias ll='exa -la' && alias lt='exa -la --sort=time'
# command -v fd >/dev/null && alias find='fd'
# command -v rg >/dev/null && alias grep='rg'
# command -v htop >/dev/null && alias top='htop'
# command -v ncdu >/dev/null && alias du='ncdu'

# Git aliases (if git is available)
if command -v git >/dev/null 2>&1; then
    alias g='git'
    alias ga='git add'
    alias gc='git commit'
    alias gst='git status'
    alias gd='git diff'
    alias gco='git checkout'
    alias gb='git branch'
    alias gl='git log --oneline --graph'
    alias gp='git push'
    alias gpl='git pull'
fi

# ============================================================================
# COMPLETION SYSTEM
# ============================================================================

# Initialize completion system
autoload -Uz compinit

# Only regenerate compdump once a day for faster startup
if [[ -n "$ZCONF/.zcompdump"(#qN.mh+24) ]]; then
    compinit -d "$ZCONF/.zcompdump"
else
    compinit -C -d "$ZCONF/.zcompdump"
fi

# Enhanced completion configuration
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- No matches found --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Completion for common commands
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Host completion from various sources
if [[ -f ~/.ssh/config ]]; then
    zstyle ':completion:*:ssh:*' hosts $(_ssh_config_hosts)
    zstyle ':completion:*:scp:*' hosts $(_ssh_config_hosts)
fi

# Directory completion
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Correction settings
if [[ "$NOCOR" -eq 0 ]]; then
    setopt CORRECT
    setopt CORRECT_ALL
    zstyle ':completion:*:correct:*' insert-unambiguous true
    zstyle ':completion:*:correct:*' original true
fi

# ============================================================================
# PLUGIN MANAGEMENT & MODULE LOADING
# ============================================================================

# Function to source files if they exist
source_if_exists() {
    [[ -f "$1" ]] && source "$1"
}

# Load antidote plugin manager if available
source_if_exists "$ZCONF/.antidote/antidote.zsh" && antidote load

# Load modular configuration files
if [[ -d "$ZCONF/zshrc.d" ]] && find "$ZCONF/zshrc.d" -mindepth 1 -print -quit | grep -q .; then
    # Load immediate files first
    for config_file in "$ZCONF/zshrc.d"/*.zsh(N); do
        source "$config_file"
    done

    # Load deferred files from subdirectories
    if command -v zsh-defer >/dev/null 2>&1; then
        for config_file in "$ZCONF/zshrc.d"/*/*.zsh(N); do
            zsh-defer source "$config_file"
        done
    else
        for config_file in "$ZCONF/zshrc.d"/*/*.zsh(N); do
            source "$config_file"
        done
    fi
fi

# ============================================================================
# USEFUL FUNCTIONS
# ============================================================================

# Extract archives
extract() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.xz)        unxz $1        ;;
            *.lzma)      unlzma $1      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find process and kill it
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [[ -n "$pid" ]]; then
        echo "$pid" | xargs kill -${1:-9}
    fi
}

# Quick note taking
note() {
    local notes_dir="$HOME/Documents/notes"
    [[ ! -d "$notes_dir" ]] && mkdir -p "$notes_dir"
    $EDITOR "$notes_dir/$(date +%Y-%m-%d).md"
}

# Weather function
weather() {
    curl -s "wttr.in/${1:-}"
}

# Display help for per-command history feature
zsh-help() {
    cat << 'EOF'
ZSH Configuration Help
----------------------

Per-Command History:
===================
  ↑/↓ arrows    - Find commands starting with current text
  Ctrl+P/N      - Alternative per-command history search
  Alt+↑/↓       - Standard history navigation
  Ctrl+R/S      - Interactive history search backward/forward

Example: Type "git" and press ↑ to see previous git commands.
Set ENABLE_PER_COMMAND_HISTORY=0 to disable.

Useful Functions:
================

  extract <file>       - Extract various archive formats (tar, zip, 7z, etc.)
  mkcd <dir>           - Create directory and cd into it
  fkill [signal]       - Interactive process finder and killer using fzf
  note                 - Quick note taking (opens today's note in editor)
  weather [location]   - Show weather forecast (uses wttr.in)

EOF
}

# ============================================================================
# PROMPT CONFIGURATION
# ============================================================================

# Simple but informative prompt (uncomment to use)
PROMPT='%F{blue}%n@%m%f:%F{green}%~%f%# '

# Git-aware prompt (requires git)
if command -v git >/dev/null 2>&1; then
    autoload -Uz vcs_info
    precmd() { vcs_info }
    zstyle ':vcs_info:git:*' formats ' %F{yellow}(%b)%f'
    setopt PROMPT_SUBST
    PROMPT='%F{blue}%n@%m%f:%F{green}%~%f${vcs_info_msg_0_}%# '
fi

# ============================================================================
# PERFORMANCE MONITORING
# ============================================================================

# Show startup time (uncomment to debug performance)
# zprof

# Load local customizations
source_if_exists "$HOME/.zshrc.local"

# Initialize starship prompt if available
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

