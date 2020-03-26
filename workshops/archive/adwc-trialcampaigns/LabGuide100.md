# Introduction


This lab walks you through the steps to get started using the Oracle Autonomous Data Warehouse Cloud. You will provision a new ADWC database, connect to the database using Oracle SQL Developer, and create DW users.

## Objectives


-   Learn how to provision an ADWC service

-   Learn how to connect to ADWC

## Required Artifacts


-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

-   Oracle SQL Developer (see [Oracle Technology Network download site](http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html)).
    We recommend that you download version 17.4 or later, because this version contains enhancements for key Autonomous DW Cloud features. SQL Developer 17.3.1 will also work with Autonomous DW Cloud; versions earlier than 17.3.1 will not.
    **Note**:
    If you are a Windows user on 64-bit platform, download the 'Windows 64-bit with JDK 8 included' distribution as it includes both Java 8 and the Java Cryptography Extension (JCE) files necessary to run SQL Developer and connect to your Autonomous DW Cloud.
    If you are a non-Windows user, download and install the appropriate [Java 8 JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) for your Operating System. Download and extract the [Java Cryptography Encryption Archive](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html) to the directory as indicated in the README.txt.

## Provisioning an ADWC Service

### **STEP 1**: Sign in to Oracle Cloud

Note: In this section you will be provisioning an ADWC database using the cloud console.

-   Go to [cloud.oracle.com](https://cloud.oracle.com), click **Sign In** to sign in with your Oracle Cloud account.

    ![](./images/100/Picture100-2.png)

-   Enter your **Cloud Account Name** and click **My Services**.

    ![](./images/100/Picture100-3.png)

-   Enter your Cloud **username** and **password**, and click **Sign In**.

    ![](./images/100/Picture100-4.png)

### **STEP 2: Create an ADWC Instance**

-   By default, if you have not created an Autonomous Data Warehouse Cloud instance before you will not see it in the Dashboard. Click
    **Create Instance** to create new ADWC instance.

    ![](./images/100/Picture100-5.png)

-   From the list of your available services select **Autonomous DW** under Data Management and click **Create**.

    ![](./images/100/Picture100-6.png)

-   In the Welcome page click **Go to Console**.

    ![](./images/100/Picture100-7.png)

-   Click **Create Service** to start creating your ADWC instance.

    ![](./images/100/Picture100-8.png)

-   Enter the required information and click **Next**. For the purposes of this lab, use the information below.

    -   **Database Name:** Enter any database name you choose

    -   **CPU Count:** 2

    -   **Storage Capacity (TB):** 1

    -   **Administrator Password:** Enter any password you choose

    ![](./images/100/Picture100-9.png)

-   Review your information in the confirmation page and click **Create**.

    ![](./images/100/Picture100-10.png)

-   **Refresh** the Instances page after a while to see if your instance is created.

    ![](./images/100/Picture100-11.png)

-   Check if the **Status** for your instance is cleared indicating your instance is ready to use.

    ![](./images/100/Picture100-12.png)

You now have created your first Autonomous Data Warehouse Cloud instance.

## Connecting to ADWC

### **STEP 3: Sign in to the Service Console**

Note: As ADWC only accepts secure connections to the database, you need to download a wallet file containing your credentials first. The wallet is downloaded from the ADWC service console.

-   In the Instances page find your database and click **Service Console** in the actions menu.

    ![](./images/100/Picture100-13.png)

-   This will open a new browser tab for the service console. Sign in to the service console with the following information.

    -   **Username:** admin

    -   **Password:** The administrator password you specified during provisioning

    ![](./images/100/Picture100-14.png)

### **STEP 4: Download the credentials wallet**

-   Click the “**Administration**” tab and click “**Download Client Credentials**” to download the wallet.

    ![](./images/100/Picture100-15.png)

-   Specify a password of your choice for the wallet, you will need this password when connecting to the database later. Click **Download** to download the wallet file to your client machine.

    ![](./images/100/Picture100-16.png)

Connecting to the database using SQL Developer
----------------------------------------------

Start SQL Developer and create a connection for your database using the default administrator account, ADMIN, by following these steps.

### **STEP 5: Connect to the database using SQL Developer and create DW user**

-   Click the **Create Connection** icon in the Connections toolbox on the top left of the SQL Developer homepage.

    ![](./images/100/Picture100-17.png)

-   Fill in the connection details as below:

    -   **Connection Name:** admin_high

    -   **Username:** admin

    -   **Password:** The password you specified during provisioning

    -   **Connection Type:** Cloud PDB

    -   **Configuration File:** Enter the full path for the wallet file you downloaded before, or click the **Browse button** to point to the location of the file.

    -   **Keystore Password:** The password you specified when downloading the wallet from the ADWC service console

    -   **Service:** There are 3 pre-configured database services for each database. Pick **&lt;databasename&gt;_high** for this lab. For
        example, if you created a database named testdw select testdw_high as the service.

    ![](./images/100/Picture100-18.png)

-   Test your connection by clicking the **Test** button, if it succeeds save your connection information by clicking **Save**, then connect to your database by clicking the **Connect** button. 

-   Using your existing connection in SQL Developer, create a new user named **dwuser** using the following commands. For the next lab, you will use dwuser user to connect and work.
```
create user dwuser identified by "Welcome_123!";
grant dwrole to dwuser;
```
- Note that the database role DWROLE includes the privileges required by a typical DW developer. You can grant additional database privileges if needed.

-   You are now ready to move to the next lab [LabGuide200.md](LabGuide200.md).
