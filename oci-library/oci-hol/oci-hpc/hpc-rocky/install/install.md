# Installation

## Introduction

In this lab, we will walk you through the steps required to install Rocky DEM.

Estimated Lab Time: 25 minutes

### Objectives

In this lab:
* We will walk you through the different steps on how to install the Rocky DEM Software (including it's specific libraries and binaries) on OCI. 

### Prerequisites

* Download the Rocky DEM installer from the ESSS website or other place
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful
* Familiarity with networking is helpful

## Steps to Install Rocky DEM

This guide will show the different steps for the Oracle Linux 7.6 and CentOS 7 images available on Oracle Cloud Infrastructure. There is no need to configure NVIDIA GPUs if you have selected an Oracle LINUX version for GPU.

**Configuring NVIDIA GPUs**

If you are running Rocky on CPUs this part is not needed, you can skip directly to the part "Installing Rocky DEM". By default, the nouveau open-source drivers are active. In order to install the Nvidia drivers, they need to be stopped. You can run the following script and reboot your machine.

```
<copy>
sudo yum -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
sudo sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="modprobe.blacklist=nouveau /g' /etc/default/grub
sudo grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg
sudo reboot
</copy>
```

Once your machine has rebooted, you can run the command ```lsmod | grep nouveau``` and you should not see any results.

```
<copy>
sudo yum -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r) gcc make redhat-lsb-core
wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.105_418.39_linux.run
sudo chmod +x cuda_10.1.105_418.39_linux.run
sudo ./cuda_10.1.105_418.39_linux.run --silent
</copy>
```

**Installing Rocky DEM**

There are a couple of library that need to be added to the CentOS image. sudo yum -y install mesa-libGLU-devel mesa-libGL-devel

You can download the Rocky installer using wget from the ESSS website or other place. In our architecture, we have mounted a file system in the /mnt directory.
    
```
<copy>
rockyHomeDir=/mnt/disk1
sudo mkdir $rockyHomeDir/Rocky
sudo chmod 777 $rockyHomeDir/Rocky
sudo tar -jxvf rocky4-bin-4.2.0-linux64.tbz2 -C $rockyHomeDir/Rocky/
</copy>
```

If you change the variable for the rocky installer package in the terraform or resource manager, the package will be extracted on the selected drive. NVMe, block or FSS.

**Licensing**

If you have enabled the VNC, you can start Rocky ($rockyHomeDir/Rocky/rocky4/Rocky) and it will ask how to point to your license server.

If you did not set it up, you can run the following commands and substitute the ip address and port of your choosing.

```
<copy>
mkdir ~/.Rocky/
echo SERVER 192.168.0.1 ANY 1515 > ~/.Rocky/license.lic
echo USE_SERVER >> ~/.Rocky/license.lic
echo license_id: FlexLM > ~/.Rocky/license_definition.txt
echo license_path: /home/opc/.Rocky/license.lic >> ~/.Rocky/license_definition.txt
echo version: 1 >> ~/.Rocky/license_definition.txt
</copy>
```

There is a variable in the terraform stack that you can edit with the license path and port and it will do that step for you.
## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.