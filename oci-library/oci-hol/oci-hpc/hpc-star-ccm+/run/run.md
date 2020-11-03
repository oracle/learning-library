# Running STAR-CCM+

## Introduction
In this lab, you will Run STAR-CCM+.

Estimated Lab Time: 10 minutes

## **STEP 1**: Running STAR-CCM+
1. Running Star-CCM+ is pretty straightforward: You can either start the GUI if you have a VNC session started with

    ```
        /mnt/share/install/version/STAR-CCM+version/star/bin/starccm+
    ```
2. To specify the host you need to run on, you need to create a machinefile. You can generate it as follow, or manually. Format is hostname:corenumber.

    ```
        sed 's/$/:36/' /etc/opt/oci-hpc/hostfile > machinefile
    ```
3. To run on multiple nodes, place the model.sim on the nfs-share drive (Ex:/mnt/nfs-share/work/) and replace the CORENUMBER and PODKEY.

    ```
        /mnt/nfs-share/install/15.02.009/STAR-CCM+15.02.009/star/bin/starccm+ -batch -power\\ 
        -licpath 1999@flex.cd-adapco.com -podkey PODKEY -np CORENUMBER 
        -machinefile machinefile /mnt/nfs-share/work/model.sim
    ```
## **STEP 2**: MPI implementations and RDMA

Performances can really differ depending on the MPI that you are using. 3 are supported by Star-CCM+ out of the box.

* IBM Platform MPI: Default or flag platform
* Open MPI: Flag intel
* Intel MPI: Flag openmpi3 To specify options, you can use the flag -mppflags When using OCI RDMA on a Cluster Network, you will need to specify these options:

1. **OpenMPI**

    For RDMA:

    ```
        -mca btl self -x UCX_TLS=rc,self,sm -x HCOLL_ENABLE_MCAST_ALL=0 -mca coll_hcoll_enable 0 -x UCX_IB_TRAFFIC_CLASS=105 -x UCX_IB_GID_INDEX=3 

    ```
    Additionally, instead of disabling hyper-threading, you can also force the MPI to pin it on the first 36 cores:

    ```
        --cpu-set 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35
    ```
2. **IntelMPI**

    For RDMA:

    ```
    -mppflags "-iface enp94s0f0 -genv I_MPI_FABRICS=shm:dapl -genv DAT_OVERRIDE=/etc/dat.conf -genv I_MPI_DAT_LIBRARY=/usr/lib64/libdat2.so -genv I_MPI_DAPL_PROVIDER=ofa-v2-cma-roe-enp94s0f0 -genv I_MPI_FALLBACK=0"
    Additionaly, instead of disabling hyper-threading, you can also force the MPI to pin it on the first 36 cores:
    -genv I_MPI_PIN_PROCESSOR_LIST=0-33 -genv I_MPI_PROCESSOR_EXCLUDE_LIST=36-71
    ```

3. **PlatformMPI**

    For RDMA:
    ```
    -mppflags "-intra=shm -e MPI_HASIC_UDAPL=ofa-v2-cma-roe-enp94s0f0 -UDAPL"

    ```

    For better performances:
    ```
    -prot -aff:automatic:bandwidth
    ```
    To pin on the first 36 threads:

    ```
    -cpu_bind=MAP_CPU:0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19 ,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35
    ```

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.