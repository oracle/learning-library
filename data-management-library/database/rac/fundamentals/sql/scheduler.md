# Oracle Scheduler

## Introduction

This lab walks you through the operation of Oracle Scheduler in a RAC database

Estimated Lab Time: 20 Minutes

### Prerequisites
- An Oracle LiveLabs or Paid Oracle Cloud account
- Lab: Generate SSH Key
- Lab: Build a DB System
- Lab: Fast Application Notification
- Lab: Install Sample Schema
- Lab: Services

### About Oracle Scheduler
Oracle Scheduler is an enterprise job scheduler designed to help you simplify the scheduling of hundreds or even thousands of tasks. Oracle Scheduler (the Scheduler) is implemented by the procedures and functions in the DBMS_SCHEDULER PL/SQL package.

The Scheduler enables you to control when and where various computing tasks take place in the enterprise environment. The Scheduler helps you effectively manage and plan these tasks. By ensuring that many routine computing tasks occur without manual intervention, you can lower operating costs, implement more reliable routines, minimize human error, and shorten the time windows needed.

The Scheduler provides sophisticated, flexible enterprise scheduling functionality, which you can use to:
* Run database program units
* Run external executables, (executables that are external to the database)
* Schedule job execution using the following methods:
   - Time-based scheduling
   - Event-based scheduling
   - Dependency scheduling
* Prioritize jobs based on business requirements.
* Manage and Monitor jobs
* Operate in a clustered environment

In a RAC database, PL/SQL can execute on any instance - and this must be taken into account when processes are architected. In an Oracle Real Application Clusters environment, the Scheduler uses one job table for each database and one job coordinator for each instance.

The job coordinators communicate with each other to keep information current. The Scheduler attempts to balance the load of the jobs of a job class across all available instances when the job class has no service affinity, or across the instances assigned to a particular service when the job class does have service affinity.

We will take a brief look at this property through two simple tests.

## **STEP 1:**  Assign a Job Class to a service and prepare a package to be scheduled
1.  If you aren't already logged in to the Oracle Cloud, open up a web browser and re-login to Oracle Cloud. If you are logged in, skip to step 4.

2.  Start Cloud Shell

    *Note:* You can also use Putty or MAC Cygwin if you chose those formats in the earlier lab.  
    ![](../clusterware/images/start-cloudshell.png " ")

3.  Connect to node 1 as the *opc* user (you identified the IP address of node 1 in the Build DB System lab).

    ````
    ssh -i ~/.ssh/sshkeyname opc@<<Node 1 Public IP Address>>
    ````
    ![](../clusterware/images/racnode1-login.png " ")

4. Confirm which instance is offering the service **svctest**.  Execute the following on **node 1** as the *oracle* user.  Remember to replace the database name with the database name you have been using in previous labs.

    ````
    <copy>
    sudo su - oracle
    srvctl status service -d aTFdbVm_replacename -s svctest
    </copy>
    ````
    ![](./images/job-num4.png " " )

5.  Stop the service **svctest**

    ````
    <copy>
    srvctl stop service -d aTFdbVm_replacename -s svctest
    srvctl stop service -d aTFdbVm_replacename -s svctest
    </copy>
    ````
    ![](./images/job-num5.png " " )

6.  Connect to the pluggable database, **PDB1** as the SH user.  Replace the password with the password you chose.

    ````
    <copy>
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    </copy>
    ````
    ![](./images/job-num6.png " " )

7. As the SH user create a job class and a PL/SQL procedure that we can execute from the job. Note that the service name is case sensitive

    ````
    <copy>
    exec dbms_scheduler.create_job_class('TESTOFF1',service=>'svctest');

    create or replace procedure traceme(id varchar2) as x number;
    begin
       execute immediate 'alter session set tracefile_identifier='||id;
       dbms_session.session_trace_enable(true,true);
	     select count(*) into x from sh.customers;
	     dbms_session.session_trace_disable();
    end traceme;
    /
    </copy>
    ````
    ![](./images/job-num7.png " " )


## **STEP 2:** Schedule a job

1. Schedule the job to run immediately with the job class that's tied to the **svctest** service. From your sqlplus session connected to PDB1

    ````
    <copy>
    select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs;

     begin
        dbms_scheduler.create_job('TESTJOB1','PLSQL_BLOCK', job_action=>'begin traceme(''scheduler01''); end;', job_class=>'TESTOFF1',enabled=>true);
     end;
     /

    select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs;  
    </copy>
    ````

    ![](./images/job-step2-num1.png " " )

2. If you query user\_scheduler\_jobs several times, does anything change?

    ````
    select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs;
    exit;
    ````
    ![](./images/job-step2-num2.png " " )

3. Start the **svctest** service and query user\_scheduler\_jobs again as the *oracle* user    

    ````
    <copy>
    srvctl start service -d aTFdbVm_replacename -s svctest
    </copy>
    ````
    Did the job run?
    You may have to query user\_scheduler\_jobs several times.

    ![](./images/job-step2-num3.png " " )

4. Job details are also visible in the view user\_scheduler\_job\_run\_details as the *sh* user.

    ````
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    <copy>
    SELECT to_char(log_date, 'DD-MON-YY HH24:MI:SS') TIMESTAMP, job_name, status, additional_info
    FROM user_scheduler_job_run_details ORDER BY log_date;
    </copy>
    ````
    ![](./images/job-step2-num4.png " " )



5. What node did the job run on?
Look in the diagnostic_dest for files with the **id** set in the job schedule. The **id** will be in UPPERCASE

6. On node1, for example, execute the following command.  Remember to replace the database name.

    ````
    ls -altr /u01/app/oracle/diag/rdbms/atfdbvm_replacename/aTFdbVm1/trace/*SCHEDULER01*
    ````
    ![](./images/job-step2-num6.png " " )

## **STEP 3:** Submitting work to a uniform service
1. Modify the service **svctest** to run on both instances, and then stop this service

    ````
    <copy>
    srvctl modify service -d  aTFdbVm_replacename -s svctest -modifyconfig -preferred aTFdbVm1,aTFdbVm2
    srvctl stop service -d  aTFdbVm_replacename -s svctest
    </copy>
    ````
    ![](./images/job-step3-num1.png " " )

2. Submit multiple jobs to the job class as the *sh* user.  Remember to replace the password.


    ````
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    <copy>
    begin
      for i in 1..10
        loop
          dbms_scheduler.create_job('TESTJOB'||i,'PLSQL_BLOCK', job_action=>'begin traceme(''scheduler01''); end;', job_class=>'TESTOFF1',enabled=>true);
        end loop;
    end;
       /
    ````
    ![](./images/job-step3-num2.png " " )

3. View that they are scheduled by issuing the query below.

    ```
    col job_name format a15
    col job_class format a15
    select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs order by job_name;
    exit
    ```
    ![](./images/job-step3-num3.png " " )

4. Re-start the **svctest** service again (which will now run on both instances) and view where the jobs executed:

    ````
    srvctl start service -d  aTFdbVm_replacename -s svctest
    srvctl status service -d  aTFdbVm_replacename -s svctest

    ````

5. The view user_scheduler_job_run_details includes the instance name on which the job executed.  Relogin as the *sh* user on **node 1**

    ````
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    <copy>
    SELECT to_char(log_date, 'DD-MON-YY HH24:MI:SS') TIMESTAMP, job_name, status, instance_id, additional_info
    FROM user_scheduler_job_run_details ORDER BY log_date;    
    exit
    </copy>
    ````
    ![](./images/job-step3-num3-1.png " " )
    ![](./images/job-step3-num3-2.png " " )

6. For example
    ````
    TIMESTAMP                   JOB_NAME        INSTANCE_ID ADDITIONAL_INFO
    --------------------------- --------------- ----------- --------------------------------------------------
    28-AUG-20 03:17:01          TESTJOB2                  1
    28-AUG-20 03:17:01          TESTJOB4                  1
    28-AUG-20 03:17:01          TESTJOB1                  2
    28-AUG-20 03:17:01          TESTJOB3                  2
    28-AUG-20 03:17:01          TESTJOB6                  1
    28-AUG-20 03:17:01          TESTJOB8                  1
    28-AUG-20 03:17:02          TESTJOB10                 1
    28-AUG-20 03:17:02          TESTJOB5                  2
    28-AUG-20 03:17:02          TESTJOB7                  2
    28-AUG-20 03:17:02          TESTJOB9                  2
    ````    
    Trace files will exist in the trace directory of each node:

7. On node 1 for as the oracle user query the trace files for ACTION NAME.

    ````
    <copy>
    grep "ACTION NAME" `ls /u01/app/oracle/diag/rdbms/atfdbvm_replacename/aTFdbVm1/trace/*SCHEDULER*.trc`
    </copy>
    ````

8. Could show for example

    ![](./images/job-step3-num7.png " " )


You may now *proceed to the next lab*.  

## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** - Kay Malcolm
* **Last Updated By/Date** - Kay Malcolm, October 2020
