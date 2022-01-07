#!/usr/bin/env bash

echo -e "\\nInstalling apt packages."
echo "=============================="
apt install \
	bat \
	build-essential \
	curl \
	fd-find \
	fonts-roboto \
	fonts-jetbrains-mono \
	gawk \
	git \
	htop \
	kitty \
	lm-sensors \
	ripgrep \
	shellcheck \
	tmux \
	wl-clipboard \
	zsh


echo -e "\\nInstalling latex packages."
echo "=============================="
apt install texlive-xetex latexmk
