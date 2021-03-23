# Capture and Preserve SQL

## Introduction

In this lab you will capture and preserve SQL statements and information as well as the AWR. We’ll use this collection later on following a performance stability method guideline.

![](./images/capturesql.png " ")

Estimated Lab Time: n minutes

### About SQL Tuning Sets
A SQL tuning set (STS) is a database object that you can use as input to tuning tools. The database stores SQL tuning sets in a database-provided schema. An STS includes:

- A set of SQL statements
- Associated execution context, such as user schema, application module name and action, list of bind values, and the environment for SQL compilation of the cursor
- Associated basic execution statistics, such as elapsed time, CPU time, buffer gets, disk reads, rows processed, cursor fetches, the number of executions, the number of complete executions, optimizer cost, and the command type
- Associated execution plans and row source statistics for each SQL statement (optional)

An STS allows you to transport SQL between databases.  You can export SQL tuning sets from one database to another, enabling transfer of SQL workloads between databases for remote performance diagnostics and tuning. When suboptimally performing SQL statements occur on a production database, developers may not want to investigate and tune directly on the production database. The DBA can transport the problematic SQL statements to a test database where the developers can safely analyze and tune them.

![](./images/sqltuningset.png " ")

### Objectives
In this lab, you will:
* Collect Statements from AWR
* Collect Statements from Cursor Cache
* Optional - Export AWR

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
		- Lab: Initialize Environment

## **STEP 1**: Collect Statements from AWR

In order to collect SQL Statements directly from AWR (Automatic Workload Repository) you’ll call a SQL script which:
- Creates a SQL Tuning Set (STS)
- Populates the STS with SQL information stored in AWR

1.  Run the script stored in /home/oracle/scripts:
    
    capture_awr.sql

2. In your open SQL*plus session connected to UPGR run the statement below.  The number of statements in SQL Tuning Set “STS_CaptureAWR” will be displayed.

    ````
    <copy>
    @/home/oracle/scripts/capture_awr.sql
    </copy>
    ````
    ![](./images/upgrade_19c_10.png " ")

## **STEP 2**: Collect Statements from Cursor Cache

You can also collect statements directly from the Cursor Cache. This is more resource intense but helpful in case of OLTP applications. Be careful when you poll the cursor cache too frequently.

1. This procedure:
   - Creates a SQL Tuning Set (STS)
   - Populates the STS with SQL statements/information from the cursor cache
   - It will poll the cursor cache for 240 seconds every 10 seconds

2. The script is stored in /home/oracle/scripts:
        capture_cc.sql

    You used it already when you ran HammerDB in the earlier lab. Hence, no need to run it again. @/home/oracle/scripts/capture_cc.sql — don’t run it again!!!

3. The number of statements in SQL Tuning Set “STS_CaptureCursorCache” will be displayed. But now check, how many statements you’ve collected in each SQL Tuning Set.
    
    ````
    <copy>
    select name, owner, statement_count from dba_sqlset;
    </copy>
    ````
    ![](./images/sqlset.png " ")


## **STEP 3**: Optional - Export AWR

Especially when you migrate databases, exporting and preserving the AWR is important. When you upgrade, the AWR will stay in the database. This exercise is only done for protection but not necessary for the flow of the lab.

1. Export the AWR by running the sql stored in your Oracle home.

    ````
    <copy>
    @?/rdbms/admin/awrextr.sql
    </copy>
    ````
    ![](./images/upgrade_19c_11.png " ")

2. Hit **RETURN**.
    
    ![](./images/upgrade_19c_12.png " ")

3. Type: 2 and Hit **RETURN**.
   ![](./images/snapday2.png " ")

    ![](./images/snapid.png " ")

4. Type: 154 <= Your snapshot number may be different.  Hit RETURN.

    ![](./images/upgrade_19c_15.png " ")

5. Type: DATA\_PUMP\_DIR.  Hit RETURN

    ![](./images/upgrade_19c_16.png " ")
    Enter value for file_name:
    Hit **RETURN**
    ![](./images/upgrade_19c_17.png " ")
    This will take now a few minutes.

6. Exit from SQL*Plus.
    
    ````
    <copy>
    exit
    </copy>
    ````

You may now [proceed to the next lab](#next).

## Learn More

* [SQL Tuning Sets](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgsql/managing-sql-tuning-sets.html#GUID-DD136837-9921-4C73-ABB8-9F1DC22542C5)

## Acknowledgements
* **Author** - Mike Dietrich, Database Product Management
* **Contributors** -  Roy Swonger, Database Product Management
* **Last Updated By/Date** - Kay Malcolm, February 2021
