#!/bin/bash

function get_result {
    # evaluate function
    eval "$1"
    # print result to stdout
    echo "$?" > /dev/stdout
    # success
    return 0
}

# switch on test return value ...
# shellcheck disable=SC2194
case 0 in
# ------------ FILES ------------
# fsearch : recursive search for files name (shell wildcards)
"$(get_result "[[ $# -eq 4 ]] && [[ \"$1\" = fs ]] && [[ -d \"$2\" ]] && [[ \"$3\" -gt 0 ]] && [[ -n \"$4\" ]] || false")")
    # search from $2 starting point, $3 directories deep for file name matching $4
    find -P "$2" -maxdepth "$3" -name "$4" -ls
;;
# fsearch : recursive search for files name (regexp extended)
"$(get_result "[[ $# -eq 5 ]] && [[ \"$1\" = fs ]] && [[ -d \"$2\" ]] && [[ \"$3\" -gt 0 ]] && [[ \"$4\" = -r ]] && [[ -n \"$5\" ]] || false")")
    # search from $2 starting point, $3 directories deep for file matching expr $5
    find -P "$2" -maxdepth "$3" -regextype 'posix-extended' -regex "$5" -ls
;;
# fparse : output files lines matching pattern (regexp extended + remove tabs/separators for clean display)
"$(get_result "[[ $# -eq 4 ]] && [[ \"$1\" = fp ]] && [[ -d \"$2\" ]] && [[ \"$3\" -gt 0 ]] && [[ -n \"$4\" ]] || false")")
    # search from $2 starting point, $3 directories deep, output every file line matching expr $4, cut match width to 145 to bypass colums messing the terminal ...
    find -P "$2" -maxdepth "$3" -type f -exec grep -nE "$4" '{}' + | sed -r 's/^([^:]+):([^:]+):(\t|\s)*(.*)$/\1\^\2^\4/gm' - | cut -c -145 - | column -ts '^' -N FILE,LINE,MATCH
;;
# ftype : show matching file types in target directory
"$(get_result "[[ $# -eq 3 ]] && [[ \"$1\" = ft ]] && [[ -d \"$2\" ]] && [[ -n \"$3\" ]] || false")")
    # output list one entry per line, launch file, update separator, output columns, regexp on 3rd param value
    find "$2" -maxdepth 1 | file -f - | sed -r 's/:\s{2,}/:/g' - | column -ts ':' | grep -E - --color=always -hTis -e "$3"
;;
# arbo : output file system tree from starting point, pruned, less + color escape sequence
"$(get_result "[[ $# -eq 2 ]] && [[ \"$1\" = ar ]] && [[ -d \"$2\" ]] || false")")
    # output everything
    tree --prune -afFhpC "$2" | less -R -
;;
# arbo : same as the above, match optional pattern
"$(get_result "[[ $# -eq 3 ]] && [[ \"$1\" = ar ]] && [[ -d \"$2\" ]] && [[ -n \"$3\" ]] || false")")
    # output matches
    tree --prune -afFhpCP "$3" "$2" | less -R -
;;
# ------------ PROCESSES ------------

# ------------ SHELL ------------
# varenv : print environment variables in a civilized manner
"$(get_result "[[ $# -eq 2 ]] && [[ \"$1\" = en ]] && [[ -n \"$2\" ]] || false")")
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
;;
# ------------ HISTORY ------------
# histsave : ask for confirmation and run history saving
"$(get_result "[[ $# -eq 1 ]] && [[ \"$1\" = hs ]] || false")")
    echo 'do you want to save and reset current history ? (Y/n)'
    read -r confirm
    # shellcheck disable=SC1091
    [[ $confirm = 'Y' ]] && . "$SHELL_SCRIPTS/.save_history.sh"
;;
# histprune : ask for confirmation and run command history pruning
"$(get_result "[[ $# -eq 1 ]] && [[ \"$1\" = hp ]] || false")")
    echo 'do you want to prune command archive files ? (Y/n)'
    read -r confirm
    # shellcheck disable=SC1091
    [[ $confirm = 'Y' ]] && . "$SHELL_SCRIPTS/.prune_history.sh"
;;
# ------------ UTILITIES ------------
# nscript : create new bash script and vi into it
"$(get_result "[[ $# -eq 2 ]] && [[ \"$1\" = ns ]] || false")")
    # resolve to full path
    filename=$(realpath -q "$2")
    # check if file already exists
    if [[ -z $filename ]]; then
        echo "failed to create file: $2 is not a valid path."
        # failure
        return 1
    elif [[ -e $filename ]]; then
        echo "failed to create file: $filename already exists."
        # failure
        return 1
    fi
    # touch
    touch "$filename" &&
    # chmod executable
    chmod 755 "$filename" &&
    # add shebang
    echo -e "#!/bin/bash\n\n" >> "$filename" &&
    # vi at line 3
    vi -c ':set nu' +3 "$filename"
;;
# tab2space : ask for confirmation and run replacement script
"$(get_result "[[ $# -eq 2 ]] && [[ \"$1\" = ts ]] && [[ -f \"$2\" ]] || false")")
    echo "do you want to replace all tabs by default indentation in $2? (Y/n)"
    read -r confirm
    [[ $confirm = 'Y' ]] &&
    cp --preserve=all "$2" "$2.tmp" &&
    sed -r "s/\t/$DEFAULT_INDENT/g" "$2" > "$2.tmp" &&
    mv -fv "$2.tmp" "$2"
;;
# ------------ APT/DPKG ------------
# pkfind : search for pattern matching packages names with apt-cache
"$(get_result "[[ $# -eq 2 ]] && [[ \"$1\" = pk ]] && [[ -n \"$2\" ]] || false")")
    # output name and short description
    apt-cache search "$2" --names-only | sort | sed -r "s/\s-\s/¤/" - | column -tN "PACKAGE,DESCRIPTION" -s "¤" | less
;;
# pdetail : show single package details with apt-cache
"$(get_result "[[ $# -eq 2 ]] && [[ \"$1\" = pd ]] && [[ -n \"$2\" ]] || false")")
    # output full description
    apt-cache search "^$2$" --full
;;
# pstatus : query dpkg database for package(s) installation status
"$(get_result "[[ $# -ge 2 ]] && [[ \"$1\" = ps ]] && [[ -n \"$2\" ]] || false")")
# output columnated list
    dpkg-query -Wf='${Package}|${db:Status-Abbrev}|${Version}|${Architecture}|${Installed-Size}|${binary:Synopsis}|${Origin}|${Maintainer}\n' "${@:2}" | column -tN "NAME,STATUS,VERSION,ARCH,SIZE,DESCRIPTION,ORIGIN,MAINTAINER" -s "|"
;;
# ------------ FILE SYSTEM ------------
# parttable : display partition table + sudo revocation
"$(get_result "[[ $# -eq 2 ]] && [[ \"$1\" = pt ]] && [[ -b \"$2\" ]] || false")")
    sudo echo "$DASH_LINE" && sudo fdisk -lo +UUID "$2"  | sed -r "s/^$/$DASH_LINE/g" - && echo "$DASH_LINE"
    # sudo revocation
    sudo -k  
;;
# partdetail : display partition details for $2 + sudo revocation
"$(get_result "[[ $# -eq 2 ]] && [[ \"$1\" = dd ]] && [[ -b \"$2\" ]] || false")")
    sudo echo "$DASH_LINE" && sudo blkid -p "$2" | sed -r "s/\s/\n/g" && 
    echo "$DASH_LINE" && sudo dumpe2fs "$2" | grep -F 'Filesystem' &&
    echo "$DASH_LINE"
    # sudo revocation
    sudo -k
;;
# -------------------------------------

# action is unknown
*)
	echo -e "no command could be executed"
    # failure
    return 1
;;
esac

# success
return 0
