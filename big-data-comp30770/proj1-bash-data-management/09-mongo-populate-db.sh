#!/bin/bash

echo -e "Populating database (reddit) in MongoDB:"

file="./data/reddit_2021_clean.csv"
mongo_log="./log/mongo-populate-db"

# create log dir. to store mongo write results
mkdir -p ./log/

# drop pre-existing collection 
mongo reddit --eval "db.allposts.drop()" --quiet > "$mongo_log"

# read column headings into array
IFS=',' read -ra headings <<< "$(head -n 1 $file),"

# prepare columns to take key: value format for awk
num_cols=$(head -1 "$file" | sed 's/[^,]//g' | wc -c)
columns="print "
for ((i=0; i<num_cols; i++)); do
    columns="$columns \"${headings[i]}:\" \$$((i+1)),"
done
columns="${columns%?}"


# count number of rows
num_rows=$(($(wc -l "$file" | cut -d' ' -f1)-1))

# NOTE: uncomment line below to use a subset (10,000 rows) instead of the full CSV
# num_rows=10000

# format row like JSON object {"key": "value", ...}
# step 1. remove all colons from the rows (interferes with JSON formatting), except in url
# step 2. awk to reformat row as column name: row value
# step 3. sed to remove all error-causing \r characters
# step 4. sed to double-quote every line, then quote every comma and colon
# step 5. sed to unquote any colons in URL
# step 6. sed to fix missing quotes when field value is empty
# step 7. enclose each row in braces {} 
rows="$(sed -e 's/://g' -e 's/https/https:/g' <<< "$(tail -n +2 "$file" | head -n $num_rows)")"
allposts="$(awk -F, \
    '{OFS=","; '"$columns"'}' <<< "$rows" | \
    sed 's/\r//g' | \
    sed 's/^\|$/"/g' | sed 's/,/","/g' | \
    sed -E 's/([^ ])([:])([^ ])/\1"\2"\3/g' | \
    sed 's#":"//#://#g' | \
    sed 's/":",/":"",/g' | \
    sed -e 's/^/{/g' -e 's/$/},/g')"


# insert rows in batches
max_batch_size=100
for ((i=1; i<=num_rows; i=$((i+max_batch_size)))); do 
    begin=$i
    end=$((i+max_batch_size-1))

    if [ $end -gt $((num_rows)) ]; then
        end=$num_rows;
    fi
    echo -ne "Inserting rows $begin-$end/$num_rows (max. batch size: $max_batch_size)..."\\r

    # step 8. prepare batch to insert into mongodb collection;
    # note: cannot add all rows at once due to Bash argument size limit
    # step 9. compress rows into a line and remove trailing comma
    batch="$(echo "$allposts" | sed -n "$begin,$end p" | tr '\n' ' ' | sed -E 's/, ?$//')"

    
    # insert into collection
    mongo reddit --eval "db.allposts.insert([$batch])" --quiet >> "$mongo_log"


    # check if all rows are inserted
    if [ $((end-begin)) -lt $((max_batch_size-1)) ]; then
        break;
    fi
done

echo -e "\nBulkWriteResult log written to $mongo_log\nDone!\n"

