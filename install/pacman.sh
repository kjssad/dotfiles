#!/usr/bin/env bash

echo -e "\\nInstalling pacman packages."
echo "=============================="
pacman -S \
    bind-tools \
    curl \
    diff-so-fancy \
    gawk \
    git \
    highlight \
    libva-intel-driver \
    neovim \
    ngrep \
    python-neovim \
    ripgrep \
    shellcheck \
    tcpdump \
    tmux \
    util-linux \
    zsh
