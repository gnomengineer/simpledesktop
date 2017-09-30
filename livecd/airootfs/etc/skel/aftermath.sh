#!/bin/bash

if [ ~/.ssh/id_rsa.pub -e ]
then
    ## setup zsh
    git clone git@github.com:gnomengineer/prezto.git ~/.zprezto

    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done

    ## setup simpledesktop
    git clone git@github.com:gnomengineer/simpledesktop.git ~/projects/simpledesktop
    # copy the awesome configuration to the local config file
    cp -r ~/projects/simpledesktop/src/* ~/.config/awesome/
    #TODO make this a submodule part for simpledesktop (to make the include easier)
    git clone https://github.com/berlam/awesome-switcher-preview.git ~/.config/awesome

    sudo pacman -Syu

    # print info about optional repos
    echo "DONE with the aftermath!"
    echo ""
    echo "optional repos can be installed"
    echo "  scripts (optional)"
    echo "  dnd (optional)"
    echo "  project (optional)"
    echo ""
    echo "maybe some more programs from AUR need to be installed"
    echo "  mons (optional)"
    echo "  conky-lua-archers (optional)"
    echo ""
else
    echo "you need to setup your ssh key for git usage"
fi
