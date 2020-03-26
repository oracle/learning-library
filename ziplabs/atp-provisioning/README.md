---
layout: ziplab
description: Learn how to provision and get started with Oracle Autonomous Transaction Processing.
tags: Oracle Cloud, Autonomous Transaction Processing, ATP, Oracle Cloud Infrastructure, OCI
permalink: /ziplabs/atp-provisioning/index.html
---
# Provisioning Autonomous Transaction Processing and Connecting with SQL Developer #

## Before You Begin ##
This 15-minute lab walks you through the steps to get started using the Oracle Autonomous Transaction Processing (ATP) on Oracle Infrastructure Cloud (OCI). You will provision a new ATP database and connect to the database using Oracle SQL Developer.

### Background ###
Oracle Autonomous Transaction Processing is fully-managed, offers high-performance, and is elastic. You have all of the performance of the market-leading Oracle Database in an environment that is tuned and optimized for transaction processing workloads.

Autonomous Transaction Processing is built upon the Oracle Database, so that all applications and tools that support Oracle Database also support Autonomous Transaction Processing. These tools and applications connect to the Autonomous Transaction Processing database using standard SQL*Net connections. The tools and applications can either be in your data center or in a public cloud. Oracle Analytics Cloud and other Oracle Cloud services are preconfigured for Autonomous Transaction Processing.

### What Do You Need? ###
* Access to an instance of Oracle Transaction Processing
* [Oracle SQL Developer 18.2](http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html)  (already installed)
* [Oracle's Java Development Kit 8 (JDK 8)](http://www.oracle.com/technetwork/java/javase/downloads/index.html) (already installed)
* [Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files](https://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html) (already installed)


## Create an ATP Instance ##
1. Sign in to the Oracle Cloud Platform. 
2. Click the menu icon to expand the menu on the left edge of the screen.
3. Click **Services**.
4. Click **Autonomous Transaction Processing**.

    ![](img/MyServicesMenu.png)

    [Description of the illustration MyServicesMenu.png](files/MyServicesMenu.txt)

5. Click the **Create Autonomous Transaction Processing** button to start the instance creation process.
6. In the Create Autonomous Transaction Processing dialog, enter the following information:
     * **Compartment**: For this lab, we'll use the `root` compartment.
     * **Display Name**: `atpxweek`
     * **Database Name**: `atpxweek`
     * **CPU Core Count**: `2`
     * **Storage (TB)**:  `1`
     * **Administrator Credentials**: Create a password for the ADMIN user of the service instance. You'll need this password in the upcoming steps to download the credential wallet and connect to the database from Oracle SQL Developer.
     * **License Type**: `My organization already owns Oracle database software licenses`
     * **Tags**: (Optional) You don't need to enter anything here. Tags can be used for additional security and segmentation.
7. Click the **Create Autonomous Transaction Processing Database** button to start provisioning the instance. 
8. The Create Autonomous Transaction Processing dialog closes. On the console, the State field indicates that the instance is **Provisioning**. When it's complete, the State field changes from **Provisioning** to **Available**. If the status doesn't change to available after few minutes, try refreshing the page.
9. Click the name of your ATP instance.

    ![](img/atp_provisioning_state.png)

    [Description of the illustration atp_provisioning_state.png](files/atp_provisioning_state.txt)

10. You're taken to the instance page which displays more information about your instance. Notice the ATP icon on the left. It's green to indicate the service is available. There are also various menu buttons that help you manage your new instance including buttons to start, stop, terminate, and scale the service.

    ![](img/atp_instance.png)

    [Description of the illustration atp_instance.png](files/atp_instance.txt)


## Download the Credentials Zip File ##
Now that you've created an ATP database, download the credentials zip file. This connections wallet provides the only authentication information that can be used to connect to your ATP database. It must be downloaded to the client that will connect to the database. Use this zip file to connect SQL Developer to your ATP database.

1. Click the **Service Console** button.

    ![](img/atp_open_service_console.png)

    [Description of the illustration atp_open_service_console.png](files/atp_open_service_console.txt)

2. Depending on your browser settings, you may need to give permission for the Service Console to open in a new tab. In Firefox:
     * Click **Preferences**
     * Click the final option to **Show** the content.

    ![](img/ShowNewTab.png)

    [Description of the illustration ShowNewTab.png](files/ShowNewTab.txt)

3. The service console opens to the **Overview** page. There is no activity displayed yet because this is a new instance. Click **Administration** in the left navigation pane.

    ![](img/atp-administration.png)

    [Description of the illustration atp-administration.png](files/atp-administration.txt)

4. Click **Download a Connection Wallet**.
5. You are prompted to create a password for the credentials zip file. Enter a password. This password is separate from the Admin user password created earlier.
     * Note: Version 18.2.0 of SQL Developer drops the requirement to enter the ATP keystore password and does not provide the keystore password field in the dialog for creating a connection. If using SQL Developer version 18.2.0 or newer, you do not use the password you just created.
7. Click **Download**.
6. Make note of where the zip file is stored. This will most likely be the downloads directory (Oracle's Home/Downloads). You'll use this file in the next step to define a SQL Developer connection to your ATP database.


## Connect to the Database using SQL Developer ##
Start SQL Developer and create a connection for your database using the default administrator account, ADMIN.

1. Open SQL Developer on your local computer. 
2. In the Connections panel, right-click **Connections** and select **New Connection**.

    ![](img/select_new_connection.png)

    [Description of the illustration select_new_connection.png](files/select_new_connection.txt)
    
3. Fill in the connection details:
     * **Connection Name**: `xweek_admin_parallel`
     * **Username**: `admin`
     * **Password**: Enter the admin user's password that you specified when provisioning the service instance.
     * **Connection Type**: `Cloud PDB`
     * **Configuration File**: Click **Browse**, and select the **Client Credentials** zip file you downloaded from the ATP service console.
     * **Keystore Password**:
        * **For SQL Developer 18.2.0 or newer**: Starting with version 18.2.0, SQL Developer does not require that you enter a Keystore Password and does not provide the Keystore Password field.
        * **For SQL Developer older version**: Enter the password that was generated when you downloaded the Client Credentials zip file from the ATP service console.
     * **Service**: Pick `atpxweek_parallel`. Many pre-configured services may be listed. Make sure you pick the one for with the database name you created.

    ![](img/NewConnection.png)

    [Description of the illustration NewConnection.png](files/NewConnection.txt)

4. Click **Test**. "Status: Success" should display at the left-most bottom of the New/Select Database Connection dialog.
5. Click **Save** to save the connecton information.
6. Click **Connect** to connect the database. An entry for the new connection appears under Connections. A new worksheet also appears.
7. Repeat the previous steps to create another connection. Use the same information as before with, with the following exceptions:
    * **Connection Name**: `xweek_admin_low`
    * **Service**: `atpxweek_low`

Keep SQL Developer open. You'll need it in the next lab when you examine the differences between parallel and low database service levels.


## Want to Learn More? ##
* [Autonomous Cloud Platform Courses](https://learn.oracle.com/pls/web_prod-plq-dad/dl4_pages.getpage?page=dl4homepage&get_params=offering:35573#filtersGroup1=&filtersGroup2=.f667&filtersGroup3=&filtersGroup4=&filtersGroup5=&filtersSearch=) from Oracle University 
* [ATP Self-Guided Hands-On Workshop](https://cloudsolutionhubs.github.io/autonomous-transaction-processing/workshops/?page=README.md)

