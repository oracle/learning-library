# Real-time Migration with Oracle Goldengate Replication

## Introduction

Data Replication is a essential part of your efforts and tasks when you are migrating your Oracle databases. While data migration can be acheived in many ways, there are fewer options when downtime tolerance is low and live, trickle feed replication may be the only way. Oracle Cloud Infrastructure Marketplace provides a goldengate microservice that can easily be setup for logical data replication between a variety of databases. In this hands-on lab we will setup goldengate to replicate data from a 12.2 Oracle database comparable to an 'on-prem' source database to an ExaCS  database in OCI. This approach is recommended while migrating most production or business critical application to ExaCS .

### Why Golden Gate?

* Oracle Golden Gate is an enterprise grade tool which can provide near real time data replication from one database to another.
* Oracle GoldenGate offers a real-time, log-based change data capture (CDC) and replication software platform to meet the needs of today’s transaction-driven applications. It provides capture, routing, transformation, and delivery of transactional data across heterogeneous environments in real time can be achieved using Golden Gate.
* Oracle GoldenGate only captures and moves committed database transactions to insure that transactional integrity is maintained at all times. The application carefully ensures the integrity of data as it is moved from the source database or messaging system, and is applied to any number of target databases or messaging systems

* There are three components to this lab. The **source database** that you are planning to migrate to ExaCS, the **target ExaCS database** in OCI and an instance of **Oracle Goldengate** server with access to both source and target databases.

* The source database can be any Oracle database version 11.2.0.4 or higher with atleast one application schema that you wish to replicate to an ExaCS database in OCI. For the purpose of this lab, you may provision a 12.2.0.1 DBCS instance in your compartment in OCI and configure it as source.

* *Note: You cannot complete this lab without setting up access to your ExaCS instance.*

* The Golden Gate software is going to be deployed on a linux server in a public network which has access to both the source database and the target database via the Goldengate marketplace image in OCI.

* Let us understand the architecture of the setup we have here:
    * We have a source database on a VM on OCI(DBCS) which will act as an on-premise database.
    * We have a target database on an exadata cloud service VM on OCI.
    * We have a Goldengate instance with access to both the source database and target database.

![](./images/gg_arch.png " ")

Estimated Lab Time (with existing source database): 60 minutes.

Estimated Lab Time (with DBCS creation): 90 minutes.

### Objectives

* Setup real time data replication from on-premise database to ExaCS database instance.

### Prerequisites

* Access to an Oracle Cloud Infrastructure tenancy.
* Access to an Oracle 12c database configured as source database.
* An Exadata Cloud Service (ExaCS) as target database.
* Access to ExaCS network via jump server or VPN.
* VNC Viewer or other suitable VNC client on your laptop.

## **STEP 1:** Provision a Goldengate Microservice from OCI Marketplace

1. Connect to your OCI tenancy and select **Marketplace** from top left menu. Browse for **Oracle Goldengate 19c for Oracle**. You may set a filter on Type on the left. Select **Stack** from the dropdown and the image should be easier to find. The image is a terraform orchestration that deploys Goldengate on a compute image along with required resources.

2. Click on image and choose your compartment to deploy the goldengate instance. For eg. as a workshop user with assigned compartment userX-Compartment, pick userX-Compartment from the drop down.

3. Launch Stack and provide details as described. Name: Any descriptive name or you could leave default

4. Hit Next, rest of the items are filled in or optional

5. Enter the following network setting. This is essentially to select the network you wish to deploy your goldengate image.

    ![](./images/network1.png " ")

6. Hit next. For instance details pick and AD with sufficient compute capacity. **Note this deployment needs a minimum 2 ocpu instance**. Make sure you check the 'public IP' checkbox. We will use this later to ssh into the instance and also connect to the Goldengate admin console.

    ![](./images/network2.png " ")

7. Next, under **Create OGG deployments** choose your source and target deployment names and versions. Note that you may select one or two deployments (the second deployment is optional). This simply tell Goldengate admin server the location of relevant artifacts for source and target DB connections.

8. In this lab we choose a single deployment called Databases. Therefore, under **Deployment 1 -Name**, type **Databases** and leave Deployment 2- Name blank. We keep this simple by using a single deployment folder for both source and target configurations.

    ![](./images/source-target.png " ")

9. Next, paste your public key and hit **Create**

10. Your Goldengate instance should be ready in a few mins and we will come back to configure it.

## **STEP 2:** Configure the Source Database

It is assumed that you either have an Oracle 12c database configured as source or know how to provision a 12c DBCS instance in OCI

[This Medium blog provides step by step directions to deploying a DBCS instance in OCI](https://medium.com/@fathi.ria/oracle-database-on-oci-cloud-ee144b86648c)

The source database requires a Common (CDB) user that has DBA privileges over all PDBs in that database.

Lets also assume that the schema we wish to replicate with Goldengate is the 'appschema' in PDB1. So for a freshly provisioned DBCS instance as source, we create the common user and application schema as follows

1. Connect as sys to your source DB and execute the following SQL commands

    ```
    <copy>
    create user C##user01 identified by WElcome_123#;
    grant connect, resource, dba to c##user01;
    alter database add supplemental log data;
    exec dbms_goldengate_auth.grant_admin_privilege('C##user01', container=>'all');
    alter system set ENABLE_GOLDENGATE_REPLICATION=true scope=both;
    </copy>
    ```

2. Check if Goldengate replication is enabled,

    ```
    <copy>
    show parameter ENABLE_GOLDENGATE_REPLICATION;
    </copy>
    ```

3. This should return **True**

    ![](./images/GGConfigSourceCDB.png " ")

4. Next, lets create a schema user to replicated called **appschema** in PDB1 and add a table to it. A sample 'Comments' table is provided here. You may add one or more table of your choice to the appschema.

5. Next, we need to create a golden gate user and grant the necessary previliges. *Note : Please make sure you replace pdb_name with your database's pdb name in the below code.*

    ```
    <copy>
    alter session set container=pdb_name;
    create user appschema identified by WElcome_123# default tablespace users;
    grant connect, resource, dba to appschema;
    CREATE TABLE appschema.COMMENTS
       (  "COMMENT_ID" NUMBER(10,0),
      "ITEM_ID" NUMBER(10,0),
      "COMMENT_BY" NUMBER(10,0),
      "COMMENT_CREATE_DATE" DATE DEFAULT sysdate,
      "COMMENT_TEXT" VARCHAR2(500)
       ) ;
    alter user appschema quota unlimited on users;
    </copy>
    ```

    ![](./images/GGConfigSourcePDB.png " ")

6. The source database is all set. Next, lets setup the target ExaCS instance.

## **STEP 3:** Configure the Target ExaCS  Database

1. Connect to the ExaCS database instance you created earlier as user **sys** as sysdba. *Note: You will need to be VPN'd into the network or VNC to a jump server.*

2. First, lets create the a common user in ExaCS and grant the necessary previliges.

    ```
    <copy>
    create user C##user01 identified by WElcome_123#;
    grant connect, resource, dba to c##user01;
    alter database add supplemental log data;
    exec dbms_goldengate_auth.grant_admin_privilege('C##user01', container=>'all');
    alter system set ENABLE_GOLDENGATE_REPLICATION=true scope=both;
    show parameter ENABLE_GOLDENGATE_REPLICATION;
    </copy>
    ```

    ![](./images/GGConfigExaCDB.png " ")

4. Next we create an 'appschema' user similar to source and create the same set of tables as source. Also, we will create a goldengate admin user and grant necessary previliges to that user. *Note : Please make sure you replace pdb_name with your database's pdb name in the below code.*

    ```
    <copy>
    alter session set container = pdb_name
    create user appschema identified by WElcome_123# default tablespace users;
    grant connect, resource to appschema;
    alter user appschema quota unlimited on users;
    CREATE TABLE appschema.COMMENTS
       (  "COMMENT_ID" NUMBER(10,0),
      "ITEM_ID" NUMBER(10,0),
      "COMMENT_BY" NUMBER(10,0),
      "COMMENT_CREATE_DATE" DATE DEFAULT sysdate,
      "COMMENT_TEXT" VARCHAR2(500)
       ) ;
    </copy>
    ```

    ![](./images/GGConfigExaPDB.png " ")

5. That is it! Your target DB is now ready.

## **STEP 4:** Configure Goldengate Service

1. By now, your Goldengate service instance must be deployed. On your OCI console navigate to **Compute** from top left menu and **choose your compartment**

2. Click on your Goldengate compute instance to get to the details page that looks as follows.

    ![](./images/ggcompute.png " ")

3. Note down the public IP address of your instance. We will use this IP to ssh into the virtual machine.

4. Before we launch the Goldengate admin console and start configuring the service, we need to provide connection information for both source and target databases.

5. Therefore, **gather your source and target database connection TNS entries for both the common user and the appschema user. Remember, the CDB and PDB run different services, therefore the TNS entries differ.**

6. A tns entry is typically found in your database's tnsnames.ora file and looks like this.

    mySourceDB=(DESCRIPTION=(CONNECT\_TIMEOUT=120)(RETRY\_COUNT=20)(RETRY\_DELAY=3)(TRANSPORT\_CONNECT\_TIMEOUT=3)(ADDRESS\_LIST=(LOAD\_BALANCE=on)(ADDRESS=(PROTOCOL=TCP)(HOST=129.30.xxx.xxx)(PORT=1521)))(CONNECT\_DATA=(SERVICE\_NAME=pdb1.ExaCS.oraclecloud.com)))

    **This file needs to go into the folder /u02/deployments/\<Deployment Name\>/etc**

7. Remember the deployment name 'Databases' provided while provisioning the goldengate image? That is what it does. By providing just one deployment, we can configure both source and target DB entries in one place for simplicity.

8. Edit the sqlnet.ora file and update the WALLET_LOCATION parameter to point to the wallet folder

    ```
    <copy>
    WALLET_LOCATION = (SOURCE=(METHOD=FILE)(METHOD_DATA=(DIRECTORY="/u02/deployments/Databases/etc")))
    </copy>
    ```

9. Next we edit the tnsnames.ora file and add entries for the source common user, source appschema user, target common user and the target appschema user. This single tnsnames.ora will serve to connect to both source and target.

10. Open tnsnames.ora in vi and add TNS connection entries as shown in the example screen shot below. Note the TNS entries for the source and target DB.

    ![](./images/tns-entries.png " ")

11. Also, rarely you might have to replace the hostname of the source db with the IP address to circumvent the dns resolution issue. *Note: All IP addresses in the lab guide are scrubbed for security purposes. None of the instances in the screenshots are accessible using the information provided*

12. We are now ready to access the goldengate admin console and configure our extract and replicat processes.

13. The credentials to access the admin console are provided in a file called ogg-credentials.json in the home folder /home/opc

14. Open the file and save the credentials on a notepad.

    ```
    <copy>
    $ cd
    $ cat ogg-credentials.json
    {"username": "oggadmin", "credential": "E-kqQH8.MPA0u0.g"}
    </copy>
    ```

15. Next we logon to the Goldengate admin console using credentials above.

16. Open a browser and navigate to https://<ip\_address\_of\_goldengate\_image\>

17. If you have browser issues or get Unicode warning, try using Firefox browser. Fixing browser issues is beyond scope for this lab guide.

    ![](./images/ogg1.png " ")

18. Once logged on, click on the port # for Admin server to get into configurtion mode as shown below

    ![](./images/ogg2.png " ")

19. If prompted, login with the same credentials one more time.

20. From the top left hamberger menu, select 'Configuration' as shown below -

    ![](./images/ogg3.png " ")

21. Here we configure connectivity to our source and target databases. We will setup 4 connections - The Source DB common user, Source DB appschema user, Target DB common user and Target DB appschema user.

22. Use the screenshot below as a guide -

    ![](./images/creds1.png " ")

23. Add the first credential for appschema you created earlier in the lab in the source DB.

    ![](./images/AddCred2.png " ")

24. Note the userid format is userid@connectString. The connect string is how it knows which database to connect to. It looks for this connect string in /u02/deployments/Databases/etc/tnsnames.ora

25. Submit credentials and test connectivity as shown in screenshot below

    ![](./images/creds3.png " ")

26. Similarly, add credentials for source DB c##user01, target ExaCS c##user01 schema and target ExaCS appschema schema as shown below.

    ![](./images/AllCredGG.png " ")

27. Make sure you test connectivity for each credential.

28. Next, we create checkpoint tables in source and target databases. Checkpoint tables keep track of changes in the database. We need one in the appschema in each database i.e source and target.

29. Lets start with appschema in source. Connect to the pdb on the source database and click + sign beside the Checkpoint section heading to add a checkpoint table as shown below

    ![](./images/chkpt1.png " ")

    ![](./images/chkpt2.png " ")

30. We also specify the schema we want to replicate here. In the Transaction Information section below checkpoint, add the schema first by clicking the + sign and hit Submit.

    ![](./images/chkpt3.png " ")

31. Now when you enter the schema name and search for it, it shows up as shown below with 3 tables. 2 checkpoint tables and one 'comments' table we created earlier.

    ![](./images/chkpt4.png " ")

32. Next, we add a checkpoint table to the target instance and also set the heartbeat.

33. Connect to the target DB from the goldengate admin console just like you did for the source DB. Lets also add a checkpoint table here.

    ![](./images/ChkpointtabExa.png " ")

    ![](./images/ChkpointtabExa2.png " ")

34. Scroll down and set the hearbeat for target. Use default configuration for the purpose of this lab

    ![](./images/heartbeat.png " ")

35. As a final step, we now create an 'extract' and a 'replicat' process to conduct the replication from source to target.

36. Navigate back to the Goldengate Admin server dashboard so you can see both the extract and replicat setup as shown below

    ![](./images/extract1.png " ")

37. Choose **Integrated Extract** on the next screen and hit next.

    ![](./images/ExtConf1.png " ")

38. Entries on the following screen may be entered as follows,

    ![](./images/ExtConf2.png " ")

    Process Name: Provide any name of choice

    Credential Domain: Pick OracleGoldenGate from drop down

    Credential Alias:  Pick the common user alias for source DB. In this lab we created cdb_source alias

    Trail Name: Any 2 character name

39. Scroll down and click in the text box Register to PDBs. PDB1 should popup as shown

    ![](./images/ExtConf3.png " ")

40. If you do not see Register to PDBs text box, make sure you have picked the 'Common User' alias and provided all mandatory entries. Click next. As a final step, add this entry at the end of your parameter file as shown below.

    ```
    <copy>
    extract source
    useridalias cdb_source domain OracleGoldenGate
    exttrail et
    table pdb1.appschema.*;
    </copy>
    ```

    ![](./images/ParamExt.png " ")

41. This tells Goldengate to capture changes on all tables in pdb1.appschema. Hit 'Create and Run'. If all goes well you should now see the extract running on source.

42. Next, we configure a replicat on the target. On the same screen hit the **+** sign on the **Replicats** side to start configuring one.

    ![](./images/RepConf0.png " ")

43. Pick **Integrated Replicat**

    ![](./images/RepConf1.png " ")

44. Fill out the mandatory items in **Basic Information** on the next screen as follows. You may leave the rest at default values.

    **Process Name:**  Target

    **Credential Domain:**  Oracle Goldengate from drop down

    **Credential Alias:** pdb1_target (or the alias name you provided for appschema user on your ExaCS instance)

    **Trail Name:** et (or any 2 character name)

    **Checkpoint Table:** The checkpoint table you configured for appschema user should show up in the drop down

45. Hit **Next**

    ![](./images/RepConf2.png " ")

    ![](./images/RepConf3.png " ")

46. On the last and final screen (phew!) edit the parameter file to REPLACE the line mapping the source and target schemas as show below. Note: Pls remove the original line MAP *.*, TARGET *.*;

    ```
    <copy>
    replicat target
    useridalias pdb1_target domain OracleGoldenGate
    MAP <pdb_name>.appschema.*, TARGET <pdb_name>.appschema.*;
    </copy>
    ```

    ![](./images/paramRep.png " ")

47. Hit **Create and Run**. If all goes well, you should now see both extract and replicat processes running on the dashboard.

    ![](./images/GGExtRepSuccess.png " ")

48. Hurray! You have completed the replication setup. To test, simply connect to your source database, insert and commit some rows. Then check your corresponding target table and in a few secs you should see the data appear. A sample Insert script for the Comments table is provided below.

    ```
    <copy>
    Insert into appschema.COMMENTS (COMMENT_ID,ITEM_ID,COMMENT_BY,COMMENT_CREATE_DATE,COMMENT_TEXT) values (7,4,4,to_date('06-JUL-15','DD-MON-RR'),'Im putting an offer. Can you meet me at the apple store this evening?');
    commit;
    </copy>
    ```

    ![](./images/AddRowsSource.png " ")

    ![](./images/VerifyTarget.png " ")

You may proceed to the next lab.

## Learn More

For more information on Oracle Goldengate, see the following link: [Goldengate Documentation](http://www.oracle.com/us/products/middleware/data-integration/oracle-goldengate-realtime-access-2031152.pdf)

## Acknowledgements

- **Author** - Tejus Subrahmanya, Phani Turlapati, Abdul Rafae, Sathis Muniyasamy, Sravya Ganugapati, Padma Natarajan, Aubrey Patsika, Jacob Harless
- **Last Updated By/Date** - Jess Rein - Cloud Engineer, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
