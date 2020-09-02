![](./media/adbtitle.png)
# Provisioning an Autonomous Database


## Table of Contents

- [Module 1: Learn how to login to the Oracle Cloud Console](#module-1--learn-how-to-login-to-the-oracle-cloud-console)
- [Module 2: Learn how to provision a new Autonomous Database](#module-2--learn-how-to-provision-a-new-autonomous-database)

***** 

## Module 1:  Learn How to Login to the Oracle Cloud Console

In this section you will be provisioning an ATP database using the cloud
console.

1. Go to [cloud.oracle.com](https://cloud.oracle.com), click Sign In to sign in
with your Oracle Cloud account.

![](media/32da3d2a9a2066af692d571c6071efb6.png)
<p align="center">Figure 1-1</p>

2. Enter your Cloud Account Name and click **Next**.

![](media/2ff2c7b36d769075b9edbfa402528120.png)
<p align="center">Figure 1-2</p>

3. Enter your Cloud username and password, and click **Sign In**. In this example, the
Cloud username is *adw_admin*.

![](media/3bcfe3c10f6b3821c1298edd15f11544.png)
<p align="center">Figure 1-3</p>

4. This will bring you to the main cloud page which may differ depending on whether
this cloud account has been used before and the main portal customized. Below
you will see the main screen for a new account, that shows available Guided
Journey’s. From here you can launch different Oracle cloud services. From the
top left select the drop down menu highlighted in red:

![](media/d1fa3898f59c6b6561adedd702f1b891.png)
<p align="center">Figure 1-4</p>

5. Select **Autonomous Transaction Processing** from the drop down menu

![](media/b7a5b961764035c8b0dc66af52e86254.png)
<p align="center">Figure 1-5</p>

This will put you in the main Autonomous Database Service Console (see below).
Any ADB Databases created will be listed here. You can also create and access
databases from this page.

It is possible to use different compartments to separate databases into
different associated groups, we will use the default compartment, so no change
just fyi:

![](media/519f90a4b9e0ad0d198c6f6a651979c7.png)
<p align="center">Figure 1-6</p>

***** 

[Back to Top](#table-of-contents)

## Module 2:  Learn How to Provision a New Autonomous Database

1. Click on the “**Create Autonomous Transaction Processing Database**” button, as
shown below:

![](media/f5503ce437deca3784758e841a77bebd.png)
<p align="center">Figure 2-1</p>

2. The following information must be filled in this page:

**Workload Type-** Autonomous Data Warehouse or Autonomous Transaction
Processing

**Compartment** – This can be changed, to organize and isolate databases

**Display Name –** The name of the service displayed

**Database Name –** The name of the actual database

**CPU Core Count –** Number of CPU’s allocated to the database (min 1)

**Storage –** Storage allocated to database in Terabytes (min 1)

**Password –** Database “Admin” user password

**License Type –** Select whether customer is using existing on-premises
database licenses (BYOL) or requires new licences. Customer charge will be based
on selected option

**TAGS –** a metadata system that allows you to organize and track resources
within your tenancy. Tags are composed of keys and values that can be attached
to resources.

3. After filling fields, click **Create Autonomous Database** which will open up
the screen to complete you database information:

![](media/ce48534c7dfffd014351615dd84e9ec1.png)
<p align="center">Figure 2-2</p>

You will be placed on the Database Details page and your database will be in
“**Provisioning**” status. The Database Details page displays more information
about your instance, notice the various menu buttons that help you manage your
new instance.

![](media/1865063cdcbea900e9233a4c0a36bc11.png)
<p align="center">Figure 2-3</p>

The status will automatically change to “**Available**” when the database is
ready in a few minutes…Your Autonomous database is up and running! Take notice
of the green color of the ATP logo indicating the service is available and
commands to start, stop, terminate, and scale the service.

![](media/f44598299d1fa60ad2ee5caf66734bfb.png)
<p align="center">Figure 2-4</p>

4. Now connect to your database, click the Service Console button:

![](media/1e31bffc05142a7bfa190d9eb11bcb0f.png)
<p align="center">Figure 2-5</p>

5. You will be placed in the Service Console page, you will notice there is no
activity displayed because this is a new instance. Select the **Administration**
option from the left:

![](media/0d68d4e2b1fa5ff9c451eb2adb865915.png)
<p align="center">Figure 2-6</p>

On the administration page there are six options:

**Download Client Credentials (Wallet) –** this contains the credentials files
used for connectivity to the instance from client applications, tools

**Set Administrator Password –** used to change the “Admin” account password

**Download Oracle Instant Client –** points to different clients that can be
used to connect to the database (like sql\*plus)

**Set Resource Management Rules –** ATP has pre-created user resource groups,
those can be managed here

**Manage Oracle ML Users –** Notebook development environment that can be used
with ATP

**Send Feedback to Oracle –** email feedback on ATP

![](media/28f102c530dcd46cbcd3716cda916a97.png)
<p align="center">Figure 2-7</p>

**You have successfully provisioned an Autonomous Database**

***END OF LAB***

[Back to Top](#table-of-contents)   
