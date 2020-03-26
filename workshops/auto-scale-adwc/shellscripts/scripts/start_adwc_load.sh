#!/bin/bash
echo 
echo "starting adwc_load.sh"
export ORAENV_ASK=NO
export ORACLE_SID=APEXDB
. oraenv
echo "check the log : tail -f adwcload.log.nohup " 
nohup sh /home/oracle/scripts/adwc_load.sh adwapexdemo > /home/oracle/scripts/adwcload.log.nohup 2>&1 &
echo
