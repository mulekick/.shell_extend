#!/bin/bash

# list all files in commands history folder
entries=$(ls -A "$SHELL_HISTORY")

# for each file
for entry in $entries; do
    # if file is not pruned
    if [[ ! $entry =~ ^.+\.pruned$ ]]; then
        # unpruned file
        before=$(wc -l < "$SHELL_HISTORY/$entry")
        # pruned file
        after=$(sed -r 's/^(\s*[0-9]+\s+)?(.+)$/\2/g' < "$SHELL_HISTORY/$entry" | sort - | uniq - | wc -l)
        # log
        echo "pruning $entry from $before lines to $after lines"
        # process and remove entry
        sed -r 's/^(\s*[0-9]+\s+)?(.+)$/\2/g' < "$SHELL_HISTORY/$entry" | sort - | uniq - > "$SHELL_HISTORY/$entry.pruned" && rm "$SHELL_HISTORY/$entry" 
    fi
done

# success
return 0 
