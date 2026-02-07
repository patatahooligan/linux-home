PS1='\[\e[93m\][\w]\$ \[\e[0m\]'

COMMON_SHELL_SETTINGS='/usr/local/share/shell/settings'
if [ -f "$COMMON_SHELL_SETTINGS" ]; then
    source "$COMMON_SHELL_SETTINGS"
fi

# fzf
. /usr/share/fzf/key-bindings.bash
. /usr/share/fzf/completion.bash
