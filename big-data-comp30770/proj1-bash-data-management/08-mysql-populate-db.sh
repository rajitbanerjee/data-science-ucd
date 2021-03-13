#!/bin/bash

echo -e "Populating database (reddit) in MySQL:"

file="./data/reddit_2021_clean.csv"

# column numbers required for database
declare -A col_nums=(
    ["author_id"]=0 ["author"]=0 ["author_cakeday"]=0
    ["subreddit"]=0
    ["id"]=0 ["created_month"]=0 ["title"]=0
)

# read column headings and compute column numbers for necessary fields
i=1
while IFS= read -d, -r heading; do
    if [ "$heading" == "created_utc" ]; then
        heading="created_month"
    fi
    if [[ -v "col_nums[$heading]" ]]; then
        col_nums["$heading"]=$i
    fi
    i=$((i+1))
done <<< "$(head -n 1 $file),"


# for each table variable:
# step 1. awk to select required fields in correct order, and comma-separated;
# step 2. sed to  double-quote every line, then fix it to every field (by quoting commas);
# step 3. sed to replace every "" (empty field) with NULL for SQL;
# step 4. sed to surround every line with brackets;
# step 5. sed to add commas after every line
user="$(awk -F, \
    '{OFS=","; print $'"${col_nums["author_id"]}"',$'"${col_nums["author"]}"',$'"${col_nums["author_cakeday"]}"'}'\
    "$file" | tail -n +2 | \
    sed -e 's/^\|$/"/g' \
        -e 's/,/","/g' \
        -e 's/""/NULL/g' | \
    sed -E 's/(.*)/(\1)/g' | \
    sed 's/$/,/')"

subreddit="$(awk -F, \
    '{OFS=","; print $'"${col_nums["subreddit"]}"'}'\
    "$file" | tail -n +2 | \
    sed -e 's/^\|$/"/g' \
        -e 's/,/","/g' \
        -e 's/""/NULL/g' | \
    sed -E 's/(.*)/(\1)/g' | \
    sed 's/$/,/')"

post="$(awk -F, \
    '{OFS=","; print $'"${col_nums["id"]}"',$'"${col_nums["author_id"]}"',$'"${col_nums["subreddit"]}"',$'"${col_nums["created_month"]}"',$'"${col_nums["title"]}"'}'\
    "$file" | tail -n +2 | \
    sed -e 's/^\|$/"/g' \
        -e 's/,/","/g' \
        -e 's/""/NULL/g' | \
    sed -E 's/(.*)/(\1)/g' | \
    sed 's/$/,/')"

num_rows=$(($(wc -l "$file" | cut -d' ' -f1)-1))
max_batch_size=1000
for ((i=1; i<=num_rows; i=$((i+max_batch_size)))); do 
    begin=$i
    end=$((i+max_batch_size-1))
    if [ $end -gt $((num_rows)) ]; then
        end=$num_rows;
    fi
    echo -ne "Inserting rows $begin-$end/$num_rows (max. batch size: $max_batch_size)..."\\r

    # step 6. prepare batch to insert into mysql database;
    # note: cannot add all rows at once due to Bash argument size limit
    # step 7. compress rows into a line and remove trailing comma
    user_batch="$(echo "$user"            | sed -n "$begin,$end p" | tr '\n' ' ' | sed -E 's/, ?$//')"
    subreddit_batch="$(echo "$subreddit"  | sed -n "$begin,$end p" | tr '\n' ' ' | sed -E 's/, ?$//')"
    post_batch="$(echo "$post"            | sed -n "$begin,$end p" | tr '\n' ' ' | sed -E 's/, ?$//')"

    
    # insert into tables
    mysql -D "reddit" -e "INSERT INTO user VALUES $user_batch;"
    # IGNORE: to stop attempting to insert duplicate primary keys
    mysql -D "reddit" -e "INSERT IGNORE INTO subreddit VALUES $subreddit_batch;"
    mysql -D "reddit" -e "INSERT IGNORE INTO post VALUES $post_batch;"

    # check if all rows are inserted
    if [ $((end-begin)) -lt $((max_batch_size-1)) ]; then
        break;
    fi
done

echo -e "\nDone!\n"

