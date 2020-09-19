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

# Completion options
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

autoload -Uz compinit
compinit

# Set bash-style word boundaries, which means words are only [A-Za-z]*
autoload -U select-word-style
select-word-style bash

# Enable run-help for internal commands
unalias run-help
autoload run-help

# Load autosuggestions if present
if [[ -e /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    # Autosuggestions options
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
    ZSH_AUTOSUGGEST_STRATEGY=(history)
    #export ZSH_AUTOSUGGEST_COMPLETION_IGNORE=\
    #'pacman -S*|sudo pacman*|'\
    #'yay -S*|'\
    #'man*|'\
    #'systemctl*|'\
    #'journalctl*'
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load syntax highlighting if present
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

if [[ $TERM = 'xterm-kitty' ]]; then
    alias icat='kitty +kitten icat'

    # This kitten copies over the terminfo to the target system, solving the
    # same problem that the gcloud alias above exists for, but without
    # sacrificing functionality this time.
    alias ssh='kitty +kitten ssh'
fi

## History file configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Explicitly set emacs keybindings, because zsh checks $EDITOR and $VISUAL and
# uses vim bindings instead
bindkey -e


## Aliases & functions for default settings
alias exa='exa -la --git --color-scale'
alias grep='grep --color=always --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias less='less -R'
alias ls='ls --color=auto'

# Set TERM to something generic for which we hope the host machine will have the
# appropriate terminfo. This is useful because if they don't have the correct
# terminfo, the terminal bugs out. Maybe this isn't the perfect value for it, so
# I might have to change it in the future. Maybe I can set a custom ssh command
# for gcloud so that I can redirect it to the kitten as below.
alias gcloud="TERM='xterm-256color' gcloud"

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;33m") \
        LESS_TERMCAP_md=$(printf "\e[1;33m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}


## Keybindings
typeset -g -A key

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${terminfo[khome]}" ]] && bindkey -M emacs "${terminfo[khome]}" beginning-of-line
[[ -n "${terminfo[kend]}" ]] && bindkey -M emacs "${terminfo[kend]}"  end-of-line
[[ -n "${terminfo[kpp]}" ]] && bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
[[ -n "${terminfo[knp]}" ]] && bindkey -M emacs "${terminfo[knp]}" down-line-or-history
[[ -n "${terminfo[kcuu1]}" ]] && bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
[[ -n "${terminfo[kcud1]}" ]] && bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
[[ -n "${terminfo[khome]}" ]] && bindkey -M emacs "${terminfo[khome]}" beginning-of-line
[[ -n "${terminfo[kend]}" ]] && bindkey -M emacs "${terminfo[kend]}"  end-of-line
[[ -n "${terminfo[kcbt]}" ]] && bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
bindkey -M emacs '^?' backward-delete-char
[[ -n "${terminfo[kdch1]}" ]] && bindkey -M emacs "${terminfo[kdch1]}" delete-char
bindkey -M emacs "^[[3~" delete-char
bindkey -M emacs "^[3;5~" delete-char
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M emacs '^[[1;5D' backward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
