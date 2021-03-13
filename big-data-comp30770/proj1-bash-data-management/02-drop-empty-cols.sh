#!/bin/bash

file="./data/reddit_2021_clean.csv"
temp="./data/reddit_temp"

echo "Dropping empty columns..."

# count number of columns
num_cols=$(head -1 "$file" | sed 's/[^,]//g' | wc -c)
empty_cols=""

# loop through columns, and append empty column numbers to string
for ((i=1; i<=num_cols; i++)); do
    echo -ne "Checking column #$i/$num_cols..."\\r
    non_empty_cells="$(cut -d, -f"$i" "$file" | tail -n +2)"
    if [ -z "$non_empty_cells" ]; then
        empty_cols="$empty_cols,$i"
    fi
done

# remove extra leading comma
empty_cols="${empty_cols:1}"

echo -e "Empty columns identified: $empty_cols\nRewriting $file..."
# remove all columns that are completely empty
cut -d, -f"$empty_cols" --complement "$file" > "$temp"

mv "$temp" "$file"
echo -e "Done!\n"
