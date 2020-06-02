# Copyright (c) 2018 Oracle and/or its affiliates. All rights reserved.
#
# WLST Offline for deploying an application under APP_NAME packaged in APP_PKG_FILE located in APP_PKG_LOCATION
# It will read the domain under DOMAIN_HOME by default
#
# author: Monica Riccelli <monica.riccelli@oracle.com>
#
import os

# Deployment Information
admin_name = os.environ.get('ADMIN_NAME', 'AdminServer')
appname    = os.environ.get('APP_NAME', 'SimpleDB')
apppkg     = os.environ.get('APP_PKG_FILE', 'SimpleDB.ear')
appdir     = os.environ.get('APP_PKG_LOCATION', '/u01/oracle')
domainhome = os.environ.get('DOMAIN_HOME', '/u01/oracle/user_projects/domains/' + domainname)
adminport  = os.environ.get('ADMIN_PORT', '7001')
username   = os.environ.get('ADMIN_USER', 'weblogic')
password   = os.environ.get('ADMIN_PASSWORD', 'welcome1')
admin_url  = 't3://localhost:7001'

# # Read Domain in Offline Mode
# # ===========================
# readDomain(domainhome)

# Connect to the AdminServer.
connect(username, password, admin_url)

edit()
startEdit()

deploy(appname, appdir + '/' + apppkg, 'cluster', 'stage')

activate()

# Update Domain, Close It, Exit
# ==========================

disconnect()
exit()
