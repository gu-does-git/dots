# dots

This repo contains the configuration to setup my machines. This is using [Chezmoi](https://chezmoi.io), the dotfile manager to setup the install.

This automated setup is currently only configured for Fedora machines.

## How to run

```shell
## Install the dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:gu-does-git/dots.git

## Install kickstart.nvim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

## Re-apply the nvim config
chezmoi apply
```
