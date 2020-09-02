#!/bin/bash
#: Title : adwc.sh
#: Date : 2018.05.29
#: Author : "Ashwini - ashwini.nagaraju@oracle.com"
#: Version : v1
#: Description : Scale up or scale down number of OCPU based on the CPU load/Usage
#: Syntax :
#: adwc.sh <your adwc instance name>
#set -x

# Commands to setup secure external password wallet
# . oraenv [APEXDB]
# cd ~/wallet_ADWAPEXDEMO
# mkstore -wrl . -list [Welcome1!]
# mkstore -wrl . -createCredential adwapexdemo_medium admin
# mkstore -wrl . -modifyCredential adwapexdemo_medium admin
# mkstore -wrl . -modifyCredential adwapexdemo_high admin
# mkstore -wrl . -modifyCredential adwapexdemo_low admin
# Then edit sqlnet.ora and add this line:
# SQLNET.WALLET_OVERRIDE = TRUE
SCALING_UP_CPU_COUNT=1
args=("$@")
echo "`date '+%F %T'` Info: adwc.sh started..."
# get number of elements
ELEMENTS=${#args[@]}

if [ $ELEMENTS -eq 0 ]
then
    echo "`date '+%F %T'` Info: No command line arguments found..Atleast ADWC Instance name has to be passed as an argument"
        echo "`date '+%F %T'` Usage: sh adwc.sh <ADWC Instance Name>"
    exit 1

elif [ $ELEMENTS -eq 1 ]
then
    echo "`date '+%F %T'` Info: Required number of  command line arguments / required parameters mentioned, executing the script"
    svc=${1}
else
    echo "`date '+%F %T'` Info: More command line arguments found..Only ADWC Instance name has to be passed as an argument"
        echo "`date '+%F %T'` Usage: sh adwc.sh <ADWC Instance Name>"
    exit 1
fi
#echo "`date '+%F %T'` Info:Removing files in /tmp/adwcScl.* directory....!!!!"
#rm -f /tmp/adwcScl.*
#cd /tmp
#adwc1="psm adwc scale-service --service-name "$svc" ";
thrldup='50'
thrlddown='20'
slp=180;
slp2=180;
end=$((SECONDS-1))
end2=$((SECONDS-1))
waitscaledown=0     #  JS: This variable will be used to slowdown the downscaling

echo "`date '+%F %T'` Info:Fetching the load from ADWC DataBase ..."

while [[ true ]]; do


#echo "`date '+%F %T'` Info:Fetching the DBPROVISIONEDOCPUS And Current OCUP count from ADWC DataBase ..."

waitscaledown=$((waitscaledown+1))

# select round(util/cpus*100+0.3) from (SELECT sum(AVG_CPU_UTILIZATION) util from v\$rsrcmgrmetric where consumer_group_name != 'OTHER_GROUPS') u, (select value cpus from v\$parameter where name='cpu_count') c;
DB_OCPU_AND_PROVISIONED_OCPU=$(sqlplus -s /@adwapexdemo_medium <<!
 set heading off
 SELECT DBPROVISIONEDOCPUS FROM DBOCPU;
 SELECT value FROM V\$PARAMETER WHERE name='cpu_count';
 select round(util/cpus*100) from (SELECT sum(AVG_CPU_UTILIZATION) util, max(cpu_utilization_limit) cpus from v\$rsrcmgrmetric where consumer_group_name != 'OTHER_GROUPS') u;
!
);

case "$DB_OCPU_AND_PROVISIONED_OCPU" in
  *ORA*)
    echo "Error: $DB_OCPU_AND_PROVISIONED_OCPU"
        continue
esac

DBPROVISIONEDOCPUS=$(echo $DB_OCPU_AND_PROVISIONED_OCPU | cut -d ' ' -f1)
ACTUAL_OCPU_COUNT=$(echo $DB_OCPU_AND_PROVISIONED_OCPU | cut -d ' ' -f2)
ald=$(echo $DB_OCPU_AND_PROVISIONED_OCPU | cut -d ' ' -f3)




if ([ $SECONDS -gt $end2 ] && [ ${ald// /} -ge 0 ])
then

  echo "`date '+%F %T'`  load is $ald and cpu count is $ACTUAL_OCPU_COUNT"
#write to pdb1
LOG_TO_DB=$(sqlplus -s /@pdb1 <<!
 set heading off
 INSERT INTO SCALE_LOG (DB_PROVISIONED_CPU, DB_CPU_USAGE)  values ($DBPROVISIONEDOCPUS , $ald);
 insert into TIME_CPU_LOG (DB_PROVISIONED_CPU,AUDIT_USER,AUDIT_INSERT,AUDIT_UPDATE,DB_CPU_USAGE) values  ($DBPROVISIONEDOCPUS,'APP_USER',sysdate,sysdate,$ACTUAL_OCPU_COUNT);
 COMMIT;
!
);
else
  echo "`date '+%F %T'`  Paused.  load is $ald and cpu count is $ACTUAL_OCPU_COUNT"
#write to pdb1 but put null for cpu usage
LOG_TO_DB=$(sqlplus -s /@pdb1 <<!
 set heading off
 INSERT INTO SCALE_LOG (DB_PROVISIONED_CPU, DB_CPU_USAGE)  values ($DBPROVISIONEDOCPUS , decode($ald,0,null,$ald));
 insert into TIME_CPU_LOG (DB_PROVISIONED_CPU,AUDIT_USER,AUDIT_INSERT,AUDIT_UPDATE,DB_CPU_USAGE) values  ($DBPROVISIONEDOCPUS,'APP_USER',sysdate,sysdate,$ACTUAL_OCPU_COUNT);
 COMMIT;
!
);

fi

if [ $SECONDS -gt $end ]
then
   if ([ ${ald// /} -ge ${thrldup// /} ] && [ ${ACTUAL_OCPU_COUNT// /} -lt ${DBPROVISIONEDOCPUS// /} ] )
   then
      waitscaledown=0  #JS: resetting to counter
       echo "`date '+%F %T'` Info:Scale Up ADWC DataBase ..."
       #echo '-a increase -u 1 '>> /home/oracle/scripts/adwcScl.out
       #echo $adwc1 $(grep crease /home/oracle/scripts/adwcScl.out) > /home/oracle/scripts/adwcScl.sh; chmod +x /home/oracle/scripts/adwcScl.sh;
       #/home/oracle/scripts/adwcScl.sh
       SCALE_UP_CPU_COUNT=$[ACTUAL_OCPU_COUNT + SCALING_UP_CPU_COUNT]
       echo $SCALE_UP_CPU_COUNT
       echo $SCALING_UP_CPU_COUNT
       LOG_TO_DB=$(sqlplus -s /@pdb1 <<!
 set heading off
 INSERT INTO SCALING_JOB_LOG (event_date, message, event_action, from_qty, to_qty, load_qty) values (sysdate, 'Scaling up from $ACTUAL_OCPU_COUNT to $SCALE_UP_CPU_COUNT based on load=$ald', 'UP', $ACTUAL_OCPU_COUNT, $SCALE_UP_CPU_COUNT, $ald);
 COMMIT;
!
);
       echo '{"cpuCoreCount" :'" $SCALE_UP_CPU_COUNT}" > /home/oracle/scripts/scaleadwc.json
       cat /home/oracle/scripts/scaleadwc.json
       source /home/oracle/scripts/restapi.sh
       oci-curl database.us-ashburn-1.oraclecloud.com  put /home/oracle/scripts/scaleadwc.json "/20160918/autonomousDataWarehouses/ocid1.autonomousdwdatabase.oc1.iad.abuwcljt3vlevx66pbz3wlwvgml3mq3ugek6hxeffsgrgd3zev7akxkacsqa"
       echo "Pausing scaling for $slp secs";
       end=$((SECONDS+slp))
       end2=$((SECONDS+slp2))

   elif ([ ${ald// /} -le ${thrlddown// /} ] && [ ${ACTUAL_OCPU_COUNT// /} -gt 2 ] && [ ${waitscaledown//  /} -ge 30 ] )
   then

       echo echo "`date '+%F %T'` Info:Scale Down ADWC DataBase ..."
       waitscaledown=0    # JS: resetting the variable, as per elf logic, downscaling will happen after 30X20sec=600secs
       SCALE_DOWN_CPU_COUNT=$[ACTUAL_OCPU_COUNT-2]
       if ([ ${SCALE_DOWN_CPU_COUNT} -lt 3 ] )
       then
         SCALE_DOWN_CPU_COUNT=2
       fi
       LOG_TO_DB=$(sqlplus -s /@pdb1 <<!
 set heading off
 INSERT INTO SCALING_JOB_LOG (event_date, message, event_action, from_qty, to_qty, load_qty) values (sysdate, 'Scaling down from $ACTUAL_OCPU_COUNT to $SCALE_DOWN_CPU_COUNT based on load=$ald', 'DOWN', $ACTUAL_OCPU_COUNT, $SCALE_DOWN_CPU_COUNT, $ald);
 DELETE FROM SCALE_LOG where audit_insert < systimestamp - 3;
 DELETE FROM TIME_CPU_LOG where audit_insert < systimestamp - 3;
 COMMIT;
!
);
       echo '{"cpuCoreCount" :'" $SCALE_DOWN_CPU_COUNT}" > /home/oracle/scripts/scaleadwc.json
       cat /home/oracle/scripts/scaleadwc.json
       source /home/oracle/scripts/restapi.sh
       oci-curl database.us-ashburn-1.oraclecloud.com  put /home/oracle/scripts/scaleadwc.json "/20160918/autonomousDataWarehouses/ocid1.autonomousdwdatabase.oc1.iad.abuwcljt3vlevx66pbz3wlwvgml3mq3ugek6hxeffsgrgd3zev7akxkacsqa"
       #echo '-a decrease -u 1' >> /home/oracle/scripts/adwcScl.out
       #echo $adwc1 $(grep crease /home/oracle/scripts/adwcScl.out) > /home/oracle/scripts/adwcScl.sh; chmod +x /home/oracle/scripts/adwcScl.sh;
       #/home/oracle/scripts/adwcScl.sh
       echo "Pausing scaling for $slp secs";
       end=$((SECONDS+slp))
       end2=$((SECONDS+slp2))
   fi
fi
#echo "sleeping for 20 secs";
sleep 20;
done;


