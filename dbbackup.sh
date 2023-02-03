#!/bin/bash
# -------------------------------------------------------------------------
 
 
DEST="/backup"
 
 
# Get data in dd-mm-yyyy format
NOW="$(date +"%Y%m%d%H%M%S")"
mysqldump --defaults-file=/root/.my.cnf --no-tablespaces dbZfdm | gzip -9 > $DEST/dbZfdm$NOW.sql.gz
if [ $? -eq 0 ]
then
  echo "backup Successfully done"
else
  echo "backup successfully not done"
fi
