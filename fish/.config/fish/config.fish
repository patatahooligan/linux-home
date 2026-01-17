if status is-interactive
    # Disable greeting by setting value to empty text.
    set -g fish_greeting

    fish_add_path /usr/lib/jvm/default/bin
    source /usr/local/share/shell/settings

    if command -q pyenv
        pyenv init - fish | source
    end

    # motd: message of the day
    # This is often used in linux systems to display login messages. I
    # sometimes use this for non-critical notifications. It's not
    # guaranteed to exist.
    if test -f /etc/motd
        cat /etc/motd
    end
end
