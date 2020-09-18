# Enter gpg passphrase through terminal shell
# This is required for signing commits through remote sessions
# It is important that this happens first when using p10k because it appears to
# perform some magic and tty returns "not a tty" if we don't do it now.
export GPG_TTY=$(tty)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation (arch)
ZSH=/usr/share/oh-my-zsh/

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


if [[ -e /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    # Source zsh-syntax-highlighting only if we are sure our current terminal has
    # enough colors for it to look normal
    TERMINAL_COLORS=$(tput colors)

    # Check the exit code because 'colors' might not even exist in the terminfo
    if [[ $? && $TERMINAL_COLORS -ge 256 ]]; then
        source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# fzf
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh

# Update when there are no news to indicate that intervention is
# needed. When there are news, display them.
safe-update() {
    if [ $(yay -Pw --color=always | tee /dev/tty | wc -l) = 0 ]
    then
        yay -Syu
    fi
}

alias exa='exa -la --git --color-scale'

# Set TERM to something generic for which we hope the host machine will have the
# appropriate terminfo. This is useful because if they don't have the correct
# terminfo, the terminal bugs out. Maybe this isn't the perfect value for it, so
# I might have to change it in the future. Maybe I can set a custom ssh command
# for gcloud so that I can redirect it to the kitten as below.
alias gcloud="TERM='xterm-256color' gcloud"

if [[ $TERM = 'xterm-kitty' ]]; then
    alias icat='kitty +kitten icat'

    # This kitten copies over the terminfo to the target system, solving the
    # same problem that the gcloud alias above exists for, but without
    # sacrificing functionality this time.
    alias ssh='kitty +kitten ssh'
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
