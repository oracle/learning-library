# Run ANSYS Fluent

## Introduction
In this lab, you will Run ANSYS Fluent.

Estimated Lab Time: 10 minutes

## **STEP 1:** Running ANSYS Fluent
Running Fluent is pretty straightforward: You can either start the GUI if you have a VNC session started with

```
/mnt/gluster-share/install/fluent/v190/fluent/bin/fluent
```
To specify the host you need to run on, you need to create a machinefile. You can generate it as follow, or manually. Format is hostname:corenumber.

```
sed 's/$/:36/' /etc/opt/oci-hpc/hostfile > machinefile
```
To run on multiple nodes, place the model on the share drive (Ex:/mnt/nfs-share/work/). Example provided here is to run any of the benchmark model provided on the ANSYS website. You can add it to object storage like the installer and download it or scp it to the machine.

```
wget https://objectstorage.us-phoenix-1.oraclecloud.com/p/qwbdhqwdhqh/n/tenancy/b/bucket/o/f1_racecar_140m.tar  -O - | tar x
mkdir f1_racecar_140m
mv bench/fluent/v6/f1_racecar_140m/cas_dat/* f1_racecar_140m/
gunzip f1_racecar_140m/*
rm -rf bench/
```

Now that you have set up the model, you can run it with the following command (change the modelname and core number):

```
modelname=f1_racecar_140m
N=288
fluentbench.pl -ssh -noloadchk -casdat=$modelname -t$N -cnf=machinefile -mpi=intel
```

Intel is the prefered MPI for ANSYS Fluent on OCI.


## **STEP 2:** Benchmark Example

Performances of Fluent are often measured using the Formula 1 benchmark with 140 Millions cells. The next graph is showing how using more nodes impact the runtime, with a scaling really close to 100%. RDMA network only start to differentiate versus regular TCP runs if the Cells / Core ratio starts to go down. Here is a comparison with AWS C5n HPC machines.

![](images/fluent_bench.png " ")


## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.