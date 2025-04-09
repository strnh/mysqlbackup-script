#!/bin/sh
#
# call by mysql_dump.sh(..awk)
#
USER=root
PW=""
MYSQLDUMPCMD=/usr/local/bin/mysqldump  ## freebsd
#MYSQLDUMPCMD=/usr/bin/mysqldump #ubuntu or other linuxen
DATE=$(date +"%Y%m%d%H%M%S") # POSIX

#
if [ $1 == "" ]; then
 echo "do nothing."
 exit 0;
fi

$MYSQLDUMPCMD -u $USER  $1  --set-gtid-purged=OFF  > dump-$DATE.sql

