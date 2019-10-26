#!/usr/bin/env bash

# echo -e "\\nInstalling base desktop environment."
# echo "=============================="
dnf group install base-x "Hardware Support" "Common NetworkManager Submodules"
dnf group install "Firefox Web Browser"
dnf group install Standard --exclude="ed,irqbalance,opensc,rsyslog,smartmontools,abrt-cli,sssd,nano"
dnf group install "Gnome Desktop Environment" --exclude="gnome-boxes,gnome-software,gnome-weather,gnome-photos,gnome-documents,gnome-contacts,gnome-maps,gnome-user-docs,simple-scan,yelp,PackageKit-command-not-found,PackageKit-gtk3-module,cheese,gnome-characters,gnome-classic-session,gnome-clocks,gnome-font-viewer,gnome-getting-started-docs,gnome-initial-setup,gnome-logs,gnome-screenshot,baobab,orca,chrome-gnome-shell" --setopt=install_weak_deps=False

echo -e "\\nInstalling RPM Fusion."
echo "=============================="
dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo -e "\\nInstalling Multimedia codecs."
echo "=============================="
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf install libva-intel-driver gstreamer1-vaapi libva-utils

echo -e "\\nInstalling Fonts."
echo "=============================="
dnf install mozilla-fira-mono-fonts google-noto-cjk-fonts google-noto-emoji-color-fonts

echo -e "\\nInstalling RPM packages."
echo "=============================="
dnf install \
    ShellCheck \
    git \
    gnome-tweaks \
    highlight \
    menulibre \
    ngrep \
    neovim \
    python3-neovim \
    ripgrep \
    sqlite \
    tmux \
    util-linux-user \
    zsh
