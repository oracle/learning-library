---
layout: ziplab
description: Examine Database Services and ATP Consumer Groups.
tags: Oracle Cloud, Autonomous Transaction Processing, ATP, Oracle Cloud Infrastructure, OCI
permalink: /ziplabs/atp-services/index.html
---
# Working with Database Services and ATP Consumer Groups #

## Before You Begin ##
In this 10-minute lab, you will use the LOW and PARALLEL database services (consumer groups) to understand the performance differences between them. You will run queries on the SSB schema sample data set provided in your ATP database, first on the LOW service and then on the PARALLEL service. 

### Background ###
The priority of user requests in Autonomous Transaction Processing is determined by the database service the user is connected with. Users are required to select a service when connecting to the database. These services map to the LOW, MEDIUM, HIGH and PARALLEL consumer groups. The basic characteristics of these consumer groups are:

**HIGH**
* Sessions connected to the High database service get the highest priority when the system is under resource pressure.
* Queries run serially unless you specify a parallel degree through a session parameter, using a statement hint, or by specifying a parallel degree on the underlying tables.

**MEDIUM**
* Sessions connected to the Medium database service get medium priority when the system is under resource pressure.
* Queries run serially unless you specify a parallel degree through a session parameter, using a statement hint, or by specifying a parallel degree on the underlying tables.

**LOW**
* Sessions connected to the Low database service get the lowest priority when the system is under resource pressure.
* Queries run serially unless you specify a parallel degree through a session parameter, using a statement hint, or by specifying a parallel degree on the underlying tables.

**PARALLEL**
* SQL statements executed through the Parallel service are automatically executed using Oracle automatic parallelism. However, sessions connected to the Parallel database service get lowest priority when the system is under resource pressure, therefore we only recommend batch processes or reporting workloads use this service.
* Queries are executed with Oracle Automatic Degree of Parallelism.

As a user you need to pick the database service based on your performance and concurrency requirements.

The expectation for this lab is that you will see parallelization and therefore faster execution with the PARALLEL service vs. the non-parallelized execution in the LOW service. This is dependent on the number of CPU’s allocated to the database and other activity that may be running concurrently.


### What Do You Need? ###
* Access to an instance of Oracle Autonomous Transaction Processing
* [Oracle SQL Developer 18.2](http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html)  (already installed)
* [Oracle's Java Development Kit 8 (JDK 8)](http://www.oracle.com/technetwork/java/javase/downloads/index.html) (already installed)
* [Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files](https://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html) (already installed)
* You must have completed the previous lab **Provisioning Autonomous Transaction Processing and Connecting with SQL Developer**.


## Connect and Query with the LOW Database Service ##
1. Open SQL Developer. 
2. If you're not already connected, expand the list of connections and double click the **xweek_admin_low** connection to connect to the database. After you enter the admin signin credentials, a SQL worksheet will open.

    ![](img/connections.png)

    [Description of the illustration connections.png](files/connections.png)

3. Copy and paste this code into the SQL Developer worksheet. The `/*+no_result_cache */` hint ensures results are not cached, which would skew the timings:

   ````SQL
   select /*+no_result_cache*/ c_city,c_region,count(*) 
   from ssb.customer c_high
   group by c_city,c_region
   order by count(*);
   ````

4. Click **Run Script (or F5)** in SQL Developer so that all the rows are displayed on the screen.
5. Note the response time.
    
    ![](img/ResponseTimeLow.png)

    [Description of the illustration ResponseTimeLow.png](files/ResponseTimeLow.txt)


## Connect and Query with the PARALLEL Database Service ##
1. If you're not already connected, double click the **xweek_admin_parallel** connection to connect to the database. After you enter the admin signin credentials, a SQL worksheet will open.
2. Copy and paste the same code into the SQL Developer worksheet for the parallel database service:

   ````SQL
   select /*+no_result_cache*/ c_city,c_region,count(*) 
   from ssb.customer c_high
   group by c_city,c_region
   order by count(*);
   ````

3. Click **Run Script** in SQL Developer.
4. Note the response time.
    
    ![](img/ResponseTimeParallel.png)

    [Description of the illustration ResponseTimeParallel.png](files/ResponseTimeParallel.txt)

The query using the PARALLEL service ran in about half the time as before! This is because we have 2 CPU’s allocated in this environment, and the PARALLEL service parallelized the query to take advantage of both CPU’s. The LOW service has only 1 CPU and cannot utilized parallelization. Therefore, the query using the LOW service takes twice as long to run.


## Want to Learn More? ##
* [Autonomous Cloud Platform Courses](https://learn.oracle.com/pls/web_prod-plq-dad/dl4_pages.getpage?page=dl4homepage&get_params=offering:35573#filtersGroup1=&filtersGroup2=.f667&filtersGroup3=&filtersGroup4=&filtersGroup5=&filtersSearch=) from Oracle University 
* [ATP Self-Guided Hands-On Workshop](https://cloudsolutionhubs.github.io/autonomous-transaction-processing/workshops/?page=README.md)
