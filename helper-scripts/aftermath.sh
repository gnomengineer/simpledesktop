#!/usr/bin/zsh

#if [ ~/.ssh/id_rsa.pub -e ]
#then
    ## setup zsh
    echo "cloning zprezto configuration via HTTPS..."
    git clone --recursive https://github.com/gnomengineer/prezto.git ~/.zprezto

    echo "copying config files..."
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        echo "$rcfile ..."
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done

    echo ""
    ## setup simpledesktop
    echo "cloning simpledesktop via HTTPS..."
    git clone --recursive https://github.com/gnomengineer/simpledesktop.git /tmp/simpledesktop

    # check if awesome folder exist, if not create it
    if [! -d ~/.config/awesome ]
    then
        mkdir ~/.config/awesome
    fi 
    
    # copy the awesome configuration to the local config file
    echo "copying simpledesktop configuration to config folder"
    cp -r /tmp/simpledesktop/src/* ~/.config/awesome/
    if [ -e ~/.config/awesome/rc.lua ]
    then
        echo "simpledesktop was installed successfully!"
    else
        echo "(WW) something is wrong with simpledesktop. Maybe the X11 wont start properly"
    fi

    # installing vundle for vim
    echo "installing vundle to vim..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    if [ -d ~/.vim/bundle/Vundle.vim ]
    then
        echo "vundle installed!"
    else
        echo "(WW) vundle was not correctly installed"
    fi

    echo ""
    echo "updating pacman"
    sudo pacman -Syu

    echo "asking for new password"
    passwd
    echo "changing user shell"
    chsh -s /bin/zsh
    echo ""
    echo "DONE with the aftermath!"
    echo ""
    # print info about optional repos
    echo "optional repos can be installed"
    echo "  scripts (optional)"
    echo "  dnd (optional)"
    echo "  project (optional)"
    echo ""
    echo "maybe some more programs from AUR need to be installed"
    echo "  mons (optional)"
    echo "  conky-lua-archers (optional)"
    echo ""
#else
#    echo "you need to setup your ssh key for git usage"
#fi
