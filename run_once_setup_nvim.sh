#!/bin/bash

NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if [ -d "$NVIM_CONFIG_DIR" ]; then
  echo "nvim configuration directory already exists at $NVIM_CONFIG_DIR. Skipping clone."
else
  echo "Trying to clone kickstart.nvim"
  git clone https://github.com/dam9000/kickstart-modular.nvim.git "$NVIM_CONFIG_DIR"
fi
