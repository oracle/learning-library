#!/bin/bash
 #Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.


if [ "$#" -ne 3 ]; then
    echo "======="
    echo  "Usage:    automated_test.sh MASTERIP 0/1 SLAVEIP"
    echo "0  - without geo-redundancy"
    echo "1  - with geo-redundancy"
    echo -e "SLAVEIP will be setup to 0 if the setup is without geo-red. Otherwise please input SLAVEIP address\n"
    echo "======="
    echo -e "Example without geo-redundancy :  automated_test.sh 192.168.0.1 0 0"
    echo -e "Example WITH geo-redundancy :     automated_test.sh 192.168.0.1 1 192.168.10.1\n"
    exit 1
fi

CLUSTERIP=$1
GEORED=$2
SLAVE=$3

TYPE=`ssh $CLUSTERIP "/usr/bin/sudo /usr/sbin/gluster volume info glustervol |grep Type: |awk '{print \\$2}'"`
echo "Cluster type is: $TYPE"
sleep 1

run_tests(){
    sudo mkdir /u100
	echo "Mounting gluster volume in /u100 .......";
        /usr/bin/sudo /usr/bin/mount -t nfs4 $CLUSTERIP:/glustervol /u100;echo "Mount finished";sleep 2;
        echo "Creating files......"
        for i in {1..10} ;do sudo /usr/bin/dd if=/dev/zero of=/u100/test.$i bs=$i count=0 seek=100M ; done
        echo "Number of bricks:"
        BRICKS=`ssh $CLUSTERIP "sudo gluster volume info glustervol |grep \"Number of Bricks:\" |awk '{print $1}'"`
        echo $BRICKS
	`ssh $CLUSTERIP "/usr/bin/sudo /usr/sbin/gluster volume info glustervol" > /tmp/gluster.status`
	`sudo cat /tmp/gluster.status |for server in $(seq 1 $BRICKS); do grep Brick$server /tmp/gluster.status |awk -F":" '{print \$2,\$3}';done |sudo sed -e 's/^ //' > /tmp/servers_bricks.txt`
	if [ $GEORED -eq 1 ];then
	    `ssh $CLUSTERIP "/usr/bin/sudo /usr/sbin/gluster volume geo-replication glustervol $SLAVE::glustervol status|grep glustervol|awk '{print \\$6,\\$3}'" >> /tmp/servers_bricks.txt`
	fi
	cat /tmp/servers_bricks.txt |while read line; do echo "";echo $line
	ip=`awk '{print $1}'<<<"$line"`;dir=`awk '{print $2}'<<<"$line"`
	echo "hostname;ls -lah $dir"|ssh -T $ip;done
	echo "Unmounting file-system ...."
	/usr/bin/sudo /usr/bin/umount /u100;
	echo "Done"
    sudo rm -rf /u100
}

case $TYPE in
    "Distribute")
        echo "Distribute"
        run_tests 4
            ;;

    "Replicate")
        echo "Replicate"
        run_tests 8
            ;;
    "Disperse")
        echo "Distributed-Disperse"
        run_tests 10
            ;;
    *)
        echo "missing parameters"
            exit 1
esac
