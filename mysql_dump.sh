#!/bin/sh
#  limitation:  localhost only
# 
# 
BACKUPDIR=/var/spool/mysqldump
MYSQLCMD=/usr/local/bin/mysql
SHELL_DO="/bin/sh -x"
#SHELL_DO_DELETE="/bin/sh -x "
DOIT=$(pwd)/doit.sh

if [ ! -d $BACKUPDIR ]; then
    echo "initialise backup storage .."  
    echo -n $BACKUPDIR "  ok ? [Y/n]: "
    read ANS

case $ANS in
  "" | [Yy]* )

   mkdir $BACKUPDIR
  cd $BACKUPDIR/..
   echo "---- information backup dist. --"
   du -h .
   df -h .
   echo "--------------------------------" 
   ;;
   * )
     echo "canceled"
     exit 255; 
   ;;
esac
fi

#
# fetch db list 
cd $BACKUPDIR

databases=$(echo "SHOW DATABASES;" | $MYSQLCMD -u root  | sed "s/information_schema//g" | sed "s/Database//g")
echo $databases | awk -v doit=$DOIT '{ for(i=1;i<NF;i++) {print "mkdir "$i " && cd " $i " && " doit " " $i " &&  ls -1 && cd .. " } }' | $SHELL_DO
#echo $databases | awk '{ for(i=1;i<NF;i++) {print "rmdir  " $i  }}'  | $SHELL_DO_DELETE
