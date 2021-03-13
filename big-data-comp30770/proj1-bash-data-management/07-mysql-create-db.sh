#!/bin/bash

echo -e "Creating a database in MySQL for cleaned Reddit data:\n"

# create database 'reddit'
echo "DATABASE: reddit"
mysql -e "DROP DATABASE IF EXISTS reddit; CREATE DATABASE reddit"

# create table 'user'
echo "TABLE: user"
mysql -D "reddit" -e """
CREATE TABLE user (
author_id       VARCHAR(12) PRIMARY KEY,
author          VARCHAR(24) NOT NULL,
author_cakeday  VARCHAR(14)
);

DESCRIBE user;
"""

# create table 'subreddit'
echo -e "\nTABLE: subreddit"
mysql -D "reddit" -e """
CREATE TABLE subreddit (
subreddit       VARCHAR(24) PRIMARY KEY
);

DESCRIBE subreddit;
"""

# create table 'post'
echo -e "\nTABLE: post"
mysql -D "reddit" -e """
CREATE TABLE post (
id              VARCHAR(8)      PRIMARY KEY,
author_id       VARCHAR(12)     NOT NULL,
subreddit       VARCHAR(24)     NOT NULL,
created_month   VARCHAR(9)      NOT NULL,
title           VARCHAR(509),

FOREIGN KEY (author_id) REFERENCES user(author_id),
FOREIGN KEY (subreddit) REFERENCES subreddit(subreddit)
);

DESCRIBE post;
"""
