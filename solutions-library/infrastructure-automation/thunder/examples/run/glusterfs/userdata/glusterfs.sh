#!/bin/bash
# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.


#-------------Configuration Section------------#
sudo grep -Ri assumeyes=1 /etc/yum.conf
if [[ $? -ne 0 ]]; then
  sudo su <<HERE
    echo "assumeyes=1" >> /etc/yum.conf
HERE
fi

sudo test -f /etc/yum.repos.d/Gluster.repo
if [[ $? -ne 0 ]]; then
  sudo cat >> /etc/yum.repos.d/Gluster.repo <<HERE
[gluster7]
name=Gluster7
baseurl=http://mirror.centos.org/centos/7/storage/x86_64/gluster-7/
gpgcheck=0
enabled=1
HERE
fi
#sudo yum-config-manager --add-repo http://yum.oracle.com/repo/OracleLinux/OL7/developer_gluster312/x86_64 >&/dev/null
sleep 15

sudo yum install glusterfs-server –y
sleep 10

sudo yum install glusterfs-geo-replication -y 
sleep 10

sudo yum install samba -y
sleep 10

sudo systemctl status glusterd.service | grep running
if [[ $? -ne 0 ]]; then
  sudo systemctl enable glusterd.service
  sudo systemctl start glusterd.service
fi

sudo firewall-cmd --zone=public --list-all | grep 24007-24009/tcp
if [[ $? -ne 0 ]]; then
  sudo su <<HERE
  firewall-cmd --zone=public --add-port=24007-24009/tcp --add-port=49152-49251/tcp --permanent
  firewall-cmd --reload
HERE
fi
