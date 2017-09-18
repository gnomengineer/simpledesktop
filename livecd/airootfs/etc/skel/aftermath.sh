#!/bin/bash

if [ ~/.ssh/id_rsa.pub -e ]
then
    # clone important github repos
    git clone git@github.com:gnomengineer/prezto.git ~/.zprezto
    git clone git@github.com:gnomengineer/simpledesktop.git ~/projects/simpledesktop

    # copy the awesome configuration to the local config file
    cp -r ~/projects/simpledesktop/src ~/.config/awesome/

    # print info about optional repos
    echo ""
    echo "optional repos can be installed"
    echo "scripts (optional)"
    echo "dnd (optional)"
    echo "project (optional)"
    echo ""
    echo "done with the aftermath"
else
    echo "you need to setup your ssh key for git usage"
fi
