#!/bin/bash

file="./data/reddit_2021_clean.csv"
stemmed_titles="./data/stemmed_titles.txt"
temp="./data/reddit_temp"

echo "Replacing $file titles with $stemmed_titles..."

# count number of columns
num_cols=$(head -1 "$file" | sed 's/[^,]//g' | wc -c)

for ((i=num_cols; i>0; i--)); do
    heading="$(head -n 1 "$file" | cut -d, -f"$i")"
    if [ "$heading" == "title" ]; then
        # substitute dataset's 'title' column with stemmed titles
        awk 'NR==FNR{a[NR]=$1;next} {$'"$i"'=a[FNR]}1' \
            FS=, OFS=, "$stemmed_titles" "$file" > "$temp"
        
        break
    fi
done

echo "Rewriting $file..."
mv "$temp" "$file"

echo -e "Done!\n"
