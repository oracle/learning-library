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

  ![](./images/provision-db-1.png =50%x*)

2. Click the VCN that was created by the stack, which would be called <if type="oci">`nonjrf-wls`</if><if type="oke">`nonjrf-vcn`</if> if you used the same naming conventions.

  <if type="oci">
  ![](./images/provision-db-2.png =70%x*)

  You should find 2 subnets: a `nonjrf-lb-pubsubnet` and a `nonjrf-wls-subnet`.
  </if>
  <if type="oke">
  ![](./images/provision-db-2oke.png =70%x*)

  You should find 5 subnets, including `nonjrf-workers`, which is the subnet for the WLS worker nodes.
  </if>

<if type="oci">

3. Copy the CIDR block of the `nonjrf-wls-subnet` (which should be 10.0.3.0/24) and click **Security Lists** on the left-side menu

  ![](./images/provision-db-3-seclists.png)
</if>
<if type="oke">

3. Copy the CIDR block of the `nonjrf-workwers` subnet (which should be 10.0.4.0/28) and click **Security Lists** on the left-side menu

  ![](./images/provision-db-3-seclistsoke.png)
</if>

4. Click **Create Security List**

  ![](./images/provision-db-4.png)

5. **Name** the security list `nonjrf-db-security-list`

  ![](./images/provision-db-5-dbseclist.png =70%x*)

6. Click **Additional Ingress Rule**

  ![](./images/provision-db-5-ingress1521.png =70%x*)

<if type="oci">

7. For **Source CIDR**, paste the CIDR block of the `nonjrf-wls-subnet` copied earlier (`10.0.3.0/24`) and for **Destination Port Range** enter **1521**

  ![](./images/provision-db-5-ingress1521b.png =70%x*)
</if>
<if type="oke">

7. For **Source CIDR**, paste the CIDR block of the `nonjrf-workers` copied earlier (`10.0.4.0/28`) and for **Destination Port Range** enter **1521**

  ![](./images/provision-db-5-ingress1521boke.png =70%x*)
</if>

8. Click **Additional Ingress Rule** and enter `0.0.0.0/0` for the **Source CIDR** and enter `22` for the **Destination Port Range** to authorize SSH from outside (through the bastion host)

  ![](./images/provision-db-6-ingress22.png =70%x*)

9. Click **Create Security List**

## **STEP 2:** Create the database subnet

1. Click **Subnets** on the left-side menu

  ![](./images/provision-db-7-subnet.png)

2. Click **Create Subnet**

  ![](./images/provision-db-8-subnet.png)

3. **Name** the subnet `nonjrf-db-subnet`

  ![](./images/provision-db-9-subnet1.png =70%x*)

4. Keep the defaults for the **Subnet Type** and enter a CIDR block of `10.0.7.0/24`

  ![](./images/provision-db-9-subnet2.png =70%x*)

5. **Select** the `Default Routing Table for `<if type="oci">`nonjrf-wls`</if><if type="oke">`nonjrf-vcn`</if> for the **Routing Table**

  ![](./images/provision-db-9-subnet3.png =70%x*)

6. Select **Private Subnet**

  ![](./images/provision-db-9-subnet4.png =70%x*)

7. Keep the defaults for the DNS resolution and label and select `Default DHCP Options for `<if type="oci">`nonjrf-wls`</if><if type="oke">`nonjrf-vcn`</if> for **DHCP Options**

  ![](./images/provision-db-9-subnet5.png =70%x*)

8. **Select** the `nonjrf-db-security-list` created earlier for the **Security List**

  ![](./images/provision-db-9-subnet6.png =70%x*)

9. and click **Create Subnet**

  ![](./images/provision-db-9-subnet7.png =70%x*)

## **STEP 3:** Provision the Database system

1. Go to **Database -> Bare Metal, VM and Exadata**

  ![](./images/provision-db-10.png =40%x*)

2. Click **Create DB System**

  ![](./images/provision-db-11.png)

3. Make sure you are in the **Compartment** where you created the DB subnet, and name your **Database System**

  ![](./images/provision-db-12.png)

4. Select an Availability Domain or keep the default, keep the default **Virtual Machine** and select a **Shape** that is available.

  ![](./images/provision-db-13-ad-shape.png =70%x*)

5. Keep the defaults for **Total node count** and **Database Edition**

  ![](./images/provision-db-14.png =70%x*)

6. Select **Logical Volume Manager** 

  ![](./images/provision-db-15-lvm.png =70%x*)

7. Keep defaults for **Storage**

  ![](./images/provision-db-16-storage.png =70%x*)

8. **Upload** the **SSH public key** created earlier

    The key created in the Docker container can be found in the folder `./weblogic-to-oci/ssh`

    If using the marketplace image, just use the **Paste SSH Keys** and get the key  inside the 'on-premises' environment with:

    ```
    <copy>
    cat ~/.ssh/id_rsa.pub
    </copy>
    ```

  ![](./images/provision-db-17-ssh.png =70%x*)

9. Keep the default **License Included**

  ![](./images/provision-db-18-license.png =70%x*)

10. Select the **Virtual cloud network** <if type="oci">`nonjrf-wls`</if><if type="oke">`nonjrf-vcn`</if>, the **Client subnet** `nonjrf-db-subnet` and set a **Hostname prefix** of `db`

  ![](./images/provision-db-19-net.png =70%x*)

11. Click **Next**

12. Name the Database `RIDERS` like the database on-premises (required for proper migration)

  ![](./images/provision-db-20-dbname.png =70%x*)

13. Keep the default **Database version** 19c

  ![](./images/provision-db-21-version.png =70%x*)

14. Name the **PDB** `pdb` as it is on premises

  ![](./images/provision-db-22-pdb.png =70%x*)

15. Enter and confirm the **SYS Database password** as it is on-premises: 

    ```
    <copy>
    YpdCNR6nua4nahj8__
    </copy>
    ```

  ![](./images/provision-db-23-creds.png =70%x*)

16. Keep the default of **Transaction Processing** for **Workload type** and **Backup**, and click **Create DB System**

  ![](./images/provision-db-24.png)

  This will usually take up to 40 minutes to provision.

  ![](./images/provision-db-25.png)

To save some time, you can proceed to starting the DB migration lab while the DB is provisioning if you wish, however you will need the DB fully provisioned and you will need to gather the DB information before you can finish the migration.

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Weblogic). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
