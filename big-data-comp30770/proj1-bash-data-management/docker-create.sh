#!/bin/bash

docker stop comp30770-db && docker rm comp30770-db

docker run -tid \
    --name comp30770-db \
    registry.gitlab.com/roddhjav/ucd-bigdata/db

