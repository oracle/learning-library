# SQL Plan Management

## Introduction

In the previous section you did find slow SQL statements with the SQL Performance Analyzer. Now we can use SQL Plan Management to fix the plans. The question is: Is this always necessary and useful?

The SQL Performance Analyzer reports showed overall good results for the run in Oracle 19c.

But still you could now try to fix a specific plan which has been changed. Or just write down all plans from the SQL Tuning Set into the SQL Plan Baseline in Oracle 19c. Lets see if the result is good. Or if it may be better to allow the optimizer to find newer paths.

![](./images/sql-plan-mgmt.png " ")

In this exercise we use scripts written by Carlos Sierra.

Estimated Lab Time: n minutes

### About SQL Plan Management
SQL plan management is a preventative mechanism that enables the optimizer to automatically manage execution plans, ensuring that the database uses only known or verified plans.

SQL plan management uses a mechanism called a SQL plan baseline, which is a set of accepted plans that the optimizer is allowed to use for a SQL statement.

In this context, a plan includes all plan-related information (for example, SQL plan identifier, set of hints, bind values, and optimizer environment) that the optimizer needs to reproduce an execution plan. The baseline is implemented as a set of plan rows and the outlines required to reproduce the plan. An outline is a set of optimizer hints used to force a specific plan.

The main components of SQL plan management are as follows:

Plan capture
- This component stores relevant information about plans for a set of SQL statements.

Plan selection
- This component is the detection by the optimizer of plan changes based on stored plan history, and the use of SQL plan baselines to select appropriate plans to avoid potential performance regressions.

Plan evolution
- This component is the process of adding new plans to existing SQL plan baselines, either manually or automatically. In the typical use case, the database accepts a plan into the plan baseline only after verifying that the plan performs well.


### Objectives

In this lab, you will:
* Fix A Single Statement
* Fix All Statements

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
		- Lab: Initialize Environment

## **STEP 1**: Fix A Single Statement

1. Run the statements below.
      ````
      <copy>
      . upgr19
      cd /home/oracle/scripts
      sqlplus / as sysdba
      </copy>
      ````
      ![](./images/fix_a_1.png " ")

2. Here we’ll use one of Carlos Sierra’s scripts: spb_create.sql:

      ````
      <copy>
      @/home/oracle/scripts/spb_create.sql
      </copy>
      ````
      ![](./images/fix_a_2.png " ")

3. The script asks you for the SQL_ID first.  Type in: **7m5h0wf6stq0q**.  Then it will display the potential plans:
      ![](./images/fix_a_3.png " ")
      ![](./images/fix_a_4.png " ")

    <!-- ````
      PLANS PERFORMANCE
      ~~~~~~~~~~~~~~~~~

            Plan ET Avg      ET Avg      CPU Avg     CPU Avg           BG Avg       BG Avg     Rows Avg     Rows Avg       Executions       Executions                                   ET 100th    ET 99th     ET 97th     ET 95th     CPU 100th   CPU 99th    CPU 97th    CPU 95th
      Hash Value AWR (ms)    MEM (ms)    AWR (ms)    MEM (ms)             AWR          MEM          AWR          MEM              AWR              MEM   MIN Cost   MAX Cost  NL  HJ  MJ Pctl (ms)   Pctl (ms)   Pctl (ms)   Pctl (ms)   Pctl (ms)   Pctl (ms)   Pctl (ms)   Pctl (ms)
      ----------- ----------- ----------- ----------- ----------- ------------ ------------ ------------ ------------ ---------------- ---------------- ---------- ---------- --- --- --- ----------- ----------- ----------- ----------- ----------- ----------- ----------- -----------
      3642382161       1.914                   1.241                      254                     1.000                        21,302                         244        244   0   0   0       1.914       1.914       1.914       1.914       1.241       1.241       1.241       1.241
      1075826057       3.839                   2.040                      254                     1.000                        21,555                         248        248   0   0   0       3.960       3.960       3.960       3.960       2.091       2.091       2.091       2.091

      The first plan is the better plan – found after upgrade. We will fix it now by accepting it as THE plan we’d like to be used for future executions of statement with SQL_ID: 7m5h0wf6stq0q

      Select up to 3 plans:
      1st Plan Hash Value (req): 3642382161
      2nd Plan Hash Value (opt): 1075826057
      ```` -->

4. Hit RETURN, RETURN and again RETURN.  Verify if the plans have been accepted:

      ````
      <copy>
      SELECT sql_handle, plan_name, enabled, accepted FROM dba_sql_plan_baselines;
      </copy>
      ````
      ![](./images/fix_a_6.png " ")

      <!-- SQL_HANDLE                     PLAN_NAME                      ENA ACC
      —————————— —————————— — —
      SQL_59a879455619c567           SQL_PLAN_5ma3t8pb1mjb766511f85 YES YES

      ```` -->
If you like to dig deeper “Why this plan has changed?”, Franck Pachot has done an excellent showcase on the basis of the lab to find out what exact optimizer setting has caused this plan change.

## **STEP 2**: Fix all statements

Now we pin down all possible statements collected in the SQL Tuning Set STS_CaptureCursorCache – and verify with SQL Performance Analyzer again the effect.

1. Use spm_load_all.sql:

      ````
      <copy>
      @/home/oracle/scripts/spm_load_all.sql
      </copy>
      ````
      ![](./images/fix_a_7.png " ")

2. Check what has happened:

      ````
      <copy>
      SELECT sql_handle, plan_name, enabled, accepted FROM dba_sql_plan_baselines;
      </copy>
      ````
      ![](./images/fix_a_8.png " ")

      <!-- SQL_HANDLE           PLAN_NAME                      ENA ACC
      ——————– —————————— — —
      SQL_0c79b6d2c87ca446 SQL_PLAN_0sydqub47t926ee6188f4 YES YES
      SQL_1465e6eba9245647 SQL_PLAN_18tg6xfnk8pk7f4091add YES YES
      SQL_1d3eb12408a63da1 SQL_PLAN_1ugpj4h4acgd12e067175 YES YES
      SQL_2469648692a7cf75 SQL_PLAN_28ub4hu9agmvp341d91fc YES YES
      SQL_248d6d8dbf8dc7a0 SQL_PLAN_293bdjqzsvjx06e1fb41e YES YES
      SQL_2f304ba11a91bba2 SQL_PLAN_2yc2bn4d93fx23efd80e4 YES YES
      SQL_3276f16ef07d6f11 SQL_PLAN_34xrjdvs7uvsj872680f9 YES YES
      SQL_356b057a1f6de0db SQL_PLAN_3aus5g8gqvs6vdda5da8a YES YES
      SQL_3f06a4b1f7e2279b SQL_PLAN_3y1p4q7vy49wva9df0a29 YES YES
      SQL_46bd0ca6de6f98d0 SQL_PLAN_4dg8cnvg6z66h341d91fc YES YES
      SQL_4719eac4b4e7caec SQL_PLAN_4f6gaskufgkrc341d91fc YES YES
      SQL_48be4eb9876ae7d4 SQL_PLAN_4jgkfr63qptynb5a27b1c YES YES
      SQL_59a879455619c567 SQL_PLAN_5ma3t8pb1mjb745221865 YES YES
      SQL_59a879455619c567 SQL_PLAN_5ma3t8pb1mjb766511f85 YES YES
      SQL_683745e98d7cb1f6 SQL_PLAN_6hdu5x66rtcgqb77b2865 YES YES
      SQL_6b4e05515d733fb5 SQL_PLAN_6qmh5a5fr6gxp3d347ecd YES YES
      SQL_7eee136bc66cdb19 SQL_PLAN_7xvhmdg36tqst3f568acb YES YES
      SQL_87d3a723fbe4eab5 SQL_PLAN_8gnx74gxy9upp872680f9 YES YES
      SQL_922be39ed0f149cd SQL_PLAN_94az3mv8g2kfd4036fd75 YES YES
      SQL_945ea9d5e1ba14fa SQL_PLAN_98rp9urhvn57uad9ddf9f YES YES
      SQL_98685f091b440961 SQL_PLAN_9hu2z14dn82b13f568acb YES YES
      SQL_9ade74d66fd8cd75 SQL_PLAN_9prmnutrxjmbp4036fd75 YES YES
      SQL_a4621efe3a403847 SQL_PLAN_a8shyzsx40f273e83d5c2 YES YES
      SQL_cba8d9b390654cbf SQL_PLAN_cra6tqf86am5z452bbf3f YES YES
      SQL_cbeeaa37269264a6 SQL_PLAN_crvpa6wm94t56702cc8e9 YES YES
      SQL_e6de372a14bff12f SQL_PLAN_fdrjr58abzw9g95d362e3 YES YES
      SQL_eb19550280bd4f5d SQL_PLAN_fq6ap0a0bumux198236ef YES YES
      SQL_f59c951fdf367160 SQL_PLAN_gb74p3zgmcwb0872680f9 YES YES
      SQL_f7db40080b18fe6a SQL_PLAN_ggqu0105jjzma6d5a2ea5 YES YES
      SQL_fc5efaa8ffabe508 SQL_PLAN_gsrrup3zurt88e90e4d55 YES YES
      ```` -->

3. You ACCEPTED all previous plans from before the upgrade and added them to the SQL Plan Baseline.  Once you “fixed” the plans, use the SQL Performance Analyzer to verify the plans and the performance.

      ````
      <copy>
      @/home/oracle/scripts/spa_cpu.sql
      @/home/oracle/scripts/spa_report_cpu.sql
      </copy>
      ````
      ````
      <copy>
      @/home/oracle/scripts/spa_elapsed.sql
      @/home/oracle/scripts/spa_report_elapsed.sql
      </copy>
      ````

4. Compare the two resulting reports again – and compare them to the two examples from the previous run.
      ![](./images/sql_per_5.png " ")

      Do you recognize that fixing all statements resulted in worse CPU_TIME compared to 11.2.0.4 – the initial run in 19c was better!
      This is one of the reasons why you should test your plans instead of just “fixing them to behave as before”.

      What is the outcome?
      Allow the new release to find new, sometimes better plans. Even though your most critical statements should be stable at first, you should allow changes to benefit from better performance.

      The idea of testing is that you identify the really bad statements and plans, and fix them. But not all of them.


      Carlos Sierra: Plan Stability

You may now [proceed to the next lab](#next).

## Learn More

MOS Note: 789888.1
How to Load SQL Plans into SQL Plan Management (SPM) from the Automatic Workload Repository (AWR)

MOS Note: 456518.1
How to Use SQL Plan Management (SPM) – Plan Stability Worked Example

White Paper:
SQL Plan Management with Oracle Database 12c Release 2

## Acknowledgements
* **Author** - Mike Dietrich, Carlos Sierra
* **Contributors** -  Roy Swonger, Sanjay Rupprel, Cristian Speranta
* **Last Updated By/Date** - Kay Malcolm, February 2021
