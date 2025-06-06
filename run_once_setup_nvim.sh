#!/bin/bash

echo "Trying to clone kickstart.nvim"

git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
