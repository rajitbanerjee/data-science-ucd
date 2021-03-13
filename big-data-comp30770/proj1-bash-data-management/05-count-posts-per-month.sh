#!/bin/bash

file="./data/reddit_2021_clean.csv"

echo "Number of posts created and retrieved, by month:"

# count number of columns
num_cols=$(head -1 "$file" | sed 's/[^,]//g' | wc -c)

for ((i=1; i<=num_cols; i++)); do
    heading="$(head -n 1 "$file" | cut -d, -f"$i")"
    if [ "$heading" == "created_utc" ] || [ "$heading" == "retrieved_on" ]; then
        echo -e "\n$heading:"
        # cut out date columns and count unique entries
        tail -n +2 "$file" | cut -d, -f"$i" | sort | uniq -c
    fi
done

echo ""
