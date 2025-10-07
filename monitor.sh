#!/bin/bash
# Example script to rebuild slides
# FIXME: this should use "entr" if available
# FIXME: this should also build the script.md output

file="slides.md"
live-server --no-browser release/slides_preview.html &
last=""

while true; do
    ts=$(stat -c %Y "$file" 2>/dev/null)
    if [ "$ts" != "$last" ]; then
        echo "Change detected in $file"
        make preview-slides
        last=$ts
    fi
    sleep 1
done
