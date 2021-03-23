# Run ESI Pam-Crash

## Introduction
In this lab, we will walk you through the steps to run ESI Pam-Crash.

Estimated Lab Time: 10 minutes

### Objectives

In this final lab:
* We will walk you through the different steps for running the ESI Pam-Crash Software on OCI. 

### Prerequisites

* Complete Lab 7 : Install Rocky DEM
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful
* Familiarity with networking is helpful

## Steps to Run ESI Pam-Crash

**Running the Application**

Running Pam-Crash is pretty straightforward. 

To run on multiple nodes, place your model files in ```/mnt/modelshare/work/```. The machinefile that we have created in the previous steps contains all the nodes we can run on. Pay attention that you will use all the nodes along with all the cores specified in the file.

```
<copy>
cd /mnt/modelshare/work/
pamcrash -cf /mnt/share/machinefile.txt inputfile.pc
</copy>
```

That will use the default MPI from Pamcrash which is platform. To specify openmpi or intelmpi, you can use those different flags:

* ```-mpi``` to select which mpi to use.
    * platform-9.1.2
    * openmpi-1.8.2
    * impi-5.1.3
* ```-mpidir``` to specify where to look for MPI environment binary directory
* ```-mpiext``` to pass a list of extra arguments to mpi sub-processes

For even more parameters to include, run ```pamcrash -man```



## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.