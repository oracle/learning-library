# Copyright (c) 2014-2018 Oracle and/or its affiliates. All rights reserved.
#
#
#Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#
domainname=${DOMAIN_NAME}
domainhome=${MW_HOME}/user_projects/${DOMAIN_NAME}
admin_name=${ADMIN_NAME}
dsname=${DS_NAME}
dsdbname=${DB_SID}.${DB_DOMAIN}
dsjndiname=${DS_JNDI_NAME}
dsdriver=oracle.jdbc.xa.client.OracleXADataSource
dsurl=jdbc:oracle:thin:@//${DB_HOST}:1521/${DB_PDB}.${DB_DOMAIN}
dsusername=${DS_USER}
dspassword=${DS_PASSWORD}
dstestquery=SELECT * FROM DUAL
cp_initial_capacity=0
target_type=Cluster
target_name=cluster
