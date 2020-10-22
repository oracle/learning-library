# Access your GPU Node

## Introduction
In this lab, you will access your GPU Node.

Estimated Lab Time: 5 minutes

## **STEP**: Access your GPU Node
1. Once your job has completed successfully in Resource Manager, you can find the Public IP Addresses for the GPU node and the Private Key on the lower left menu under **Outputs**. 

2. Copy the Private Key onto your local machine, change the permissions of the key and login to the instance:

    ```
    chmod 400 /home/user/key
    ssh -i /home/user/key opc@ipaddress

    ```
3. Once logged into your GPU node, you can run Gromacs from /mnt/block. Refer to the README.md file for specific commands on how to run Gromacs on your GPU instance.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.