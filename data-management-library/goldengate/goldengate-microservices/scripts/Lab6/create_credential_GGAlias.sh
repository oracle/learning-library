#!/bin/bash

#variables
vPass=$1
vASHost=localhost
vASPort=$2
vGGUser=$3
vGGPass=$4
vGGAlias=TGGATE

function _createAlias {
     curl -X POST \
       http://$vASHost:$vASPort/services/v2/credentials/OracleGoldenGate/$vGGAlias \
       --user "oggadmin:"$vPass   \
       -H 'Cache-Control: no-cache' \
       -d '{
         "userid":"'$vGGUser'",
         "password":"'$vGGPass'"
     }' | python -mjson.tool
}

function _main {
     _createAlias
}

_main

