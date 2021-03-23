# Provision and Setup #

## Introduction ##

This lab is all about getting your environment set up correctly. Here we will show you how to provision two different autonomous database instances, create a user, enable the schema for the user and load data into a table.

Estimated lab time: 20 - 30 minutes

Watch this short video to preview how to provision and setup your environment.

[](youtube:NP-svu6dXwI)

### About Oracle Machine Learning

Simplifying greatly, you can split machine learning into two parts: the process of building and training a model so it is ready to work; putting that model to work in production systems, applications, and processes. In general, training a machine learning model takes significant computing resources. You should not run that kind of work in an existing data warehouse or data mart, without clearing it ahead of time because it’s possible that model training could use too many resources and impact SLAs. You definitely don’t want to build and train a model in any kind of critical transactional system for the same reason.

For this Alpha Office scenario, we provision two different autonomous databases. The autonomous data warehouse is used to build and train your model. Think of it as a stand-in for your own data warehouse or data mart. Alternatively, given how easy it is to provision a data mart, think of this ADW as the best way for you to do machine learning without impacting anybody else in the organization. Setting up a dedicated data mart for machine learning may be the right thing for you to do outside of this lab.

But it’s not just about training the model - you also have to deploy it, and there are some options. You could deploy a model into a data warehouse where it’s available for analytics. Or maybe you want to deploy it into a production transaction processing system so that you can score each new transaction. Either way, you are going to need to know how to export and import a model. So we show you that in this lab using two different databases.

What Alpha Office wants is to deploy this machine learning model in a production database that supports their Client Service application. When an existing customer comes into the branch, we can pull up their name and check their credit in real-time. The marketing department can also load batch data into this system and run a process to score a new set of customers in bulk. So, this setup of just two different services allows you to build, train, and deploy a machine learning model into an application so that customer-facing and marketing employees can work with it.

### Objectives

-   Learn how to provision an ADW instance
-   Learn how to provision an ATP instance
-   Create a user in ADW and grant privileges
-   Load data into a table

### Prerequisites

This lab assumes you have completed the following labs:
* Login to Oracle Cloud/Sign Up for Free Tier

*Note: You may see differences in account details (eg: Compartment Name is different in different places) as you work through the labs. This is because the workshop was developed using different accounts over time.*

In this section, you will be provisioning an ADW database and an ATP database using the cloud console.

## **STEP 1:** Create an ADW Instance

First, we are going to create an ADW Instance.

1.  Click the hamburger menu, search for **Autonomous Data Warehouse**, and click on it.

    ![](./images/choose-adw.png  " ")

2.  Choose your **Compartment** by clicking on the drop-down list and then click **Create Autonomous Database**.

    ![](./images/create-adw2.png  " ")

3.  Select **Compartment** by clicking on the drop-down list. (Note that yours will be different - do not select **ManagedCompartmentforPaaS**) and then enter **Display Name**, **Database Name**.

    ![](./images/database-name.png  " ")

4.  Under **Choose a workload type** and **Choose a deployment type**, select **Data Warehouse**, and **Shared Infrastructure** respectively.

    ![](./images/workload-type.png  " ")

5.  Under **Configure the database**, leave **Choose database version** and **Storage (TB)** and **OCPU Count** as they are.

    ![](./images/009.png  " ")

6.  Add a password. Note the password down in a notepad, you will need it later in labs.

    ![](./images/010.png  " ")

7.  In **Choose network access**, keep the default access type **Allow secure access from everywhere**. Under **Choose a license type**, select **License Included** and click **Create Autonomous Database**.

    ![](./images/provision.png  " ")

8.  Now, Autonomous Data Warehouse starts provisioning. Once it finishes provisioning, you can view the instance details.

    ![](./images/provision-adw.png  " ")

    ![](./images/adw-available.png  " ")

You now have created your first ADW instance. Now, we are going to work on very similar steps to create an ATP Database.

## **STEP 2:** Create an ATP Instance

1.  Click the hamburger menu and select **Autonomous Transaction processing**.

    ![](./images/choose-atp.png  " ")

2.  Choose your **Compartment** by clicking on the drop-down list and then click **Create Autonomous Database**.

    ![](./images/atp-create.png  " ")

3.  Select **Compartment**. If you are using a LiveLabs environment, be sure to select the compartment provided by the environment. (Note that yours will be different - do not select **ManagedCompartmentforPaaS**) and then enter **Display Name**, **Database Name**.

    ![](./images/display-name.png  " ")

4.  Under **Choose a workload type** and **Choose a deployment type**, select **Transaction Processing**, and **Shared Infrastructure** respectively.

    ![](./images/provision-atp.png  " ")

5.  Under **Configure the database**, leave **Choose database version** and **Storage (TB)** and **OCPU Count** to how they are.

    ![](./images/009.png  " ")

6.  Add a password. Note the password down in a notepad, you will need it later in labs.

    ![](./images/010.png  " ")

7.  In **Choose network access**, keep the default access type **Allow secure access from everywhere**. Under **Choose a license type**, select **Bring Your Own License (BYOL)** and click **Create Autonomous Database**.

    ![](./images/atp-provision.png  " ")

8.  Now, Autonomous Data Warehouse starts provisioning. Once it finishes provisioning, you can view the instance details.

    ![](./images/atp-provisioned.png  " ")

    ![](./images/atp-available.png  " ")

You now have created your first ATP instance.

## **STEP 3:** Create ML User in ADW

1.  From the hamburger menu, select **Autonomous Data Warehouse** and navigate to your ADW instance.

    ![](./images/ml-adw.png " ")

    ![](./images/adw-instance.png " ")

2.  Select **Tools** on the Autonomous Database Details page.

    ![](./images/tools.png " ")

3.  Select **Open Oracle ML User Administration** under the tools.

    ![](./images/open-ml-admin.png " ")

4. Sign in as **Username - ADMIN** and with the password you used when you created your Autonomous instance.

    ![](./images/ml-login.png  " ")

6.  Click **Create** to create a new ML user.

    ![](./images/create.png  " ")

7. On the Create User form, enter **Username - ML\_USER**, an e-mail address (you can use admin@oracle.com), un-check **Generate password**, and enter a password you will remember. You can use the same password you used for the ADMIN account. Then click **Create**.

    ![](./images/ml-user.png  " ")

8. Notice that the **ML\_USER** is created.

    ![](./images/ml-user-created.png " ")

## **STEP 4:** Grant Privileges to ML_USER to access Database Actions

1.  From the hamburger menu, select **Autonomous Data Warehouse** and navigate to your ADW instance.

    ![](./images/ml-adw.png " ")

    ![](./images/adw-instance.png " ")

2.  Select **Tools** on the Autonomous Database Details page.

    ![](./images/tools.png " ")

3. Select **Open Database Actions** under the tools.

    ![](./images/open-database-actions.png  " ")

4. On the Database Actions login page, log in with your ADW credentials, provide the **Username - ADMIN** and click **Next**. Then provide the <if type="freetier">**Password** you created for the Autonomous instance.</if><if type="livelabs">password **WELcome__1234**</if> and click **Sign in**.

    ![](./images/ml-admin.png " ")

    ![](./images/ml-admin-password.png " ")

5. From the Database Action menu, select **SQL**.

    ![](./images/sql.png " ")

6. Dismiss the Help by clicking on the **X** in the popup.

    ![](./images/click-x.png  " ")

7.  By default, only the ADMIN user can use the SQL Developer Web. To enable ML\_USER to use it, you need to enter the following and execute the procedure to grant SQL developer web access to ML\_USER.

    ````
    <copy>
    BEGIN
      ORDS_ADMIN.ENABLE_SCHEMA(
        p_enabled => TRUE,
        p_schema => 'ML_USER',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'ml_user',
        p_auto_rest_auth => TRUE
      );
      COMMIT;
    END;
    /
    </copy>
    ````

    ![](./images/grant-mluser-access.png " ")
    ![](./images/mluser-access-granted.png " ")

8.  Grant storage privileges to ML\_USER.

    ````
    <copy>
    alter user ml_user quota 100m on data;
    </copy>
    ````

    ![](./images/storage-privileges.png " ")

## **STEP 5:** Download the Necessary Files

1.  Click the link below to download the install file.

    [install.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/n/natdcshjumpstartprod/b/adbml/o/install.zip)

2.  Save the install.zip to a download directory and then unzip the file.

    ![](./images/060.png  " ")

## **STEP 6**: Upload the data files to ML_USER

1. On the tab with your ADW instance, click on **Open Database Actions** under Tools.

    ![](./images/open-database-actions.png  " ")

2. This time sign in as **ML\_USER**. Provide the **Username - ML\_USER** and click **Next**. Then provide the password for your ML\_USER and click **Sign in**.

    ![](images/ml-user-next.png)

    ![](images/ml-user-sign-in.png)

3. Select **Data Load** from Database Actions menu.

    ![](images/data-load.png)

4. Leave the default selections - **Load data** and **Local File** and click **Next**.

    ![](images/to-load-data.png)

5. Drag and drop the **credit\_scoring\_100k.csv** from the directory where you downloaded and unzipped the install file onto the Drag and Drop target or click on **Select files** to browse the credit\_scoring\_100k.csv file and upload it.

    ![](images/select-files.png)

6. When the upload is complete, click **Start** and click **Run** in the Run Data Load Job confirmation dialog box.

    ![](images/run.png)

    ![](images/run2.png)

7. Notice the *Status: Running(1/1)* while loading the data. The status will be updated to *Status: Completed(1/1)* once the data loading job is completed.

    ![](./images/loading.png " ")

    ![](images/load-complete.png)

8. Click on the hamburger menu and click on **Development**. From the database actions development menu, select **SQL**.

    ![](images/hamburger-menu.png)

    ![](images/development.png)

    ![](images/development-sql.png)

9. Click on the **X** in the popup to dismiss the Help.

    ![](./images/close.png  " ")

10. The SQL Web Developer shows the table has been successfully created (and associated with ML\_USER).

    ![](images/tables-loaded.png)

[Please proceed to the next lab](#next).

## Acknowledgements

- **Author** - Derrick Cameron, Leah Bracken (v2)
- **Last Updated By/Date** - Anoosha Pilli, Product Manager, DB Product Management, March 2021

