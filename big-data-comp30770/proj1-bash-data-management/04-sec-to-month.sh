#!/bin/bash

file="./data/reddit_2021_clean.csv"
temp="./data/reddit_temp"

echo "Converting 'created_utc', 'retrieved_on' columns from Unix timestamp to month name..."

date_cols=()
col_num=1

# read column headings
while IFS= read -d, -r heading; do
    # store column numbers for date columns
    if [ "$heading" == "created_utc" ] || [ "$heading" == "retrieved_on" ]; then
        date_cols+=("$col_num")
    fi
    col_num=$((col_num+1))
done <<< "$(head -n 1 $file),"

echo "Date columns identified: ${date_cols[*]}"

# write column headings
head -n 1 "$file" > "$temp"

# use awk column replacement and time formatting to change Unix timestamp to full month name (%B);
# we know there are only two date columns (created_utc, retrieved_on)
tail -n +2 "$file" \
    | awk '$'"${date_cols[0]}"'=strftime("%B", $'"${date_cols[0]}"')' FS=, OFS=, \
    | awk '$'"${date_cols[1]}"'=strftime("%B", $'"${date_cols[1]}"')' FS=, OFS=, \
    >> "$temp"

mv "$temp" "$file"
echo -e "Done!\n"
