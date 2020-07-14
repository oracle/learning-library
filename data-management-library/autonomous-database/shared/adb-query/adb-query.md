# Query Data in External Files

## Introduction

In this lab, you will query files on the Oracle Cloud Infrastructure Object Storage (OCI) directly without loading them to your database.

### Objectives

-   Learn how to create external tables on top of files residing on the object store
-   Learn how to query external data by the external tables

### Required Artifacts

-   The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

### Lab Prerequisites

- This lab assumes you have completed the **Login to Oracle Cloud/Sign Up for Free Trial** and **Getting Started**  labs seen in the menu on the right.
- Make sure you have completed the previous lab in the menu on the right, [Load Data into ADB](?lab=lab-3-loading-data), before you proceed with this lab. In that lab, you created data files on the OCI Object Storage and you created the credential object, all of which you will use in this lab.

## **STEP 1**: Create External Tables with DBMS_CLOUD

1.  If you are not logged in to Oracle Cloud Console, login and select Autonomous Data Warehouse from the hamburger menu and navigate into your ADW Finance Mart instance.

    ![](images/step1.1-LabGuide1-39fb4a5b.png " ")

    ![](images/step1.1-adb.png " ")

2.  To login to SQL Developer Web, in your ADW Finance Mart database's details page, click the **Tools** tab and then click on **Open SQL Developer Web**. Enter **Username - admin** and with the admin **Password** you specified when creating the database and click **Sign in**.

    ![](./images/step1.2-Picture100-34.png " ")

    ![](./images/open_sql_developer_web.jpg " ")

    ![](./images/step1.2-Picture100-16.png " ")

3. Download <a href="./files/create_external_tables_without_base_url.txt" target="\_blank">this code snippet</a> to a text editor.

4. Replace `<file_uri_base>` in the code with the base URL you copied in Lab 4, Step 6. You should make 9 substitutions.

    This code uses the **create\_external\_table** procedure of the **DBMS\_CLOUD** package to create external tables on the files staged in your object store. Note that you are still using the same credential and the URLs of files on OCI Object Storage you used when loading data in the previous lab.

    For each `<file_uri_list>` statement:
        
    - Change `us-phoenix-1` to your real region name. The name is case-sensitive.
    - Change `idthydc0kinr` to your real namespace. The name is case-sensitive.
    - Change `ADWCLab` to your real bucket name. The name is case-sensitive.

    ![](./images/step1.4.png " ")

5.  Run the script. In the Substitutions Variables dialog, paste the base URL you copied in Lab 4, Step 6 and click **OK**.

  ![](images/step1.5.png " ")

  ![](images/substitution-variables.png " ")

    Now you have **external tables** for the sample data pointing to files in the object store. Any query against the external tables will return the same result as against the original tables.

    ![](./images/run_script_create_ext_tables_without_base_url.png " ")

## **STEP 2**: Querying External Data

1.  Copy and paste <a href="./files/query_external_data.txt" target="\_blank">this code snippet</a> to a SQL Developer Web worksheet. Compared to the query in the previous lab, we only replaced the original table names **TABLE\_NAME** with **TABLE\_NAME\_EXT** in the sample query.

2.  Run the script. You will now see the same query result as in the previous lab, but from data pulled directly from the Object Store.

    ![](images/external_table_query_results.jpg " ")

Please proceed to the next lab.

## Want to Learn More?

Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/query-external.html#GUID-ABF95242-3E04-42FF-9361-52707D14E833) for documentation on querying external data with Autonomous Data Warehouse.

## Acknowledgements

- **Author** - Nilay Panchal, ADB Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Richard Green, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
