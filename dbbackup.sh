#!/bin/bash
 
DEST="/backup"
dbs=`cat /root/.my.cnf| grep dbname | cut -d "=" -f 2` 
devsrv=`cat /root/.my.cnf| grep srvname | cut -d "=" -f 2` 
sml=`cat /root/.my.cnf| grep emailid | cut -d "=" -f 2`
snm=`cat /root/.my.cnf| grep srvname | cut -d "=" -f 2`
susr=`cat /root/.my.cnf| grep usrname | cut -d "=" -f 2`

#Check backup directory exist or not, if not then create it
if [ ! -d /backup ];
   then 
         mkdir -p /backup
fi 

#Check if db config file exist or not, exit if not
if [ ! -f /root/.my.cnf ]
   then 
        echo "DB config file not found"
        exit 1
fi

# Get data in dd-mm-yyyy format
NOW="$(date +"%Y%m%d%H%M%S")"
mysqldump --defaults-file=/root/.my.cnf --no-tablespaces $dbs > $DEST/$dbs$NOW.sql
if [ $? -eq 0 ]
then
  echo "backup Successfully done"
  gzip $DEST/$dbs$NOW.sql
  if [ $? -eq 0 ]
   then
      echo "backup Successfully done archived"
      rsync -rvz -e 'ssh -p 48456' $DEST/$dbs$NOW.sql $susr@$devsrv:/opt/dbbackup/$snm/
   else
     echo "backup successfully not archived"
     echo "Prod Server DB Backup failed to archive" | mail -s "Prod Server DB Backup failed to archive" $sml
   fi
  
else
  echo "backup successfully not done"
  echo "Prod Server DB Backup failed" | mail -s "Prod Server DB Backup failed to archive" $sml
fi




