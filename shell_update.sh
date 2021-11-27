#!/bin/bash

# set shell extension
# shellcheck disable=SC2016
extendshell='\n
# ------ SET SHELL EXTENSIONS ------\n
if [[ -f $HOME/.shell_extend/.bash_extend ]]; then\n
\t. $HOME/.shell_extend/.bash_extend\n
fi'

# append to .bashrc
if [[ -f $HOME/.bashrc ]]; then
    echo -e "$extendshell"  >> "$HOME/.bashrc"
fi

# set custom .vimrc
if [[ ! -f $HOME/.vimrc ]]; then
    cp "$HOME/.shell_extend/.vimrc_default" "$HOME/.vimrc"
fi

# success
return 0
