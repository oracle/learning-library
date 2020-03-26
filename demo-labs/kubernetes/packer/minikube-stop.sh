#!/bin/bash

sudo su -c 'minikube stop' root
sudo su -c 'minikube delete' root

sudo systemctl stop kubelet
sudo docker stop $(sudo docker ps -q --filter name=k8s); sudo docker rm -f $(sudo docker ps -aq --filter name=k8s);

sudo rm -rf /home/ubuntu/.kube
sudo rm -rf /home/ubuntu/.minikube
sudo rm -rf /etc/kubernetes
sudo rm -rf /var/lib/localkube
