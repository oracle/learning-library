# Set up the environment

## Introduction 

This lab walks you through the steps to create the required resources you'll use for OCI GoldenGate. We'll show you how to create a VCN and subnet, provision autonomous database instances, and load data into the databases.

Estimated Lab Time: 20 mins

### Objectives
-  Learn to provision a VCN and subnet
-  Learn how to provision, connect, and load data into an Autonomous Transaction Processing (ATP) instance
-  Learn how to provision, connect, and load data into an Autonomous Data Warehouse (ADW) instance

### Prerequisites

This lab assumes you have completed the following labs:
* Sign Up for Free Tier/Login to Oracle Cloud

*Note: You may see differences in account details (eg: Compartment Name is different in different places) as you work through the labs. This is because the workshop was developed using different accounts over time.*

In this section, you will provision a VCN and subnet, ATP and ADW instances, and load data to use with OCI GoldenGate.

## **STEP 1:** Create a VCN and subnet

1.  In the Console navigation menu, under **Core Infrastructure**, in the **Networking** submenu, select **Virtual Cloud Networks**

    ![Select Virtual Cloud Networks](./images/00-01-vcn.png)

2.  Click **Start VCN Wizard**.

3.  Select **VCN with Internet Connectivity**, and then click **Start VCN Wizard.**

    ![Select VCN with Internet Connectivity](./images/00-03-vcn-wizard.png)

4.  Enter a name for the VCN, select a compartment, and then click **Next**.

    ![Start VCN Wizard](./images/00-04.png)

5.  Verify the configuration, and then click **Create**.

    ![Verify configuration](./images/00-05.png)

You can click View VCN Details and see both a Public and Private subnet were created.

## **STEP 2:** Create an ATP Instance

1.  In the Console navigation menu, under **Oracle Database**, select **Autonomous Transaction Processing**.

    ![Select Autonomous Transaction Processing](./images/01-01-atp.png)

2.  Click **Create Autonomous Database**.

    ![Create Autonomous Database](./images/01-02-create-adb.png)

3. Select **Compartment** by clicking on the drop-down list. (Note that yours will be different - do not select **ManagedCompartmentforPaaS**) and then enter **ATPSource** for **Display Name** and **Database Name**.

    ![Complete Database Information](./images/01-03-compartment.png)

4.  Under **Choose a workload type**, select **Transaction Processing**.

    ![Workload Type](./images/01-04-workload.png)

5.  Under **Choose a deployment type**, select **Shared Infrastructure**.

    ![Deployment Type](./images/01-05-deployment.png)

6.  Under **Configure the database**, leave **Choose database version** and **Storage (TB)** and **OCPU Count** as they are.

    ![Configure database](./images/01-06-db.png)

7.  Add a password. Take note of the password, you will need it later in this lab.

    ![Database user and password](./images/01-07-pw.png)

8.  Under **Choose a license type**, select **License Included**.

    ![License Type](./images/01-08-license.png)

9.  Click **Create Autonomous Database**. Once it finishes provisioning, you can click on the instance name to see details of it.


## **STEP 3:** Load the ATP schema

1.  Click the following link to download the database schema.

    [Archive.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/D9dqoEWMpWZgpMSyILK-ycaSQqiywQ2CxFZZkTY4ZpW9Yi0rV0MHiD4UWOgIGu0T/n/c4u03/b/data-management-library-files/o/Archive.zip)

2.  Save `Archive.zip` to a download directory, and then unzip the file.

3.  Back in the OCI Console, select your ATP instance from the Autonomous Databases list to view its details and access tools.

    ![Select ATP database](./images/02-03-atp.png)

4.  Click the **Tools** tab, and then click **Open Database Actions**.

    ![Click Tools](./images/02-04-tools.png)

    ![Click Open Database Actions](./images/02-04-db-actions.png)

5.  Log in with the ADMIN user and password provided when you created the ATP instance.

    ![Log in to Database Actions](./images/02-05-login.png)

6.  From the Database Actions menu, under **Development**, select **SQL**.

    ![Select SQL](./images/02-06-db-actions.png)

7.  (Optional) Click **X** to close the Help dialog.

8.  Copy the SQL script from **OCIGGLL\_OCIGGS\_SETUP\_USERS\_ATP.sql** paste it into the SQL Worksheet.

    ![Paste ATP User Set Up](./images/02-08-atp-sql.png)

9.  Click **Run Script**. The Script Output tab displays confirmation messages.

10. Copy the SQL script from **OCIGGLL\_OCIGGS\_SRC\_USER\_SEED\_DATA.sql** and paste it into a new SQL Worksheet.

    ![Paste ATP User Seed](./images/02-10-atp-schema.png)

11. Click **Run Script**. The Script Output tab displays confirmation messages.

12. In the Navigator tab, look for the SRC\_OCIGGLL schema and then select tables from their respective dropdowns to verify the schema and tables were created. You may need to log out and log back in if you can't locate SRC\_OCIGGLL.

    ![Refresh Navigator tab](./images/02-11-verify.png)

13. To enable supplemental logging, run the following command:

    ```
    <copy>ALTER PLUGGABLE DATABASE ADD SUPPLEMENTAL LOG DATA;</copy>
    ```

## **STEP 4:** Create an ADW Instance

1.  In the Console navigation menu, under **Oracle Database**, select **Autonomous Data Warehouse**.

    ![Select Autonomous Data Warehouse](./images/03-01-adw.png)

2.  Click **Create Autonomous Database**.

    ![Create Autonomous Database](./images/01-02-create-adb.png)

3. Select **Compartment** by clicking on the drop-down list. (Note that yours will be different - do not select **ManagedCompartmentforPaaS**) and then enter **ADWTarget** for **Display Name** and **Database Name**.

    ![Complete Database information](./images/01-03-compartment.png)

4.  Under **Choose a workload type**, select **Data Warehouse**.

    ![Workload Type](./images/01-04-workload.png)

5.  Under **Choose a deployment type**, select **Shared Infrastructure**.

    ![Deployment Type](./images/01-05-deployment.png)

6.  Under **Configure the database**, leave **Choose database version** and **Storage (TB)** and **OCPU Count** as they are.

    ![ADW configuration](./images/01-06-db.png)

7.  Add a password. Note the password down in a notepad, you will need it later in Lab 2.

    ![Database user and password](./images/01-07-pw.png)

8.  Under **Choose a license type**, select **License Included**.

    ![License Type](./images/01-08-license.png)

9.  Click **Create Autonomous Database**. Once it finishes provisioning, you can click on the instance name to see details of it.


## **STEP 5:** Load the ADW schema

1.  Select your ADW instance from the Autonomous Databases list to view its details and access tools.

    ![Select ADW database](./images/04-01-adw.png)

2.  Click the **Tools** tab, and then click **Open Database Actions**.

    ![Click Tools](./images/02-04-tools.png)

    ![Open Database Actions](./images/02-04-db-actions.png)

3.  Log in with the ADMIN user and password provided when you created the ATP instance.

    ![Log in to Database Actions](./images/02-05-login.png)

4.  From the Database Actions menu, under **Development**, select **SQL**.

    ![Select SQL](./images/02-06-db-actions.png)

5.  Copy the SQL script from **OCIGGLL_OCIGGS_SETUP_USERS_ADW.sql** paste it into the SQL Worksheet.

    ![Paste ADW User Set Up](./images/04-05-adw.png)

6.  Click **Run Script**. The Script Output tab displays confirmation messages.

7.  Copy the SQL script from **OCIGGLL_OCIGGS_SRC_MIRROR_USER_SEED_DATA.sql** and paste it into a new SQL Worksheet.

    ![Paste ADW User Seed](./images/04-07-adw-schema.png)

8.  Click **Run Script**. The Script Output tab displays confirmation messages.

9.  In the Navigator tab, look for the SRCMIRROR_OCIGGLL schema and then select tables from their respective dropdowns to verify the schema and tables were created. You may need to log out and log back in if you can't locate SRCMIRROR_OCIGGLL.

Please proceed to the next [lab](#next).

## Acknowledgements

- **Author** - Jenny Chan, Consulting User Assistance Developer
- **Last Updated** - March 2021
- **PAR Expiration date** - March 31, 2022

