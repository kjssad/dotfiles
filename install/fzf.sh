#!/usr/bin/env bash

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf
./install --all --no-bash --no-fish
