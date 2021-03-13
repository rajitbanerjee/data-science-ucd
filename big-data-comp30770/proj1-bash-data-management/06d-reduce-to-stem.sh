#!/bin/bash

dict_file="./data/diffs.txt"
titles="./data/titles.txt"
output="./data/stemmed_titles.txt"

# dictionary used for stemming
echo "Downloading dictionary file..."
wget -q http://snowball.tartarus.org/algorithms/english/diffs.txt -O "$dict_file"

num_words=$(wc -l "$dict_file" | cut -d' ' -f1)
num_titles=$(($(wc -l "$titles" | cut -d' ' -f1)-1))

# load dictionary file into map
declare -A dictionary
i=1
while IFS= read -r line; do
    echo -ne "Loading dictionary $dict_file line #$i/$num_words..."\\r
    IFS=' ' read -r word stem <<< "$line"
    if [ "$word" != "$stem" ]; then
        dictionary["$word"]="$stem"
    fi
    i=$((i+1))
done < "$dict_file"


echo ""
echo "title" > "$output"
# loop through words in every title and reduce them to stem words if possible
i=1
while IFS= read -r title; do
    echo -ne "Stemming titles #$i/$num_titles..."\\r

    while IFS= read -d' ' -r word; do
        if [ -n "$word" ]; then
            # if word exists in dictionary, write stem to output
            if [[ -v dictionary["$word"] ]]; then
                echo -n "${dictionary[$word]} " >> "$output"
            else
                echo -n "$word " >> "$output"
            fi
        fi
    done <<< "$title "

    echo "" >> "$output"
    i=$((i+1))
done <<< "$(tail -n +2 "$titles")"

echo -e "\nDone!\n"

