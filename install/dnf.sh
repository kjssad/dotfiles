#!/usr/bin/env bash

echo -e "\\nInstalling base desktop environment."
echo "=============================="
dnf install gdm --setopt=install_weak_deps=False
dnf group install base-x "Hardware Support" "Common NetworkManager Submodules" "Firefox Web Browser"
dnf install \
    file-roller \
    eog \
    evince \
    gnome-sudoku \
    gnome-calculator \
    gnome-tweaks \
    gnome-system-monitor \
    gnome-power-manager \
    gnome-disk-utility \
    gedit \
    gnome-calendar \
    nautilus \
    nautilus-sendto \
    evince-nautilus \
    file-roller-nautilus \
    gnome-terminal-nautilus \
    microcode_ctl \
    tar \
    sqlite \
    NetworkManager-config-connectivity-fedora \
    bind-utils \
    xdg-user-dirs \
    xdg-user-dirs-gtk \
    dmidecode \
    mcelog \
    dejavu-sans-fonts \
    dejavu-serif-fonts \
    dejavu-sans-mono-fonts \
    gnome-themes-extra

echo -e "\\nInstalling RPM Fusion."
echo "=============================="
dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo -e "\\nInstalling Multimedia codecs."
echo "=============================="
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf install libva-intel-driver gstreamer1-vaapi libva-utils

echo -e "\\nInstalling RPM packages."
echo "=============================="
dnf install \
    ShellCheck \
    git \
    highlight \
    ngrep \
    neovim \
    python3-neovim \
    ripgrep \
    tmux \
    util-linux-user \
    zsh
