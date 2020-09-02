#!/bin/bash
#: Author : "david.bayard@oracle.com"
#: Version : v1
#: Description : Generate load on adwc
#: Syntax :
#: adwc_load.sh <your adwc instance name>
set -x
args=("$@")
echo "`date '+%F %T'` Info: adwc_load.sh started..."
# get number of elements
ELEMENTS=${#args[@]}

if [ $ELEMENTS -eq 0 ]
then
    echo "`date '+%F %T'` Info: No command line arguments found..At least ADWC Instance name has to be passed as an argument"
        echo "`date '+%F %T'` Usage: sh adwc_load.sh <ADWC Instance Name>"
    exit 1

elif [ $ELEMENTS -eq 1 ]
then
    echo "`date '+%F %T'` Info: Required number of  command line arguments / required parameters mentioned, executing the script"
    svc=${1}
else
    echo "`date '+%F %T'` Info: More command line arguments found..Only ADWC Instance name has to be passed as an argument"
        echo "`date '+%F %T'` Usage: sh adwc_load.sh <ADWC Instance Name>"
    exit 1
fi

slp=90;
echo "`date '+%F %T'` Info:Fetching the load queue from APEX DataBase ..."
while [[ true ]]; do


#echo "`date '+%F %T'` Info:Fetching the load queue from APEX DataBase ..."


LOAD_QUEUE=$(sqlplus -s /@pdb1 <<!
 set heading off
 SELECT id, script_id, consumer_group, desired_run_time_secs from load_queue where status='SUBMITTED' and rownum<2;
!
);

#echo output $LOAD_QUEUE

LOAD_ID=$(echo $LOAD_QUEUE | cut -d ' ' -f1)

if [[ "$LOAD_ID" != "no" ]]
then


LOAD_SCRIPT=$(echo $LOAD_QUEUE | cut -d ' ' -f2)
LOAD_CONSUMER_GROUP=$(echo $LOAD_QUEUE | cut -d ' ' -f3)
LOAD_RUNTIME=$(echo $LOAD_QUEUE | cut -d ' ' -f4)

#echo Load $LOAD_ID
#echo Script $LOAD_SCRIPT
#echo Service $LOAD_CONSUMER_GROUP
### added by mtheo 12/06/2018 to hack system

LOAD_QUEUE_CHECK=$(sqlplus -s /@pdb1 <<!
 set heading off
 SELECT count(*) from load_queue where status='RUNNING' and script_id =6 and consumer_group='High';
!
);

LQC_COUNT=$(echo $LOAD_QUEUE_CHECK | cut -d ' ' -f1)

echo "LQC_COUNT =="$LQC_COUNT

if [ $LQC_COUNT -ge 1 ]
then
echo "Changing LOAD_SCRIPT to 2 for HACK OverRide"

LOAD_SCRIPT=2

fi

echo "LOAD_SCRIPT=="$LOAD_SCRIPT
### end mtheo hack



#Now update the status.
LOAD_QUEUE=$(sqlplus -s /@pdb1 <<!
 set heading off
 UPDATE load_queue set status='RUNNING' where id=$LOAD_ID;
 commit;
!
);

#Now launch the script
/home/oracle/scripts/apex_load_2.sh $LOAD_ID $LOAD_SCRIPT $LOAD_CONSUMER_GROUP $LOAD_RUNTIME &

fi
#echo "sleeping for 10 secs"; sleep 10;
done;
