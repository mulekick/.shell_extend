#!/bin/bash

# list all files in commands history folder
entries=$(ls -A $SHELL_HISTORY)

# for each file
for entry in $entries; do
    # if file is not pruned
    if [[ ! $entry =~ ^.+\.pruned$ ]]; then
        # unpruned file
        before=$(cat "$SHELL_HISTORY/$entry" | wc -l)
        # pruned file
        after=$(cat "$SHELL_HISTORY/$entry" | sed -r 's/^(\s*[0-9]+\s+)?(.+)$/\2/g' - | sort - | uniq - | wc -l)
        # log
        echo "pruning $entry from $(echo $before) lines to $(echo $after) lines"
        # process and remove entry
        cat "$SHELL_HISTORY/$entry" | sed -r 's/^(\s*[0-9]+\s+)?(.+)$/\2/g' - | sort - | uniq - > "$SHELL_HISTORY/$entry.pruned" && rm "$SHELL_HISTORY/$entry" 
    fi
done

# success
return 0 
