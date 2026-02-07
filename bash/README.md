# bash

This configuration emulates XDG Base Directory support, which bash
lacks. Bash will not automatically source this bashrc because it is not
in the default location. You will have to source it manually by doing
one of the following:

- In /etc/bash.bashrc `source "$HOME/.config/bash/bashrc"` if it exists
- If invoking `bash`, append `--init-file "$HOME/.config/bash/bashrc"`

This configuration will read `/usr/local/share/shell/settings` if it
exists, as a way to support common options across multiple shells.
