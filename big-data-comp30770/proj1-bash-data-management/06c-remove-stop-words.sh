#!/bin/bash

stopwords="./data/stopwords.txt"
titles="./data/titles.txt"
temp="./data/without_stop"

# stop words to be removed
echo "Downloading stop words file..."
wget -q https://raw.githubusercontent.com/igorbrigadir/stopwords/master/en/alir3z4.txt \
    -O ./data/stopwords.txt

echo "title" > "$temp"
echo "Removing stop words..."

# build regex and remove all stopwords from all titles
words="$(tr '\n' '|' < "$stopwords")"
sed -E "s/\b($words)\b//g" <<< "$(tail -n +2 "$titles")" >> "$temp"

# echo "Rewriting $titles..."
mv "$temp" "$titles"
echo -e "Done!\n"
