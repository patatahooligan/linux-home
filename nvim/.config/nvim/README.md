# neovim

This neovim setup is based on astronvim. It was created by modifying
[this template][1] and following [these instructions][2].

[1]: https://github.com/AstroNvim/AstroNvim
[2]: https://docs.astronvim.com/configuration/v4_migration/

## Dependencies

The setup is configured as a set of lazy plugins. Lazy itself is
installed, if absent, by `init.lua`. So this configuration mostly sets
itself up with no system dependencies. The only exceptions are:

- git: for the bootstrap process
- otf-commit-mono-nerd: for the icons used by astronvim

Optionally, for using neovim outside a terminal:

- neovide
