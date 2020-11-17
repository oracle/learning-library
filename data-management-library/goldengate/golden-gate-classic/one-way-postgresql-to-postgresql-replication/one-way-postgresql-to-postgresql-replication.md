# UniDirectional replication between PostgreSQL and PostgreSQL

## Introduction
This lab will show you how to setup an ***UniDirectional replication between PostgreSQL to PostgreSQL***.

*Estimated Lab Time*: 30 minutes


### Objectives
-   UniDirectional replication between PostgreSQL to PostgreSQL
-   Connect to compute instance

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup

### Environment details 

- GoldenGate for PostgreSQL
- PostgreSQL database V12
- GoldenGate Software location : /u01/software/postgres
- GOldenGate Home : /u01/ggpost/

## **STEP 1**: ODBC configuration

In this step you will add the databse connection details to communicate with source and target database.

From the terminal ,move to the ***GOldenGate Home*** directory and create a file called  ***odbc.ini***:

```
<copy>
cd /u01/ggpost/
vi odbc.ini 
</copy>
```
Copy paste the below text in ***odbc.ini***.

``` 
<copy>
[ODBC Data Sources]
sourcedsn=DataDirect 7.1 PostgreSQL Wire Protocol
targetdsn=DataDirect 7.1 PostgreSQL Wire Protocol

[ODBC]
IANAAppCodePage=4
InstallDir=/u01/ggpost

[sourcedsn]
Driver=/u01/ggpost/lib/GGpsql25.so
Description=DataDirect 7.1 PostgreSQL Wire Protocol
Database=source
HostName=localhost
PortNumber=5432
LogonID=ggadmin
Password=Madhu_123


[targetdsn]
Driver=/u01/ggpost/lib/GGpsql25.so
Description=DataDirect 7.1 PostgreSQL Wire Protocol
Database=target
HostName=localhost
PortNumber=5432
LogonID=ggadmin
Password=Madhu_123
</copy>
```

Save the text using ***wq!***


	
## **STEP 2**: Extract configuration

1. Enter into ***ggsci*** command prompt from the terminal

Oracle GoldenGate Software Command Interface (GGSCI) is the command interface between users and Oracle GoldenGate functional components.

```
 -bash-4.2$ <copy>./ggsci</copy>

Oracle GoldenGate Command Interpreter for PostgreSQL
Version 19.1.0.0.200714 OGGCORE_19.1.0.0.0OGGBP_PLATFORMS_200628.2141
Linux, x64, 64bit (optimized), PostgreSQL on Jun 29 2020 03:59:15
Operating system character set identified as UTF-8.

Copyright (C) 1995, 2019, Oracle and/or its affiliates. All rights reserved.


GGSCI (ogg-classic) 1>
```
2. Extract parameter creation

Opens a extract **E_POST** parameter file for editing in the default text editor.

```

GGSCI (ogg-classic) 1> <copy>edit params E_POST</copy>

```


3. Append the below lines

Copy the below content and update in the extract **E_POST** parameter file
```
<copy>EXTRACT E_POST
SOURCEDB sourcedsn USERID ggadmin, PASSWORD Madhu_123
EXTTRAIL ./dirdat/pa
TABLE public.*;</copy>
```
4. View the param file

Displays the contents of a **E_POST** parameter file in read-only mode on-screen.
```
GGSCI (ogg-classic) 2> <copy>view params E_POST</copy>

EXTRACT E_POST
SOURCEDB sourcedsn USERID ggadmin, PASSWORD Madhu_123
EXTTRAIL ./dirdat/pa
TABLE public.*;

```
5. Extract Registration

Login the source database to register the Extract group E_POST
```
GGSCI (ogg-classic) 3><copy> DBLOGIN SOURCEDB sourcedsn USERID ggadmin, PASSWORD Madhu_123</copy>

2020-08-20 12:37:20  INFO    OGG-03036  Database character set identified as UTF-8. Locale: en_US.UTF-8.

2020-08-20 12:37:20  INFO    OGG-03037  Session character set identified as UTF-8.
Successfully logged into database.

```

6. Registering the Extract for PostgreSQL

Register the Extract group E_POST with the database using the REGISTER EXTRACT command. This will create a replication slot. Make sure not to add the Extract before it is registered with the database.

```
GGSCI (ogg-classic as ggadmin@sourcedsn) 4> <copy>REGISTER EXTRACT E_POST</copy>

2020-08-20 12:38:16  INFO    OGG-25355  Successfully created replication slot 'e_post_f21eb07bf475178e' for Extract group E_POST 'E_POST' in database 'dvdrental'.

```

7. Enabling Supplemental Logging

Enable supplemental logging for the user tables to be captured from PostgreSQL.
```

GGSCI (ogg-classic as ggadmin@sourcedsn) 4> <copy>ADD TRANDATAT public.* </copy>

2020-08-20 12:38:16  INFO    Logging of supplemental log data is enabled for table public.actor with REPLICA IDENTITY set to DEFAULT

```
8. Extract creation

Add the Extract to the Oracle GoldenGate installation.

```

GGSCI (ogg-classic as ggadmin@sourcedsn) 5> <copy>ADD EXTRACT E_POST, TRANLOG, BEGIN NOW</copy>
EXTRACT added.
```
9. Add extract trail file 

Use ADD EXTTRAIL to create a trail for online processing on the local system and Associate it with an Extract group E_POST.

```

GGSCI (ogg-classic as ggadmin@sourcedsn) 6> <copy>ADD EXTTRAIL ./dirdat/pa, EXTRACT E_POST</copy>
EXTTRAIL added.

```
10. Start Extract

To start Extract from GGSCI, issue the following command.

```
GGSCI (ogg-classic as ggadmin@sourcedsn) 8> <copy>start E_POST</copy>

Sending START request to MANAGER ...
EXTRACT E_POST starting

```
11. Status of the Extact

Display the status  for Extract group E_POST
```
GGSCI (ogg-classic as ggadmin@sourcedsn) 10><copy> info E_POST</copy>

EXTRACT    E_POST    Last Started 2020-08-20 12:38   Status RUNNING
Checkpoint Lag       00:00:23 (updated 00:00:10 ago)
Process ID           16472
VAM Read Checkpoint  2020-08-20 12:38:26.694734

Replication Slot     e_post_f21eb07bf475178e is active with PID 16480 in database dvdrental
Slot Restart LSN     0/245BAF8
Slot Flush LSN       0/245BB30
Current Log Position 0/245BB30


GGSCI (ogg-classic as ggadmin@sourcedsn) 11>

```

## **STEP 3**: Replication configuration

1. Edit Replicat parameter

Opens a extract **R_POST** parameter file for editing in the default text editor.

```
GGSCI (ogg-classic) 1>  <copy>EDIT PARAMS R_POST</copy>

```
2. Appended the below lines to R_POST


Copy the below content and update in the extract **R_POST** parameter file
```
<copy>REPLICAT R_POST
TARGETDB targetdsn USERID ggadmin, PASSWORD Madhu_123
MAP *.*, TARGET *.*;
</copy>
```
3. Login the target database

login to target database for the creating the replicat process

```

GGSCI (ogg-classic) 2> <copy>dblogin SOURCEDB  targetdsn USERID ggadmin, PASSWORD Madhu_123</copy>

2020-08-20 12:46:36  INFO    OGG-03036  Database character set identified as UTF-8. Locale: en_US.UTF-8.

2020-08-20 12:46:36  INFO    OGG-03037  Session character set identified as UTF-8.
Successfully logged into database.
```

4. Add checkpoint table

ADD CHECKPOINTTABLE to create a checkpoint table in the target database. Replicat uses the table to maintain a record of its read position in the trail for recovery purposes.

```
GGSCI (ogg-classic as ggadmin@targetdsn) 3>  <copy>add checkpointtable public.ggchk</copy>

Successfully created checkpoint table public.ggchk.

```
5. Add replicat process

ADD REPLICAT creates an online process group that creates checkpoints so that processing continuity is maintained from run to run.
```
GGSCI (ogg-classic as ggadmin@targetdsn) 4> <copy>ADD REPLICAT R_POST, EXTTRAIL ./dirdat/pa, CHECKPOINTTABLE public.ggchk</copy>
REPLICAT added.
```


6. Start Replicat

To start REPLICAT from GGSCI, issue the following command.

```
GGSCI (ogg-classic as ggadmin@targetdsn) 6> <copy>start REPLICAT R_POST</copy>

Sending START request to MANAGER ...
REPLICAT R_POST starting
```

7. Status of the replicat


Display the status  for REPLICAT  group R_POST

```
GGSCI (ogg-classic as ggadmin@targetdsn) 6> <copy>info R_POST</copy>

REPLICAT   R_POST    Last Started 2020-08-20 12:47   Status RUNNING
Checkpoint Lag       00:00:00 (updated 00:00:08 ago)
Process ID           17328
Log Read Checkpoint  File ./dirdat/pa000000000
                     First Record  RBA 0


GGSCI (ogg-classic as ggadmin@targetdsn) 7> 

```

## **STEP 4**: Execuating  DML statments against source database


1. DML Operation :

 Execute the command against the source database

```
<copy>psql postgres -h 127.0.0.1 -d source -f /var/lib/pgsql/gen_data.sql</copy>
```
***Output :***
```
-bash-4.2$ psql postgres -h 127.0.0.1 -d source -f /var/lib/pgsql/gen_data.sql
You are now connected to database "source" as user "postgres".
TRUNCATE TABLE
You are now connected to database "target" as user "postgres".
TRUNCATE TABLE
 region_id | region_name
-----------+-------------
(0 rows)

INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
 region_id |      region_name
-----------+------------------------
         1 | Europe
         2 | Americas
         3 | Asia
         4 | Middle East and Africa
(4 rows)

UPDATE 1
UPDATE 1
 region_id |      region_name
-----------+------------------------
         3 | Asia
         4 | Middle East and Africa
         1 | CHANGE1
         2 | CHANGE2
(4 rows)

DELETE 1
DELETE 1
You are now connected to database "source" as user "postgres".
 region_id | region_name
-----------+-------------
(0 rows)



```
2. Stats output 

Display statistics  of the both extract and replicat 

```
-bash-4.2$ <copy>ggpost</copy>

Oracle GoldenGate Command Interpreter for PostgreSQL
Version 19.1.0.0.200714 OGGCORE_19.1.0.0.0OGGBP_PLATFORMS_200628.2141
Linux, x64, 64bit (optimized), PostgreSQL on Jun 29 2020 03:59:15
Operating system character set identified as UTF-8.

Copyright (C) 1995, 2019, Oracle and/or its affiliates. All rights reserved.



GGSCI (ogg-classic) 1><copy> stats *
</copy>

Sending STATS request to EXTRACT E_POST ...

Start of Statistics at 2020-11-08 15:48:56.

Output to ./dirdat/pa:

Extracting from public.regions to public.regions:

*** Total statistics since 2020-11-08 15:47:43 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Daily statistics since 2020-11-08 15:47:43 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Hourly statistics since 2020-11-08 15:47:43 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Latest statistics since 2020-11-08 15:47:43 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

End of Statistics.

Sending STATS request to REPLICAT R_POST ...

Start of Statistics at 2020-11-08 15:48:57.

Replicating from public.regions to public.regions:

*** Total statistics since 2020-11-08 15:48:44 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Daily statistics since 2020-11-08 15:48:44 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Hourly statistics since 2020-11-08 15:48:44 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Latest statistics since 2020-11-08 15:48:44 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

End of Statistics.


GGSCI (ogg-classic) 2>
```

You have reached *End of the lab*

## Learn More

* [GoldenGate](https://www.oracle.com/middleware/data-integration/goldengate/")


## Acknowledgements
* **Author** -Madhu Kumar S, Data Integration Team, Oracle, November 2020
* **Contributors** - Brian Elliott,Meghana Banka
* **Last Updated By/Date** - Madhu Kumar S, November 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.
If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.





=======
# UniDirectional replication between PostgreSQL to PostgreSQL

## Introduction
This lab will show you how to setup an ***UniDirectional replication between PostgreSQL to PostgreSQL***.

*Estimated Lab Time*: 30 minutes


### Objectives
-   UniDirectional replication between PostgreSQL to PostgreSQL
-   Connect to compute instance

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup

### Environment details 

- GoldenGate for PostgreSQL
- PostgreSQL database V12
- GoldenGate Software location : /u01/software/postgres
- GOldenGate Home : /u01/ggpost/

## **STEP 1**: ODBC configuration

In this step you will add the databse connection details to communicate with source and target database.

From the terminal ,move to the ***GOldenGate Home*** directory and create a file called  ***odbc.ini***:

```
<copy>
cd /u01/ggpost/
vi odbc.ini 
</copy>
```
Copy paste the below text in ***odbc.ini***.

``` 
<copy>
[ODBC Data Sources]
sourcedsn=DataDirect 7.1 PostgreSQL Wire Protocol
targetdsn=DataDirect 7.1 PostgreSQL Wire Protocol

[ODBC]
IANAAppCodePage=4
InstallDir=/u01/ggpost

[sourcedsn]
Driver=/u01/ggpost/lib/GGpsql25.so
Description=DataDirect 7.1 PostgreSQL Wire Protocol
Database=source
HostName=localhost
PortNumber=5432
LogonID=ggadmin
Password=Madhu_123


[targetdsn]
Driver=/u01/ggpost/lib/GGpsql25.so
Description=DataDirect 7.1 PostgreSQL Wire Protocol
Database=target
HostName=localhost
PortNumber=5432
LogonID=ggadmin
Password=Madhu_123
</copy>
```

Save the text using ***wq!***


	
## **STEP 2**: Extract configuration

1. Enter into ***ggsci*** command prompt from the terminal

Oracle GoldenGate Software Command Interface (GGSCI) is the command interface between users and Oracle GoldenGate functional components.

```
 -bash-4.2$ <copy>./ggsci</copy>

Oracle GoldenGate Command Interpreter for PostgreSQL
Version 19.1.0.0.200714 OGGCORE_19.1.0.0.0OGGBP_PLATFORMS_200628.2141
Linux, x64, 64bit (optimized), PostgreSQL on Jun 29 2020 03:59:15
Operating system character set identified as UTF-8.

Copyright (C) 1995, 2019, Oracle and/or its affiliates. All rights reserved.


GGSCI (ogg-classic) 1>
```
2. Extract parameter creation

Opens a extract **E_POST** parameter file for editing in the default text editor.

```

GGSCI (ogg-classic) 1> <copy>edit params E_POST</copy>

```


3. Append the below lines

Copy the below content and update in the extract **E_POST** parameter file
```
<copy>EXTRACT E_POST
SOURCEDB sourcedsn USERID ggadmin, PASSWORD Madhu_123
EXTTRAIL ./dirdat/pa
TABLE public.*;</copy>
```
4. View the param file

Displays the contents of a **E_POST** parameter file in read-only mode on-screen.
```
GGSCI (ogg-classic) 2> <copy>view params E_POST</copy>

EXTRACT E_POST
SOURCEDB sourcedsn USERID ggadmin, PASSWORD Madhu_123
EXTTRAIL ./dirdat/pa
TABLE public.*;

```
5. Extract Registration

Login the source database to register the Extract group E_POST
```
GGSCI (ogg-classic) 3><copy> DBLOGIN SOURCEDB sourcedsn USERID ggadmin, PASSWORD Madhu_123</copy>

2020-08-20 12:37:20  INFO    OGG-03036  Database character set identified as UTF-8. Locale: en_US.UTF-8.

2020-08-20 12:37:20  INFO    OGG-03037  Session character set identified as UTF-8.
Successfully logged into database.

```

6. Registering the Extract for PostgreSQL

Register the Extract group E_POST with the database using the REGISTER EXTRACT command. This will create a replication slot. Make sure not to add the Extract before it is registered with the database.

```
GGSCI (ogg-classic as ggadmin@sourcedsn) 4> <copy>REGISTER EXTRACT E_POST</copy>

2020-08-20 12:38:16  INFO    OGG-25355  Successfully created replication slot 'e_post_f21eb07bf475178e' for Extract group E_POST 'E_POST' in database 'dvdrental'.

```

7. Enabling Supplemental Logging

Enable supplemental logging for the user tables to be captured from PostgreSQL.
```

GGSCI (ogg-classic as ggadmin@sourcedsn) 4> <copy>ADD TRANDATAT public.* </copy>

2020-08-20 12:38:16  INFO    Logging of supplemental log data is enabled for table public.actor with REPLICA IDENTITY set to DEFAULT

```
8. Extract creation

Add the Extract to the Oracle GoldenGate installation.

```

GGSCI (ogg-classic as ggadmin@sourcedsn) 5> <copy>ADD EXTRACT E_POST, TRANLOG, BEGIN NOW</copy>
EXTRACT added.
```
9. Add extract trail file 

Use ADD EXTTRAIL to create a trail for online processing on the local system and Associate it with an Extract group E_POST.

```

GGSCI (ogg-classic as ggadmin@sourcedsn) 6> <copy>ADD EXTTRAIL ./dirdat/pa, EXTRACT E_POST</copy>
EXTTRAIL added.

```
10. Start Extract

To start Extract from GGSCI, issue the following command.

```
GGSCI (ogg-classic as ggadmin@sourcedsn) 8> <copy>start E_POST</copy>

Sending START request to MANAGER ...
EXTRACT E_POST starting

```
11. Status of the Extact

Display the status  for Extract group E_POST
```
GGSCI (ogg-classic as ggadmin@sourcedsn) 10><copy> info E_POST</copy>

EXTRACT    E_POST    Last Started 2020-08-20 12:38   Status RUNNING
Checkpoint Lag       00:00:23 (updated 00:00:10 ago)
Process ID           16472
VAM Read Checkpoint  2020-08-20 12:38:26.694734

Replication Slot     e_post_f21eb07bf475178e is active with PID 16480 in database dvdrental
Slot Restart LSN     0/245BAF8
Slot Flush LSN       0/245BB30
Current Log Position 0/245BB30


GGSCI (ogg-classic as ggadmin@sourcedsn) 11>

```

## **STEP 3**: Replication configuration

1. Edit Replicat parameter

Opens a extract **R_POST** parameter file for editing in the default text editor.

```
GGSCI (ogg-classic) 1>  <copy>EDIT PARAMS R_POST</copy>

```
2. Appended the below lines to R_POST


Copy the below content and update in the extract **R_POST** parameter file
```
<copy>REPLICAT R_POST
TARGETDB targetdsn USERID ggadmin, PASSWORD Madhu_123
MAP *.*, TARGET *.*;
</copy>
```
3. Login the target database

login to target database for the creating the replicat process

```

GGSCI (ogg-classic) 2> <copy>dblogin SOURCEDB  targetdsn USERID ggadmin, PASSWORD Madhu_123</copy>

2020-08-20 12:46:36  INFO    OGG-03036  Database character set identified as UTF-8. Locale: en_US.UTF-8.

2020-08-20 12:46:36  INFO    OGG-03037  Session character set identified as UTF-8.
Successfully logged into database.
```

4. Add checkpoint table

ADD CHECKPOINTTABLE to create a checkpoint table in the target database. Replicat uses the table to maintain a record of its read position in the trail for recovery purposes.

```
GGSCI (ogg-classic as ggadmin@targetdsn) 3>  <copy>add checkpointtable public.ggchk</copy>

Successfully created checkpoint table public.ggchk.

```
5. Add replicat process

ADD REPLICAT creates an online process group that creates checkpoints so that processing continuity is maintained from run to run.
```
GGSCI (ogg-classic as ggadmin@targetdsn) 4> <copy>ADD REPLICAT R_POST, EXTTRAIL ./dirdat/pa, CHECKPOINTTABLE public.ggchk</copy>
REPLICAT added.
```


6. Start Replicat

To start REPLICAT from GGSCI, issue the following command.

```
GGSCI (ogg-classic as ggadmin@targetdsn) 6> <copy>start REPLICAT R_POST</copy>

Sending START request to MANAGER ...
REPLICAT R_POST starting
```

7. Status of the replicat


Display the status  for REPLICAT  group R_POST

```
GGSCI (ogg-classic as ggadmin@targetdsn) 6> <copy>info R_POST</copy>

REPLICAT   R_POST    Last Started 2020-08-20 12:47   Status RUNNING
Checkpoint Lag       00:00:00 (updated 00:00:08 ago)
Process ID           17328
Log Read Checkpoint  File ./dirdat/pa000000000
                     First Record  RBA 0


GGSCI (ogg-classic as ggadmin@targetdsn) 7> 

```

## **STEP 4**: Execuating  DML statments against source database


1. DML Operation :

 Execute the command against the source database

```
<copy>psql postgres -h 127.0.0.1 -d source -f /var/lib/pgsql/gen_data.sql</copy>
```
***Output :***
```
-bash-4.2$ psql postgres -h 127.0.0.1 -d source -f /var/lib/pgsql/gen_data.sql
You are now connected to database "source" as user "postgres".
TRUNCATE TABLE
You are now connected to database "target" as user "postgres".
TRUNCATE TABLE
 region_id | region_name
-----------+-------------
(0 rows)

INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
 region_id |      region_name
-----------+------------------------
         1 | Europe
         2 | Americas
         3 | Asia
         4 | Middle East and Africa
(4 rows)

UPDATE 1
UPDATE 1
 region_id |      region_name
-----------+------------------------
         3 | Asia
         4 | Middle East and Africa
         1 | CHANGE1
         2 | CHANGE2
(4 rows)

DELETE 1
DELETE 1
You are now connected to database "source" as user "postgres".
 region_id | region_name
-----------+-------------
(0 rows)



```
2. Stats output 

Display statistics  of the both extract and replicat 

```
-bash-4.2$ <copy>ggpost</copy>

Oracle GoldenGate Command Interpreter for PostgreSQL
Version 19.1.0.0.200714 OGGCORE_19.1.0.0.0OGGBP_PLATFORMS_200628.2141
Linux, x64, 64bit (optimized), PostgreSQL on Jun 29 2020 03:59:15
Operating system character set identified as UTF-8.

Copyright (C) 1995, 2019, Oracle and/or its affiliates. All rights reserved.



GGSCI (ogg-classic) 1><copy> stats *
</copy>

Sending STATS request to EXTRACT E_POST ...

Start of Statistics at 2020-11-08 15:48:56.

Output to ./dirdat/pa:

Extracting from public.regions to public.regions:

*** Total statistics since 2020-11-08 15:47:43 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Daily statistics since 2020-11-08 15:47:43 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Hourly statistics since 2020-11-08 15:47:43 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Latest statistics since 2020-11-08 15:47:43 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

End of Statistics.

Sending STATS request to REPLICAT R_POST ...

Start of Statistics at 2020-11-08 15:48:57.

Replicating from public.regions to public.regions:

*** Total statistics since 2020-11-08 15:48:44 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Daily statistics since 2020-11-08 15:48:44 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Hourly statistics since 2020-11-08 15:48:44 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

*** Latest statistics since 2020-11-08 15:48:44 ***
        Total inserts                                      4.00
        Total updates                                      2.00
        Total deletes                                      2.00
        Total upserts                                      0.00
        Total discards                                     0.00
        Total operations                                   8.00

End of Statistics.


GGSCI (ogg-classic) 2>
```

You have reached *End of the lab*

## Learn More

* [GoldenGate](https://www.oracle.com/middleware/data-integration/goldengate/")


## Acknowledgements
* **Author** -Madhu Kumar S, Data Integration Team, Oracle, November 2020
* **Contributors** - Brian Elliott,Meghana Banka
* **Last Updated By/Date** - Madhu Kumar S, November 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.
If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.





>>>>>>> 7ba530a897a9be5699b8502c88406f3b7d649ed4
