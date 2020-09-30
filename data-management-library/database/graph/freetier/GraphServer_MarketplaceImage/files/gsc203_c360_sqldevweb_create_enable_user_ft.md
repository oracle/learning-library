# Create and enable a user in SQLDeveloper Web

## Introduction
This lab walks you through the steps to get started with SQL Developer Web. You will learn how to create a user in SQL Developer Web and provide that user the access to SQL Develoepr Web.

### What Do You Need?
* Register cloud account
* Generate SSH Keys

## **Step 1:** Create the Customer_360 user

1. Login as the Admin user in SQLDevWeb of the newly cerated ADB Free Tier instance.

  Go to your Cloud Console, click **Autonomous Transaction Processing**. Select the ADB instance **ATP Finance Mart** you created in Lab 3.
    
  ![](../../GraphServer_ManualSetup/images/select_ATP.png " ")

  In Autonomous Database Details page, click **Service Console**. Make sure your brower allow pop-up windows.

  ![](../../../../images/ADB_console.png " ")

  Choose Development from the list on the left, then click the **SQL Developer Web**.

  ![ADB Console Development Page](../../GraphServer_ManualSetup/images/ADB_ConsoleDevTab.png " ")

  Enter `ADMIN` as Username, and the enter the password you set up at Lab 3, Step 2, Section 7.

  ![](../../../../images/login.png " ")
  Login as the ADMIN user. 

  ![Login as Admin](../../GraphServer_ManualSetup/images/ADB_SQLDevWebHome.png)

2. Now create the `CUSTOMER_360` user. Enter the following commands into the SQL Worksheet and run it while connected as the Admin user.

  ```
  <copy>
  CREATE USER customer_360 
  IDENTIFIED BY Welcome1_C360 
  DEFAULT TABLESPACE data 
  TEMPORARY TABLESPACE temp 
  QUOTA UNLIMITED ON data;  

  CREATE ROLE GRAPH_DEVELOPER;
  CREATE ROLE GRAPH_ADMINISTRATOR;

  GRANT connect, resource, graph_developer TO customer_360;
  </copy>
  ```

  ![](../../GraphServer_ManualSetup/images/ADB_SDW_CreateUser_C360.png " ")

  *Notes:* 
  - *The `IDENTIFIED BY` clause specifies the password (“Welcome1_C360”)*
  - *Since [20.3 the Graph Server uses database authentication](https://docs.oracle.com/en/database/oracle/oracle-database/20/spgdg/using-inmemory-analyst-oracle-database.html). The user needs at least the graph_developer role.*


## **Step 2:** Enable SQLDevWeb for Customer_360

  1. Now provide SQLDevWeb access for this user. See the [documentation](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/sql-developer-web.html#GUID-4B404CE3-C832-4089-B37A-ADE1036C7EEA)
  for details.
    First clear the previous text in the SQL Worksheet. 

    Copy and paste the following text into the SQL Worksheet and run it. 
    ```
    <copy>
    BEGIN
      ORDS_ADMIN.ENABLE_SCHEMA(
        p_enabled => TRUE,
        p_schema => 'CUSTOMER_360',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'c360',
        p_auto_rest_auth => TRUE
      );
      COMMIT;
    END;
    /
    </copy>
    ```

  ![Enable SQLDevWeb for Customer_360](../../GraphServer_ManualSetup/images/ADB_SDW_EnableLoginFor_C360.png " ")

  The URL for SQLDeveloperWeb for the Customer_360 user will have `c360` in place of `admin` in it.   
  Save the URL for the next step.  

  For details, see the ["Provide SQL Developer Web Access to Database Users"](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/sql-developer-web.html#GUID-4B404CE3-C832-4089-B37A-ADE1036C7EEA) section in the documentation. 


## Acknowledgements ##

* **Author** - Jayant Sharma, Product Manager, Spatial and Graph.  

* **Contributors** - Albert Godfrind and Ryota Yamanaka.  
  Thanks to Jenny Tsai for helpful, constructive feedback that improved this workshop.

* **Last Updated By/Date** - Arabella Yao, Product Manager Intern, Database Management, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
