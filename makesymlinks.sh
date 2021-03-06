#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory 
# to any desired dotfiles in ~/projects/dotfiles
# Run this script from the home directory
############################

case "$(uname)" in
   CYGWIN*) cygwin=1 ;;
   *)       cygwin=0 ;;
esac

if [ $cygwin -eq 1 ]; then
    # Cygwin
    dir=/cygdrive/c/Users/Phil/My\ Projects/dotfiles
    echo $dir
    ln -sb "${dir}"/.screenrc $HOME
    ln -sb "${dir}"/.bash_profile $HOME
    ln -sb "${dir}"/.bashrc $HOME
    ln -sb "${dir}"/.bashrc_custom $HOME
    ln -sb "${dir}"/.emacs $HOME
    mv $HOME/.emacs.d $HOME/.emacs.d~
    ln -s "${dir}"/.emacs.d $HOME
else
    # Linux
    dir=$HOME/projects/dotfiles
    ln -sb $dir/.screenrc $HOME
    ln -sb $dir/.bash_profile $HOME
    ln -sb $dir/.bashrc $HOME
    ln -sb $dir/.bashrc_custom $HOME
    ln -sb $dir/.emacs $HOME
    mv .emacs.d .emacs.d~
    ln -s $dir/.emacs.d $HOME
fi
