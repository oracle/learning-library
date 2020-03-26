#! /bin/bash
#: Author : "david.bayard@oracle.com"
#: Version : v1
#: Description : Generate load on adwc
#: Syntax :
#: adwc_load.sh <your adwc instance name>
set -x
args=("$@")
echo "`date '+%F %T'` Info: adwc_load_2.sh started..."
# get number of elements
ELEMENTS=${#args[@]}

if [ $ELEMENTS -eq 0 ]
then
    echo "`date '+%F %T'` Info: No command line arguments found..At least ADWC Instance name has to be passed as an argument"
        echo "`date '+%F %T'` Usage: sh adwc_load_2.sh ID SCRIPT CONSUMER_GROUP RUNTIME"
    exit 1

elif [ $ELEMENTS -eq 4 ]
then
    echo "`date '+%F %T'` Info: Required number of  command line arguments / required parameters mentioned, executing the script"
    LOAD_ID=${1}
    LOAD_SCRIPT=${2}
    LOAD_CONSUMER_GROUP=${3}
    LOAD_RUNTIME=${4}
else
    echo "`date '+%F %T'` Info: More command line arguments found..Only ADWC Instance name has to be passed as an argument"
        echo "`date '+%F %T'` Usage: sh adwc_load_2.sh ID SCRIPT CONSUMER_GROUP RUNTIME"
    exit 1
fi

echo "`date '+%F %T'` Info:Launching workload for id $LOAD_ID ..."

CONCAT_OUTPUT=""
ITERATION=1
end=$((SECONDS+LOAD_RUNTIME))

while [ $SECONDS -lt $end ]; do

echo "Iteration $ITERATION"
echo "`date '+%F %T'` Info:Launching sqlplus ..."


N_OUTPUT=$(sqlplus -s /@adwapexdemo_$LOAD_CONSUMER_GROUP <<!
 set heading off
 set verify off
 set timing on
start $LOAD_SCRIPT.sql $LOAD_ID $LOAD_SCRIPT $ITERATION
!
);

#Jagjeet : Commented below 3 lines due to error in concat_output (too long) 
#          And supressing echoing every iteration to keep the logfile size minimum
#echo output $N_OUTPUT
#CONCAT_OUTPUT="$CONCAT_OUTPUT    $ITERATION: ${N_OUTPUT//[$'\t\r\n']/ }"
#echo clean $CONCAT_OUTPUT

#If ERROR, then break
case "$N_OUTPUT" in
  *ERROR*)
    echo ERROR $N_OUTPUT
        break
    ;;
esac

let ITERATION=ITERATION+1
done;

#If ERROR, then ERROR
case "$N_OUTPUT" in
  *ERROR*)
    UPDATE=$(sqlplus -s /@pdb1 <<!
 set heading off
 set echo on
 UPDATE load_queue set status='ERROR', complete_date=sysdate, script_output='$CONCAT_OUTPUT' where id=$LOAD_ID;
 commit;
!
);
    ;;
  *)
    UPDATE=$(sqlplus -s /@pdb1 <<!
 set heading off
 set echo on
 UPDATE load_queue set status='COMPLETED', complete_date=sysdate, script_output='$CONCAT_OUTPUT' where id=$LOAD_ID;
 commit;
!
);

esac


echo $UPDATE


echo "Script done"

