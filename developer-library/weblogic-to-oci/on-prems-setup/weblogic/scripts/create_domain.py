# Copyright (c) 2014-2018 Oracle and/or its affiliates. All rights reserved.
#
#
#Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#
#
# WebLogic on Docker Default Domain
#
# Domain, as defined in DOMAIN_NAME, will be created in this script. Name defaults to 'base_domain'.
#
# Author: monica.riccelli@oracle.com
# ==============================================
domain_name  = os.environ.get("DOMAIN_NAME", "base_domain")
admin_name  = os.environ.get("ADMIN_NAME", "AdminServer")
admin_username  = os.environ.get("ADMIN_USERNAME", "weblogic")
admin_pass  = os.environ.get("ADMIN_PASSWORD", "welcome1")
admin_port   = int(os.environ.get("ADMIN_PORT", "7001"))
domain_path  = '/u01/oracle/user_projects/domains/%s' % domain_name
production_mode = os.environ.get("PRODUCTION_MODE", "prod")
machine_name  = os.environ.get("MACHINE_NAME", "machine_0")
ms_name_1  = os.environ.get("MANAGED_SERVER_NAME_1", "server_0")
ms_name_2  = os.environ.get("MANAGED_SERVER_NAME_2", "server_1")
ms_port_1 = os.environ.get("MANAGED_SERVER_PORT_1", "7003")
ms_port_2 = os.environ.get("MANAGED_SERVER_PORT_2", "7004")
cluster_name = os.environ.get("CLUSTER_NAME", "cluster")

print('domain_name     : [%s]' % domain_name);
print('admin_port      : [%s]' % admin_port);
print('domain_path     : [%s]' % domain_path);
print('production_mode : [%s]' % production_mode);
print('admin password  : [%s]' % admin_pass);
print('admin name      : [%s]' % admin_name);
print('admin username  : [%s]' % admin_username);
print('machine name    : [%s]' % machine_name);
print('ms name 1       : [%s]' % ms_name_1);
print('ms port 1       : [%s]' % ms_port_1);
print('ms name 2       : [%s]' % ms_name_2);
print('ms port 2       : [%s]' % ms_port_2);
print('cluster name    : [%s]' % cluster_name);

# Open default domain template
# ======================
readTemplate("/u01/oracle/wlserver/common/templates/wls/wls.jar")

set('Name', domain_name)
setOption('DomainName', domain_name)

# Configure the Administration Server and SSL port.
# =========================================================
cd('/Servers/AdminServer')
set('Name', admin_name)
set('ListenAddress', '0.0.0.0')
set('ListenPort', admin_port)

# Define the user password for weblogic
# =====================================
cd('/Security/%s/User/weblogic' % domain_name)
cmo.setPassword(admin_pass)

# Write the domain and close the domain template
# ==============================================
setOption('OverwriteDomain', 'true')
setOption('ServerStartMode', production_mode)

cd('/NMProperties')
set('ListenAddress', '')
set('ListenPort', 5556)
set('CrashRecoveryEnabled', 'true')
set('NativeVersionEnabled', 'true')
set('StartScriptEnabled', 'true')
set('SecureListener', 'false')
set('LogLevel', 'FINEST')

# Set the Node Manager user name and password (domain name will change after writeDomain)
cd('/SecurityConfiguration/%s' % domain_name)
set('NodeManagerUsername', admin_username)
set('NodeManagerPasswordEncrypted', admin_pass)

# create managed servers
cd('/')
ms = create(ms_name_1, 'Server')
cd('Server/%s' % ms_name_1)
set('ListenPort', int(ms_port_1))
set('ListenAddress', '0.0.0.0')

cd('/')
ms = create(ms_name_2, 'Server')
cd('Server/%s' % ms_name_2)
set('ListenPort', int(ms_port_2))
set('ListenAddress', '0.0.0.0')

# create a cluster
cd('/')
create(cluster_name, 'Cluster')
assign('Server', '*', 'Cluster', cluster_name)
cd('Cluster/%s' % cluster_name)
set('ClusterMessagingMode', 'multicast')
set('MulticastAddress', '237.0.0.101')
set('MulticastPort', 5555)
set('WeblogicPluginEnabled', 'true')

# Create a machine
cd('/')
create('%s' % machine_name, 'UnixMachine')
assign('Server', '*', 'Machine', machine_name)
assign('AdminServer', '*', 'Machine', machine_name)
cd('Machines/%s/' % machine_name)
create(machine_name, 'NodeManager')
cd('NodeManager/%s' % machine_name)
set('NMType', 'Plain')
set('ListenPort', 5556)
set('ListenAddress', '0.0.0.0')
set('DebugEnabled', 'true')

# Write Domain
# ============
writeDomain(domain_path)
closeTemplate()

# Exit WLST
# =========
exit()