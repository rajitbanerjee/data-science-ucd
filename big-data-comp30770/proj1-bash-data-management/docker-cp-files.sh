#!/bin/bash

# clean CSV used for data management
docker exec comp30770-db mkdir -p /root/data/
docker cp ./data/reddit_2021_clean.csv comp30770-db:/root/data/reddit_2021_clean.csv

# MySQL and MongoDB create and populate database scripts
for script in ./*{populate,create}-db.sh; do
    docker cp "$script" comp30770-db:/root/
done
