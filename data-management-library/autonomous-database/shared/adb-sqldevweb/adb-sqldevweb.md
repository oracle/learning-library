
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

*Note: While this lab uses ADW, the steps are identical for creating and connecting to an ATP database.*


### Objectives
- Learn how to connect to your new Autonomous Database using SQL Developer Web
- Learn about the different levels of an autonomous database service (HIGH, MEDIUM, LOW)
- Learn about the Star Schema Benchmark (SSB) and Sales History (SH) sample data sets
- Run a query on an ADW sample dataset

### Required Artifacts

-   The following lab requires an Oracle Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

### Lab Prerequisites
This lab assumes you have completed the *Login to Oracle Cloud* and *Provision ADB* labs.

### Video Preview
Watch a video demonstration of connecting to your new Autonomous Database instance using SQL Developer.

[](youtube:PHQqbUX4T50)


### Run a Query on a Sample Autonomous Database Dataset

## STEP 1: Connect with SQL Developer Web

Although you can connect to your autonomous database from local PC desktop tools like Oracle SQL Developer, you can conveniently access the browser-based SQL Developer Web directly from your ADW or ATP console.
1. In your database's details page, click the **Tools** tab.

    ![](./images/Picture100-34.png " ")

2. The Tools page provides you access to SQL Developer Web, Oracle Application Express, and Oracle ML User Administration. In the SQL Developer Web box, click **Open SQL Developer Web**.

    ![](./images/Picture100-15.png " ")

3. A sign in page opens for SQL Developer Web. For this lab, simply use your database instance's default administrator account, ADMIN, with the admin password you specified when creating the database. Click **Sign in**.

    ![](./images/Picture100-16.png " ")

4. SQL Developer Web opens on a worksheet tab. The first time you open SQL Developer Web, a series of pop-up informational boxes introduce the main features.

    ![](./images/Picture100-16b.png " ")


## STEP 2: Run Scripts in SQL Developer Web

1. Copy and paste the code snippet below to your SQL Developer Web worksheet. This query will run on the Star Schema Benchmark, one of the two ADW sample data sets that may be accessed from any ADW instance. Take a moment to examine the script. Then click the **Run Script** button to run it. Make sure you click the Run Script button in SQL Developer Web so that all the rows are displayed on the screen.

    ````
    <copy>
    select /* low */ c_city,c_region,count(*) 
    from ssb.customer c_low
    group by c_region, c_city
    order by count(*);
    </copy>
    ````

    ![](./images/SSB_query_low_results_SQL_Developer_Web.png " ")

2. Take a look at the output response from your Autonomous Data Warehouse.

3.  When possible, ADW also *caches* the results of a query for you. If you run identical queries more than once, you will notice a much lower response time when your results have been cached.

## STEP 3: Experiment with running other sample queries

1. You can find more sample queries to run in the ADW documentation.  Try some of the queries from the ADW Documentation <a href="https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/sample-queries.html" target="\_blank">here</a>.

Please proceed to the next lab.

## Acknowledgements

- **Author** - Nilay Panchal, ADB Product Managemnt
- **Last Updated By/Date** - Richard Green, DB Docs Team, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).