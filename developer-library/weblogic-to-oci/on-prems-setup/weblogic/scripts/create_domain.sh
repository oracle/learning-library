#! /bin/bash
# Copyright (c) 2014-2018 Oracle and/or its affiliates. All rights reserved.
#
#
#Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#

# Create an empty domain
wlst.sh -skipWLSModuleScanning /u01/oracle/create_domain.py
export DOMAIN_HOME=/u01/oracle/user_projects/domains/$DOMAIN_NAME

# create boot.properties file to start without password prompt
SERVER_SECURITY=${DOMAIN_HOME}/servers/${ADMIN_NAME}/security/
echo $SERVER_SECURITY
mkdir -p $SERVER_SECURITY
echo "username=${ADMIN_USERNAME}" > ${SERVER_SECURITY}/boot.properties
echo "password=${ADMIN_PASSWORD}" >> ${SERVER_SECURITY}/boot.properties
# this boot.properties file will be encrypted on 1st start of the server.

${DOMAIN_HOME}/bin/setDomainEnv.sh
