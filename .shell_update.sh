#!/bin/bash

# create symlink to command archive directory
echo -e "$DASH_LINE\nplease provide your command archive directory path :"

# read input from user
read -r cmdarchdir

# if directory does not exist, create
if [[ ! -d $cmdarchdir ]]; then
    mkdir -pv $cmdarchdir
fi

# create symlink in shell-extend directory
ln -s $cmdarchdir $HOME/.shell_extend/.cmd_archive

# set shell extension
extendshell='\n\n
# ------ SET SHELL EXTENSIONS ------\n\n
if [[ -f $HOME/.shell_extend/.bash_extend ]]; then\n
\t. $HOME/.shell_extend/.bash_extend\n
fi'

# append to .bashrc
if [[ -f $HOME/.bashrc ]]; then
    echo -e $extendshell  >> $HOME/.bashrc
fi

# set custom .vimrc
if [[ ! -f $HOME/.vimrc ]]; then
    cp $HOME/.shell_extend/.vimrc_default $HOME/.vimrc
fi

# success
return 0
