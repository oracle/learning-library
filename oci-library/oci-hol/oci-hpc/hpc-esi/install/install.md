# Installation

## Introduction

In this lab, we will walk you through the steps required to install ESI Pam-Crash.

Estimated Lab Time: 25 minutes

### Objectives

In this lab:
* We will walk you through the different steps on how to install the ESI Pam-Crash Software (including it's specific libraries and binaries) on OCI. 

### Prerequisites

* Download the ESI Pam-Crash installer from their website or other place
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful
* Familiarity with networking is helpful

## Steps to Install Rocky DEM

This guide will show the different steps for the Oracle Linux 7.6 image available on Oracle Cloud Infrastructure. 

**Connecting all compute nodes**

Each compute node needs to be able to talk to all the compute nodes. SSH communication works but most applications have issues if all the hosts are not in the known host file. To disable the know host check for nodes with address in the VCN, you can deactivate with the following commands. You may need to modify it slightly if your have different addresses in your subnets.

```
<copy>
for i in 0 1 2 3
do
    echo Host 10.0.$i.* | sudo tee -a ~/.ssh/config
    echo "    StrictHostKeyChecking no" | sudo tee -a ~/.ssh/config
done
</copy>
```

**Create a machinefile**

If you used terraform to create the cluster, this step has been done already. VPS on the headnode does not automatically know which compute nodes are available. You can create a machinefile at /mnt/share/machinefile.txt with the private IP address of all the nodes along with the number of CPUs available.

```
<copy>
10.0.0.2 36
10.0.3.2 36
10.0.3.3 36
privateIP cores_available
...
</copy>
```

**Disable Hyperthreading**

If you used terraform to create the cluster, this step has been done already. Siemens recommmend to turn off hyperthreading on your compute nodes to get better performances. This means that you have only one thread per CPU. By default, on HPC shapes, you have 36 CPU with 2 threads. You can turn it off like this:

```
<copy>
for i in {36..71}; do
   echo "Disabling logical HT core $i."
   echo 0 | sudo tee /sys/devices/system/cpu/cpu${i}/online;
done
</copy>
```

**Disable Firewall**

Oracle will handle security through the security list and having the machine firewall is causing issues with the mpi. Open the correct port or disable the firewall completely on all compute nodes.

```
<copy>
sudo systemctl stop firewalld 
</copy>
```

**Installing Virtual Performance Solution**

You can download the binaries or push it to your machine using scp. ```scp /path/own/machine/VPC_version.tar-bz2 "opc@1.1.1.1:/home/opc/"```
    
Untar the package

```
<copy>
mkdir /mnt/share/install
cd /mnt/share/install
mv ~/package.tar.bz2 .
tar -xf package.tar.bz2
. `pwd`/setpamhome.bash `pwd`
echo ". `pwd`/setpamhome.bash `pwd`\" >> ~/.bashrc
</copy>
```

If you would like to include the installation in the Resource Manager or terraform script. Include the URL in the variables.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.