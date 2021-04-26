# Provisioning your Autonomous Database instance

![Autonomous Databases](./images/adb_banner2.png)

## Introduction

This workshop walks you through the steps to get started using the **Oracle Autonomous Data Warehouse Database (ADW)**. You will provision a new database in just a few minutes.

Oracle Autonomous Databases have the following characteristics:

**Self-driving**
Automates database provisioning, tuning, and scaling.

- Provisions highly available databases, configures and tunes for specific workloads, and scales compute resources when needed, all done automatically.

**Self-securing**
Automates data protection and security.

- Protect sensitive and regulated data automatically, patch your database for security vulnerabilities, and prevent unauthorized access—all with Oracle Autonomous Database.

**Self-repairing**
Automates failure detection, failover, and repair.

- Detect and protect from system failures and user errors automatically and provide failover to standby databases with zero data loss.

Watch our short video that explains Lab 1 - Provisioning your Autonomous Database instance & Lab 2 - Provisioning your Oracle Analytics Cloud instance in detail:

[](youtube:rpKwrm-7eCk)

_Estimated Lab Time:_ 15 minutes

### Objectives
- Create an Autonomous Database with the latest features of Oracle Databases

## **STEP 1**: Create a new Autonomous Data Warehouse Database

1. Click on the hamburger **MENU (Navigator)** link at the upper left corner of the page.

    This will produce a drop-down menu, where you should select **Autonomous Data Warehouse.**  
    ![Oracle Cloud Web Console](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png)

    This will take you to the management console page.

    [You can learn more about compartments in this link](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcompartments.htm).

2. To create a new instance, click the blue **Create Autonomous Database** button.

    ![Create ADB](./images/lab100_2small.png)

    Enter the required information and click the **Create Autonomous Database** button at the bottom of the form. For the purposes of this workshop, use the information below:

    >**Compartment:** Verify that a compartment ( &lt;tenancy_name&gt; ) is selected.

    By default, any OCI tenancy has a default ***root*** compartment, named after the tenancy itself. The tenancy administrator (default root compartment administrator) is any user who is a member of the default Administrators group. For the workshop purpose, you can use ***root*** or create your own _Compartment_ under the **root** folder.

     > **Display Name:** Enter the display name for your ADW Instance. Use a user-friendly name to help you easily identify the resource. You can leave the name provided. That field is not a mandatory one.

    > **Database Name:** Enter any database name you choose that fits the requirements for ADW. The database name must consist of letters and numbers only, starting with a letter. The maximum length is 14 characters. For this demo purpose, I have called my database **ADWH**.
  
    > **Workload Type:** Autonomous Data Warehouse  
    >
    > **Deployment Type:** Shared Infrastructure
    >
    > **Always Free:** Off
    
      - **Not recommended for this lab**, but you can select Always Free configuration to start enjoying your Free Autonomous Database.  
       With Free you cannot scale the database so you'll not be able to follow "**_Lab 7: Monitoring and Ad-hoc scaling up ADW activity for optimal OAC experience_**".
      
        [If you select 'Always Free Tier On', please check the following link](https://www.oracle.com/uk/cloud/free/#always-free).

      ![ADB Creation Details](./images/lab100_3a.png)

   > **Choose Database version:** 19c
   >
   > **CPU Count:** 2
   >
   > **Storage Capacity (TB):** 2
   >
   > **Auto scaling:** Off
   ![ADB Creation Storage](./images/lab100_4a.png)

3. Under **Create administration credentials** section:

    > **Administrator Password:** Enter any password you wish to use noting the specific requirements imposed by ADW. A suggested password is ADWwelcome-1234.
    >
    > **Reminder:** Note your password in a safe location as this cannot be easily reset.

    Under **Choose network access** section:

    > Select **'Allow secure access from everywhere'**: *On*
    >
    > Select **Configure access control rules:** *Off*  
    ![ADB Creation Password](./images/lab100_5.png)

4. Under **Choose a license type** section, choose **License Type: Licence Included**.

    When you have completed the required fields, scroll down and click on the blue **Create Autonomous Database** button at the bottom of the form:  
    ![ADB Creation](./images/lab100_6.png)

5. The Autonomous Database **Details** page will show information about your new instance. You should notice the various menu buttons that help you manage your new instance -- because the instance is currently being provisioned all the management buttons are greyed out.


6. A summary of your instance status is shown in the large box on the left. In this example, the color is amber and the status is **Provisioning.**  
![ADB Creation Provisioning Amber](./images/lab100_8.png)

7. After a short while, the status turns to **Available State** and the "ADW" box will change color to green:  
![ADB Creation Provisioning Green](./images/lab100_9.png)

8. Once the Instance Status is **Available**, additional summary information about your instance is populated, including workload type and other details.

    The provisioning process should take **under 5 minutes**.

9. After having the Autonomous Database instance **created** and **available**, you you may be prompted with a Pop Up window asking you to upgrade (from 18c to 19c, if you have selected 18c as a database version during the provisioning - the database version might be different). You may choose to upgrade the database version after the hands-on session, otherwise the upgrade process can take a few minutes, and you may miss a few exercises during the session.

    This page is known as the **Autonomous Database Details Page**. It provides you with status information about your database, and its configuration. Get **familiar** with the buttons and tabs on this page.  
    ![ADB Creation Details](./images/lab100_adw_readya.png)

You have just created an Autonomous Database with the latest features of Oracle Databases.

You may now [proceed to the next lab](#next)

## **Acknowledgements**

- **Author** - Lucian Dinescu, Product Strategy, Analytics
- **Contributors** - Priscila Iruela, Database Business Development | Juan Antonio Martin Pedro, Analytics Business Development Victor Martin, Melanie Ashworth-March, Andrea Zengin
- **Reviewed by** - Shiva Oleti, Product Strategy, Analytics
- **Last Updated By/Date** - Lucian Dinescu, February 2021