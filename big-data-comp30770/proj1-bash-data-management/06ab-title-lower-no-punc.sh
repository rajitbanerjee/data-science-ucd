#!/bin/bash

file="./data/reddit_2021_clean.csv"
titles="./data/titles.txt"
temp="./data/temp_titles"

echo "Converting 'title' to lower case and removing punctuation..."

# count number of columns
num_cols=$(head -1 "$file" | sed 's/[^,]//g' | wc -c)

echo "Creating $titles..."
for ((i=num_cols; i>0; i--)); do
    heading="$(head -n 1 "$file" | cut -d, -f"$i")"
    if [ "$heading" == "title" ]; then
        # store only the tile column for processing throughout question 6
        cut -d, -f"$i" $file > "$titles"
        break
    fi
done

# change to lower case and remove punctuation
tr "[:upper:]" "[:lower:]" < "$titles" | tr -d "[:punct:]" > "$temp"

mv  "$temp" "$titles"
echo -e "Done!\n"

