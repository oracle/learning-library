# Environment Setup Oracle GoldenGate for PostgreSQL Installation

## Introduction
This workshop will show you how to install a Oracle GoldenGate for PostgreSQL.  This workshop requires a compute instance running with PostgreSQL database and a Virtual Cloud Network (VCN).

*Estimated Lab Time*: 30 minutes


### About Oracle GoldenGate for PosgreSQL
With Oracle GoldenGate for PosgreSQL, you can perform initial loads and capture transactional data from supported PostgreSQL versions and replicate the data to a PostgreSQL database or other supported Oracle GoldenGate targets, such as an Oracle Database.

Oracle GoldenGate for PostgreSQL supports the mapping, manipulation, filtering, and delivery of data from other types of databases to a PostgreSQL database.

### Objectives
-   Oracle GoldenGate between PostgreSQL to PostgreSQL
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

## **STEP 1**: Installation of OGG for PostgreSQL

In this step you will install **Oracle GoldenGate for PostgreSQL** in new **"GoldenGate Home of the PostgreSQL"** directory.

-	From the terminal screen change to the ***GoldenGate Software*** directory location  

1. Unzip the **OGG for PostgreSQL package** in to directory **GoldenGate Home**

```
<copy>cd /u01/software/postgres/

unzip -d /u01/ggpost/  19100200714_ggs_Linux_x64_PostgreSQL_64bit.zip </copy>

Archive:  19100200714_ggs_Linux_x64_PostgreSQL_64bit.zip
inflating: /u01/ggpost/ggs_Linux_x64_PostgreSQL_64bit.tar
inflating: /u01/ggpost/OGG-19.1.0.0-README.txt
inflating: /u01/ggpost/release-notes-oracle-goldengate_19.1.0.200714.pdf
```
## **STEP 2**:	Untar the GoldenGate executable

Go to the ***GoldenGate Home*** and untar the ***ggs_Linux_x64_PostgreSQL_64bit.tar*** executable.

```
<copy>cd /u01/ggpost/ </copy>
<copy>ll </copy>
total 333868
-rw-r--r--. 1 postgres postgres 341534720 Jul 13 08:36 ggs_Linux_x64_PostgreSQL_64bit.tar
-rw-r--r--. 1 postgres postgres      1413 Jan 31  2020 OGG-19.1.0.0-README.txt
-rw-r--r--. 1 postgres postgres    338530 Jul 13 20:43 release-notes-oracle-goldengate_19.1.0.200714.pdf

<copy>tar -xf ggs_Linux_x64_PostgreSQL_64bit.tar  </copy>
```

## **STEP 3**: Execute the ggsci commands from goldengate for postgreSQL home
1. Execute the ggsci command from terminal

Execute remaining subdirectories in the installation location
```      
bash-4.2$ <copy> ./ggsci</copy>

Oracle GoldenGate Command Interpreter for PostgreSQL
Version 19.1.0.0.200714 OGGCORE_19.1.0.0.0OGGBP_PLATFORMS_200628.2141
Linux, x64, 64bit (optimized), PostgreSQL on Jun 29 2020 03:59:15
Operating system character set identified as UTF-8.

Copyright (C) 1995, 2019, Oracle and/or its affiliates. All rights reserved.


GGSCI (ogg-classic) 1> 
```


```
GGSCI (ogg-classic) 1> <copy> create subdirs</copy>

Creating subdirectories under current directory /u01/ggpost

Parameter file                 /u01/ggpost/dirprm: created.
Report file                    /u01/ggpost/dirrpt: created.
Checkpoint file                /u01/ggpost/dirchk: created.
Process status files           /u01/ggpost/dirpcs: created.
SQL script files               /u01/ggpost/dirsql: created.
Database definitions files     /u01/ggpost/dirdef: created.
Extract data files             /u01/ggpost/dirdat: created.
Temporary files                /u01/ggpost/dirtmp: created.
Credential store files         /u01/ggpost/dircrd: created.
Masterkey wallet files         /u01/ggpost/dirwlt: created.
Dump files                     /u01/ggpost/dirdmp: created.
```
## **STEP 4**:Edit the manager


1. Edit the manager parameter

The Manager process in each Oracle GoldenGate installation requires a dedicated port for communication between itself and other local Oracle GoldenGate processes. 

```
GGSCI (ogg-classic) 2> <copy>edit params mgr</copy>

```
2. Append the ***port number*** as ***7811***  in the manager param file  
To specify this port, use the PORT parameter in the Manager parameter file.

```

<copy>PORT 7811</copy>

```

## **STEP 5**:Start the manager
To start Manager from GGSCI, issue the following command.
```
GGSCI (ogg-classic) 4> <copy>start mgr</copy>
Manager started.

```
## **STEP 6**: Manager status check
***info all*** will display the status  for all Manager
```
GGSCI (ogg-classic) 5> <copy>info all</copy>

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING


GGSCI (ogg-classic) 6>
```

You may now *proceed to the next lab*


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
# Environment Setup Oracle GoldenGate for PostgreSQL Installation

## Introduction
This workshop will show you how to install a Oracle GoldenGate for PostgreSQL.  This workshop requires a compute instance running with PostgreSQL database and a Virtual Cloud Network (VCN).

*Estimated Lab Time*: 30 minutes


### About Oracle GoldenGate for PosgreSQL
With Oracle GoldenGate for PosgreSQL, you can perform initial loads and capture transactional data from supported PostgreSQL versions and replicate the data to a PostgreSQL database or other supported Oracle GoldenGate targets, such as an Oracle Database.

Oracle GoldenGate for PostgreSQL supports the mapping, manipulation, filtering, and delivery of data from other types of databases to a PostgreSQL database.

### Objectives
-   Oracle GoldenGate between PostgreSQL to PostgreSQL
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

## **STEP 1**: Installation of OGG for PostgreSQL

In this step you will install **Oracle GoldenGate for PostgreSQL** in new **"GoldenGate Home of the PostgreSQL"** directory.

-	From the terminal screen change to the ***GoldenGate Software*** directory location  

1. Unzip the **OGG for PostgreSQL package** in to directory **GoldenGate Home**

```
<copy>cd /u01/software/postgres/

unzip -d /u01/ggpost/  19100200714_ggs_Linux_x64_PostgreSQL_64bit.zip </copy>

Archive:  19100200714_ggs_Linux_x64_PostgreSQL_64bit.zip
inflating: /u01/ggpost/ggs_Linux_x64_PostgreSQL_64bit.tar
inflating: /u01/ggpost/OGG-19.1.0.0-README.txt
inflating: /u01/ggpost/release-notes-oracle-goldengate_19.1.0.200714.pdf
```
## **STEP 2**:	Untar the GoldenGate executable

Go to the ***GoldenGate Home*** and untar the ***ggs_Linux_x64_PostgreSQL_64bit.tar*** executable.

```
<copy>cd /u01/ggpost/ </copy>
<copy>ll </copy>
total 333868
-rw-r--r--. 1 postgres postgres 341534720 Jul 13 08:36 ggs_Linux_x64_PostgreSQL_64bit.tar
-rw-r--r--. 1 postgres postgres      1413 Jan 31  2020 OGG-19.1.0.0-README.txt
-rw-r--r--. 1 postgres postgres    338530 Jul 13 20:43 release-notes-oracle-goldengate_19.1.0.200714.pdf

<copy>tar -xf ggs_Linux_x64_PostgreSQL_64bit.tar  </copy>
```

## **STEP 3**: Execute the ggsci commands from goldengate for postgreSQL home
1. Execute the ggsci command from terminal

Execute remaining subdirectories in the installation location
```      
bash-4.2$ <copy> ./ggsci</copy>

Oracle GoldenGate Command Interpreter for PostgreSQL
Version 19.1.0.0.200714 OGGCORE_19.1.0.0.0OGGBP_PLATFORMS_200628.2141
Linux, x64, 64bit (optimized), PostgreSQL on Jun 29 2020 03:59:15
Operating system character set identified as UTF-8.

Copyright (C) 1995, 2019, Oracle and/or its affiliates. All rights reserved.


GGSCI (ogg-classic) 1> 
```


```
GGSCI (ogg-classic) 1> <copy> create subdirs</copy>

Creating subdirectories under current directory /u01/ggpost

Parameter file                 /u01/ggpost/dirprm: created.
Report file                    /u01/ggpost/dirrpt: created.
Checkpoint file                /u01/ggpost/dirchk: created.
Process status files           /u01/ggpost/dirpcs: created.
SQL script files               /u01/ggpost/dirsql: created.
Database definitions files     /u01/ggpost/dirdef: created.
Extract data files             /u01/ggpost/dirdat: created.
Temporary files                /u01/ggpost/dirtmp: created.
Credential store files         /u01/ggpost/dircrd: created.
Masterkey wallet files         /u01/ggpost/dirwlt: created.
Dump files                     /u01/ggpost/dirdmp: created.
```
## **STEP 4**:Edit the manager


1. Edit the manager parameter

The Manager process in each Oracle GoldenGate installation requires a dedicated port for communication between itself and other local Oracle GoldenGate processes. 

```
GGSCI (ogg-classic) 2> <copy>edit params mgr</copy>

```
2. Append the ***port number*** as ***7811***  in the manager param file  
To specify this port, use the PORT parameter in the Manager parameter file.

```

<copy>PORT 7811</copy>

```

## **STEP 5**:Start the manager
To start Manager from GGSCI, issue the following command.
```
GGSCI (ogg-classic) 4> <copy>start mgr</copy>
Manager started.

```
## **STEP 6**: Manager status check
***info all*** will display the status  for all Manager
```
GGSCI (ogg-classic) 5> <copy>info all</copy>

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING


GGSCI (ogg-classic) 6>
```

You may now *proceed to the next lab*


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
