# Future LAB: Setup of GoldenGate Microservices - Adminclient

## Introduction

Since we’ve already done multiple labs, this one will take what we used so far to script this using DB container reset scripts, SQL scripts to setup AutoCDR in the database, OGGCA silent deployment scripts and GG REST API scripts to do a rapid deployment.

**Bi-Directional Replication, AutoCDR, Rapid Deployment and Intro to the Admin Client**

## Objectives

Using the GoldenGate Microservices Adminclient, you can perform tasks to manage different deployments using RestfulAPIs from a Windows or Linux environment.

- Rapid Deployment using:
  - OGGCA silent deployment scripts (remove and recreate deployments).
  - REST API to setup bi-directional GoldenGate replication between two databases.
  - SQL Scripts to setup up auto conflict detection and resolution in the database.

### Lab Architecture

![](./images/ggmicroservicesarchitecture.png " ")

*Estimated Lab Time*: - 60 mins

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

In this lab we will setup GoldenGate Microservices


## **STEP 1:** Recreate Deployments Using Adminclient

 Open a terminal session

![](./images/terminal3.png " ")

    ````
    <copy>sudo su - oracle</copy>
    ````



## Required Artifacts

VNC Client for the deployment

Browser to check the deployment

Swingbench to apply transactions

### **STEP 1**: Run a script to perform a rapid deployment.

1. Open up a terminal window and change directory to Lab6 and Review script build_all_bi_di.sh.

                [oracle@OGG181DB183 ~]$ cd ~/OGG181_WHKSHP/Lab6
```
<copy>cd ~/OGG181_WHKSHP/Lab6</copy>
```

                [oracle@OGG181DB183 Lab6]$ cat build_all_bi_di.sh 
```
<copy>cat build_all_bi_di.sh </copy>
```


2. This script performs the following:

Drops the existing container databases.

Clones two container databases from a base container.

Deletes the two deployments (Atlanta and SanFran).  This will remove any current lab setups.

Creates the two deployments again.

Creates new credentials for both deployments.

Adds Schema supplemental logging to both container databases for the SOE schema.

Adds checkpoint tables on both container databases.

Adds the Extract, Distribution Path and Replicat for both deployments.  This includes the correct 
parameters for the Extract and Replicats.

3. Run the **build_all_bi_di.sh** script

                [oracle@OGG181DB183 Lab6]$ ./build_all_bi_di.sh 
```
<copy>./build_all_bi_di.sh </copy>
```
While it's running note the messages displayed that informs what has been added to the services.You should see the below message to be sure that all the steps are completed.

![](images/600/Lab600_image6001.PNG) 
![](images/600/Lab600_image6002.PNG) 


### **STEP 2**: Check the deployment using the AdminClient

This step will be a short introduction to the AdminClient.  If you’re familiar with Classic GoldenGate, this would be like using GGSCI.  However, the advantage with the AdminClient is that you can connect to separate GG deployments from this one interface.  With GGSCI you would need to execute it in each server environment where GG is installed.  
In this step we will use the AdminClient to check the deployment instead of the web interface.

1. Change directory to OGG_HOME/bin

                [oracle@OGG181DB183 Lab6]$ cd $OGG_HOME/bin
```
                <copy>cd $OGG_HOME/bin</copy>
```
                [oracle@OGG181DB183 bin]$ pwd
                /opt/app/oracle/product/18.1.0_RC2/bin
```
                <copy>pwd</copy>
```

2. Run adminclient

                [oracle@OGG181DB183 bin]$ ./adminclient 
```
<copy>./adminclient </copy>
```

                Oracle GoldenGate Administration Client for Oracle
                Version 18.1.0.0.0 OGGCORE_18.1.0.0.0_PLATFORMS_180928.0432

                Copyright (C) 1995, 2018, Oracle and/or its affiliates. All rights reserved.

                Linux, x64, 64bit (optimized) on Sep 28 2018 16:57:51
                Operating system character set identified as UTF-8.

                OGG (not connected) 1>

3. Use connect command

                OGG (not connected) 1> connect http://<your ip>:16000 as oggadmin password Welcome1
```
<copy>connect http://<your ip>:16000 as oggadmin password Welcome1</copy>
```

                ERROR: Deployment name must be specified
                Available deployments are:
                Atlanta
                SanFran

You’ll see an error that you have to specify the deployment name and it will give you a list of deployments.

4. Connect again using the deployment name of Atlanta.

                OGG (not connected) 2> connect http://<your ip>:16000 deployment Atlanta as oggadmin password Welcome1
```
<copy>connect http://<your ip>:16000 deployment Atlanta as oggadmin password Welcome1</copy>
```

                OGG (http://<your ip>:16000 Atlanta)
```
<copy>OGG (http://<your ip>:16000 Atlanta)</copy>
```

5. Type in **“help”**.  You can scroll up and down the list.  For classic GG users you’ll see some familiar commands.

                OGG (http://<your ip>:16000 Atlanta) 
```
<copy>OGG (http://<your ip>:16000 Atlanta) </copy>
```

           

                Admin Client Command Summary:
```
<copy>!</copy>
```
                **!** - Executes the previous command without modifications.

                **ADD AUTORESTART**            - Create an autorestart rule.
                
                **ADD CHECKPOINTTABLE**      
                 Creates a checkpoint table in a database.
                
                **ADD CREDENTIALSTORE**
                (Deprecated) Creates a credentials store (wallet) that stores encrypted database user credentials.
                
                **VIEW PARAMS**
                Displays the contents of a parameter file in read-only mode on-screen.
                
                **VIEW REPORT**
                Displays the process report that is generated by Extract or Replicat.

                OGG (http://<your ip>:16000 Atlanta) 
```
<copy>OGG (http://<your ip>:16000 Atlanta)</copy>
```



6. Type in **“info all”**. You’ll see the services for the Atlanta deployment we added and their status and the replication processes and their status.

                OGG (http://localhost:16000 Atlanta) 4> info all
                Program     Status      Group       Lag at Chkpt  Time Since Chkpt

                ADMINSRVR   RUNNING   
                DISTSRVR    RUNNING   
                PMSRVR      RUNNING   
                RECVSRVR    RUNNING   
                EXTRACT     STOPPED     EXTSOE1     00:00:00      00:13:01    
                REPLICAT    STOPPED     IREP1       00:00:00      00:12:28    

7. Type in **"set debug on"**

                OGG (http://localhost:16000 Atlanta) 5> set debug on
                Command 5 succeeded: 'set debug on'

8. Type in "info all" again.  This time you'll see the JSON generated that you can use for the REST API.

                OGG (http://localhost:16000 Atlanta) 6> info all
                --------------------------------------------------------------------------------
                > GET /services/v2/deployments/Atlanta/services
                < Status 200
                {
                "$schema" : "api:standardResponse",
                "links" : [
                {
                        "href" : "http://localhost:16000/services/v2/deployments/Atlanta/services",
                        "mediaType" : "application/json",
                        "rel" : "canonical"
                .
                .
                .
                "messages" : [],
                "response" : {
                "$schema" : "ogg:replicatStatus",
                "lag" : 0,
                "lastStarted" : null,
                "position" : {
                        "name" : "ba",
                        "offset" : 0,
                        "path" : "/opt/app/oracle/gg_deployments/Atlanta/var/lib/data/",
                        "sequence" : 0
                },
                "sinceLagReported" : 865,
                "status" : "stopped"
                }
                }
                --------------------------------------------------------------------------------
                REPLICAT    STOPPED     IREP1       00:00:00      00:14:25    
                Command 6 succeeded: 'info all'

                OGG (http://localhost:16000 Atlanta) 7> 

9. Type in **"set debug off"**

                OGG (http://<your IP>:16000 Atlanta)
```
<copy>OGG (http://<your IP>:16000 Atlanta) </copy>
```
         7> set debug off

10.  Let’s type in a command that isn’t in classic GG.  Type in **“health deployment Atlanta”**.  You’ll get more info on the services than just the info all command gives.

                OGG (http://<your IP>:16000 Atlanta) 
```
<copy>OGG (http://<your IP>:16000 Atlanta) </copy>
```                
                
                27> health deployment Atlanta
```
<copy>health deployment Atlanta</copy>
```

                Deployment: Atlanta
                Service: adminsrvr
                Status: running
                Started: 2019-02-07T22:17:21.925Z
                Health: OK
                Resources: Name                              Type        Status      Health
                        --------------------------------  ----------  ----------  ------

                Deployment: Atlanta
                Service: distsrvr
                Status: running
                Started: 2019-02-07T22:17:22.026Z
                Health: OK
                Resources: Name                              Type        Status      Health
                        --------------------------------  ----------  ----------  ------

                Deployment: Atlanta
                Service: recvsrvr
                Status: running
                Started: 2019-02-07T22:17:21.920Z
                Health: OK
                Resources: Name                              Type        Status      Health
                        --------------------------------  ----------  ----------  ------

11.  Connect to the SanFran deployment to do a quick check on the status.  You can type in **"history"** to get a list of the previous commands.

```
<copy>history</copy>
```

12.  The connect to the Atlanta deployment is there so you can check the syntax.  Enter the same command and change **"Atlanta"** to **"SanFran"**

                OGG (http://<your IP>:16000 Atlanta) 
```
<copy>OGG (http://<your IP>:16000 Atlanta </copy>
```

                28> history
                
                connect http://<your IP>:16000 as oggadmin password Welcome1
                
```
<copy>connect http://<your IP>:16000 as oggadmin password Welcome1</copy>
```
                connect http://<your IP>:16000 deployment Atlanta as oggadmin password Welcome1
```
<copy>connect http://<your IP>:16000 deployment Atlanta as oggadmin password Welcome1</copy>
```

                OGG (http://<your IP>:16000 Atlanta) 
```
<copy>OGG (http://<your IP>:16000 Atlanta) </copy>
```
                
                connect http://<your IP>:16000 deployment SanFran as oggadmin password Welcome1
```
<copy>connect http://<your IP>:16000 deployment SanFran as oggadmin password Welcome1
</copy>
```
                OGG (http://<your IP>:16000 SanFran)
```
<copy>OGG (http://<your IP>:16000 SanFran) </copy>
```

13.  Type in **“info all”**.  You’ll see the services for the SanFran deployment we added and their status and the replication processes and their status.

                OGG (http://<your IP>:16000 SanFran) 
```
<copy>OGG (http://<your IP>:16000 SanFran)</copy>
```
                30> info all
```
<copy>info all</copy>
```
                Program     Status      Group       Lag at Chkpt  Time Since Chkpt

                ADMINSRVR   RUNNING   
                DISTSRVR    RUNNING   
                PMSRVR      RUNNING   
                RECVSRVR    RUNNING   
                EXTRACT     STOPPED     EXTSOE2     00:00:00      00:23:02    
                REPLICAT    STOPPED     IREP2       00:00:00      00:22:29    

- Exit the AdminClient by typing in **"exit"**.

                OGG (http://<your IP>:16000 SanFran) 
```
<copy>OGG (http://<your IP>:16000 SanFran)</copy>
```            
                exit
                [oracle@OGG181DB183 bin]$ 

                You may now *proceed to the next lab*

## Learn More

* [GoldenGate Microservices](https://docs.oracle.com/en/middleware/goldengate/core/19.1/understanding/getting-started-oracle-goldengate.html#GUID-F317FD3B-5078-47BA-A4EC-8A138C36BD59)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration, November 2020
* **Contributors** - Zia Khan
* **Last Updated By/Date** - Brian Elliott, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.