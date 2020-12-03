# Running LS-DYNA

## Introduction
In this lab, you will Run LS-DYNA.

Estimated Lab Time: 10 minutes

## Running LS-DYNA
Running LS-DYNA is pretty straightforward. To specify the host you need to run on, you need to create a machinefile. You can generate it as follow, or manually. Format is hostname:corenumber for both Platform and IntelMPI.

```
<copy>
sed 's/$/:36/' /etc/opt/oci-hpc/hostfile > machinefile
</copy>
```
Some run parameters can be specified by a parameter file: pfile

```
<copy>
gen { nodump nobeamout dboutonly }
dir { global /mnt/nfs-share/benchmark/one_global_dir local /dev/shm }

</copy>
```
This particular pfile tells LSDyna not to dump to much information to the disk. Uses memory to store local files and store global files into /mnt/nfs-share/benchmark/one_global_dir.

ANother place to store local files if it does not fit in the memory is /mnt/localdisk/tmp to use the local NVMe on the machine to store those files.

To run on multiple nodes, place the model on the share drive (Ex:/mnt/nfs-share/work/). Example provided here is to run the 3 cars model. . You can add it to object storage like the installer and download it or scp it to the machine.

```
<copy>
wget https://objectstorage.us-phoenix-1.oraclecloud.com/p/qwbdhqwdhqh/n/tenancy/b/bucket/o/3cars_shell2_150ms.k

</copy>
```
Make sure you have set all the right variables for mpi to run correctly. Run it with the following command for Intel MPI (change the modelname and core number):

```
<copy>
mpirun -np 256 -hostfile ./hostfile_rank \
-ppn 32 -iface enp94s0f0 -genv I_MPI_FABRICS=shm:dapl -genv DAT_OVERRIDE=/etc/dat.conf -genv I_MPI_DAT_LIBRARY=/usr/lib64/libdat2.so \
-genv I_MPI_DAPL_PROVIDER=ofa-v2-cma-roe-enp94s0f0 -genv I_MPI_FALLBACK=0 -genv I_MPI_DAPL_UD=0 -genv I_MPI_ADJUST_ALLREDUCE 5 -genv I_MPI_ADJUST_BCAST 1 -genv I_MPI_DEBUG=4 \
-genv I_MPI_PIN_PROCESSOR_LIST=0-35 -genv I_MPI_PROCESSOR_EXCLUDE_LIST=36-71 \
/mnt/nfs-share/LSDYNA/ ls-dyna_mpp_s_r9_2_119543_x64_redhat54_ifort131_sse2_intelmpi-413 
i=3cars_shell2_150ms.k \
memory=1000m memory2=160m p=pfile

</copy>
```

For platform MPI:

```
<copy>
mpirun -np 256 -hostfile ./hostfile_rank -ppn 32 \ 
-d -v -prot -intra=shm -e MPI_FLAGS=y -e MPI_HASIC_UDAPL=ofa-v2-cma-roe-enp94s0f0 -UDAPL \
/mnt/nfs-share/LSDYNA/ls-dyna_mpp_s_r9_2_119543_x64_redhat54_ifort131_sse2_platformmpi \
i=3cars_shell2_150ms.k \
memory=1000m memory2=160m p=pfile

</copy>
```

## Special Case

For some model, Douple Precision executables will not be enough to do the decomposition of the model. You can either use the double precision version of the executable or you can do the decomposition in double precision and still do the run in single precision to gain speed.

For the decomposition, add ncycles=2 to the command line and add this part to the pfile:

```
decomposition {								
 file decomposition								
 rcblog rcblog								
}
```

The model will be decomposed in a file called decomposition and stored in the directory of the model. During the second run, LS-Dyna will see this file and not redo the decomposition.

For the run in Single precision, you can use the same commands in the pfile.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.