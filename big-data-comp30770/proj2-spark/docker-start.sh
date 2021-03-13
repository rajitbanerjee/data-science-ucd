#!/bin/bash

echo -e "\nDownloading data files...\n"
rm -rf ./data/ && mkdir -p ./data/
wget https://csserver.ucd.ie/~thomas/github-big-data.csv -P ./data/     # Task 1
wget https://csserver.ucd.ie/~thomas/dblp_coauthorship.csv -P ./data/   # Task 2
docker cp ./data/ spark-master:/root/

echo -e "\nCopying scripts to container..."
docker cp ./01-github.scala spark-master:/root/
docker cp ./02-dblp.scala spark-master:/root/

echo -e "Done!\n\nStarting prompt...\n"
docker exec -w /root/ -it spark-master bash
