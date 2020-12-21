# Add Gromacs Installer to Object Storage

## Introduction
In this lab, you will add Gromacs Installer to Object Storage. 

Estimated Lab Time: 5 minutes

## **STEP**: Add Gromacs Installer to Object Storage
*Note that the terraform scripts [zip file](https://github.com/oci-hpc/oci-hpc-runbook-gromacs/tree/master/Resources/gromacs-2020.1.zip) provided in this github already contain object storage urls for Gromacs 2020.1, VMD 1.9.3 and an example benchmarking model from [Max Planck Institute](https://www.mpibpc.mpg.de/grubmueller/bench). If you want to change these url's, modify the variable.tf file and replace the values for gromacs_url, model_url and visualizer_url with your own pre-authenticated request urls.*

1. Select the menu ![](./images/menu.png)  on the top left, then select Object Storage --> Object Storage
2. Create a new bucket or select an existing one. To create one, click on![](./images/create_bucket.png)
3. Leave the default options: Standard as Storage tiers and Oracle-Managed keys. Click on![](./images/create_bucket.png)
4. Click on the newly created bucket name and then select![](./images/upload_object.png)
5. Select your Gromacs installer tar file and click![](./images/upload_object.png)
6. Click on the 3 dots to the right side of the object you just uploaded  and select "Create Pre-Authenticated Request"
7. In the following menu, leave the default options and select an expiration date for the URL of your installer. Click on![](./images/pre-auth.png)
8. In the next window, copy the "PRE-AUTHENTICATED REQUEST URL" and keep it. You will not be able to retrieve it after you close this window. If you loose it or it expires, it is always possible to recreate another Pre-Authenticated Request that will generate a different URL


## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.