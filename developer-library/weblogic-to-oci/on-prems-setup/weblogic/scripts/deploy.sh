
#Loop determining state of WLS
function check_wls {
    action=$1
    host=$2
    admin_port=$3
    sleeptime=$4
    while true
    do
        sleep $sleeptime
        if [ "$action" == "started" ]; then
            started_url="http://$host:$admin_port/weblogic/ready"
            echo -e "[Provisioning Script] Waiting for WebLogic server to get $action, checking $started_url"
            status=`/usr/bin/curl -s -i $started_url | grep "200 OK"`
            echo "[Provisioning Script] Status:" $status
            if [ ! -z "$status" ]; then
              break
            fi
        elif [ "$action" == "shutdown" ]; then
            shutdown_url="http://$host:$admin_port"
            echo -e "[Provisioning Script] Waiting for WebLogic server to get $action, checking $shutdown_url"
            status=`/usr/bin/curl -s -i $shutdown_url | grep "500 Can't connect"`
            if [ ! -z "$status" ]; then
              break
            fi
        fi
    done
    echo -e "[Provisioning Script] WebLogic Server has $action"
}

# Start Admin Server and tail the logs
echo 'Start Admin Server'
${DOMAIN_HOME}/startWebLogic.sh &

#Wait for Admin Server to start
echo 'Waiting for Admin Server to reach RUNNING state'
check_wls "started" localhost $ADMIN_PORT 2

#WLST online to configure DataSource
echo 'Deploying WLST Online'
cd /u01/oracle
wlst.sh -skipWLSModuleScanning -loadProperties /u01/oracle/oradatasource.properties /u01/oracle/deploy_datasource.py

APP_NAME=SimpleDB APP_PKG_FILE=SimpleDB.ear wlst.sh -skipWLSModuleScanning -loadProperties /u01/oracle/oradatasource.properties /u01/oracle/deploy_app.py
APP_NAME=SimpleHTML APP_PKG_FILE=SimpleHTML.ear wlst.sh -skipWLSModuleScanning -loadProperties /u01/oracle/oradatasource.properties /u01/oracle/deploy_app.py

# copy boot.properties after first start of admin server as values get encrypted on 1st start.
mkdir -p ${DOMAIN_HOME}/servers/${MANAGED_SERVER_NAME_1}/security/
mkdir -p ${DOMAIN_HOME}/servers/${MANAGED_SERVER_NAME_2}/security/
cp ${DOMAIN_HOME}/servers/${ADMIN_NAME}/security/boot.properties ${DOMAIN_HOME}/servers/${MANAGED_SERVER_NAME_1}/security/
cp ${DOMAIN_HOME}/servers/${ADMIN_NAME}/security/boot.properties ${DOMAIN_HOME}/servers/${MANAGED_SERVER_NAME_2}/security/
