
<!--September 21, 2018-->

# Working with Autonomous Database Services and the free Sample Data Sets


## Introduction

In this lab you will explore the provided sample data sets and learn more about the choices of database services that come with your Autonomous Data Warehouse (ADW) or Autonomous Transaction Processing ATP) instance.

Autonomous databases provide three database services that you can choose when connecting to your database. These are named as HIGH, MEDIUM, and LOW services and provide different levels of performance and concurrency.
<blockquote>
The <strong>HIGH</strong> database service provides the maximum amount of CPU resources for a query; however this also means the number of concurrent queries you can run in this service will not be as much as the other services. The number of concurrent SQL statements that can be run in this service is 3; this number is independent of the number of CPUs in your database.
<br><br>
The <strong>MEDIUM</strong> database service provides multiple compute and IO resources for a query. This service provides more concurrency compared to the HIGH database service. The number of concurrent SQL statements that can be run in this service depends on the number of CPUs in your database, and scales linearly with the number of CPUs.
<br><br>
The <strong>LOW</strong> database service provides the least amount of resources for a query. You can run any number of concurrent queries in this service.
<br>
</blockquote>
As a user you need to pick the database service based on your performance and concurrency requirements.

This lab uses SQL Developer Web, which currently connects only with the LOW database service level. For performance or for a higher degree of parallelism, you can use Oracle SQL Developer, as described in another lab in this series.

This lab will demo queries on sample data sets provided out of the box with ADW. ADW provides the Oracle Sales History sample schema and the Star Schema Benchmark (SSB) data set; these data sets are in the SH and SSB schemas, respectively.

You will run a basic query on the SSB data set which is a 1TB data set with one fact table with around 6 billion rows, and several dimension tables.

**Note:** While this lab uses ADW, the steps are identical for creating and connecting to an ATP database.

To **log issues**, click <a href="https://github.com/millerhoo/journey4-adwc/issues/new" target="\_blank"> here </a> to go to the GitHub Oracle Repository issue submission form.

### Objectives

- Learn about the different levels of an autonomous database service (HIGH, MEDIUM, LOW)
- Learn about the Star Schema Benchmark (SSB) and Sales History (SH) sample data sets
- Run a query on an ADW sample dataset

### Required Artifacts

-   The following lab requires an Oracle Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

### Run a Query on a Sample Autonomous Database Dataset

#### **STEP 1: Open up SQL Developer Web to connect to the autonomous database you created in the previous lab**

-   In your database's details page, click the **Tools** tab.

![](./images/200/Picture100-34.png " ")

-  The Tools page provides you access to SQL Developer Web, Oracle Application Express, and Oracle ML User Administration. In the SQL Developer Web box, click **Open SQL Developer Web**.

![](./images/200/Picture100-15.png " ")

-   If you are not still signed in to SQL Developer Web from the previous lab, a sign in page opens. For this lab, simply use your database instance's default administrator account, ADMIN, with the admin password you specified when creating the database. Click **Sign in**.

![](./images/200/Picture100-16.png " ")

-   SQL Developer Web opens on the worksheet tab. The first time you open SQL Developer Web, a series of pop-up informational boxes provide a tour of the main features.

![](./images/200/Picture100-16b.png " ")


-   Copy and paste <a href="./scripts/200/low_ssb_query.txt" target="\_blank">this code snippet</a> to your SQL Developer Web worksheet. This query will run on the Star Schema Benchmark, one of the two ADW sample data sets that may be accessed from any ADW instance. Take a moment to examine the script. Then click the **Run Script** button to run it. Make sure you click the Run Script button in SQL Developer Web so that all the rows are displayed on the screen.

![](./images/200/SSB_query_low_results_SQL_Developer_Web.png " ")

-   Take a look at the output response from your Autonomous Data Warehouse.

-   When possible, ADW also **caches** the results of a query for you. If you run identical queries more than once, you will notice a much lower response time when your results have been cached.

### Explore Additional Queries with the Sample Schemas


#### **STEP 2: Experiment with running other sample queries**

-   You can find more sample queries to run in the ADW documentation.  Try some of the queries from the ADW Documentation <a href="https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/sample-queries.html" target="\_blank">here</a>.


<table>
<tr><td class="td-logo">[![](images/hands_on_labs_tag.png " ")](#)</td>
<td class="td-banner">
## Great Work - All Done!
**You are ready to move on to the next lab. You may now close this tab.**
</td>
</tr>
<table>
