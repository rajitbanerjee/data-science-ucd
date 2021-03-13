#!/bin/bash

input="./data/reddit_2021.csv"
output="./data/reddit_2021_clean.csv"

cp "$input" "$output"
pattern='s/\("[^"][^"]*\),\(.*"\)/\1;\2/'

# commas in double quotes mess with CSV, need to fix it
echo "Replacing all protected commas with semi-colon..."
while grep -q '"[^"][^"]*,.*"' "$output"; do
    sed -i "$pattern" "$output"
done

echo "Written to $output"
echo -e "Done!\n"
