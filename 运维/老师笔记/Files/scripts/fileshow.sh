#!/bin/bash
#
echo "Files: $@."

for file in $@; do
    lines=$(wc -l $file | cut -d' ' -f1)
    echo "$file has $lines line(s)."
done

echo "Total files: $#."
