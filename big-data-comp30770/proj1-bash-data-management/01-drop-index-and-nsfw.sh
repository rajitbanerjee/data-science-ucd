#!/bin/bash

file="./data/reddit_2021_clean.csv"
temp="./data/temp_drop"

echo "Dropping columns 1,2,3,34..."

# drop columns 1, 2, 3 (index variables) and 34 (NSFW check)
cut -d, -f1-3,34 --complement "$file" > "$temp"

mv "$temp" "$file"
echo -e "Done!\n"

