# Run Rocky DEM

## Introduction
In this lab, we will walk you through the steps to run Rocky DEM.

Estimated Lab Time: 10 minutes

### Objectives

In this final lab:
* We will walk you through the different steps for running the Rocky DEM Software on OCI. 

### Prerequisites

* Complete Lab 7 : Install Rocky DEM
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful
* Familiarity with networking is helpful

## Steps to Run Rocky DEM

**Running the Application**

Running Rocky is pretty straightforward. You can either start the GUI if you have a VNC session started with

```
<copy>
rockyHomeDir=/mnt/block/
$rockyHomeDir/Rocky/rocky4/Rocky
</copy>
```

If you do not, you can run Rocky in batch mode:

Example 1 use 2 GPUs for modelName

```
<copy>
$rockyHomeDir/Rocky/rocky4/Rocky --simulate modelName --resume 0 --use-gpu 1 --gpu-num=0 --gpu-num=1 
</copy>
```

Example 2 use 32 CPUs for modelName

```
<copy>
$rockyHomeDir/Rocky/rocky4/Rocky --simulate modelName --resume 0 --use-gpu 0 -ncpus 32
</copy>
```


## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.