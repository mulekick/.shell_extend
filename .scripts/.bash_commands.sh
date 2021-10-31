#!/bin/bash

# custom shell commands aggregated in a single file
# using exit because of "can only `return' from a function or sourced script" ?

# -------------------------------------------------
# histsave : ask for confirmation and run history saving
if [[ $1 = "hs" ]]; then
    echo 'do you want to save and reset current history ? (Y/n)'
    read -r confirm
    # shellcheck disable=SC1091
    [[ $confirm = 'Y' ]] && . "$SHELL_SCRIPTS/.save_history.sh"
# -------------------------------------------------
# histprune : ask for confirmation and run command history pruning
elif [[ $1 = "hp" ]]; then
    echo 'do you want to prune command archive files ? (Y/n)'
    read -r confirm
    # shellcheck disable=SC1091
    [[ $confirm = 'Y' ]] && . "$SHELL_SCRIPTS/.prune_history.sh"
# -------------------------------------------------
# params will be the command id and actual command line param
elif [[ $# -lt 2 ]]; then
    echo "please provide command line parameter"
    # failure
    exit 1
# -------------------------------------------------
# nscript : create new bash script and vi into it 
elif [[ $1 = "ns" ]]; then
    # resolve to full path
    filename=$(realpath -q "$2")
    # check if file already exists
    if [[ -z $filename ]]; then
        echo "failed to create file: $2 is not a valid path."
        # failure
        exit 1
    elif [[ -e $filename ]]; then
        echo "failed to create file: $filename already exists."
        # failure
        exit 1
    fi
    # touch
    touch "$filename" &&
    # chmod executable
    chmod 755 "$filename" &&
    # add shebang
    echo -e "#!/bin/bash\n\n" >> "$filename" &&
    # vi at line 3
    vi -c ':set nu' +3 "$filename"
# -------------------------------------------------
# fsearch : recursive search for files name (shell wildcards)
elif [[ $1 = "fs" ]] && [[ $# -eq 4 ]]; then
    # search from $2 starting point, $3 directories depth for file name matching $4
    find -P "$2" -maxdepth "$3" -name "$4" -ls
# -------------------------------------------------
# fsearch : recursive search for files name (regexp extended)
elif [[ $1 = "fs" ]] && [[ $# -eq 5 ]] && [[ $4 = "-r" ]]; then
    # search from $2 starting point, $3 directories depth for file matching expr $5
    find -P "$2" -maxdepth "$3" -regextype 'posix-extended' -regex "$5" -ls
# -------------------------------------------------
# fparse : output files lines matching pattern (regexp extended + remove tabs/separators for clean display)
elif [[ $1 = "fp" ]] && [[ $# -eq 4 ]]; then
    # search from $2 starting point, $3 directories, output every file line matching expr $4, cut match width to 145 to bypass colums messing the terminal ...
    find -P "$2" -maxdepth "$3" -type f -exec grep -nE "$4" '{}' + | sed -r 's/^([^:]+):([^:]+):(\t|\s)*(.*)$/\1\^\2^\4/gm' - | cut -c -145 - | column -ts '^' -N FILE,LINE,MATCH
# -------------------------------------------------
# ftype : show matching file types in target directory
elif [[ $1 = "ft" ]] && [[ $# -eq 3 ]]; then
    # output list one entry per line, launch file, update separator, output columns, regexp on 3rd param value
    find "$2" -maxdepth 1 | file -f - | sed -r 's/:\s{2,}/:/g' - | column -ts ':' | grep -E - --color=always -hTis -e "$3" 
# -------------------------------------------------
# arbo : output file system tree from starting point, pruned, less + color escape sequence
elif [[ $1 = "ar" ]] && [[ $# -eq 2 ]]; then
    # output everything
    tree --prune -afFhpC "$2" | less -R -
# -------------------------------------------------
# arbo : same as the above, match optional pattern
elif [[ $1 = "ar" ]] && [[ $# -eq 3 ]]; then
    # output matches
    tree --prune -afFhpCP "$3" "$2" | less -R -
# -------------------------------------------------
# pkfind : search for pattern matching packages names with apt-cache
elif [[ $1 = "pk" ]]; then
    # output name and short description
    apt-cache search "$2" --names-only | sort | sed -r "s/\s-\s/¤/" - | column -tN "PACKAGE,DESCRIPTION" -s "¤" | less
# -------------------------------------------------
# pdetail : show single package details with apt-cache
elif [[ $1 = "pd" ]]; then
    # output full description
    apt-cache search "^$2$" --full
# -------------------------------------------------
# pstatus : query dpkg database for package(s) installation status
elif [[ $1 = "ps" ]]; then
    # output columnated list
    dpkg-query -Wf='${Package}|${db:Status-Abbrev}|${Version}|${Architecture}|${Installed-Size}|${binary:Synopsis}|${Origin}|${Maintainer}\n' "${@:2}" | column -tN "NAME,STATUS,VERSION,ARCH,SIZE,DESCRIPTION,ORIGIN,MAINTAINER" -s "|"
# -------------------------------------------------
# tab2space : ask for confirmation and run replacement script
elif [[ $1 = "ts" ]] && [[ -f "$2" ]]; then
    echo "do you want to replace all tabs by default indentation in $2? (Y/n)"
    read -r confirm
    [[ $confirm = 'Y' ]] &&
    cp --preserve=all "$2" "$2.tmp" &&
    sed -r "s/\t/$DEFAULT_INDENT/g" "$2" > "$2.tmp" &&
    mv -fv "$2.tmp" "$2"
# -------------------------------------------------
# varenv : print environment variables in a civilized manner
elif [[ $1 = "en" ]]; then
    # read environment variables, grep on 2nd param
    vars=$(printenv | cut -d "=" -f 1 - | grep -F -i "$2" -)
    # loop on variables
    for v in $vars
        do
            echo "--------------------------------"
            # present values, one entry per line
            echo "$v"
            # no echo here in order to preserve new lines in output
            # shellcheck disable=SC1004
            printenv "$v" | sed -r 's/:/\
/g' - | nl -n ln -
        done
# -------------------------------------------------
# parttable : display device details + sudo revocation
elif [[ $1 = "sd" ]]; then
    sudo echo "$DASH_LINE" && sudo fdisk -lo +UUID "$2"  | sed -r "s/^$/$DASH_LINE/g" - && echo "$DASH_LINE"
    # sudo revocation
    sudo -k    
# -------------------------------------------------
# partdetail : display more details on partition and file system for device $2 + sudo revocation
elif [[ $1 = "pt" ]]; then
    sudo echo "$DASH_LINE" && sudo blkid -p "$2" | sed -r "s/\s/\n/g" && 
    echo "$DASH_LINE" && sudo dumpe2fs "$2" | grep -F 'Filesystem' &&
    echo "$DASH_LINE"
    # sudo revocation
    sudo -k
# -------------------------------------------------
# print process exit code for $2 execution (DOESN'T WORK, BUT WOULD BE GREAT)
# elif [[ $1 = "ec" ]] && [[ $# -eq 2 ]] && [[ -n $2 ]]; then
#          echo -e result -\> `$2` \n  && echo exit code -\> $? || echo exit code -\> $?
# -------------------------------------------------
else
    echo "no command could be executed"
    # failure
    exit 1
fi

# success
exit 0
