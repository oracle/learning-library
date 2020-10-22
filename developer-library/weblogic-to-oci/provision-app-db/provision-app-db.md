# Provision the Application Database on OCI with DBaaS

## Introduction

This lab with guide you through provisioning a Application Database.

Estimated Lab Time: 30-35 min including ~25-30 min provisioning time.

### Objectives

In this lab you will:

- Create a Security List with proper ports open
- Create a private subnet for the Application Database
- Provision the Application Database as a Database VM.

## **STEP 1:** Create a security List for the database subnet

Before we can provision the Application Database, we need to provision a **private subnet** for the **Database System** with appropriate **Security Lists** to open up the required ports:
- port 1521 for the database,
- port 22 for SSH.

In this section we will create a Security List for the WebLogic subnet to be able to reach the Database subnet on port 1521 (the Oracle Database default port) and SSH port 22.

1. Go to **Networking -> Virtual Cloud Network** in the compartment where WebLogic was provisioned.

  <img src="./images/provision-db-1.png" width="50%">

2. Click the VCN that was created by the stack, which would be called `nonjrf-wls` if you used the same naming conventions.

  <img src="./images/provision-db-2.png" width="100%">

  You should find 2 subnets: a `nonjrf-lb-pubsubnet` and a `nonjrf-wls-subnet`, both public subnets since the WebLogic server instances were provisioned in a public subnet.

3. Copy the CIDR block of the `nonjrf-wls-subnet` (which should be 10.0.3.0/24) and click **Security Lists** on the left-side menu

  <img src="./images/provision-db-3-seclists.png" width="100%">

4. Click **Create Security List**

  <img src="./images/provision-db-4.png" width="100%">

5. **Name** the security list `nonjrf-db-security-list`

  <img src="./images/provision-db-5-dbseclist.png" width="70%">

6. Click **Additional Ingress Rule**

  <img src="./images/provision-db-5-ingress1521.png" width="70%">

7. For **Source CIDR**, paste the CIDR block of the `nonjrf-wls-subnet` copied earlier (`10.0.3.0/24`) and for **Destination Port Range** enter **1521**

  <img src="./images/provision-db-5-ingress1521.png" width="70%">

8. Click **Additional Ingress Rule** and enter `0.0.0.0/0` for the **Source CIDR** and enter `22` for the **Destination Port Range** to authorize SSH from outside (through the bastion host)

  <img src="./images/provision-db-6-ingress22.png" width="70%">

9. Click **Create Security List**

## **STEP 2:** Create the database subnet

1. Click **Subnets** on the left-side menu

  <img src="./images/provision-db-7-subnet.png" width="100%">

2. Click **Create Subnet**

  <img src="./images/provision-db-8-subnet.png" width="100%">

3. **Name** the subnet `nonjrf-db-subnet`

  <img src="./images/provision-db-9-subnet1.png" width="70%">

4. Keep the defaults for the **Subnet Type** and enter a CIDR block of `10.0.5.0/24`

  <img src="./images/provision-db-9-subnet2.png" width="70%">

5. **Select** the `Default Routing Table for nonjrf-wls` for the **Routing Table**

  <img src="./images/provision-db-9-subnet3.png" width="70%">

6. Select **Private Subnet**

  <img src="./images/provision-db-9-subnet4.png" width="70%">

7. Keep the defaults for the DNS resolution and label and select `Default DHCP Options for nonjrf-wls` for **DHCP Options**

  <img src="./images/provision-db-9-subnet5.png" width="70%">

8. **Select** the `nonjrf-db-security-list` created earlier for the **Security List**

  <img src="./images/provision-db-9-subnet6.png" width="70%">

9. and click **Create Subnet**

  <img src="./images/provision-db-9-subnet7.png" width="70%">

## **STEP 3:** Provision the Database system

1. Go to **Database -> Bare Metal, VM and Exadata**

  <img src="./images/provision-db-10.png" width="40%">

2. Click **Create DB System**

  <img src="./images/provision-db-11.png" width="100%">

3. Make sure you are in the **Compartment** where you created the DB subnet, and name your **Database System**

  <img src="./images/provision-db-12.png" width="100%">

4. Select an Availability Domain or keep the default, keep the default **Virtual Machine** and select a **Shape** that is available.

  <img src="./images/provision-db-13-ad-shape.png" width="70%">

5. Keep the defaults for **Total node count** and **Database Edition**

  <img src="./images/provision-db-14.png" width="70%">

6. Select **Logical Volume Manager** 

  <img src="./images/provision-db-15-lvm.png" width="70%">

7. Keep defaults for **Storage**

  <img src="./images/provision-db-16-storage.png" width="70%">

8. **Upload** the **SSH public key** created earlier

    The key created in the Docker container can be found in the folder `./weblogic-to-oci/ssh`

    If using the marketplace image, just use the **Paste SSH Keys** and get the key  inside the 'on-premises' environment with:

    ```
    <copy>
    cat ~/.ssh/id_rsa.pub
    </copy>
    ```

  <img src="./images/provision-db-17-ssh.png" width="70%">

9. Keep the default **License Included**

  <img src="./images/provision-db-18-license.png" width="70%">

10. Select the **Virtual cloud network** `nonjrf-wls`, the **Client subnet** `nonjrf-db-subnet` and set a **Hostname prefix** of `db`

  <img src="./images/provision-db-19-net.png" width="70%">

11. Click **Next**

12. Name the Database `RIDERS` like the database on-premises (required for proper migration)

  <img src="./images/provision-db-20-dbname.png" width="70%">

13. Keep the default **Database version** 19c

  <img src="./images/provision-db-21-version.png" width="70%">

14. Name the **PDB** `pdb` as it is on premises

  <img src="./images/provision-db-22-pdb.png" width="70%">

15. Enter and confirm the **SYS Database password** as it is on-premises: 

    ```
    <copy>
    YpdCNR6nua4nahj8__
    </copy>
    ```

  <img src="./images/provision-db-23-creds.png" width="70%">

16. Keep the default of **Transaction Processing** for **Workload type** and **Backup**, and click **Create DB System**

  <img src="./images/provision-db-24.png" width="100%">

  This will usually take up to 40 minutes to provision.

  <img src="./images/provision-db-25.png" width="100%">

To save some time, you can proceed to starting the DB migration lab while the DB is provisioning if you wish, however you will need the DB fully provisioned and you will need to gather the DB information before you can finish the migration.

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
