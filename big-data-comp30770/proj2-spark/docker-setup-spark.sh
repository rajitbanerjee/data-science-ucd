#!/bin/bash

# remove preexisting containers
docker stop spark-master spark-worker-1
docker rm spark-master spark-worker-1

# Spark master
docker run --name spark-master \
    -h spark-master \
    -e ENABLE_INIT_DAEMON=false \
    -e PATH="/spark/bin:$PATH" \
    -d bde2020/spark-master:3.0.0-hadoop3.2-java11

# Spark worker
docker run --name spark-worker-1 \
    --link spark-master:spark-master \
    -e ENABLE_INIT_DAEMON=false \
    -d bde2020/spark-worker:3.0.0-hadoop3.2-java11

