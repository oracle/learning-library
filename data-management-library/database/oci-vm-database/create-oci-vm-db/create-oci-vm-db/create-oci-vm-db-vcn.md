# Create a 21C VM Database

## Introduction

This lab walks you through the steps to create a virtual cloud network (VCN) and an instance of an Oracle 21c Database running in Oracle Cloud Infrastructure. Oracle Cloud Infrastructure provides several options for rapidly creating a Database system for development and testing, including fast provisioning of 1-node virtual machine database systems.

A virtual cloud network (VCN) provides the necessary network Infrastructure required to support resources, including Oracle Database instances. This includes a gateway, route tables, security lists, DNS and so on. 

### Objectives
You can use a 1-node virtual database system to complete labs and tutorials that require an Oracle database.

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* SSH Keys
  
## **STEP 1**: Create a Virtual Cloud Network instance
Fortunately, Oracle Cloud Infrastructure provides a wizard that simplifies the creation of a basic, public internet accessible VCN.

1. Login to Oracle Cloud
2. From the Console menu, select **Networking > Virtual Cloud Networks**.

  ![](../create-virtual-cloud-network/images/virtual-cloud-networks.png " ")

2. Select your compartment and click on **Networking Quickstart**. If you haven't created any compartments yet, just leave it as the default (root) compartment.

  ![](../create-virtual-cloud-network/images/networking-quickstart.png " ")

3. Be sure the default "VCN with Internet Connectivity" is selected and click **Start Workflow**.

  ![](../create-virtual-cloud-network/images/start-workflow.png " ")

4. Enter a name for your VCN, and enter the default values for the VCN CIDR block(10.0.0.0/16), Public Subnet CIDR block (10.0.0.0/24) and Private CIDR block (10.0.1.0/24), and click **Next**.

  ![](../create-virtual-cloud-network/images/vcn-configuration.png " ")

5. Review your selections on the next screen and click **Create**.

  ![](../create-virtual-cloud-network/images/create-vcn.png " ")

6. On the summary screen, click **View Virtual Cloud Network**.
   
## **STEP 2**: Create a Database Virtual Machine

1. From the Console menu, click on **Bare Metal, VM, and Exadata**.

  ![](images/bare-metal-vm-exadata.png " ")

2. Select the compartment you want to create the database in and click on **Create DB System**.

  ![](images/create-VM-DB.png " ")

3. On the DB System Information form, enter the following information and click **Next**:

    * In the **Name your DB system** field, give your database a name.
    * Select **Logical Volume Manager** as the Storage Management Software.
    * In the **Add public SSH keys** section, browse to the location of your SSH keys and select the public key file (with a .pub extension).
    * In the **Specify the Network information** section, select the VCN you created using the drop down list.
    * Select the public subnet using the drop down list.
    * Enter a hostname prefix.

    ![](images/create-VM-DB-form1.png " ")

4. On the Database Information form, enter the following information and click **Create DB System**.

    * In the **Database name** field, change the default database name to "cdb1".
    * On the **Database version** drop down menu, select the version of the Oracle Database you want: 21c.
    * In the **PDB name** field, enter "pdb1".
    * Enter the password: `WElcome123##` for your sys user in the **Password** field and then repeat the password in the **Confirm password** field.  This password will be used for all exercies in the 21c workshop series.  Please enter it carefully.

    ![](images/create-VM-DB-form2.png " ")

5. After a few minutes, your Database System will change color from yellow (Provisioning) to green.

    ![](images/database-VM-created.png " ")

## **STEP 3**: Connect to the Database using SSH

1. On the **DB System Details** page, Click **Nodes**.

  ![](images/VM-DB-IP.png " ")

   Note the IP address.

2. In a terminal window, navigate to the folder where you created the SSH keys and enter this command, using your IP address:

    ```
    $ <copy>ssh -i ./myOracleCloudKey opc@</copy>123.123.123.123
    Enter passphrase for key './myOracleCloudKey':
    Last login: Tue Feb  4 15:21:57 2020 from 123.123.123.123
    [opc@tmdb1 ~]$
    ```

3. Once connected, you can switch to the "oracle" OS user and connect using SQL*Plus:

    ```
    [opc@tmdb1 ~]$ sudo su - oracle
    [oracle@tmdb1 ~]$ . oraenv
    ORACLE_SID = [cdb1] ?
    The Oracle base has been set to /u01/app/oracle
    [oracle@tmdb1 ~]$ sqlplus / as sysdba

    SQL*Plus: Release 21.0.0.0.0 - Production on Sat Nov 15 14:01:48 2020
    Version 20.2.0.0.0

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to:
    Oracle Database 21c EE High Perf Release 21.0.0.0.0 - Production
    Version 21.0.0.0.0

    SQL>
    ```

You may now [proceed to the next lab](#next).

## Want to Learn More?

* [Oracle Cloud Infrastructure: Creating Bare Metal and Virtual Machine DB Systems](https://docs.cloud.oracle.com/en-us/iaas/Content/Database/Tasks/creatingDBsystem.htm)
* [Oracle Cloud Infrastructure: Connecting to a DB System](https://docs.cloud.oracle.com/en-us/iaas/Content/Database/Tasks/connectingDB.htm)

## Acknowledgements
* **Author** - Tom McGinn, Learning Architect, Database User Assistance
* **Last Updated By/Date** - Kay Malcolm, November 30, 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 
