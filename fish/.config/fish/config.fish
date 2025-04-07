if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path /usr/lib/jvm/default/bin
    source /usr/local/share/shell/settings

    if command -q pyenv
        pyenv init - fish | source
    end
end
