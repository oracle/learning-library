# Create Autonomous Database

![Autonomous](./images/adb_banner.png)

## Introduction

This workshop walks you through the steps to get started using the **Oracle Autonomous Transaction Processing Database (ATP)** on **Oracle Cloud Infrastructure (OCI)**. You will provision a new database in just few minutes.

### Self-driving

- Automate database provisioning, tuning, and scaling.

- Provisions highly available databases, configures and tunes for specific workloads, and scales compute resources when needed, all done automatically.

### Self-securing

- Automate data protection and security.

- Protect sensitive and regulated data automatically, patch your database for security vulnerabilities, and prevent unauthorized access—all with Oracle Autonomous Database.

### Self-repairing

- Automate failure detection, failover, and repair.

- Detect and protect from system failures and user errors automatically and provide failover to standby databases with zero data loss.

- Perfect for Developers!

Estimated Lab Time: 10 minutes

### Objectives
- Create an Autonomous Database with the latest features of Oracle Databases

## **STEP 1**: Create a new Autonomous Transaction Processing

1. Go to the **Autonomous Transaction Processing (ATP)** menu:

    ![Menu ATP](./images/menu_atp.png)

    Check if you are in the **root compartment** that is fine for testing.

    > Compartments are a logical separation of resources to attach roles and permissions. It will make possible to create your team structure in compartments so you know who manage what resources. Not necessary at this stage.

    And click in **Create Autonomous Database** button.

    ![ATPs](./images/atps.png)

    You can leave the compartment as it is. It would say something like _<tenancy_name> (root)_. Write the Display name and Database name.

2. Make sure you select **Transaction Processing** and **Shared Infrastructure**.

    ![ATP Creation](./images/atp_creation_1.png)

3. You can select **Always Free** configuration to start enjoying your Free Autonomous Database. You will have visible the **Always Free** logo next to the name of your database:

    ![Always Free Logo](./images/always_free_logo.png)

    CPU and Storage are good with default values, the same for the database version.

    Auto scaling you can leave it off but it is a nice feature as the ATP database will scale if the workload is increasing and scale down automatically if the workload reduces. Zero downtime during the process. It's cool, isn't it?

4. Under the Create Administrator credentials section, provide the **Administrator Password**. Enter any password you wish to use following the specific requirements imposed by ATP.

    > Reminder: Note your password in a safe location as this cannot be reset.

    ![ATP Creation](./images/atp_creation_2.png)

   Leave **Allow Secure Access From Everywhere** for the workshop and **License Included**.

5. Click **Create Autonomous Database** button.

    ![ATP Creation](./images/atp_creation_3.png)
    ![ATP Creation](./images/atp_creation_4.png)

    After few seconds you will have your new Autonomous Database up and running.

    Look around the details and get familiar with the buttons and tabs on this page.

    ![ATP Details](./images/atp_details.png)

    Remember: You will have visible the **Always Free** logo next to the name of your database:

    ![Always Free Logo](./images/always_free_logo.png)

*You can proceed to the next lab…*

## **Acknowledgements**

- **Author** - Victor Martin - Principal Cloud Engineer | Priscila Iruela - Database Business Development
- **Contributors** - Melanie Ashworth-March
- **Last Updated By/Date** - Kamryn Vinson, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.