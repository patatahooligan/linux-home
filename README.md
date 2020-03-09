# linux-home

Just a bunch of dotfiles and stuff I want to carry across installations. Not
intended to be useful to anyone but me, but feel free to fork and use.

The files are managed by GNU stow. Read the manual on what that means but the
gist of it is to clone into a directory directly inside your home dir, and then
set up like

    cd ~/linux-home
    stow package-name

where `package-name` is any top-level dir, eg "git", "zsh" etc.

Be careful of stow folding directories, ie creating symlink to the highest level
directory that it can. If undesired, invoke as

    stow --no-folding package-name

dconf-dump is an exception. I decided against committing the actual binary file,
so you have to use dconf to import it into your database. I might break it up
in the future if it gets bigger so that I can deploy only the settings for
specific packages. For now, the file is created by running

    dconf dump / > dconf-dump

And the values can be read back by running

    dconf load / < dconf-dump

This will not overwrite values not included in dconf-dump. If the previous
database is to be discarded, it can be done by running

    dconf reset -f /

The configs are used in arch linux. They might be incompatible with the software
versions on any other distro.

Dependencies will be documented in each package's README.md.
