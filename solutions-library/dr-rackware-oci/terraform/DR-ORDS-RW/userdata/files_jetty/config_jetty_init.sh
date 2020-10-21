#!/bin/bash

# This script requires 1 argument 
# Arg1 : port for access to ords

### Port for ords on Compute Instance
ComPort=$1

### Debug
#echo $ComPort

### Install and setup Jetty
# Add User oracle by installing pre-install package 
yum install -y oracle-database-preinstall-18c
mkdir /home/oracle/.ssh
cp -f /home/opc/.ssh/authorized_keys /home/oracle/.ssh/
chown -R oracle:oinstall /home/oracle/.ssh

# Environment Variable Setting
cat <<EOF >> /home/oracle/.bash_profile
export LD_LIBRARY_PATH=/usr/lib/oracle/18.3/client64/lib:\$LD_LIBRARY_PATH
export PATH=/usr/lib/oracle/18.3/client64/bin:\$PATH
EOF

# Copy files to tomcat home directory
mv files_jetty.zip /home/oracle/
chown oracle:oinstall /home/oracle/files_jetty.zip

# Open port
firewall-cmd --zone=public --add-port=${ComPort}/tcp --permanent
firewall-cmd --reload
