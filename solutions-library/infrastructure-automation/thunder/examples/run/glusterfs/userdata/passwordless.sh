#!/bin/bash
# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.


master(){
    slave_private_ip=$1
    master_vol="glustervol"
    slave_vol=$master_vol

    # wait until gluster is available
    vol_info=$(gluster volume info | grep -i $master_vol && gluster volume info | grep "Started" && systemctl status nfs-ganesha | grep -i running)
    #vol_info=$(cat /etc/passwd) # for test only
    ret_code=$?
    while [ $ret_code -ne 0 ]
    do
        sleep 20
        vol_info=$(gluster volume info | grep -i $master_vol && gluster volume info | grep "Started" && systemctl status nfs-ganesha | grep -i running)
        #vol_info=$(cat /etc/passwd) # for test only
        ret_code=$?
    done

    ssh-keygen -t rsa -b 2048 -f /root/.ssh/id_rsa -q -N ""
    ssh-keyscan $slave_private_ip >> /root/.ssh/known_hosts
    cp /root/.ssh/id_rsa.pub /tmp/id_rsa.pub
    chown opc: /tmp/id_rsa.pub
    # ssh $slave_private_ip

    # rm -rf /root/.ssh/id_rsa*
    # rm -rf /tmp/id_rsa.pub
}

slave(){
    master_vol="glustervol"
    slave_vol=$master_vol
    master_public_key=$(cat /tmp/id_rsa.pub)

    # wait until gluster is available
    vol_info=$(gluster volume info | grep -i $slave_vol && gluster volume info | grep "Started" && systemctl status nfs-ganesha | grep -i running)
    #vol_info=$(cat /etc/passwd) # for test only
    ret_code=$?
    while [ $ret_code -ne 0 ]
    do
        sleep 20
        vol_info=$(gluster volume info | grep -i $slave_vol && gluster volume info | grep "Started" && systemctl status nfs-ganesha | grep -i running)
        #vol_info=$(cat /etc/passwd) # for test only
        ret_code=$?
    done

    echo $master_public_key  >> /root/.ssh/authorized_keys
    rm -rf /tmp/id_rsa.pub

    ## sed -i '$ d' /root/.ssh/authorized_keys
}

georeplication(){
    slave_private_ip=$1
    master_vol="glustervol"
    slave_vol=$master_vol
    
    sudo su <<HERE
        gluster volume set all cluster.enable-shared-storage enable
        gluster system:: execute gsec_create
        gluster volume geo-replication $master_vol $slave_private_ip::$slave_vol create push-pem
        gluster volume geo-replication $master_vol $slave_private_ip::$slave_vol config use_meta_volume true
        gluster volume geo-replication $master_vol $slave_private_ip::$slave_vol start
HERE
}

node_type=$1

case "$node_type" in
    master)
        echo "Configuring master node $(hostname)"
        slave_private_ip=$2
        master "$slave_private_ip"
        ;;
    slave)
        echo "Configuring slave node $(hostname)"
        slave
        ;;
    georeplication)
        echo "Configuring georeplication on master node $(hostname)"
        slave_private_ip=$2
        georeplication "$slave_private_ip"
        ;;
    *)
        echo "Node type does not exist"
        exit 1
        ;;
esac
