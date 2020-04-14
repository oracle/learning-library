#!/bin/bash
# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

sudo systemctl stop nfs-server
sudo systemctl disable nfs-server

sudo yum install nfs-ganesha-gluster -y
sudo mv /etc/ganesha/ganesha.conf /etc/ganesha/ganesha.conf.org
sudo firewall-cmd --add-service=nfs --permanent
sudo firewall-cmd --reload

sudo cat >> /etc/ganesha/ganesha.conf <<EOL
NFS_CORE_PARAM {
    # possible to mount with NFSv3 to NFSv4 Pseudo path
    mount_path_pseudo = true;
    # NFS protocol
    Protocols = 3,4;
}
EXPORT_DEFAULTS {
    # default access mode
    Access_Type = RW;
}
EXPORT {
    # uniq ID
    Export_Id = 101;
    # mount path of Gluster Volume
    Path = "/glustervol";
    FSAL {
    	# any name
        name = GLUSTER;
        # hostname or IP address of this Node
        hostname="$1";
        # Gluster volume name
        volume="glustervol";
    }
    # config for root Squash
    Squash="No_root_squash";
    # NFSv4 Pseudo path
    Pseudo="/glustervol";
    # allowed security options
    SecType = "sys";
}
LOG {
    # default log level
    Default_Log_Level = WARN;
}

EOL

sudo chown root:root /var/log/ganesha
sleep 30
sudo systemctl start nfs-ganesha 
sudo systemctl enable nfs-ganesha
