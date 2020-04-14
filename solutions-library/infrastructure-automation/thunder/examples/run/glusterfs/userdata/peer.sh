#!/bin/bash
# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.


IFS=$'\n' read -d '' -r -a hostnames < /tmp/hosts
current_host=`hostname -I`
mounts=()
new_mounts=()
for host in "${hostnames[@]}"
do
  if [[ $host != $current_host ]];
  then
    sudo gluster peer status | grep $host
    if [[ $? -ne 0 ]];
    then
      sudo gluster peer probe $host
    fi
  fi
done
sleep 5
IFS=$'\n' read -d '' -r -a mounts < /tmp/mounts

case $1 in
    # Distributed volume
    distributed)
    command="sudo gluster volume create glustervol transport tcp ${mounts[@]} force"
    ;;

    # Replicated volume
    replicated)
    command="sudo gluster volume create glustervol replica $2 transport tcp ${mounts[@]} force"
    ;;

    # Distributed replicated volume
    distributed_replicated)
    command="sudo gluster volume create glustervol replica $2 transport tcp ${mounts[@]} force"
    ;;

    # Dispersed volume
    dispersed)
    command="sudo gluster volume create glustervol disperse $2 transport tcp ${mounts[@]} force"
    ;;

    # Distributed Dispersed Volume
    distributed_dispersed)
    command="sudo gluster volume create glustervol disperse $2 transport tcp ${mounts[@]} force"
    ;;

    *)
     echo "Usage: `basename $0` [distributed|replicated|distributed_replicated|dispersed|distributed_dispersed] [replica number]"
     exit 0
     ;;
esac

sudo gluster volume info glustervol
if [[ $? -ne 0 ]]; then
  $command
  sleep 5
  sudo gluster volume start glustervol
else
  for mount in ${mounts[@]}
  do
    sudo gluster volume info glustervol | grep $mount
    if [[ $? -ne 0 ]]; then
      new_mounts+=($mount)
      echo $new_mounts
    fi
  done
fi

if [[ ${#new_mounts[@]} -ne 0 ]]; then
  sudo gluster volume add-brick glustervol ${new_mounts[@]} force
fi