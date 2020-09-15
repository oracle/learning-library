#!/bin/bash

#variables
vPass=$1
vASHost=localhost
vASPort=$2
vExtract=$3
vDSPort=$4
vPathName=$5
vASPort1=$6
vReplicat=$7
vSCN=$8

function _startReplicat {
     curl -X POST \
     http://$vASHost:$vASPort1/services/v2/commands/execute \
       --user "oggadmin:"$vPass   \
       -H 'Cache-Control: no-cache' \
       -d '{
               "at":'$vSCN',
               "name":"start",
               "processName":"'$vReplicat'",
               "processType":"replicat"
          }' | python -mjson.tool
}

function _startPath {
     curl -X PATCH \
       http://$vASHost:$vDSPort/services/v2/sources/$vPathName \
      --user "oggadmin:"$vPass   \
       -H 'cache-control: no-cache' \
       -d '{
          "status":"running"
     }' | python -mjson.tool
}

function _startExtract {
     curl -X POST \
     http://$vASHost:$vASPort/services/v2/commands/execute \
       --user "oggadmin:"$vPass   \
       -H 'Cache-Control: no-cache' \
       -d '{
               "name":"start",
               "processName":"'$vExtract'",
               "processType":"extract"
          }' | python -mjson.tool
}

function _main {
     _startReplicat
     sleep 15
     _startPath
     sleep 15
     _startExtract
}

_main
