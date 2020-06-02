#!/bin/bash
${DOMAIN_HOME}/bin/setDomainEnv.sh
$DOMAIN_HOME/bin/startNodeManager.sh 2>&1 &
$DOMAIN_HOME/bin/startManagedWebLogic.sh server_0 http://0.0.0.0:7001 2>&1 &
$DOMAIN_HOME/bin/startManagedWebLogic.sh server_1 http://0.0.0.0:7001 2>&1 &
$DOMAIN_HOME/startWebLogic.sh