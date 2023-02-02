#!/bin/bash
# -------------------------------------------------------------------------
 
MyUSER="SET-MYSQL-USER-NAME"     # USERNAME
MyPASS="SET-PASSWORD"       # PASSWORD 
MyHOST="localhost"          # Hostname
 
DEST="/backup"
 
 
# Get data in dd-mm-yyyy format
NOW="$(date +"%Y%m%d%H%M%S")"
mysqldump timemanagement | gzip -9 > $DEST/timemanagement$NOW.sql.gz
