#!/bin/bash

chk=`ps -ef | grep ords.war | grep -v grep | wc -l`
if [ "${chk}" = "0" ]; then
  echo "ORDS is not running. Exsiting."
  exit
elif [ "${chk}" = "1" ]; then
  pid=`ps -ef | grep ords.war | grep -v grep | awk '{print $2}'`
  echo "Stopping ORDS(pid=${pid}) ..."
else
  echo "Looks several ORDS processes are running. Need to check them."
  ps -ef | grep ords.war | grep -v grep
fi

kill `ps -ef | grep ords.war | grep -v grep | awk '{print $2}'`
sleep 2
chk=`ps -ef | grep ords.war | grep -v grep | wc -l`
if [ "${chk}" = "0" ]; then
  echo "Stopped successfully."
else
  echo "Need to check ORDS process"
fi
