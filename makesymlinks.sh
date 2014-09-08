#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/projects/dotfiles
############################

ln -sb projects/dotfiles/.screenrc .
ln -sb projects/dotfiles/.bash_profile .
ln -sb projects/dotfiles/.bashrc .
ln -sb projects/dotfiles/.bashrc_custom .
mv .emacs.d .emacs.d~
ln -s projects/dotfiles/.emacs.d .
