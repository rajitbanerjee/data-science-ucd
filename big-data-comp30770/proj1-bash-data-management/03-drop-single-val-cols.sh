#!/bin/bash

file="./data/reddit_2021_clean.csv"
temp="./data/reddit_temp"

echo "Dropping single value columns..."

# count number of columns
num_cols=$(head -1 "$file" | sed 's/[^,]//g' | wc -c)
singular_cols=""

# loop through columns, and keep track of variables taking only a single value
for ((i=1; i<=num_cols; i++)); do
    echo -ne "Checking column #$i/$num_cols..."\\r
    unique_vals=$(cut -d, -f"$i" "$file" | tail -n +2 | sort | uniq | wc -l)
    if [ "$unique_vals" -eq 1 ]; then
        singular_cols="$singular_cols,$i"
    fi
done

# remove extra comma from the beginning
singular_cols="${singular_cols:1}"

echo -e "Columns taking only one value identified: $singular_cols\nRewriting $file..."
# remove all columns that take only a single value
cut -d, -f"$singular_cols" --complement "$file" > "$temp"

mv "$temp" "$file"
echo -e "Done!\n"
