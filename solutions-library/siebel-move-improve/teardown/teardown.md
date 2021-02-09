# Teardown Your Oracle Siebel Environment

## Introduction
In this lab we will destroy your Siebel environment by deleting all the resources we created in OCI.

Estimated Lab Time: 15 minutes


### Objectives
* Delete your Siebel virtual machine
* Destroy OCI Resources

### Prerequisites
* Tenancy Admin User
* Tenancy Admin Password

## **STEP 1:** Delete the Siebel Virtual Machine In OCI

1. Navigate to the OCI home page.

2. Use the dropdown menu located in the upper lefthand corner of the screen and select **Compute** then **Instances**.

    ![Use the dropdown menu located in the upper lefthand corner to select instances](./images/dropdown_compute_instance.png " ")

3. You are now on the **Instances** page. Make sure that you have the compartment you created in the "Setup" lab selected.

    ![List scope compartment portion](./images/correct_compartment.png " ")

4.   You should now be able to see the Siebel instance you created previously.

    Now click on the three dots to the right of your Siebel instance and then select **Terminate**.

    ![Use the small dropdown menu and click terminate](./images/terminate_instance.png " ")

    Once the image has finished terminating you will see its state change to terminated.

    ![Status should be terminated as shown](./images/terminated_instance_evidence.png " ")

## **STEP 2:** Terminating the VCN

1. Use the dropdown menu located in the upper lefthand corner of the screen and select **Networking** then **Virtual Cloud Networks**.
    ![Navigate to compartments using the dropdown menu](./images/dropdown_networking_vcn.png " ")

2. You will now see you are in the **Virtual Cloud Networks** page. Make sure that you have the compartment you created in the "Setup" lab selected.
    ![](./images/correct_compartment.png " ")

3. You shoud now be able to se the VCN that you created in the "Setup" lab.

    Now click on the three dots to the right of your VCN and then select **Terminate**.

    ![List scope compartment portion](./images/siebelVCN.png " ")

4. On the next screen you will see a list of all of the Associated Resources.

    After the window has finished loading all of the resources you can click the terminate all button.

    **Note:** It may take a moment for all of the resources to load.

    ![Terminate vcn menu](./images/terminate_confirm.png " ")

    After all the resouces have terminated the VCN itself will terminate and you may then click the close button.

## **STEP 3:** Deleting the Siebel Compartment

1.  Use the dropdown menu located in the upper lefthand corner of the screen and select **Identity** then **Compartments**.

    ![Navigate to compartments using the dropdown menu](./images/dropdown_compartment.png " ")

    From this screen navigate to the compartment you created in the "Setup" lab.

    ![Click the delete button to delete the compartment](./images/delete_compartment.png " ")

    After some time the status will be shown as deleted.

    ![The compartment is shown as deleted](./images/deleted_compartment.png " ")

You have now torn down all the resources you created for the Siebel Marketplace Instance and its Environments.

Congratulations on Completing the Siebel Move and Improve Workshop; well done you! :)


## Acknowledgements
* **Authors**
  - JB Anderson, Cloud Engineering
  - Chris Wegenek, Cloud Engineering
  - Naresh Sanodariya, Cloud Engineering
* **Contributors** -  Arunkumar Ravichandran, Cloud Engineering
* **Last Updated By/Date** - Chris Wegenek, Cloud Engineering, Dec 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/migrate-saas-to-oci). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
