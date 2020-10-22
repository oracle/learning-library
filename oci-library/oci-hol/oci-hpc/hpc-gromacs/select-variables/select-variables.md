# Select Variables

## Introduction
In this lab, you will fill in the variables for your stack.

Estimated Lab Time: 10 minutes

## **STEP**: Select Variables

1. Click on ![](./images/next.png) and fill in the variables.

    **GPU Node**:

    * SHAPE OF THE GPU COMPUTE NODE: Shape of the Compute Node that will be used to run Gromacs. Select bare metal shapes BM.GPU2.2 or BM.GPU3.8 for best performance.
    * AVAILABILITY DOMAIN: AD of the Instance and Block Volume. The AD must have available GPU's.
    * GPU Node Count: Number of GPU Nodes Required.
    * VNC TYPE FOR THE GPU: Visualization Type for the headnode: none, VNC or X11VNC.
    * PASSWORD FOR THE VNC SESSIONS: password to use the VNC session on the Pre/Post Node.

    **Block Options**:

    * BLOCK VOLUME SIZE ( GB ): Size of the shared block volume.

    **Gromacs**:

    * URL TO DOWNLOAD Gromacs: URL of the Gromacs 2020.1 compiled binaries (replace the url with a different version or leave blank if you wish to download later).
    * URL TO DOWNLOAD A MODEL TARBALL: URL of the model you wish to run (replace the url with a different model or leave blank if you wish to download later).
    * URL TO DOWNLOAD VMD VISUALIZATION SOFTWARE: URL to download VMD 1.9.3 to visualize Gromacs models (replace the url with a different visualization software or leave blank if you wish to download later).

2. Click on ![](./images/next.png). Review the information and click on ![](./images/create.png)


## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.