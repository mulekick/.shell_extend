#!/bin/bash

# set shell extension
extendshell='\n\n
# ------ SET SHELL EXTENSIONS ------\n\n
if [[ -f $HOME/.shell-extend/.bash_extend ]]; then\n
\t. $HOME/.shell-extend/.bash_extend\n
fi'

# append to .bashrc
if [[ -f $HOME/.bashrc ]]; then
    echo -e $extendshell  >> $HOME/.bashrc
fi

# set custom .vimrc
if [[ ! -f $HOME/.vimrc ]]; then
    cp $HOME/.shell-extend/.vimrc_default $HOME/.vimrc
fi

# success
return 0
