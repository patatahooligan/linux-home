# Path to oh-my-zsh installation (arch)
ZSH=~/.oh-my-zsh/

ZSH_THEME="agnoster-patatahooligan"
DEFAULT_USER="patatahooligan"

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

# fzf
. /usr/share/doc/fzf/examples/key-bindings.zsh
. /usr/share/fzf/completion.zsh

# Enter gpg passphrase through terminal shell
# This is required for signing commits through remote sessions
export GPG_TTY=$(tty)

# Update when there are no news to indicate that intervention is
# needed. When there are news, display them.
safe-update() {
    TEMP_FILE=$(mktemp)
    yay -Pw > ${TEMP_FILE}
    if [ $(wc -l ${TEMP_FILE} | awk '{print $1}') = 0 ]
    then
        yay -Syu
    else
        cat ${TEMP_FILE}
    fi
}

alias exa='exa -la --git --color-scale'
