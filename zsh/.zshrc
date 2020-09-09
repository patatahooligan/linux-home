# Path to oh-my-zsh installation (arch)
ZSH=~/.oh-my-zsh/

ZSH_THEME="agnoster"
DEFAULT_USER="filon"

# Completion options
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# Disable because I want yay to manage it
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

plugins=(zsh-autosuggestions)

# Autosuggestions options
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
export ZSH_AUTOSUGGEST_STRATEGY=(history)
#export ZSH_AUTOSUGGEST_COMPLETION_IGNORE=\
#'pacman -S*|sudo pacman*|'\
#'yay -S*|'\
#'man*|'\
#'systemctl*|'\
#'journalctl*'


if [[ -e /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    # Source zsh-syntax-highlighting only if we are sure our current terminal has
    # enough colors for it to look normal
    TERMINAL_COLORS=$(tput colors)

    # Check the exit code because 'colors' might not even exist in the terminfo
    if [[ $? && $TERMINAL_COLORS -ge 256 ]]; then
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

        export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
        ZSH_HIGHLIGHT_STYLES[comment]='fg=249'
    fi
fi

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir -p $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Disable autocd because it often causes me to accidentally change directory,
# while I never intentionally use it
unsetopt AUTO_CD

# Enable interactive comments. This allows tagging cryptic commands to make them
# searchable and recongnizable in history.
setopt interactivecomments

# Personal settings unrelated to zsh
export VISUAL=vim
export EDITOR=vim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enter gpg passphrase through terminal shell
# This is required for signing commits through remote sessions
export GPG_TTY=$(tty)

alias exa='exa -la --git --color-scale'

# Set TERM to something generic for which we hope the host machine will have the
# appropriate terminfo. This is useful because if they don't have the correct
# terminfo, the terminal bugs out. Maybe this isn't the perfect value for it, so
# I might have to change it in the future.
alias ssh="TERM='xterm-256color' ssh"
alias gcloud="TERM='xterm-256color' gcloud"

if [[ $TERM = 'xterm-kitty' ]]; then
    alias icat='kitty +kitten icat'
fi
