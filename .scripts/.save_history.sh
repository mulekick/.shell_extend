#!/bin/bash

# test hostname for wsl2 compatibility, redirect STDERR to /dev/null
host=$(hostnamectl --static 2> /dev/null || echo 'wsl2' > /dev/stdout)

# check if .bash_history is present
if [[ -f "$HOME/.bash_history" ]]; then

    # compute filename (history.YYYYMMDD.logname.hostname)
    filename="$SHELL_HISTORY/history.$(date +%Y%m%d).$LOGNAME.$host"

    # write current shell history to .bash_history, clear shell history
    history -w && history -c

    # cat .bash_history contents to filename
    cat "$HOME/.bash_history" > "$filename"

    # empty .bash_history
    cat /dev/null > "$HOME/.bash_history"

    # restart shell
    exec "$SHELL"

# end if
fi

# return
return 0
