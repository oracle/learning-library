# Cleaning Up Cloud Resources

## Introduction
This lab takes you through shutting down and destroying the resources created as part of this lab including VMs and Autonomous Database Instances.

Estimated Lab Time: 5 minutes

### Objectives
In this lab you will:
* Use your Terraform Stack to tear down OCI resources

### Prerequisites
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account
  
## **STEP 1:** Destroying 

To clean up all of the OCI resources created by Terraform at the start of this lab perform the following steps:

1. Navigate to the Stack you created in the Oracle Cloud Console by going to **Resource Manager** -> **Stacks** and selecting your stack under **Stacks**

2. Under **Terraform Actions** select **Destroy** then click the **Destroy** button

    ![Destroy Stack](images/destroy_stack.png)

The Terraform automation will tear down the VMs and the Autonomous Database created as the start of this lab.

*Congratulations! You have successfully completed the lab.*

## Acknowledgements
- **Owners** - Graeme Rocher, Architect, Oracle Labs - Databases and Optimization
- **Contributors** - Chris Bensen, Todd Sharp, Eric Sedlar
- **Last Updated By** - Kay Malcolm, DB Product Management, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/building-java-cloud-applications-with-micronaut-and-oci). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
