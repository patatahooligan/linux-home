# linux-home

Just a bunch of dotfiles and stuff I want to carry across installations.
Not intended to be useful to anyone but me, but feel free to fork and
use.

The files are managed by GNU stow. Read the manual on what that means
but the gist of it is to clone into a directory directly inside your
home dir, and then
set up like

```bash
cd ~/linux-home
stow package-name
```

where `package-name` is any top-level dir, eg "git", "zsh" etc.

The configs are used in arch linux. They might be incompatible with the
software versions on any other distro.

Dependencies will be documented in each package's README.md.

## dconf-dump

dconf-dump doesn't work like the other configs because it is a binary
database. I decided against committing the actual binary file, so you
have to use dconf to import it into your database. I might break it up
in the future if it gets bigger so that I can deploy only the settings
for specific packages. For now, the file is created by running

```bash
dconf dump / > dconf-dump
```

And the values can be read back by running

```bash
dconf load / < dconf-dump
```

This will not overwrite values not included in dconf-dump. If the
previous database is to be discarded, it can be done by running

```bash
dconf reset -f /
```
