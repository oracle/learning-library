# AutoUpgrade

## Introduction
In this part of the Lab you will upgrade the UPGR database from Oracle 11.2.0.4 to Oracle 19c. You can find detailed steps including the output for a Multitenant upgrade [here](https://mikedietrichde.com/2018/06/18/upgrade-oracle-12-2-0-1-to-oracle-database-18c-on-premises/) for your information only in case you can’t complete the lab here.

You will use the AutoUpgrade and upgrade your UPGR database unattended.  The Oracle Database AutoUpgrade utility is a new tiny little command line tool which allows you to upgrade your databases in an unattended way. I call it the Hands-Free Upgrade. The new AutoUpgrade utility in Oracle 19c idea of the tool is to run the prechecks against multiple databases, fix 99% of the potential issues, set a restore point in case something goes wrong – and then upgrade your databases. And of course, do the postupgrade, recompilation and time zone adjustment.

The only thing you need to provide is a config file in text format.

Estimated Lab Time: n minutes


### About AutoUpgrade
The AutoUpgrade utility identifies issues before upgrades, performs pre- and postupgrade actions, deploys upgrades, performs postupgrade actions, and starts the upgraded Oracle Database.

The AutoUpgrade utility is designed to automate the upgrade process, both before starting upgrades, during upgrade deployments, and during postupgrade checks and configuration migration. You use AutoUpgrade after you have downloaded binaries for the new Oracle Database release, and set up new release Oracle homes. When you use AutoUpgrade, you can upgrade multiple Oracle Database deployments at the same time, using a single configuration file, customized as needed for each database deployment.

### Objectives
In this lab, you will:
* Prepare your environment
* Analyze
* Deploy

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
		- Lab: Initialize Environment

## **STEP 1**: Preparation

1.  The only task you’ll have to do when using the AutoUpgrade: You need to prepare a config file for the database(s).
2. The environment variable $OH19 is created only for your convenience. It points always to the Oracle 19c Home.

    ```
    <copy>
    . upgr
    cd /home/oracle/scripts
    java -jar $OH19/rdbms/admin/autoupgrade.jar -create_sample_file config
    </copy>
    ```
3. This tells you that the sample file has been created at:
   ![](./images/upgrade_19c_18.png " ")

4. Created sample configuration file /home/oracle/scripts/sample_config.cfg
   You will need to edit it – and then pass it to the AutoUpgrade utility.

5. Open the file /home/oracle/sample_config.cfg in your preferred editor (text or graph mode)

    ````
    Text mode:
    <copy>
    vi /home/oracle/scripts/sample_config.cfg
    </copy>
    ````
    ````
    Graphical mode:
    <copy>
    kwrite /home/oracle/scripts/sample_config.cfg &
    </copy>
    ````

6. Generated standard config.cfg 	Make the following adjustments:
   ````
    #Global configurations
    #Autoupgrade's global directory, ...
    #temp files created and other ...
    #send here
    global.autoupg_log_dir=/home/oracle/upg_logs

    #
    # Database number 1
    #
    upg1.dbname=UPGR
    upg1.start_time=NOW
    upg1.source_home=/u01/app/oracle/product/11.2.0.4
    upg1.target_home=/u01/app/oracle/product/19
    upg1.sid=UPGR
    upg1.log_dir=/home/oracle/logs
    upg1.upgrade_node=localhost
    upg1.target_version=19
    upg1.restoration=no

    ````
   ![](./images/upgrade_19c_19.png " ")
   ![](./images/upgrade_19c_20.png " ")

    <!-- ````
    # Global configurations
    #Autoupgrade's global directory, ...
    #temp files created and other ...
    #send here
    global.autoupg_log_dir=/default/...

    #
    # Database number 1
    #
    upg1.dbname=employee
    upg1.start_time=NOW
    upg1.source_home=/u01/...
    upg1.target_home=/u01/...
    upg1.sid=emp
    upg1.log_dir=/scratch/auto
    upg1.upgrade_node=hol1.localdomain
    upg1.target_version=19
    #upg1.run_utlrp=yes
    #upg1.timezone_upg=yes



    #Global configurations
    #Autoupgrade's global directory, ...
    #temp files created and other ...
    #send here
    global.autoupg_log_dir=/home/oracle/upg_logs

    #
    # Database number 1
    #
    upg1.dbname=UPGR
    upg1.start_time=NOW
    upg1.source_home=/u01/app/oracle/product/11.2.0.4
    upg1.target_home=/u01/app/oracle/product/19
    upg1.sid=UPGR
    upg1.log_dir=/home/oracle/logs
    upg1.upgrade_node=localhost
    upg1.target_version=19
    upg1.restoration=no

    ```` -->

7. Save the file and name it as UPGR.cfg in /home/oracle/scripts.  If you saved it under its original name, sample_config.cfg, rename it as shown below:

    ````
    <copy>
    mv /home/oracle/scripts/sample_config.cfg /home/oracle/scripts/UPGR.cfg
    </copy>
    ````
    ![](./images/upgrade_19c_21.png " ")

## **STEP 2**: ANALYZE Phase

1. It is best practice to run AutoUpgrade in analyze mode at first. Once the analyze phase is passed without issues, the database can be upgraded automatically (the below command is a one-line command!).

    ```
    <copy>
    . upgr
    java -jar $OH19/rdbms/admin/autoupgrade.jar -config /home/oracle/scripts/UPGR.cfg -mode analyze
    </copy>
    ````
    <!-- ````
    You will see this output:

    Autoupgrade tool launched with default options
    +--------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    1 databases will be analyzed
    Type 'help' to list console commands
    upg>
    ```` -->

    ![](./images/upgrade_19c_22.png " ")
<!-- 2. You can monitor the analyze phase in the upg> job console with:

    ````
    lsj

    status -job 100

    Shortly after, the console will reply:

    upg> Job 100 completed

    ------------------- Final Summary --------------------
    Number of databases            [ 1 ]

    Jobs finished successfully     [1]
    Jobs failed                    [0]
    Jobs pending                   [0]
    ------------- JOBS FINISHED SUCCESSFULLY -------------
    Job 100 FOR UPGR

    The database can be upgraded automatically.
    ```` -->

## **STEP 3**: Upgrade

1. When you initiate the upgrade with -mode deploy, the tool will repeat the analyze phase, but add the fixups, upgrade and postupgrade steps.

    ````
    <copy>
    java -jar $OH19/rdbms/admin/autoupgrade.jar -config /home/oracle/scripts/UPGR.cfg -mode deploy
    </copy>
    ````
    ![](./images/upgrade_19c_23.png " ")
<!-- 2. You will see this output:

    ````
    Autoupgrade tool launched with default options
    +--------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    1 databases will be processed
    Type 'help' to list console commands
    upg>
    ```` -->

3. At this point you can monitor the upgrade now – enlarge the xterm‘s width a bit to see no line wraps.  Type help on the upg> job console to see an overview of available commands.

    <!-- ````
    help

    upg> help
    exit                          // To close and exit
    help                          // Displays help
    lsj [(-r|-f|-p|-e) | -n ]     // list jobs by status up to n elements.
        -f Filter by finished jobs.
        -r Filter by running jobs.
        -e Filter by jobs with errors.
        -p Filter by jobs being prepared.
        -n  Display up to n jobs.
    lsr                           // Displays the restoration queue
    lsa                           // Displays the abort queue
    tasks                         // Displays the tasks running
    clear                         // Clears the terminal
    resume -job                   // Restarts a previous job that was running
    status [-job  [-long]]        // Lists all the jobs or a specific job
    restore -job                  // Restores the database to its state prior to the upgrade
    restore all_failed            // Restores all failed jobs to their previous states prior to the upgrade
    logs                          // Displays all the log locations
    abort -job                    // Aborts the specified job
    h[ist]                        // Displays the command line history
    /[]                           // Executes the command specified from the history. The default is the last command
    ```` -->

4. The most important commands are:
   
    lsj – this lists the job number and overview information about each active job.
    Please note that the job number has now changed for the -mode deploy run.

    ![](./images/upgrade_19c_27.png " ")

    <!-- ````
        lsj – this lists the job number and overview information about each active job.
        Please note that the job number has now changed for the -mode deploy run.

    lsj

    upg> lsj
    +----+-------+---------+---------+--------+--------------+--------+--------+-------------+
    |Job#|DB_NAME|    STAGE|OPERATION|  STATUS|    START_TIME|END_TIME| UPDATED|      MESSAGE|
    +----+-------+---------+---------+--------+--------------+--------+--------+-------------+
    | 101|   UPGR|PREFIXUPS|EXECUTING| RUNNING|19/10/17 23:15|     N/A|23:15:28|Remaining 3/3|
    +----+-------+---------+---------+--------+--------------+--------+--------+-------------+
    Total jobs 2

    status -job <number> – this gives you more information about a specific job.
    ```` -->

5. It displays you also where the log files are located.
    ![](./images/upgrade_19c_24.png " ")
    ![](./images/upgrade_19c_25.png " ")

    <!-- ````
        status -job 101

        upg> status -job 101
        Progress
        -----------------------------------
        Start time:      19/10/17 23:16
        Elapsed (min):   1
        End time:        N/A
        Last update:     2019-10-17T23:16:58.468
        Stage:           PREFIXUPS
        Operation:       EXECUTING
        Status:          RUNNING
        Pending stages:  6
        Stage summary:
            SETUP             <1 min
            PREUPGRADE        <1 min
            PRECHECKS         <1 min
            GRP               <1 min
            PREFIXUPS         <1 min (IN PROGRESS)

        Job Logs Locations
        -----------------------------------
        Logs Base:    /home/oracle/upg_logs/UPGR
        Job logs:     /home/oracle/upg_logs/UPGR/101
        Stage logs:   /home/oracle/upg_logs/UPGR/101/prefixups
        TimeZone:     /home/oracle/upg_logs/UPGR/temp

        Additional information
        -----------------------------------
        Details:
        +--------+----------------+-------+
        |DATABASE|           FIXUP| STATUS|
        +--------+----------------+-------+
        |    UPGR|DICTIONARY_STATS|STARTED|
        +--------+----------------+-------+

        Error Details:
        None
    ```` -->

6. logs – displays the logs folder
   ![](./images/upgrade_19c_26.png " ")

    <!-- ````
    logs

    Autoupgrade logs folder [/home/oracle/upg_logs/cfgtoollogs/upgrade/auto/config_files]
    logs folder [UPGR][/home/oracle/upg_logs/UPGR]
    ```` -->

7. Please open a second xterm tab and go to the logs folder.

    ````
    <copy>
    cd /home/oracle/logs/UPGR/
    </copy>
    ````

8. Explore the subdirectories, especially /home/oracle/upg_logs/UPGR/101 and below. Check the /home/oracle/upg_logs/UPGR/101/prechecks subdirectory. It contains an HTML file with the preupgrade check overview:

    ````
    cd prechecks
    firefox upgr_preupgrade.html &
    ````
9.  Check also the preupgrade.log within the same directory:

    ````
    more upgr_preupgrade.log
    ````

10. Now change the directoy and see whether the dbupgrade directory has been created. This usually takes up to 4 minutes until the prechecks and fixups have been completed. You will find the 4 upgrade worker’s logs in cd /home/oracle/upg_logs/UPGR/101/dbupgrade.These 4 subdirectories get created before dbupgrade:

    ````
    prechecks
    prefixups
    preupgrade
    drain
    ````

11. You can tail -f especially the main worker’s (ending with 0) log to display the upgrade progress.
    ````
    cd ../dbupgrade
    tail -f catupgrd*0.log
    ````

12. Interrupt the tail command with CTRL+C. Depending on the hardware, the upgrade will take about 25-35 minutes. You don’t have to wait but instead we will do some exercises now with the AutoUpgrade tool. The upgrade will take between 20-40 minutes to complete.
    
    ![](./images/upgrade_19c_28.png " ")

    ````
    <copy>
    exit
    </copy>
    ````
    

    Congratulations – you upgraded the UPGR database successfully from Oracle 11.2.0.4 to Oracle 19c.

    ````
    <copy>
    sudo su - oracle
    . upgr19
    cd /home/oracle/scripts
    sqlplus / as sysdba
   </copy>
    ````
    ![](./images/upgrade_19c_29.png " ")


You may now [proceed to the next lab](#next).

## Learn More

* [MOS Note: 2485457.1 Auto Upgrade Tool](https://support.oracle.com/epmos/faces/DocumentDisplay?id=2485457.1)
* [Using AutoUpgrade for Oracle Database Upgrades](https://docs.oracle.com/en/database/oracle/oracle-database/19/upgrd/using-autoupgrade-oracle-database-upgrades.html#GUID-71883C8C-7A34-4E93-8955-040CB04F2109)
* [AutoUpgrade Blog](https://mikedietrichde.com/2019/04/29/the-new-autoupgrade-utility-in-oracle-19c/)

## Acknowledgements
* **Author** - Mike Dietrich, Database Product Management
* **Contributors** -  Roy Swonger, Database Product Management
* **Last Updated By/Date** - Kay Malcolm, February 2021
