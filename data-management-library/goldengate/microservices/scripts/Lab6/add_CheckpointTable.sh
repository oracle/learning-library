#!/bin/bash

#variables
vPass=$1
vASHost=localhost
vASPort=$2
vGGAlias=OracleGoldenGate.TGGATE

function _createCkptTbl {
     curl -X POST \
     http://$vASHost:$vASPort/services/v2/connections/$vGGAlias/tables/checkpoint \
       --user "oggadmin:"$vPass   \
       -H 'Cache-Control: no-cache' \
       -d '{
               "operation":"add",
               "name":"ggate.checkpoints"
     }' | python -mjson.tool
}

function _main {
     _createCkptTbl
}

_main
