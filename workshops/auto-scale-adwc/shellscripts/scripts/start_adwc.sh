#!/bin/bash
echo 
echo "starting adwc.sh"
export ORAENV_ASK=NO
export ORACLE_SID=APEXDB
. oraenv
echo "check the log : tail -f adwc.log.nohup " 
. /home/oracle/scripts/adwc.sh adwapexdemo > /home/oracle/scripts/adwc.log.nohup 2>&1 &
echo
