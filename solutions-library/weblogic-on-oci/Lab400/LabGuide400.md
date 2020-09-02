# Lab 400: Provision the Database on OCI

## Introduction: 

While the WebLogic instances are provisioning, it's possible to move forward with the Application Database provisioning as soon as the VCN is provisioned.

Before we can provision the Application Database, we need to provision a **private subnet** for the **Database System** with appropriate **Security Lists** to open up the required ports: 
- port 1521 for the database, 
- port 22 for SSH.

## Step 1) Create a Security List for the database subnet

In this section we will create a Security List for the WebLogic subnet to be able to reach the Database subnet on port 1521 (the Oracle Database default port)

- Go to **Networking -> Virtual CLoud Network** in the compartment where WebLogic was provisioned.

  <img src="./images/provision-db-1.png" width="50%">

- Click the VCN that was created by the stack, which would be called `nonjrf-wls` if you used the same naming conventions.

  <img src="./images/provision-db-2.png" width="100%">

  You should find 2 subnets: a `nonjrf-lb-subnet` and a `nonjrf-wls-subnet`, both public subnets since the WebLogic server instances were provisioned in a public subnet.

- Copy the CIDR block of the `nonjrf-wls-subnet` (which should be 10.0.3.0/24) and click **Security Lists** on the left-side menu

  <img src="./images/provision-db-3-seclists.png" width="100%">

- Click **Create Security List**

  <img src="./images/provision-db-4.png" width="100%">

- **Name** the security list `nonjrf-db-security-list`

  <img src="./images/provision-db-5-dbseclist.png" width="70%">

- Click **Additional Ingress Rule**

  <img src="./images/provision-db-5-ingress1521.png" width="70%">

- For **Source CIDR**, paste the CIDR block of the `nonjrf-wls-subnet` copied earlier (`10.0.3.0/24`) and for **Destination Port Range** enter **1521**

  <img src="./images/provision-db-5-ingress1521.png" width="70%">

- Click **Additional Ingress Rule** and enter `0.0.0.0/0` for the **Source CIDR** and enter `22` for the **Destination Port Range** to authorize SSH from outside (through the bastion host) 

  <img src="./images/provision-db-6-ingress22.png" width="70%">

## Step 2) Create the database subnet

- Click **Subnets** on the left-side menu

  <img src="./images/provision-db-7-subnet.png" width="100%">

- Click **Create Subnet**

  <img src="./images/provision-db-8-subnet.png" width="100%">

- **Name** the subnet `nonjrf-db-subnet`

  <img src="./images/provision-db-9-subnet1.png" width="70%">

- Keep the defaults for the **Subnet Type** and enter a CIDR block of `10.0.5.0/24`

  <img src="./images/provision-db-9-subnet2.png" width="70%">

- **Select** the `Default Routing Table for nonjrf-wls` for the **Routing Table**

  <img src="./images/provision-db-9-subnet3.png" width="70%">

- Select **Private Subnet**

  <img src="./images/provision-db-9-subnet4.png" width="70%">

- Keep the defaults for the DNS resolution and label and select `Default DHCP Options for nonjrf-wls` for **DHCP Options**

  <img src="./images/provision-db-9-subnet5.png" width="70%">

- **Select** the `nonjrf-db-security-list` created earlier for the **Security List**

  <img src="./images/provision-db-9-subnet6.png" width="70%">

- and click **Create Subnet**

  <img src="./images/provision-db-9-subnet7.png" width="70%">

## Step 3) Provision the Database System

- Go to **Database -> Bare Metal, VM and Exadata**

  <img src="./images/provision-db-10.png" width="40%">

- Click **Create DB System**

  <img src="./images/provision-db-11.png" width="100%">

- Make sure you are in the **Compartment** where you created the DB subnet, and name your **Database System**

  <img src="./images/provision-db-12.png" width="100%">

- Select an Availability Domain or keep the default, keep the default **Virtual Machine** and select a **Shape** that is available.

  <img src="./images/provision-db-13-ad-shape.png" width="70%">

- Keep the defaults for **Total node count** and **Database Edition**

  <img src="./images/provision-db-14.png" width="70%">

- Select **Logical Volume Manager** 

  <img src="./images/provision-db-15-lvm.png" width="70%">

- Keep defaults for **Storage**

  <img src="./images/provision-db-16-storage.png" width="70%">

- **Upload** the **SSH public key** created earlier, and if you have another, upload it as well for safety.
  The key created in the container can be found in the folder `./on-prems-setup/common`

  <img src="./images/provision-db-17-ssh.png" width="70%">

- Keep the default **License Included**

  <img src="./images/provision-db-18-license.png" width="70%">

- Select the **Virtual cloud network** `nonjrf-wls`, the **Client subnet** `nonjrf-db-subnet` and set a **Hostname prefix** of `db`

  <img src="./images/provision-db-19-net.png" width="70%">

- Click **Next**

- Name the Database `RIDERS` like the database on-premises (required for proper migration)

  <img src="./images/provision-db-20-dbname.png" width="70%">

- Keep the default **Database version** 19c

  <img src="./images/provision-db-21-version.png" width="70%">

- Name the **PDB** `pdb` as it is on premises

  <img src="./images/provision-db-22-pdb.png" width="70%">

- Enter and confirm the **SYS Database password** as it is on-premises: `YpdCNR6nua4nahj8__`
This is found in the `env` file under `DB_PWD` in the `on-prems-setup/weblogic` folder

  <img src="./images/provision-db-23-creds.png" width="70%">

- Keep the default of **Transaction Processing** for **Workload type** and **Backup**, and click **Create DB System**

  <img src="./images/provision-db-24.png" width="100%">

This will take 20 to 40 minutes to provision.

  <img src="./images/provision-db-25.png" width="100%">

## Step 4) Gather the OCI database information

Once the database system is provisioned

- Go to the `nodes` left-side menu and note the **private IP address** of the node provisioned for later use

  <img src="./images/provision-db-26-nodeip.png" width="100%">

- Go to **DB Connection** 

  <img src="./images/provision-db-27-connection.png" width="100%">

- Copy the **DB connection string** for later use

  <img src="./images/provision-db-27-connection2.png" width="70%">
