#!/bin/bash

if [ ! -d /home/oracle/log ]; then
  mkdir /home/oracle/log
fi
LOGFILE=/home/oracle/log/ords_`date +%Y%m%d_%H%M%S`.log

APEX_DIR=/home/oracle/apex
if [ -d ${APEX_DIR} ]; then
  java_option="-Dorg.eclipse.jetty.server.Request.maxFormContentSize=3000000"
  apex_option="--apex-images ${APEX_DIR}/images" 
fi

max_wait_in_sec=60
count=0
ret=0

chk=`ps -ef | grep ords.war | grep -v grep | wc -l`
if [ "${chk}" = "0" ]; then
  echo "Starting ORDS ..."
else
  echo "Looks ORDS has been running already. Exsiting."
  exit
fi

cd /home/oracle
nohup java ${java_option} -jar ords.war standalone ${apex_option} >> $LOGFILE 2>&1 &

while [ ${count} -lt ${max_wait_in_sec} ]
do
  ret=`grep "INFO:oejs.Server:main: Started" ${LOGFILE}|wc -l`
  if [ ${ret} -ne 0 ]; then
    pid=`ps -ef | grep ords.war | grep -v grep | awk '{print $2}'`
    echo "ORDS(pid=${pid}) has been started successfully!"
    break
  fi
  sleep 2
  count=`expr ${count} + 2`
done

if [ ${ret} -eq 0 ]; then
  echo "ORDS has not been started..."
else
  :
fi
