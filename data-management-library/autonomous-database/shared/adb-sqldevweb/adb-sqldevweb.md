# Connect to ADB with SQL Developer Web and Run Your First Query

## Introduction

In this lab, you will explore the provided sample data sets that come with your Autonomous Data Warehouse (ADW) or Autonomous Transaction Processing ATP) instance.

### Before You Begin

This lab uses SQL Developer Web, which currently connects only with the LOW database service level. For performance or for a higher degree of parallelism, you can use Oracle SQL Developer, as described in another lab in this series.

This lab will demo queries on sample data sets provided out of the box with ADW. ADW provides the Oracle Sales History sample schema and the Star Schema Benchmark (SSB) data set; these data sets are in the SH and SSB schemas, respectively.

You will run a basic query on the SSB data set which is a 1TB data set with one fact table with around 6 billion rows, and several dimension tables.

*Note: While this lab uses ADW, the steps are identical for creating and connecting to an ATP database.*

### Objectives

- Learn how to connect to your new Autonomous Database using SQL Developer Web
- Learn about the Star Schema Benchmark (SSB) and Sales History (SH) sample data sets
- Run a query on an ADW sample dataset

### Required Artifacts

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud Account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

### Lab Prerequisites

- This lab assumes you have completed the **Login to Oracle Cloud/Sign Up for Free Trial** and **Getting Started** labs seen in the menu on the right.

## **STEP 1**: Connect with SQL Developer Web

Although you can connect to your autonomous database from local PC desktop tools like Oracle SQL Developer, you can conveniently access the browser-based SQL Developer Web directly from your ADW or ATP console.

1.  If you are not logged in to Oracle Cloud Console, login and select Autonomous Data Warehouse from the hamburger menu and navigate into your ADW Finance Mart instance.

    ![](images/step1.1-LabGuide1-39fb4a5b.png " ")

    ![](images/step1.1-adb.png " ")

2. In your ADW Finance Mart database's details page, click the **Tools** tab.

    ![](./images/Picture100-34.png " ")

3.  The Tools page provides you access to SQL Developer Web, Oracle Application Express, and Oracle ML User Administration. In the SQL Developer Web box, click **Open SQL Developer Web**.

    ![](./images/Picture100-15.png " ")

4.  A sign-in page opens for the SQL Developer Web. For this lab, simply use your database instance's default administrator account, **Username - admin**, and with the admin **Password** you specified when creating the database. Click **Sign in**.

    ![](./images/Picture100-16.png " ")

5.  SQL Developer Web opens on a worksheet tab. The first time you open the SQL Developer Web, a series of pop-up informational boxes introduce you to the main features.

    ![](./images/Picture100-16b.png " ")

## **STEP 2**: Run Scripts in SQL Developer Web

Run a Query on a Sample Autonomous Database Dataset.

1.  Copy and paste the code snippet below to your SQL Developer Web worksheet. This query will run on the Star Schema Benchmark, one of the two ADW sample data sets that may be accessed from any ADW instance. Take a moment to examine the script. Make sure you click the **Run Statement** button to run it in the SQL Developer Web so that all the rows are displayed on the screen.

    ````
    <copy>
    select /* low */ c_city,c_region,count(*)
    from ssb.customer c_low
    group by c_region, c_city
    order by count(*);
    </copy>
    ````

    ![](./images/SSB_query_low_results_SQL_Developer_Web.png " ")

2.  Take a look at the output response from your Autonomous Data Warehouse.

3.  When possible, ADW also *caches* the results of a query for you. If you run identical queries more than once, you will notice a much lesser response time when your results have been cached.

4.  You can find more sample queries to run in the ADW documentation. Try some of the queries from the ADW Documentation <a href="https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/sample-queries.html" target="\_blank">here</a>.

Please proceed to the next lab.

## Want to Learn More?

Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/sql-developer-web.html#GUID-102845D9-6855-4944-8937-5C688939610F) for documentation on connecting with the built-in SQL Developer Web.

## Acknowledgements

- **Author** - Nilay Panchal, ADB Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Richard Green, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
