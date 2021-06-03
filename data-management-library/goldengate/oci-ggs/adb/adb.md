# Verify the Source and Target Autonomous Database Connection Details

## Introduction

This lab walks you through the steps to create the source and target databases that you'll use for OCI GoldenGate.

Estimated Lab Time: 20 minutes

### About the source and target databases

This lab uses an Oracle Autonomous Transaction Processing database as its source and an Oracle Autonomous Database Warehouse for its target. Follow the steps in this lab to create these databases and their schemas.

### Objectives

In this lab, you will:

* Create the source Autonomous Transaction Processing database and create its schema
* Create the target Autonomous Data Warehouse database and its schema


## **STEP 1**: Create the Autonomous Transaction Processing instance

1. Log in to the [Oracle Cloud Infrastructure Console](https://login.us-phoenix-1.oraclecloud.com/) with your username and password.

2. Open the **Navigation Menu**, navigate to **Oracle Database**, and select **Autonomous Transaction Processing**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-atp.png " ")

3. Under List Scope, select **Compartment_Workshop** from the **Compartment** dropdown.

4. In the list of databases, select **Workshop ATP**.

5. On the Workshop ATP Database Details page, click **Tools**, and then under **Database Actions**, click **Open Database Actions**.

6. On the Oracle Database Actions log in screen, enter **SRC\_UA\_USER** for Username, and **OracleWelcome1** for the Password, and then click **Sign in**.

7. On the Database Actions page, click **SQL**.

   If you can access the SQL Page successfully, then you can proceed to the next section.

## **STEP 2:** Verify the target Autonomous Data Warehouse connection details

1. Open the **Navigation Menu**, navigate to **Oracle Database**, and select **Autonomous Data Warehouse**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

2. Under List Scope, if **Compartment_Workshop** is not already selected, select it from the **Compartment** dropdown.

3. In the list of databases, select **Workshop ADW**.

4. On the Workshop ADW Database Details page, click **Tools**, and then under **Database Actions**, click **Open Database Actions**.

5. On the Oracle Databse Actions log in screen, enter **SRC\_UA\_USER** for Username, and **OracleWelcome1** for the Password, and then click **Sign in**.

6. On the Database Actions page, click **SQL**.

   If you can access the SQL Page successfully, then you can [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management
* **Last Updated By/Date** - May 2021
