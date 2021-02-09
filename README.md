# delete-mattermost-messages

delete-messages.sh deletes mattermost messages whose channel display name ends with ":{Num}s" or ":{Num}m" or ":{Num}h" or ":{Num}d" or ":{Num}y".

* s
  * second
* m
  * minute
* h
  * hour
* d
  * day
* y
  * year


## Environment variables

* MYSQL_HOST
   * default : 127.0.0.1
* MYSQL_PORT
   * default : 3306
* MYSQL_DB
   * default : mattermost_test
* MYSQL_USER
   * default : mmuser
* MYSQL_PWD
   * default : mostest

