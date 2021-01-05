# Installing LS-DYNA

## Introduction
In this lab, you will install LS-DYNA.

Estimated Lab Time: 25 minutes

## **STEP 1**: Download the Binaries

You can download the LS-DYNA binaries from the [LSTC Website](http://www.lstc.com/download/ls-dyna) or push it to your machine using scp.

Take the version that was created for mpi and compiled for RedHat Ent Srv 5.4. According to our findings, IntelMPI performs faster than Platform MPI on OCI. (ls-dyna_mpp_s_r10_1_123355_x64_centos65_ifort160_avx2_intelmpi-413 (1).tar.gz)

```
<copy>
    scp /path/own/machine/STAR-CCM_version.zip opc@1.1.1.1:/home/opc/
</copy>

```

Another possibility is to upload the installer into object storage.

1. In the main menu of the console, select Object Storage.
2. Choose the correct region on the top right
3. Select the correct compartment on the left-hand side
4. Create a bucket if you do not have one already created
5. In the bucket, select upload object and specify the path of the installer.
6. Select the 3 dots on the right-hand side of the installer object and select Create Pre-Authenticated Request
7. If you lose the URL, you cannot get it back, but you can regenerate a new Pre-Authenticated Request

Download the installer form object storage with

```
<copy>
    wget PAR_URL
</copy>
```

Untar or unzip the installer depending on your version

```
<copy>
tar -xf installer.tgz
unzip installer.tgz
</copy>
```
## **STEP 2**: Install LS-DYNA

1. Untar the binaries on a shared location. By default, an HPC cluster has a NFS-share or a Gluster-share mounted on all the compute nodes.

    ```
    <copy>
    mkdir /mnt/nfs-share/install/lsdyna
    mv ls-dyna_mpp_s_r10_1_123355_x64_centos65_ifort160_avx2_intelmpi-413.tar.gz /mnt/nfs-share/install/lsdyna/
    cd /mnt/nfs-share/install/lsdyna/
    tar -xf ls-dyna_mpp_s_r10_1_123355_x64_centos65_ifort160_avx2_intelmpi-413.tar.gz
    </copy>

    ```

## **STEP 3**: Install MPI Libraries

**Intel MPI 2018**


Run those commands on every node.

```
<copy>
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo rpm --import GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo yum-config-manager --add-repo=https://yum.repos.intel.com/mpi
sudo yum install -y intel-mpi-2018.4-057 intel-mpi-samples-2018.4-274
</copy>
```

**Platform MPI**


Install those libraries:

```
<copy>
sudo yum install -y glibc.i686 libgcc.x86_64 libgcc.i686
</copy>
```

Download the tar file from the IBM website and run:

```
<copy>
chmod 777 platform_mpi-09.01.04.03r-ce.bin
./platform_mpi-09.01.04.03r-ce.bin
</copy>
```
Then follow the instructions on the screen. If you install platform on a share drive, it will be accessible to all compute nodes.


## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.