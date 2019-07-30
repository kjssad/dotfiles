#!/usr/bin/env bash

echo "Installing dotfiles."

source install/link.sh
source install/git.sh

if [ "$(uname)" == "Linux" ]; then
    echo -e "\\n\\nRunning on Linux"
    if type apt > /dev/null 2>&1; then
        echo -e "\\nDebian/derivatives"
        sudo install/apt.sh
    fi
    if type dnf > /dev/null 2>&1; then
        echo -e "\\nFedora/RHEL/CENT/derivatives"
        sudo install/dnf.sh
    fi
    if type pacman > /dev/null 2>&1; then
        echo -e "\\nArch/derivatives"
        sudo install/pacman.sh
    fi
fi

if ! type zsh > /dev/null 2>&1; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s "$(command -v zsh)"
fi

echo "Done. Reload your terminal."
