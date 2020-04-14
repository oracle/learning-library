#!/bin/bash
# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

#-------------Configuration Section------------#

FS_TYPE=xfs # Options are ext4, xfs
FILE_LABEL=scratch
cd /tmp
#----------------------------------------------


#-------------Format and Mount the disk----------
part=/dev/sdb
bigpart=/dev/sdaa
increment=({c..z})
incrementbig=({b..g})

ls /data &>/dev/null
if [[ $? -ne 0 ]]; then
  mkdir /data
fi

for ((i=1; i<=$1; i++)); do
  MOUNT_POINT=/data/brick$i
  ls $MOUNT_POINT &>/dev/null
  if [[ $? -ne 0 ]]; then
    sudo mkdir -p $MOUNT_POINT
  fi

	if [[ $i -lt 26 ]]; then

    sudo grep -Ri ${MOUNT_POINT} /etc/fstab
    if [[ $? -ne 0 ]]; then
      sudo parted $part --script -- mklabel gpt
      sudo parted $part --script -- mkpart primary 0% 100%
      sudo mkfs.$FS_TYPE ${part}1 -f -L $FILE_LABEL$i| tee -a /tmp/cloudinit.log
      echo "File System created. Adding entries to fstab" | tee -a /tmp/cloudinit.log

      sudo su <<HERE
          echo "LABEL=$FILE_LABEL$i         $MOUNT_POINT    $FS_TYPE        defaults,_netdev,nofail       0       0" >> /etc/fstab
          sudo mount -a | tee -a /tmp/cloudinit.log
HERE
    fi
    sudo chmod 777 $MOUNT_POINT
    echo "Completed at" `date` | tee -a /tmp/cloudinit.log
		part=${part%?}${increment[i-1]}
	fi

	if [[ $i -ge 26 && $i -lt 34 ]]; then

    grep -Ri ${MOUNT_POINT} /etc/fstab
    if [[ $? -ne 0 ]]; then
      sudo parted $bigpart --script -- mklabel gpt
      sudo parted $bigpart --script -- mkpart primary 0% 100%
      sudo mkfs.$FS_TYPE ${bigpart}1 -f -L $FILE_LABEL$i| tee -a /tmp/cloudinit.log
      echo "File System created. Adding entries to fstab" | tee -a /tmp/cloudinit.log

      sudo su <<HERE
          echo "LABEL=$FILE_LABEL$i         $MOUNT_POINT    $FS_TYPE        defaults,_netdev,nofail       0       0" >> /etc/fstab
          sudo mount -a | tee -a /tmp/cloudinit.log
        fi
HERE
    fi
    sudo chmod 777 $MOUNT_POINT
    echo "Completed at" `date` | tee -a /tmp/cloudinit.log
		bigpart=${bigpart%?}${incrementbig[i-26]}
	fi
done
