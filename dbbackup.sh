#!/bin/bash
# -------------------------------------------------------------------------
 
 
DEST="/backup"
 
 
# Get data in dd-mm-yyyy format
NOW="$(date +"%Y%m%d%H%M%S")"
mysqldump --defaults-file=/root/.my.cnf timemanagement | gzip -9 > $DEST/timemanagement$NOW.sql.gz
