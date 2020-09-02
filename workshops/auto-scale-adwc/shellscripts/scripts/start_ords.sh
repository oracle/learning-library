#!/bin/bash
NOW=$(date +"%F_%H:%M")
LOGFILE="ords-$NOW.log"
echo
echo "~~~~~~~~~~~~~~~~">> $LOGFILE
echo `date` >> $LOGFILE
echo "~~~~~~~~~~~~~~~">> $LOGFILE
nohup java -Dconfig.dir=/home/oracle/ords -jar /home/oracle/ords/ords.war install simple --preserveParamFile >> $LOGFILE  2>&1  &
echo " Check Logfile : $LOGFILE "
echo