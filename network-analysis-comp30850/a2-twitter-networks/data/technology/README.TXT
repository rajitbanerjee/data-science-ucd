COMP30850 Assignment 2
----------------------------------

This dataset consists of three files related to a specific Twitter list:

1. list_members.jsonl
- A JSON Lines (JSONL) file, where each line in the file is a separate JSON document. 
- Each JSON document contains the Twitter user profile of a list member.

2. friendships.csv
- A tab-separated text file, indicating the friend/follower relations between pairs of list members.
- The two columns contain a pair of ordered screen names X and Y, indicating that user X follows user Y. 

3. tweets.jsonl
- A JSON Lines (JSONL) file, where each line in the file is a separate JSON document. 
- Each JSON document represents a separate tweet posted by one of the list members. The lines are in no particular order.


Notes:

- For more details on the JSONL format see:
http://jsonlines.org

- For more details on the Twitter JSON format for user profiles see:
https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/user-object

- For more details on the Twitter JSON format for tweets see:
https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/tweet-object
