# Provision the application database on OCI with Database as a Service (DBaaS)

## Introduction

We will guide you through provisioning an application database.

Estimated Completion Time: 30 to 35 minutes including 25 to 30 minutes for provisioning time.

### Objectives

- Create a security list with proper ports open.
- Create a private subnet for the application database.
- Provision the application database as a database VM.

## **STEP 1:** Create a security List for the database subnet

Before we can provision the application database, we need to provision a **private subnet** for the **Database System** with appropriate **Security Lists** to open up the required ports:

- Port 1521 for the database.
- Port 22 for SSH.

In this section we will create a security list for the WebLogic subnet to be able to reach the database subnet on port 1521 (the Oracle database default port) and SSH port 22.

1. On the **Networking** menu, click **Virtual Cloud Network** in the compartment where WebLogic was provisioned.

  ![](./images/provision-db-1.png " ")

2. Click the VCN that was created by the stack, which would be called `nonjrf-vcn` if you used the same naming conventions.

  ![](./images/provision-db-2oke.png " ")

3. Click **Create Security List**.

  ![](./images/provision-db-4.png " ")

4. **Name** the security list `nonjrf-db-security-list`.

  ![](./images/provision-db-5-dbseclist.png " ")

5. Click **Additional Ingress Rule**.

  ![](./images/provision-db-5-ingress1521.png " ")

6. For **Source CIDR**, use `10.0.0.0/16` and for **Destination Port Range** enter **1521**.

  ![](./images/provision-db-5-ingress1521boke.png " ")

7. Click **Additional Ingress Rule** and enter `0.0.0.0/0` for the **Source CIDR** and enter `22` for the **Destination Port Range** to authorize SSH from outside (through the bastion host).

  ![](./images/provision-db-6-ingress22.png " ")

8. Click **Create Security List**.

## **STEP 2:** Create the Database Subnet

1. Click **Subnets** on the left-side menu.

  ![](./images/provision-db-7-subnet.png " ")

2. Click **Create Subnet**.

  ![](./images/provision-db-8-subnet.png " ")

3. **Name** the subnet `nonjrf-db-subnet`.

  ![](./images/provision-db-9-subnet1.png " ")

4. Keep the defaults for the **Subnet Type** and enter a CIDR block of `10.0.7.0/24`.

  ![](./images/provision-db-9-subnet2.png " ")

5. **Select** the `Default Routing Table for nonjrf-vcn` for the **Routing Table**.

  ![](./images/provision-db-9-subnet3.png " ")

6. Select **Private Subnet**.

  ![](./images/provision-db-9-subnet4.png " ")

7. Keep the defaults for the DNS resolution and label and select `Default DHCP Options for nonjrf-vcn` for **DHCP Options**.

  ![](./images/provision-db-9-subnet5.png " ")

8. **Select** the `nonjrf-db-security-list` created earlier for the **Security List**.

  ![](./images/provision-db-9-subnet6.png " ")

9. and click **Create Subnet**.

  ![](./images/provision-db-9-subnet7.png " ")

## **STEP 3:** Provision the Database System

1. On the **Database** menu, click **Bare Metal, VM and Exadata**.

  ![](./images/provision-db-10.png " ")

2. Click **Create DB System**.

  ![](./images/provision-db-11.png " ")

3. Make sure you are in the **Compartment** where you created the database subnet, and name your **Database System**.

  ![](./images/provision-db-12.png " ")

4. Select an availability domain or keep the default, keep the default **Virtual Machine** and select a **Shape** that is available.

  ![](./images/provision-db-13-ad-shape.png " ")

5. Keep the defaults for **Total node count** and **Database Edition**.

  ![](./images/provision-db-14.png " ")

6. Select **Logical Volume Manager**.

  ![](./images/provision-db-15-lvm.png " ")

7. Keep defaults for **Storage**.

  ![](./images/provision-db-16-storage.png " ")

8. **Upload** the **SSH public key** created earlier.

    The key created in the Docker container can be found in the folder `./weblogic-to-oci/ssh`.

    If using the marketplace image, just use the **Paste SSH Keys** and get the key  inside the on-premises environment with:

    ```
    <copy>
    cat ~/.ssh/id_rsa.pub
    </copy>
    ```

  ![](./images/provision-db-17-ssh.png " ")

9. Keep the default **License Included**.

  ![](./images/provision-db-18-license.png " ")

10. Select the **Virtual cloud network** `nonjrf-vcn`, the **Client subnet** `nonjrf-db-subnet` and set a **Hostname prefix** of `db`.

  ![](./images/provision-db-19-net.png " ")

11. Click **Next**.

12. Name the database `RIDERS` like the database on-premises (required for proper migration).

  ![](./images/provision-db-20-dbname.png " ")

13. Keep the default **Database version** 19c.

  ![](./images/provision-db-21-version.png " ")

14. Name the **PDB** `pdb` as it is on-premises.

  ![](./images/provision-db-22-pdb.png " ")

15. Enter and confirm the **SYS Database password** as it is on-premises: 

    ```
    <copy>
    YpdCNR6nua4nahj8__
    </copy>
    ```

  ![](./images/provision-db-23-creds.png " ")

16. Keep the default of **Transaction Processing** for **Workload type** and **Backup**, and click **Create DB System**.

  ![](./images/provision-db-24.png " ")

  This will usually take up to 40 minutes to provision.

  ![](./images/provision-db-25.png " ")

To save some time, you can start the database migration while the database is provisioning if you wish, however, you will need the database to be fully provisioned and you will need to gather the database information before you can finish the migration.


## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020
