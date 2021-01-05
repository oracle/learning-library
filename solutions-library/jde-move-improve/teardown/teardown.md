# Tearing down Your JDE Environment

## Introduction
Now that the lab has been completed, we will use the OCI Console to destroy your JDE Trial Edition in order to make sure all resources are properly managed. 

Estimated Lab Time: 5 minutes


### Objectives
* Delete your JDE instance
* Destroy all associated OCI resources

### Prerequisites
* Tenancy Admin User
* Tenancy Admin Password

## **STEP 1:** Delete the JDE instance

To delete instances:

1. If you are not already, sign in to OCI tenancy.


2. On the Oracle Cloud Infrastructure Console Home page, click the Navigation Menu   in the upper-left corner and hover over Compute then select Instances.


3. Navigate to your Compartment. Select the JDE trial instance in the list of Instances.
    ![](./images/jde-trial-select.png " ")

4. Next click on More Actions. From there select Terminate to terminate the instance.
    ![](./images/terminate-button.png " ")

5. Wait for the instance to terminate. Once terminated your instance should be gone from the instance list.

## **STEP 2:** Delete the Associated OCI Resources

To delete the Virtual Cloud Network:

1. On the Oracle Cloud Infrastructure Console homepage, click on the ***Navigation Menu*** in the upper-left corner and hover over ***Networking*** then select ***Virtual Cloud Network***.
    ![](./images/vcn-select.png " ")

2. Under the list of Virtual Cloud Networks (VCN), click on the ***Action*** button on the right hand side and select ***Terminate***.
    ![](./images/vcn-terminate.png " ")

3. Wait for the Virtual Cloud Network (VCN) to finish terminating and reload the page. The item should be removed from the list. 

**4) You're all set!**
    **:)**

## Acknowledgements
* **Author:** AJ Kurzman, Cloud Engineering
* **Contributors:**
    * Jeff Kalowes, Principal JDE Specialist
    * Mani Julakanti, Principal JDE Specialist
    * Marc-Eddy Paul, Cloud Engineering
    * William Masdon, Cloud Engineering
    * Chris Wegenek, Cloud Engineering 
* **Last Updated By/Date:** AJ Kurzman, Cloud Engineering, 11/18/2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/migrate-saas-to-oci). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.