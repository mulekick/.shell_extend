#!/bin/bash

# set shell extension
# shellcheck disable=SC2016
extendshell='
# ------ SET SHELL EXTENSIONS ------
if [[ -f $HOME/.shell_extend/.bash_extend ]]; then
\t. $HOME/.shell_extend/.bash_extend
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
