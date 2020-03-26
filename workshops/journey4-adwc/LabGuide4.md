<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

September 21, 2018
</td>
<td class="td-banner">
# Lab 4: Querying Data in External Files
</td></tr><table>


## Introduction

In this lab, you will be querying files on the Oracle Cloud Infrastructure Object Storage (OCI) directly without loading them to your database.

**Note:** Make sure you have completed Lab 3: Loading Data into Your New Autonomous Data Warehouse before you proceed with this lab. You will use the data files on the OCI Object Storage and the credential object from Lab 3 in this lab.

To **log issues**, click <a href="https://github.com/millerhoo/journey4-adwc/issues/new" target="_blank"> here </a> to go to the github oracle repository issue submission form.

## Objectives

-   Learn how to create external tables on top of files residing on the object store

-   Learn how to query external data by the external tables

-   Learn how to create data warehouse user

## Required Artifacts

-   The following lab requires an Oracle Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

-   Oracle SQL Developer (see [Lab 1](LabGuide1.md) for more specifics on the version of SQL Developer and how to install and configure it).

# Querying External Data

#### **STEP 1: Create External Tables with DBMS_CLOUD**

-   Connected as your user in SQL Developer, copy and paste <a href="./scripts/400/create_external_tables.txt" target="_blank">this code snippet</a> to SQL Developer worksheet.  

    Use the **create\_external\_table** procedure of the **DBMS\_CLOUD** package to create external tables on the files staged in your object store. Note that you are still using the same credential and the URLs of files on OCI Object Storage you used when loading data in the previous lab.

    -   At the top of the script, specify the Object Store base URL in the definition of the **base\_URL** variable.

    ![](./images/400/snap0014527.jpg)

    - **Run the script**.

    Now you have **external tables** for the sample data pointing to files in the object store. Any query against the external tables will return the same result as against the original tables.

#### **STEP 2: Querying External Data**

-   Copy and paste <a href="./scripts/400/query_external_data.txt" target="_blank">this code snippet</a> to SQL Developer worksheet. We only replaced the original table names &lt;TABLE_NAME&gt; with &lt;TABLE_NAME_EXT&gt; in the sample query.  
    ![](images/400/Picture400-4.png)

-   **Run the script**. You will now see the same query result as before, from data pulled directly from the Object Store.


<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
## Great Work - All Done!
**You are ready to move on to the next lab. You may now close this tab.**
</td>
</tr>
<table>
