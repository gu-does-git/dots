# dots (based on [this](https://github.com/logandonley/dotfiles))

This repo contains the configuration to setup my machines. This is using [Chezmoi](https://chezmoi.io), the dotfile manager to setup the install.

This automated setup is currently only configured for Fedora machines.

## How to run

```shell
## Install the dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:gu-does-git/dots.git
```
