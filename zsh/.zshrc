# Enter gpg passphrase through terminal shell
# This is required for signing commits through remote sessions
# It is important that this happens first when using p10k because it appears to
# perform some magic and tty returns "not a tty" if we don't do it now.
export GPG_TTY=$(tty)

export PATH="$HOME/.local/bin:${PATH}"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Completion options
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
_comp_options+=(globdots)

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
export VISUAL=nvim
export EDITOR=nvim

if [[ $TERM = 'xterm-kitty' ]] && which kitty > /dev/null; then
    alias icat='kitty +kitten icat'

    # Most of the time, there is no kitty terminfo on the systems I'm
    # ssh'ing into. There are two ways to solve this, one is to copy
    # over the terminfo in question, which is what `kitty-ssh` does, and
    # the other is to set a generic terminfo that offers a subset of
    # kitty's features. This keeps the session from breaking, but it
    # also possibly misses out on functionality. It's usefulness is
    # mostly in cases where's its possible to have nested ssh sessions,
    # in which case the kitty-ssh command won't be available. Same deal
    # for glcoud. Remember that you can always run /usr/bin/ssh
    # explicitly to bypass these aliases if they are ever unwanted for
    # some reason.
    alias kitty-ssh='kitty +kitten ssh'
    alias ssh="TERM='xterm-256color' ssh"
    alias gcloud="TERM='xterm-256color' gcloud"
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
alias bat='bat --pager="less -FSR" --wrap=never'
alias exa='exa -la --git --color-scale'
alias grep='grep --color=always --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias less='less -SR'
alias ls='ls --color=auto'
alias ip='ip --color=auto'
alias nvide='WINIT_UNIX_BACKEND=x11 neovide --multigrid'

# Use microk8s as "default" kubectl
alias kubectl="microk8s kubectl"

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:'
LS_COLORS+='cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:'
LS_COLORS+='ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:'
LS_COLORS+='*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:'
LS_COLORS+='*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:'
LS_COLORS+='*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:'
LS_COLORS+='*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:'
LS_COLORS+='*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:'
LS_COLORS+='*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:'
LS_COLORS+='*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:'
LS_COLORS+='*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:'
LS_COLORS+='*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:'
LS_COLORS+='*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:'
LS_COLORS+='*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:'
LS_COLORS+='*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:'
LS_COLORS+='*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:'
LS_COLORS+='*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:'
LS_COLORS+='*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:'
LS_COLORS+='*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:'
LS_COLORS+='*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:'
LS_COLORS+='*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:'
LS_COLORS+='*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:'
LS_COLORS+='*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:'
LS_COLORS+='*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:'
LS_COLORS+='*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
export LS_COLORS

export MANWIDTH=80
export CMAKE_EXPORT_COMPILE_COMMANDS=true

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

fzf-vim() {
    TARGET_FILE="$(fzf --preview='bat -p --color=always {}')"
    if [ -n "${TARGET_FILE}" ]; then
        nvim -- "${TARGET_FILE}"
    fi
}

fzf-grep() {
    COMMAND="bat --color=always -- {} |"
    COMMAND+="grep --color=always -C3 $@"
    grep --color=never -lIR "$@" | fzf --preview-window=up:80% --preview="${COMMAND}"
}

rgd() {
    rg --json "$@" | delta
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

# fzf
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
