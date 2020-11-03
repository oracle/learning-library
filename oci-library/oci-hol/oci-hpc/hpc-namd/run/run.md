# Running the Application

## Introduction
In this lab, you will run the application.

Estimated Lab Time: 5 minutes

## **STEP**: Running the Application

If the provided terraform scripts are used to launch the application, NAMD with CUDA is installed in the /mnt/block/NAMD/NAMD_2.13_CUDA folder and two example models are available in /mnt/block/work/NAMD_models folder.

1. Run NAMD with CUDA via the following command:

      ```
      <copy>

      namd2 +p<# of cores> +setcpuaffinity +devices <cuda visible devices> +idlepoll +commap <CPU to GPU mapping> <model path> > output.txt

      </copy>

      ```
      where:
         -  +p - number of CPU cores
         - +setcpuaffinity - assign threads/processes in a round-robin fashion to available cores in the order they are numbered by the operating system
         - +devices - number of GPU devices
         - +idlepoll - poll the GPU for results rather than sleeping while idle
         - +commap - communication mapping of the CPU’s with GPU’s
         - output.txt - output file with the analysis

      Example for BM.GPU2.2:

      ```
      <copy>

      namd2 +p26 +devices 0,1 +idlepoll +commap 0,14 /mnt/block/work/NAMD_models/apoa1/apoa1.namd > output.txt

      </copy>
      ```

      Example for BM.GPU3.8:

      ```
      <copy>

      namd2 +p52 +devices 0,1,2,3,4,5,6,7 +commap 0,1,2,3,26,27,28,29 /mnt/block/work/NAMD_models/apoa1/apoa1.namd > output.txt

      </copy>
      ```

2. Run ns_per_day.py against the output file to calculate nanoseconds per day averaged over the logged Timing statements. This is used to identify the performance and efficiency of the application using the current CPU/GPU configuration.

      ```
      <copy>

      ns_per_day.py output.txt
      </copy>
      ```

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.