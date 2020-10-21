#!/bin/bash

### 1. Install and setup Java
yum install -y java
 
# Set profile for java
echo "export JAVA_HOME=$(readlink -e $(which java)|sed 's:/bin/java::')" >  /etc/profile.d/java.sh
echo "PATH=\$PATH:\$JAVA_HOME/bin"                                       >> /etc/profile.d/java.sh
source /etc/profile.d/java.sh

### 2. Install some packages
yum install -y expect nkf screen

### 3. Install and setup Oracle Client
cd /etc/yum.repos.d
mv public-yum-ol7.repo public-yum-ol7.repo.bak  
export REGION=`curl http://169.254.169.254/opc/v1/instance/ -s | jq -r '.region'| cut -d '-' -f 2`  
wget http://yum-$REGION.oracle.com/yum-$REGION-ol7.repo
yum-config-manager --enable ol7_oci_included
yum install -y oracle-instantclient18.3-basic
yum install -y oracle-instantclient18.3-sqlplus

