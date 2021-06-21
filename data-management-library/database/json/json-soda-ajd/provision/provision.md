# Provisioning an Autonomous JSON Database

## Introduction

This lab walks you through the steps to get started using the Oracle Autonomous JSON Database [AJD] on Oracle Cloud. In this lab, you will provision a new AJD instance and connect to the Autonomous Database using JSON.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Learn how to provision a new Autonomous Database
* Connect to your Autonomous Database using JSON

### Prerequisites

* Logged into your Oracle Cloud Account
* The labs work on both 19c and 21c AJD database

## **STEP 1**: Choose AJD from the Services Menu

1. Login to the Oracle Cloud, as shown in the previous lab.

2. If you are using a Free Trial or Always Free account, and you want to use Always Free Resources, you need to be in a region where Always Free Resources are available. You can see your current default **Region** in the top, right hand corner of the page.

    ![Select region on the far upper-right corner of the page.](./images/region.png " ")

3. Click the navigation menu in the upper left to show top level navigation choices.

    ![Oracle home page.](./images/navigation.png " ")

4. Click on **Oracle Database** and choose **Autonomous JSON Database**.

    ![Click Autonomous JSON Database](./images/adb-json.png " ")

5. Use the __List Scope__ drop-down menu to select a compartment. Make sure your workload type is __JSON Database__.

    ![Check the workload type on the left.](./images/compartments.png " ")
    ![](./images/workload-type.png " ")

   *Note: Avoid the use of the ManagedCompartmentforPaaS compartment as this is an Oracle default used for Oracle Platform Services.*

## **STEP 2**: Creating the AJD Instance

1. Click **Create Autonomous Database** to start the instance creation process.

    ![Click Create Autonomous Database.](./images/create-adb.png " ")

2.  This brings up the __Create Autonomous Database__ screen where you will specify the configuration of the instance.

3. Provide basic information for the autonomous database:

    - __Choose a compartment__ - Select a compartment for the database from the drop-down list.
    - __Display Name__ - Enter a memorable name for the database for display purposes. For this lab, use __JSONDB__.
    - __Database Name__ - Use letters and numbers only, starting with a letter. Maximum length is 14 characters. (Underscores not initially supported.) For this lab, use __JSONDB__.

    ![Enter the required details.](./images/adb-info.png " ")

4. Choose a workload type: Select the workload type for your database from the choices:

    - __JSON__ - For this lab, choose __JSON__ as the workload type.

    ![Choose a workload type.](./images/workload-type2.png " ")

5. Choose a deployment type: Select the deployment type for your database from the choices:

    - __Shared Infrastructure__ - For this lab, choose __Shared Infrastructure__ as the deployment type.
    - __Dedicated Infrastructure__ - Alternatively, you could have chosen Dedicated Infrastructure as the deployment type.

    ![Choose a deployment type.](./images/deployment-type.png " ")

6. Configure the database:

    - __Always Free__ - If your Cloud Account is an Always Free account, you can select this option to create an always free autonomous database. An always free database comes with 1 CPU and 20 GB of storage. For this lab, we recommend you leave Always Free unchecked.
    - __Choose database version__ - Select a database version from the available versions. Note: This lab works on both 19c and 21c AJD database.
    - __OCPU count__ - Number of OCPUs for your service. For this lab, leave the default __1 OCPU__. If you choose an Always Free database, it comes with 1 OCPU.
    - __Storage (TB)__ - Select your storage capacity in terabytes. For this lab, leave the default __1 TB__ of storage. If you choose an Always Free database, it comes with 20 GB of storage.
    - __Auto Scaling__ - For this lab, keep auto scaling enabled, to allow the system to automatically use up to three times more CPU and IO resources to meet workload demand.

    *Note: You cannot scale up/down an Always Free autonomous database.*

    ![Choose the remaining parameters.](./images/configuration.png " ")

7. Create administrator credentials:

    - __Password and Confirm Password__ - Specify the password for ADMIN user of the service instance and confirm the password.

    The password must meet the following requirements:
    - The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character.
    - The password cannot contain the username.
    - The password cannot contain the double quote (") character.
    - The password must be different from the last 4 passwords used.
    - The password must not be the same password that is set less than 24 hours ago.
    - Re-enter the password to confirm it. Make a note of this password.

    ![Enter password and confirm password.](./images/administration.png " ")

8. Choose network access:

    - __Secure access from everywhere__ - For this lab, accept the default, "__Secure access from everywhere__.
    - __Private endpoint access only__ - If you want a private endpoint, to allow traffic only from the VCN you specify - where access to the database from all public IPs or VCNs is blocked, then select "Virtual cloud network" in the Choose network access area.
    - __Configure access control rule__ - You can control and restrict access to your Autonomous Database by setting network access control lists (ACLs). You can select from 4 IP notation types: IP Address, CIDR Block, Virtual Cloud Network, Virtual Cloud Network OCID).

    ![](./images/network-access.png " ")

9. Choose a license type:

    - __Bring Your Own License (BYOL)__ - Select this type when your organization has existing database licenses.
    - __License Included__ - Select this type when you want to subscribe to new database software licenses and the database cloud service. For this lab, choose __License Included__.

    ![](./images/license-type.png " ")

10. Click __Create Autonomous Database__.

    ![Click Create Autonomous Database.](./images/create-adb-final.png " ")

11.  Your instance will begin provisioning. In a few minutes, the state will turn from Provisioning to Available. At this point, your Autonomous JSON database is ready to use! Have a look at your instance's details here including the Database Name, Database Version, OCPU Count, and Storage.

    ![Database instance homepage.](./images/provisioning.png " ")

## **STEP 3**: Connect to your Autonomous Database using "JSON Workshop" UI

1. On the Autonomous Database Details page, click on the Tools tab.

    ![](./images/tools.png)

2. The Tools page provides you access to Database Actions, Oracle Application Express, Oracle ML User Administration and SODA Drivers. In the Database Actions box, click **Open Database Actions**.

    ![](./images/db-actions.png)

3. On Database Actions page, sign in with the database instance's default administrator account, **Username - ADMIN** and click **Next**.

    ![](./images/username.png)

4. Provide the ADMIN user with the password you specified when creating the database. Click **Sign in**.

    ![](./images/sign-in.png)

5. It displays the Database Actions console. On the Database Actions console under **Development** choose **JSON** to manager your JSON documents.

    ![](./images/json.png)

6. It opens on a worksheet. The first time you open JSON, a series of pop-up informational boxes introduce the main features. Click Next to know more or click on `X` to close the pop-up.

    ![](./images/tutorials.png " ")



You are now connected to your Autonomous Database using JSON.

You may now [proceed to the next lab](#next).

## Learn More

* [Provision Autonomous JSON Database](https://docs.oracle.com/en/cloud/paas/autonomous-json-database/ajdug/autonomous-provision.html#GUID-0B230036-0A05-4CA3-AF9D-97A255AE0C08)

## Acknowledgements

- **Author** - Anoosha Pilli, Product Manager, Oracle Database
- **Last Updated By/Date** - Anoosha Pilli, June 2021
