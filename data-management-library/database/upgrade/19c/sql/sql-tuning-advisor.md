# SQL Tuning Advisor

## Introduction

In the previous section you fixed plans with SQL Plan Management. But lets see what else could be done and ask the SQL Tuning Advisor (STA).

![](./images/sql-tuning-advisor.png " ")

You’ll pass the SQL Tuning Set from the “Load” exercise where you captured the HammerDB workload directly from Cursor Cache to the SQL Tuning Advisor and check the results.
Analyze the SQL Tuning Set and generate recommendations

A complete script is provided: sta_cc.sql.  

Estimated Lab Time: n minutes

### About SQL Tuning Advisor
SQL Tuning Advisor is SQL diagnostic software in the Oracle Database Tuning Pack.

You can submit one or more SQL statements as input to the advisor and receive advice or recommendations for how to tune the statements, along with a rationale and expected benefit.

### Objectives
In this lab, you will:
* Generate a tuning task with the SQL Tuning Set STS_CaptureCursorCache
* Run a tuning task where the SQL Tuning Advisor simulates the execution
* Generate a result report in TEXT format
* Generate statements to implement the findings

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
		- Lab: Initialize Environment

## **STEP 1**: Generate a Tuning Task

1. Execute the script
   
    ````
    <copy>
    . upgr19
    cd /home/oracle/scripts
    sqlplus / as sysdba
    </copy>
    ````
    ![](./images/sql_tun_1.png " ")

    ````
    <copy>
    @/home/oracle/scripts/sta_cc.sql
    </copy>
    ````


2. It will take 30 seconds – check the output by scrolling up.  At first, the findings, here I display just the first two findings for a COUNT statement on the CUSTOMER table:
    ![](./images/sql_tun_2.png " ")
    ![](./images/sql_tun_3.png " ")

  You see that the SQL Tuning Advisor interacts with SQL Plan Management from the previous exercise as well.

  When you scroll to the end, you will find the implementation section:
    ![](./images/sql_tun_4.png " ")

  
3. First of all, remove the duplicate recommendations (you won’t need 3 identical indexes with different names on TPCC.CUSTOMER for sure) marked in BLUE.  Fix everything.  This is an exercise. Please don’t do this in a real environment without proper verification. But let us implement all the recommendations and see what happens.  Execute all the recommendations from the Advisor.
      ![](./images/sql_tun_5.png " ")


4. Wait a bit until all statements have been executed. Afterwards repeat the SQL Performance Analyzer runs from the previous exersize and verify the results:
    ````
    <copy>
    @/home/oracle/scripts/spa_cpu.sql
    @/home/oracle/scripts/spa_report_cpu.sql
    </copy>
    ````
    ![](./images/sql_tun_6.png " ")
    ````
    <copy>
    @/home/oracle/scripts/spa_elapsed.sql
    @/home/oracle/scripts/spa_report_elapsed.sql
    </copy>
    ````
    ![](./images/sql_tun_7.png " ")
    ````
    <copy>
    exit
    </copy>
    ````

5. Compare the two resulting reports again – and compare them to the examples from the previous run.

    ````
    <copy>
    cd /home/oracle/scripts
    firefox compare_spa_* &
    </copy>
    ````
    ![](./images/sql_per_5.png " ")

    It should look similar to the ones below. More isn’t always better 😉 Be careful just implementing recommendations. Test and verify them step by step.

You may now [proceed to the next lab](#next).

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [SQL Tuning Advisor](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgsql/sql-tuning-advisor.html#GUID-8E1A39CB-A491-4254-8B31-9B1DF7B52AA1)

## Acknowledgements
* **Author** - Mike Dietrich, Carlos Sierra
* **Contributors** -  Roy Swonger, Sanjay Rupprel, Cristian Speranta
* **Last Updated By/Date** - Kay Malcolm, February 2021
