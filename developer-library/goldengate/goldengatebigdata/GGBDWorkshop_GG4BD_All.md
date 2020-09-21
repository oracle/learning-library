June 28 2020

## Before You Begin
Oracle GoldenGate for Big Data Workshop
![](images/100/image100_0.png)

Oracle Data Integration Solutions
### Introduction
Contents

Introduction	4
Disclaimer	4
Oracle GoldenGate for Big Data Workshop Architecture	5
Setup the QuickStart VM for GoldenGate for Big Data Workshop	6
If you need to re-run the setup.sh script…	8
Desktop Setup	9
Lab 1 – Install GoldenGate  binaries for Big Data	10
Optional step (Do not select Auto-install if you already installed GG manually)	12
Lab 2 – MySQL   MySQL unidirectional replication	13
Lab Architecture	13
Lab 3 – MySQL --> HDFS (delimited text format)	18
Lab Architecture	18
Lab 4 – MySQL --> Hive (Avro format)	27
Lab Architecture	27
Lab 5 – MySQL --> HBase	38
Lab Architecture	38
Lab 6 – MySQL --> Kafka (Json format)	47
Lab Architecture	47
Lab 7 – MySQL --> Cassandra	56
Lab Architecture	56
Appendix A – Handler Configuration Properties	65
Appendix B – Command Reference List	70 

### Objectives
Introduction
The GoldenGate for Big Data Workshop is designed to introduce replication capabilities from relational sources to “Big Data” targets, specifically HDFS, Hive, HBase, Kafka and Cassandra. This workshop is based on GoldenGate for Big Data which covers all GG supported Big Data targets, except Flume. Additional targets may be supported using open-source pluggable adapters. For more information, please discuss this with the workshop facilitator or the Data Integration Sales team.

Oracle GoldenGate for Big Data product streams transactional data into big data systems in real time, without impacting the performance of source systems. It streamlines real-time data delivery into most popular big data solutions, including Apache Hadoop (HDFS), HBase, Hive, Flume, Kafka and Cassandra to facilitate improved insight and timely action.

KEY FEATURES

•	Non-invasive, real-time transactional data streaming • Secured, reliable and fault-tolerant data
delivery • Easy to install, configure and maintain • Streams real-time changed data • Easily extensible and flexible to stream changed data to other big data targets and message queues

KEY BENEFITS

•	Improve IT productivity in integrating with big data systems • Use real-time data in big data analytics for more timely and reliable insight • Improve operations and customer experience with enhanced business insight • Minimize overhead on source systems to maintain high performance
Oracle GoldenGate for Big Data provides optimized and high performance delivery to Flume, HDFS, Hive, HBase, Kafka and Cassandra to support customers with their real-time big data analytics initiatives.
Oracle GoldenGate for Big Data includes Oracle GoldenGate for Java, which enables customers to easily integrate to additional big data systems, such as Apache Storm, Apache Spark, Oracle NoSQL, MongoDB, SAP HANA, IBM PureData System for Analytics and many others.

Oracle GoldenGate for Big Data’s real-time data streaming platform also allows customers to keep their big data reservoirs, or big data lakes, up to date with their production systems.
SUMMARY
Oracle GoldenGate for Big Data offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data
integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making.
Disclaimer
This workshop is only for learning and testing purposes. None of the files from the labs should be used in a production environment. Please review this file: GG4BDWorkshop-LicenseAgreement.txt
 

Oracle GoldenGate for BigData Workshop Architecture

There are 7 hands-on labs in this workshop. GoldenGate software for MySQL are auto-installed as part of the initial setup. After running Lab 1 – Install GG for Big Data, the rest of the labs can be run independently of each other, and in any order.

Lab 1 – Install GoldenGate for Big Data 
Lab 2 – MySQL -> MySQL 
Lab 3  – MySQL -> HDFS (CSV format)  
Lab 4 – MySQL -> Hive (Avro format) 
Lab 5 – MySQL -> HBase
Lab 6 – MySQL -> Kafka (Json format) 
Lab 7 – MySQL -> Cassandra

 

Setup Cloudera QuickStart VM for GoldenGate for Big Data Workshop

BEFORE STARTING THIS WORKSHOP, you should have VNC installed locally
Start VNC Viewer
Configure Connection = localhost:5901
Start VNC Session


### Install

Login as root, password: cloudera
cd to the directory (/opt/software)
untar the ggbd_workshop.tar.gz file (the tar file may have a date in the file name)
Then execute the setup.sh script to customize the VM for GoldenGate

 

The script will go through a number of configuration steps:

•	Create a base directory /u01
•	Install Python 2.7 (required for Cassandra cqlsh)
•	Copy files from the shared folder to /u01
•	Enable supplemental logging in MySQL (stop and start MySQL)
•	Create OS user: ggadmin/oracle
•	Create MySQL databases: ggsource & ggtarget
•	Create MySQL user: ggdemo/oracle
•	Create empty schema tables in both MySQL database: ggsource & ggtarget
o	Tables: emp, dept, salgrade
•	Create HDFS base directories:
o	/user/ggtarget/hdfs
o	/user/ggtarget/hive/schema
o	/user/ggtarget/hive/data
•	Install GGBD for MySQL (and execute CREATE SUBDIRS from ggsci)
Once all the steps are complete, you will be connected to ‘ggadmin’ user and the Lab Menu will be displayed. At this point you are ready to start Lab 1 – Install GoldenGate for Big Data.

If you need to re-run the setup.sh script…

If you run into any issues, and have to re-run the setup.sh script, you will get a warning that the environment already exists (maybe partially) and needs to be cleaned before configuring the environment.

You will have to explicitly enter YES to reset the environment. After that you will need to run the setup.sh script again:
 

Desktop Setup

As you step through the labs, open multiple sessions in VNC session in each lab, so that you do not have to log in/out of GG command line interface (ggsci), and change GG Home.
 
### Lab1
Lab 1 – Install GoldenGate binaries for Big Data

In this lab we will install GoldenGate for Big Data in the GG Target Home. Follow the steps below to install GG, or optionally you can select “I” from the Lab Menu below to auto-install GG.
Login to the VM using VNC on your laptop, or the ‘terminal’ tool in the QuickStart VNC GUI: Host: localhost
Port:5901

PLEASE USE ‘ggadmin’ USER FOR ALL THE LABS (not root)

# su – ggadmin
Password = oracle 


If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

The following Lab Menu will be displayed, select 1. Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.
FYI: LD_LIBRARY_PATH needs to be set for GG, and Java version needs to be version 1.8 or higher. (This is already done in the env script for this workshop)
To install GoldenGate, you will extract the GG binaries tar file – this file has been copied to /u01 as part of the setup. Then connect to the GoldenGate command line interface (ggsci) and run CREATE SUBDIRS to create the subdirectories in the GoldenGate home.
          ** Follow these instructions to install GoldenGate for Big Data

[root@localhost]$ cd /opt/software
 [root@localhost tar -xvf
/u01/gg_binaries/gg4hadoop123010/ggs_Adapters_Linux_x64.tar 


Oracle GoldenGate Command Interpreter

 [ggadmin@localhost]$ ./ggsci

Now inGGSCI  - (ggadmin@localhost) 
1> create subdirs

Creating subdirectories under current directory /u01/gg4hadoop123010

Parameter files	/u01/gg4hadoop123010/dirprm: created
Report files	/u01/gg4hadoop123010/dirrpt: created
Checkpoint files	/u01/gg4hadoop123010/dirchk: created Process status files	/u01/gg4hadoop123010/dirpcs: created SQL script files	/u01/gg4hadoop123010/dirsql: created Database definitions files /u01/gg4hadoop123010/dirdef: created Extract data files	/u01/gg4hadoop123010/dirdat: created Temporary files	/u01/gg4hadoop123010/dirtmp: created Credential store files /u01/gg4hadoop123010/dircrd: created Masterkey wallet files     /u01/gg4hadoop123010/dirwlt: created Dump files	/u01/gg4hadoop123010/dirdmp: created

GGSCI (ggadmin@localhost) 2> exit [ggadmin@localhost]$



Congratulations, GoldenGate for Big Data is now installed. You can proceed to the next lab, or to any other lab. Each lab can be run independently.
 
Optional step (Do not select Auto-install if you already installed GG manually)

If you would like to auto-install GoldenGate for Big Data, you can select this option. To access the Lab Menu, type the alias ‘labmenu’, then select I.



End of Lab 1.
 
### Lab2

Lab 2 – MySQL  MySQL unidirectional replication

Lab Architecture

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ will
capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process
‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’
Login to the VNC session on your laptop, or the ‘terminal’ tool in the QuickStart VM GUI: Host: localhost
Port:5901
Password = welcome1

For the Lab:
    User ID: ggadmin
Password: oracle
 
If already at a Unix prompt, you can access the Lab Menu by typing
su – ggadmin
Password = oracle
Execute the alias ‘labmenu’

The following Lab Menu will be displayed, select 1. Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.
FYI: LD_LIBRARY_PATH needs to be set for GG, and Java version needs to be version 1.8 or higher. (This is already done in the env script for this workshop)


*					*
*	[1]	Lab	1:	Install GoldenGate for Big Data	*
*	[2]	Lab	2:	MySQL --> MySQL one-way replication	*
*	[3]	Lab	3:	MySQL --> HDFS (delimited text format)	*
*	[4]	Lab	4:	MySQL --> Hive (Avro format)	*
*	[5]	Lab	5:	MySQL --> HBase	*
*	[6]	Lab	6:	MySQL --> Kafka (Json format)	*
*	[7]	Lab	7:	MySQL --> Cassandra	*
*					*


•	If you have run other Labs before running this Lab, 
o	select R to reset the lab environment, 

(If you are just starting the Labs, you don’t need to reset the environment).


Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.


The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to explain how GoldenGate is being configured.
1)	view /u01/gg4mysql/dirprm/create_mysql_gg_procs.oby
2)	view /u01/gg4mysql/dirprm/mgr.prm
3)	view /u01/gg4mysql/dirprm/extmysql.prm
4)	view /u01/gg4mysql/dirprm/pmpmysql.prm
5)	view /u01/gg4mysql/dirprm/repmysql.prm

Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:
 
 
Login to ggsci (GG command line interface), to create and start the GG extract, pump and replicat
processes:


Now that the GoldenGate extract, pump and replicat processes are running, next you’ll run a script to load data into the ggsource MySQL database.

Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt), and execute the following commands. (We’ve provided aliases to avoid errors, and focus on GoldenGate, rather than MySQL or Hadoop commands.)

 
 

At this point GoldenGate should have replicated all the data from database ggsource to database
ggtarget, for all 3 tables. The rows should match. Let’s confirm that from within GoldenGate. Go back to the session where you have ./ggsci running, and execute the following commands to see what data GG has processed:


The stats command displays the statistics of the data that GoldenGate processed (grouped by insert/update/deletes). Counts should match between source and target.


In summary, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local GG trail file. The pump process
‘pmpmysql’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ read the remote trail files, and applied the changes to the MySQL database ‘ggtarget’.
End of Lab 2.
 
### Lab3

Lab 3 – MySQL --> HDFS (delimited text format)

Lab Architecture


In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhdfs’ will read the remote trail files, and write the data to the HDFS target directory
/user/ggtarget/hdfs/
Login to the VNC session on your laptop, or the ‘terminal’ tool in the QuickStart VM GUI: Host: localhost
Port:5901
Password = welcome1

For the Lab:
    User ID: ggadmin
Password: oracle
 
If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

The following Lab Menu will be displayed, select R to reset the lab environment, then select 3 (this step may take a couple of minutes, or longer if you have allocated less than 8GB to the VM).
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.

*					*
*	[1]	Lab	1:	Install GoldenGate for Big Data	*
*	[2]	Lab	2:	MySQL --> MySQL one-way replication	*
*	[3]	Lab	3:	MySQL --> HDFS (delimited text format)	*
*	[4]	Lab	4:	MySQL --> Hive (Avro format)	*
*	[5]	Lab	5:	MySQL --> HBase










	*


is already done in the env script for this workshop)
1)	/create_hdfs_replicat.oby
2)	view /u01/gg4hadoop123010/dirprm/rhdfs.prm
3)	view /u01/gg4hadoop123010/dirprm/rhdfs.properties

First we will start the GG manager process on both the source and target. Start 2 putty sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.
 
In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:


In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:


In the GG for MySQL ggsci session, we will create and start the GG extract process:

 
Program	Status	Group	Lag at Chkpt	Time Since Chkpt
MANAGER	RUNNIG			
EXTRACT	RUNNIG	EXTMYSQL	00:00:00	00:00:10
EXTRACT	RUNNIG	PMPHADP	00:00:00	00:00:08

Now that the source side is setup, let’s configure GG on the target side (HDFS).

In the GG for Hadoop session, you’ll need to modify the HDFS properties by removing the ‘---‘ from the highlighted values:


Now create and start the HDFS replicat process:

 



MANAGER	RUNNING	
REPLICAT	RUNNING	RHDFS	00:00:00	00:00:06


Now that GG processes have been created and started on both the source and target, let’s take a look at what’s in the HDFS directory – it should be empty. Then we’ll load some data on the MySQL database
‘ggsource’ and GG will extract and write it to the HDFS target. GG will create a subdirectory for each table in the base directory /user/ggtarget.
Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt)::


hdfsls	-- this alias lists the files in /user/ggtarget/hdfs, (it calls this command: hdfs dfs -ls /user/ggtarget/hdfs), there should be no files in this directory.
Expected result at this point is: [ggadmin@quickstart ~]$ hdfsls
ls: `/user/ggtarget/hdfs/*/*': No such file or directory

Call the following alias:
mysqlselect	-- this will run a script to do a select * from the 3 tables on both ggsource and ggtarget.	For this lab we only care about the source database, it should be empty

loadsource	-- this will insert data into the 3 tables in the ‘ggsource’ database

mysqlselect	-- now you should see data in the source tables.

hdfsls	-- now list the files in the HDFS target.	There should be 3 .csv files for each table: emp, dept, salgrade

[ggadmin@quickstart ~]$ hdfsls
-rw-r--r--	1 ggadmin supergroup	568 2016-06-15 15:37
/user/ggtarget/hdfs/ggtarget2hdfs_csv.dept/ggtarget2hdfs_csv.dept_2016-06-15_15-37- 14.085.csv
-rw-r--r--	1 ggadmin supergroup	2724 2016-06-15 15:37
/user/ggtarget/hdfs/ggtarget2hdfs_csv.emp/ggtarget2hdfs_csv.emp_2016-06-15_15-37- 15.675.csv
-rw-r--r--	1 ggadmin supergroup	700 2016-06-15 15:37
/user/ggtarget/hdfs/ggtarget2hdfs_csv.salgrade/ggtarget2hdfs_csv.salgrade_2016-06- 15_15-37-15.816.csv

Call the following alias to apply updates/deletes to the emp table:
dmlsource	-- this will apply 3 inserts, 1 delete and 2 updates to the emp table

Print the contents of the 3 files:
hdfscat	-- this alias will run hdfs dfs -cat /user/ggtarget/hdfs/*/*

You should see the additional delete (D) and update (U) operations in the emp file:
 
 

In summary, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rhdfs’ read the remote trail file, and wrote the data to the HDFS target directory
/user/ggtarget/hdfs/*.

Let’s confirm that GG replicated the data that it captured. Go back to the MySQL ggsci session and execute the following commands to see what data GG has processed, and do the same in the Hadoop ggsci session:
In MySQL ggsci session window:

 
 

In Hadoop ggsci session window:

 
 

The stats command displays the statistics of the data that GoldenGate processed (grouped by insert/update/deletes). Counts should match between source and target.
You can also see the files created by GG from Hue: http://127.0.0.1:8888/
Login to Hue: cloudera/cloudera
Click on File Browser (Manage HDFS) > Navigate to /user/ggtarget/hdfs…

 
 


End of Lab 3.
 
### Lab4

Lab 4 – MySQL --> Hive (Avro format)

Lab Architecture















In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and wrote them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhive’ will read the trail file, create the Hive tables, write the data and the schema files (avsc) to the HDFS target directory for Hive: /user/ggtarget/hive/data/* and /user/ggtarget/hive/schema/*
Login to the VNC session on your laptop, or the ‘terminal’ tool in the QuickStart VM GUI: Host: localhost
Port:5901
Password = welcome1

For the Lab:
    User ID: ggadmin
Password: oracle
 
If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

The following Lab Menu will be displayed, select R to reset the lab environment, then select 4 (this step may take a couple of minutes, or longer if you have allocated less than 8GB to the VM).
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.









*					*
*	[1]	Lab	1:	Install GoldenGate for Big Data	*
*	[2]	Lab	2:	MySQL --> MySQL one-way replication	*
*	[3]	Lab	3:	MySQL --> HDFS (delimited text format)	*
*	[4]	Lab	4:	MySQL --> Hive (Avro format)	*
*	[5]	Lab	5:	MySQL --> HBase










	*


















The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

1)	view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
2)	Optionally view these files, same as in previous lab:
/u01/gg4mysql/dirprm/mgr.prm
/u01/gg4mysql/dirprm/extmysql.prm
/u01/gg4mysql/dirprm/pmpmysql.prm
3)	view /u01/gg4hadoop123010/dirprm/create_hive_replicat.oby
4)	view /u01/gg4hadoop123010/dirprm/rhive.prm
5)	view /u01/gg4hadoop123010/dirprm/rhive.properties

First we will start the GG manager process on both the source and target. Start 2 putty sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.
 
In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:


In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:


In the GG for MySQL ggsci session, we will create and start the GG extract process:

 
Program	Status	Group	Lag at Chkpt	Time Since Chkpt
MANAGER	RUNNIG			
EXTRACT	RUNNIG	EXTMYSQL	00:00:00	00:00:10
EXTRACT	RUNNIG	PMPHADP	00:00:00	00:00:08

Now that the source side is setup, let’s configure GG on the target side (Hive Avro format).

In the GG for Hadoop session, you’ll need to modify the Hive properties by removing the ‘---‘ from the highlighted values:

GG Home for Hadoop: cd /u01/gg4hadoop123010 -OR- use alias ‘gghadoop’

gghadoop	-- this alias does a cd to the GG Home for Hadoop
/u01/gg4hadoop123010

cd dirprm
vi rhive.properties (partial file show)

#Hive Handler. gg.handlerlist=hivehandler gg.handler.hivehandler.type=---hdfs gg.handler.hivehandler.mode=op
gg.handler.hivehandler.format=---avro_op_ocf gg.handler.hivehandler.maxFileSize=1000 gg.handler.hivehandler.rootFilePath=---/user/ggtarget/hive/data gg.handler.hivehandler.schemaFilePath=---/user/ggtarget/hive/schema gg.handler.hivehandler.inactivityRollInterval=10s gg.handler.hivehandler.fileSuffix=---.avro gg.handler.hivehandler.partitionByTable=true gg.handler.hivehandler.rollOnMetadataChange=true #gg.handler.hivehandler.format.pkUpdateHandling=update #gg.handler.hivehandler.format.treatAllColumnsAsStrings=true gg.handler.hivehandler.authType=none
#gg.handler.hivehandler.kerberosKeytabFile=/etc/security/keytabs/hdfs.service.keytab #gg.handler.hivehandler.kerberosPrincipal=hdfs@EXAMPLE.COM #gg.handler.hivehandler.compressionCodec=null

#Hive - auto-create external tables gg.handler.hivehandler.hiveJdbcUrl=---jdbc:hive2://localhost:10000
gg.handler.hivehandler.hiveJdbcUsername=---ORACLEWALLETUSERNAME myalias ggadapters gg.handler.hivehandler.hiveJdbcPassword=---ORACLEWALLETPASSWORD myalias ggadapters

:wq!


 
Now create and start the Hive replicat process:


Now that GG processes have been created and started on both the source and target, let’s take a look at what’s in the Hive directories (schema & data) – they should be empty. Then we’ll load some data on
the MySQL database ‘ggsource’ and GG will extract and write it to the Hive target. GG will create a subdirectory for each table in the base directory /user/ggtarget/hive/data.

Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

 
There should be several .avro files in the data directory, and 3 .avsc files in the schema directory. You will notice that a new directory has been created for each table in the data directory.


SAMPLE OUTPUT:

[ggadmin@quickstart dirprm]$ hivels Found 2 items
-rw-r--r--	1 ggadmin supergroup	1081 2016-06-20 11:26
/user/ggtarget/hive/data/ggtarget2hive_avro.dept/ggtarget2hive_avro.dept_2016-06- 20_11-26-30.213.avro
-rw-r--r--	1 ggadmin supergroup	767 2016-06-20 11:26
/user/ggtarget/hive/data/ggtarget2hive_avro.dept/ggtarget2hive_avro.dept_2016-06- 20_11-26-31.287.avro
Found 20 items
-rw-r--r--	1 ggadmin supergroup	1084 2016-06-20 11:26
/user/ggtarget/hive/data/ggtarget2hive_avro.emp/ggtarget2hive_avro.emp_2016-06-20_11- 26-31.326.avro
-rw-r--r--	1 ggadmin supergroup	1087 2016-06-20 11:26
/user/ggtarget/hive/data/ggtarget2hive_avro.emp/ggtarget2hive_avro.emp_2016-06-20_11- 26-31.563.avro

-rw-r--r--	1 ggadmin supergroup	842 2016-06-20 11:26
/user/ggtarget/hive/schema/ggtarget2hive_avro.dept.avsc
-rw-r--r--	1 ggadmin supergroup	1259 2016-06-20 11:26
/user/ggtarget/hive/schema/ggtarget2hive_avro.emp.avsc
-rw-r--r--	1 ggadmin supergroup	842 2016-06-20 11:26
/user/ggtarget/hive/schema/ggtarget2hive_avro.salgrade.avsc


Starting with GG version 12.2.0.1.1, GG automatically creates the Hive tables with .avsc schema file. Let’s take a look at the contents of the tables:

 
 

Also take a look at the Avro schema files created by GG, it’s created in the ./dirdef directory in the GG Home for Hadoop:



cd dirdef
ls –lrt	
total 12	
-rw-r-----	1	ggadmin	ggadmin	842	Oct	12	18:29	ggtarget2hive_avro.dept.avsc
-rw-r-----	1	ggadmin	ggadmin	1259	Oct	12	18:29	ggtarget2hive_avro.emp.avsc
-rw-r-----	1	ggadmin	ggadmin	842	Oct	12	18:29	ggtarget2hive_avro.salgrade.avsc
 
You can also see the Hive data created by GG from Hue:

Open a Browser window> http://127.0.0.1:8888/ Login to Hue: cloudera/cloudera

1-	Click on Query Editor, Hive
2-	Pull down on Database selection, and select ggtarget2hive_avro
3-	Then hover the mouse over the emp table, and click the ‘preview sample data’ –small grey icon Hue screens:
 



 
You can also see the files that are created in the Hive directory in HDFS:

Click on File Browser (Manage HDFS) > Navigate to /user/ggtarget/hive… Take a look at the .avro and the schema .avsc files:


 
 

Let’s confirm that GG replicated the data that it captured. In a GG Home for Hadoop session:
 
 
 


In summary, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rhive’ read the remote trail files, created the Hive tables, wrote the data and the schema files (avsc) to the HDFS target directory for Hive: /user/ggtarget/hive/data/* and
/user/ggtarget/hive/schem* End of Lab 4.
 
 ### Lab5

Lab 5 – MySQL --> HBase

Lab Architecture


In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhbase’ will read the remote trail files, create the HBase tables and write the data to those tables.
Login to the VNC session on your laptop, or the ‘terminal’ tool in the QuickStart VM GUI: Host: localhost
Port:5901
Password = welcome1

For the Lab:
    User ID: ggadmin
Password: oracle
 
If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

The following Lab Menu will be displayed, select R to reset the lab environment, then select 5 (this step may take a couple of minutes, or longer if you have allocated less than 8GB to the VM).
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.





*					*
*	[1]	Lab	1:	Install GoldenGate for Big Data	*
*	[2]	Lab	2:	MySQL --> MySQL one-way replication	*
*	[3]	Lab	3:	MySQL --> HDFS (delimited text format)	*
*	[4]	Lab	4:	MySQL --> Hive (Avro format)	*
*	[5]	Lab	5:	MySQL --> HBase	*
*	[6]	Lab	6:	MySQL --> Kafka (Json format)	*
*	[7]	Lab	7:	MySQL --> Cassandra	*
*					*










The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

1)	view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
2)	Optionally view these files, same as in previous lab:
/u01/gg4mysql/dirprm/mgr.prm
/u01/gg4mysql/dirprm/extmysql.prm
/u01/gg4mysql/dirprm/pmpmysql.prm
3)	view /u01/gg4hadoop123010/dirprm/create_hbase_replicat.oby
4)	view /u01/gg4hadoop123010/dirprm/rhbase.prm
5)	view /u01/gg4hadoop123010/dirprm/rhbase.properties

First we will start the GG manager process on both the source and target. Start 2 putty sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.
 
In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:


In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:


In the GG for MySQL ggsci session, we will create and start the GG extract process:

 
Program	Status	Group	Lag at Chkpt	Time Since Chkpt
MANAGER	RUNNIG			
EXTRACT	RUNNIG	EXTMYSQL	00:00:00	00:00:10
EXTRACT	RUNNIG	PMPHADP	00:00:00	00:00:08

Now that the source side is setup, let’s configure GG on the target side (HBase).

In the GG for Hadoop session, you’ll need to modify the HBase properties by removing the ‘---‘ from the highlighted values:


Now create and start the HBase replicat process:

 





MANAGER	RUNNING	
REPLICAT	RUNNING	RHBASE	00:00:00	00:00:08


Now that GG processes have been created and started on both the source and target, let’s take a look at what’s in the HBase tables – they should be empty (they don’t even exist yet). We’ll load some data on the MySQL database ‘ggsource’ and GG will extract the data, create the HBase tables, and write the data to the HBase target tables.

Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

 
Starting with GG version 12.2.0.1.1, GG automatically creates the HBase tables. Let’s take a look at the contents of the tables:

selecthbasetable ggtarget2hbase:dept	-- run this alias to do a select * on the dept table

describe 'ggtarget2hbase:dept'; scan 'ggtarget2hbase:dept'
Table ggtarget2hbase:dept is ENABLED ggtarget2hbase:dept
COLUMN FAMILIES DESCRIPTION
{NAME => 'cf', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_SCOPE
=> '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL => 'FOREVER', KEEP_DELETED_
CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}
1 row(s) in 0.3910 seconds

ROW	COLUMN+CELL
10	column=cf:deptno,
timestamp=1466454600479, value=10
10	column=cf:dname,
timestamp=1466454600479, value=Accounting
10	column=cf:location,
timestamp=1466454600479, value=New York
20	column=cf:deptno,
timestamp=1466454602352, value=20
20	column=cf:dname,
timestamp=1466454602352, value=Research
20	column=cf:location,
timestamp=1466454602352, value=Dallas
30	column=cf:deptno,
timestamp=1466454602352, value=30
30	column=cf:dname,
timestamp=1466454602352, value=Sales
30	column=cf:location,
timestamp=1466454602352, value=Chicago
40	column=cf:deptno,
timestamp=1466454602352, value=40
40	column=cf:dname,
timestamp=1466454602352, value=Operations
40	column=cf:location,
timestamp=1466454602352, value=Boston
4 row(s) in 0.1920 seconds

counthbasetables	-- this alias will do a select count(*) from the HBase tables

count 'ggtarget2hbase:emp';count 'ggtarget2hbase:dept';count 'ggtarget2hbase:salgrade'
14 row(s) in 0.3940 seconds

4	row(s) in 0.0110 seconds

5	row(s) in 0.0080 seconds
 
 

Let’s confirm that GG replicated the data that it captured. In a GG Home for Hadoop session:
 
 
 

You can also see the HBase data created by GG from Hue:

Open a Browser window> http://127.0.0.1:8888/ Login to Hue: cloudera/cloudera

1-	Click on Data Browser, HBase
2-	Click on one of the table to browse the data The results are shown below:


 
In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rhbase’ read the remote trail files, created the HBase tables and wrote the data to those tables.
End of Lab 5.
 
### Lab6

Lab 6 – MySQL --> Kafka (Json format)

Lab Architecture














In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rkafka’ will read the remote trail files, act as a producer and write the messages to an auto- created topic for each table in the source database.
Login to the VNC session on your laptop, or the ‘terminal’ tool in the QuickStart VM GUI: Host: localhost
Port:5901
Password = welcome1

For the Lab:
    User ID: ggadmin
Password: oracle
 
If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

The following Lab Menu will be displayed, select R to reset the lab environment, then select 6 (this step may take a couple of minutes, or longer if you have allocated less than 8GB to the VM).
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.





*					*
*	[1]	Lab	1:	Install GoldenGate for Big Data	*
*	[2]	Lab	2:	MySQL --> MySQL one-way replication	*
*	[3]	Lab	3:	MySQL --> HDFS (delimited text format)	*
*	[4]	Lab	4:	MySQL --> Hive (Avro format)	*
*	[5]	Lab	5:	MySQL --> HBase	*
*	[6]	Lab	6:	MySQL --> Kafka (Json format)	*
*	[7]	Lab	7:	MySQL --> Cassandra	*
*					*









The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

1)	view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
2)	Optionally view these files, same as in previous lab:
/u01/gg4mysql/dirprm/mgr.prm
/u01/gg4mysql/dirprm/extmysql.prm
/u01/gg4mysql/dirprm/pmpmysql.prm
3)	view /u01/gg4hadoop123010/dirprm/create_kafka_replicat.oby
4)	view /u01/gg4hadoop123010/dirprm/rkafka.prm
5)	view /u01/gg4hadoop123010/dirprm/rkafka.properties
6)	view /u01/gg4hadoop123010/dirprm/custom_kafka_producer.properties

First we will start the GG manager process on both the source and target. Start 2 putty sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.
 
In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:


In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:


In the GG for MySQL ggsci session, we will create and start the GG extract process:

 
Program	Status	Group	Lag at Chkpt	Time Since Chkpt
MANAGER	RUNNIG			
EXTRACT	RUNNIG	EXTMYSQL	00:00:00	00:00:10
EXTRACT	RUNNIG	PMPHADP	00:00:00	00:00:08

Now that the source side is setup, let’s configure GG on the target side (Kafka).

In the GG for Hadoop session, you’ll need to modify the Kafka properties by removing the ‘---‘ from the highlighted values:


Now create the Kafka replicat process:

 
****Before we start the GG Kafka replicat process, we need to start the Kafka Broker. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):
 

Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):


Now that GG processes have been created and the Kafka Broker has been started, let’s start the GG replicat for Kafka. Go back to the GG Home for Hadoop ggsci session:

 
Now go back to the previous session, where you ran ‘showtopics’; we’ll load some data on the MySQL database ‘ggsource’ and GG will extract and write it to the Kafka topics.

Call the following alias:

loadsource	-- this will insert data into the 3 tables in the ‘ggsource’ database

mysqlselect	-- now you should see data in the source tables.

showtopics	-- call this alias, this time it should list the 3 Kafka topics for the 3 source tables.	GG auto-creates the topics when data is loaded, and the topic does not exist:

[ggadmin@quickstart kafka4gg]$ showtopics gg2kafka_json.dept
gg2kafka_json.emp gg2kafka_json.salgrade

consumetopic gg2kafka_json.dept	-- run this alias to consume the data from one of the topics:

PARTIAL OUTPUT:
[ggadmin@quickstart kafka4gg]$ consumetopic gg2kafka_json.dept null
{
"table":"gg2kafka_json.dept", "op_type":"I",
"op_ts":"2016-06-21 18:44:38.000000", "current_ts":"2016-06-21T11:44:41.987000", "pos":"00000000000000001742",
"after":{
"deptno":10, "dname":"Accounting", "location":"New York"
}
}
null
{
"table":"gg2kafka_json.dept", "op_type":"I",
"op_ts":"2016-06-21 18:44:38.000000", "current_ts":"2016-06-21T11:44:42.418000", "pos":"00000000000000001928",
"after":{
"deptno":20, 





"dname":"Research", "location":"Dallas"
}

ctrl-c	-- to get the prompt back


 
Also take a look at the Kafka schema files created by GG, it’s created in the ./dirdef directory in the GG Home for Hadoop:



cd dirdef	
ls –lrt	
total 12
-rw-r-----	
1	
ggadmin	
ggadmin	
2281	
Oct	
12	
18:07	
gg2kafka_json.dept.schema.json
-rw-r-----	1	ggadmin	ggadmin	3077	Oct	12	18:07	gg2kafka_json.emp.schema.json
-rw-r-----	1	ggadmin	ggadmin	2285	Oct	12	18:07	gg2kafka_json.salgrade.schema.json




Next we’ll apply more DML to the source, then we’ll consume the emp topic, and see the additional data get appended to the topic. Run this from another session, since the consumetopic command runs in the foreground, and outputs the results. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):


Now go back to the previous session, and run the DML script:

 
Now go back to the session running ‘consumetopic gg2kafka_json.emp’, you should see the new messages written to the emp topics. Scroll up to see "op_type":"U" or "D". For Updates, GG will write the before and after image of the operation.

 
Let’s confirm that GG replicated the data that it captured. In the GG for Hadoop home:
 
In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rkafka’ read the remote trail files, acted as a producer and wrote the messages to an auto-created topic for each table in the source database.

End of Lab 6.
 
### Lab7

Lab 7 – MySQL --> Cassandra

Lab Architecture














In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rcass’ will read the remote trail files, create the Cassandra tables and write the data to those tables.
Login to the VNC session on your laptop, or the ‘terminal’ tool in the QuickStart VM GUI: Host: localhost
Port:5901
Password = welcome1

For the Lab:
    User ID: ggadmin
Password: oracle
 
If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

The following Lab Menu will be displayed, select R to reset the lab environment, then select 7 (this step may take a couple of minutes, or longer if you have allocated less than 8GB to the VM).
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.





*					*
*	[1]	Lab	1:	Install GoldenGate for Big Data	*
*	[2]	Lab	2:	MySQL --> MySQL one-way replication	*
*	[3]	Lab	3:	MySQL --> HDFS (delimited text format)	*
*	[4]	Lab	4:	MySQL --> Hive (Avro format)	*
*	[5]	Lab	5:	MySQL --> HBase	*
*	[6]	Lab	6:	MySQL --> Kafka (Json format)	*
*	[7]	Lab	7:	MySQL --> Cassandra	*
*					*










The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

1)	view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
2)	Optionally view these files, same as in previous lab:
/u01/gg4mysql/dirprm/mgr.prm
/u01/gg4mysql/dirprm/extmysql.prm
/u01/gg4mysql/dirprm/pmpmysql.prm
3)	view /u01/gg4hadoop123010/dirprm/create_cassandra_replicat.oby
4)	view /u01/gg4hadoop123010/dirprm/rcass.prm
5)	view /u01/gg4hadoop123010/dirprm/rcass.properties

First we will start the GG manager process on both the source and target. Start 2 putty sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.
 
First, let’s start the Cassandra database server. Open a new ssh session, run the alias as shown below and leave this running until you are done with this lab.

Open another ssh session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:


In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

In the GG for MySQL ggsci session, we will create and start the GG extract process:
 






















Program
	Status	Group	Lag at Chkpt	Time Since Chkpt


				
MGR
 	RUNNING	
EXTMYSQL	
00:00:00	
00:00:10
EXTRACT	RUNNING	PMPHADOP	00:00:00	00:00:08








Now that the source side is setup, let’s configure GG on the target side (for Cassandra).

In the GG for Hadoop session, you’ll need to modify the Cassandra properties by removing the ‘---‘ from the highlighted values:

 
 

Now create and start the Cassandra replicat process:


Now that GG processes have been created and started on both the source and target, we need to create the Cassandra Keyspace before loading data. A Cassandra Keyspace is equivalent to a database or schema in relational databases. This step can be done at anytime, and is not dependant on GG.

NOTE: If you re-run this lab later, you can run ‘dropcasskeyspace’ to drop the Cassandra keyspace – and then recreate with the alias below.


Let’s check to see if any tables exist in the ggtarget2cass Cassandra keyspace. The expected result is an error “unconfigured table …” – since the tables have not been created by GG yet. That will be done when GG encounters the first transaction for a new table.
 
 

We’ll load some data on the MySQL database ‘ggsource’ and GG will extract the data, create the Cassandra tables, and write the data to the Cassandra target tables.

Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):












Starting with GG version 12.3.0.1.0, GG automatically creates the Cassandra tables. Let’s take a look at the contents of the tables:


cassselect	-- this alias runs cqlsh, and does a select * from the 3 tables that we just loaded

select * from Cassandra tables...
[cqlsh 5.0.1 | Cassandra 3.0.10 | CQL spec 3.4.0 | Native protocol v4]

empno | comm | deptno | ename	| hiredate	| job	| mgr	| sal
 	+	+	+	+	+	+	+ 	
7902	|	null	|	20	|	FORD	|	1997-12-05	|	ANALYST	|	7566	|	3000
7900	|	null	|	30	|	JAMES	|	2000-06-23	|	CLERK	|	7698	|	950
7698	|	null	|	30	|	BLAKE	|	1992-06-11	|	MANAGER	|	7839	|	2850
7876	|	null	|	20	|	ADAMS	|	1999-06-04	|	CLERK	|	7788	|	1100
7654	|	1400	|	30	|	MARTIN	|	1998-12-05	|	SALESMAN	|	7698	|	1250
7839	|	0	|	10	|	KING	|	1990-06-09	|	PRESIDENT	|	null	|	5000
7499	|	300	|	30	|	ALLEN	|	1998-08-15	|	SALESMAN	|	7698	|	1600
7788	|	null	|	20	|	SCOTT	|	1996-03-05	|	ANALYST	|	7566	|	3000
 
7521	|	500	|	30	|	WARD	|	1996-03-26	|	SALESMAN	|	7698	|	1250
7782	|	null	|	10	|	CLARK	|	1993-05-14	|	MANAGER	|	7839	|	2450
7369	|	0	|	20	|	SMITH	|	1993-06-13	|	CLERK	|	7902	|	800
7934	|	null	|	10	|	MILLER	|	2000-01-21	|	CLERK	|	7782	|	1300
7566	|	null	|	20	|	JONES	|	1995-10-31	|	MANAGER	|	7839	|	2975
7844	|	0	|	30	|	TURNER	|	1995-06-04	|	SALESMAN	|	7698	|	1500
(14 rows)

deptno | dname	| location
 	+	+ 	
10 | Accounting | New York
30 |	Sales |	Chicago
20 |	Research |	Dallas
40 | Operations |	Boston (4 rows)
grade | hisal | losal
 		+	+		 5 | 99999 |	3001
1 |	1200 |	700
2 |	1400 |	1201
4 |	3000 |	2001
3 |	2000 |	1401

(5 rows)
Done ...

Now we’ll apply some changes to the source database


Next we’ll do a count of the Cassandra tables to see if the changes were applied as expected. You can also do a cassselect to see all the data

 
 

Let’s confirm using GG to see statistics about data that was replicated In a GG Home for Hadoop session:
 
Total	inserts	17.00
Total	updates	2.00
Total	deletes	1.00
Total	discards	0.00
Total	operations	20.00













In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rcass’ read the remote trail files, created the Cassandra tables and wrote the data to those tables.

End of Lab 7.


Congrats! You have completed the GoldenGate for Big Data Workshop!! 

Appendix A – Handler Configuration Properties

Here are a few of the properties for the GG HDFS/Hive, Kafka & Cassandra Handlers.

Please refer to the ‘Integrating Oracle GoldenGate for Big Data’ doc for a complete list: http://docs.oracle.com/goldengate/bd1221/gg-bd/GADBD/GUID-A6C0DEC9-480F-4782-BD2A-54FEDDE2FDD9.htm#GADBD110

HDFS/Hive Properties

HDFS/Hive Property Name	Optional / Required	Property Value	Description
gg.handler.name.type=hdfs	Required	-	Selects the HDFS Handler for streaming change data capture into HDFS.
gg.handler.name.mode	Optional	tx | op	Selects operation (op) mode or transaction (tx) mode for the handler. In almost all scenarios, transaction mode results in better performance.
gg.handler.name.maxFileSize	Optional	Default unit of measure is bytes. You can stipulate k, m, or g to signify kilobytes, megabytes, or gigabytes respectively. Examples of legal  values include 10000, 10k, 100 m, 1.1g.	Selects the maximum file size of created HDFS files.
gg.handler.name.rootFilePath	Optional	Any path name legal in HDFS.	The HDFS Handler will create subdirectories and files under this directory in HDFS to store the data streaming into HDFS.
gg.handler.name.fileRollInte rval	Optional	The default unit of measure is milliseconds. You can stipulate ms, s, m, h t o signify milliseconds, seconds, minutes, or hours respectively.
Examples of legal values include 10000, 10000ms, 10s, 10m,
or 1.5h. Values of 0 or less indicate that file rolling on time is turned off.	The timer starts when an HDFS file is created. If the file is still open when the interval elapses then the file will be closed. A new file will not be immediately opened. New HDFS files are created on a just in time basis.
gg.handler.name.inactivityRo llInterval	Optional	The default unit of measure is milliseconds. You can stipulate ms, s, m, h t o signify milliseconds, seconds, minutes, or hours respectively.
Examples of legal values
include 10000, 10000ms, 10s, 10.5m, or 1h.
Values of 0 or less indicate that file inactivity rolling on time is turned off.	The timer starts from the latest write to an HDFS file. New writes to an HDFS file restart the counter. If the file is still open when the counter elapses the HDFS file will be closed. A new file will not be immediately opened.
New HDFS files are created on a just in time basis.
 
gg.handler.name.fileSuffix	Optional	Any string conforming to HDFS file name restrictions.	This is a suffix that is added on to the end of the HDFS file names. File names typically follow the
format, {fully qualified table name}{current time stamp}{suffix}.
gg.handler.name.partitionByT able	Optional	true | false	Determines if data written into HDFS should be partitioned by table. If set to true, then data for different tables are written to different HDFS files. If se to false, then data from different tables is interlaced in the same HDFS file.

Must be set to true to use the Avro Object Container File Formatter. Set to falseresults in a configuration exception at initialization.
gg.handler.name.format	Optional	delimitedtext | json | xml | avro_row | avro_o p | avro_row_ocf | avro
_op_ocf | sequencefile	Selects the formatter for the HDFS Handler for how output data will be formatted
•	delimitedtext - Delimited text
•	json - JSON
•	xml - XML
•	avro_row - Avro in row compact format
•	avro_op - Avro in operation more verbose format.
•	avro_row_ocf - Avro in the row compact format written into HDFS in the Avro Object Container File format.
•	avro_op_ocf - Avro in the more verbose format written into HDFS in the Avro Object Container File format.
•	sequencefile - Delimited text written in sequence into HDFS is sequence file format.
gg.handler.name.hiveJdbcUrl	Optional	A legal URL for connecting to Hive using the Hive JDBC interface.	Only applicable to the Avro Object Container File (OCF) Formatter.

This configuration value provides a JDBC URL for connectivity to Hive through the Hive JDBC interface. Use of this property requires that you include the Hive JDBC library in
the gg.classpath.

Hive JDBC connectivity can be secured through basic credentials, SSL/TLS, or Kerberos. Configuration properties are provided for the user name and password for basic credentials.

See the Hive documentation for how to generate a Hive JDBC URL for SSL/TLS.

See the Hive documentation for how to generate a Hive JDBC URL for Kerberos. (If Kerberos is used for Hive JDBC security, it must be enabled for HDFS
 
			connectivity. Then the Hive JDBC connection can piggyback on the HDFS Kerberos functionality by using the same Kerberos principal.)
gg.handler.name.hiveJdbcUser Name	Optional	A legal user name if the Hive JDBC connection is secured through credentials.	Only applicable to the Avro Object Container File (OCF) Formatter.

This property is only relevant if
the hiveJdbcUrlproperty is set. It may be required in your environment when the Hive JDBC connection is secured through credentials. Hive requires that Hive DDL operations be associated with a user. If you do not set the value, it defaults to the result of the Java  call System.getProperty(user.name)
gg.handler.name.hiveJdbcPass word	Optional	The fully qualified Hive JDBC driver class name.	Only applicable to the Avro Object Container File (OCF) Formatter.

This property is only relevant if the hiveJdbcUrl property is set. The
default is the Hive Hadoop2 JDBC driver name. Typically, this property does not require configuration and is provided for use if Apache Hive introduces a new JDBC driver class.

Default: org.apache.hive.jdbc.HiveDriver


Kafka Properties

Kafka Property Name	Property Value	Mandatory	Description
gg.handler.kafkahandler.Type	kafka	Yes	Type of handler to use. For example, Kafka, Flume, HDFS.
gg.handler.kafkahandler.Form at	Formatter class or short code	No.  Defaults to delimitedtex t.	Formatter to use to format payload. Can be one
of xml, delimitedtext, json, avro_row, avro_op
gg.handler.kafkahandler.Sche maTopicName	Name of the schema topic	Yes, when schema delivery is required.	Topic name where schema data will be delivered. If this property is not set, schema will not be propagated. Schemas will be propagated only for Avro formatters.
gg.handler.kafkahandler.topi cPartitioning	none | table	None	Controls whether data published into Kafka should be partitioned by table.

Set to table, the data for different tables are written to different Kafka topics.

Set to none, the data from different tables are interlaced in the same topic as configured in topicNameproperty.
gg.handler.kafkahandler.Mode	tx/op	No. Defaults to tx.	With Kafka Handler operation mode, each change capture data record (Insert, Update, Delete etc) payload will be represented as a Kafka Producer Record
 
			and will be flushed one at a time. With Kafka Handler in transaction mode, all operations within a source transaction will be represented by as a single Kafka Producer record. This combined byte payload will be flushed on a transaction Commit event.


Cassandra Properties

Kafka Property Name	Property Value	Mandatory	Description
gg.handler.name.type	cassandra	Yes	Selects the Cassandra Handler for streaming change data capture into Cassandra.
gg.handler.name.contactPoint s	A comma separated list of host names that the Cassandra Handler will connect to.	Optional	A comma separated list of the Cassandra host machines for the driver to establish an initial connection to the Cassandra cluster.
gg.handler.name.username		Optional	A username for the connection to Cassandra. It is required if Cassandra is configured to require credentials.
gg.handler.name.password		Optional	A password for the connection to Cassandra. It is required if Cassandra is configured to require credentials.
gg.handler.name.compressedUp dates	true | false	Optional	Sets the Cassandra Handler whether to or not to expect full image updates from the source trail file.
gg.handler.name.ddlHandling	CREATE | ADD | DRO P	Optional	Configures the Cassandra Handler for the DDL functionality. Options include CREATE, ADD, and DROP. These options can be set in any combination delimited by commas.

When CREATE is enabled the Cassandra Handler creates tables in Cassandra if a corresponding table does not exist.

When ADD is enabled the Cassandra Handler adds columns that exist in the source table definition that
do not exist in the corresponding Cassandra table definition.

When DROP is enable the handler drops columns that exist in the Cassandra table definition that do not exist in the corresponding source table definition.
 
			
gg.handler.name.cassandraMod e	async | sync	Optional	Sets the interaction between the Cassandra Handler and Cassandra. Set to async for asynchronous interaction. Operations are sent to Cassandra asynchronously and then flushed at transaction commit to ensure durability. Asynchronous will provide better performance.

Set to sync for synchronous interaction. Operations are sent to Cassandra synchronously.
gg.handler.name.consistencyL evel	ALL | ANY | EACH_Q UORUM | LOCAL_ONE
| LOCAL_QUORUM| ON E | QUORUM| THREE
| TWO	Optional	Sets the consistency level for operations with Cassandra. It configures the criteria that must be met for storage on the Cassandra cluster when an operation is executed. Lower levels of consistency can provide better performance while higher levels of consistency are safer.
 

Appendix B – Command Reference List

Aliases have been created for this workshop, so that you can focus on GG functionality. These aliases will make it simple to look at files in HDFS, select data from Hive, HBase, Cassandra or consume a Kafka topic.

GG ggsci commands	
info all	Get a status of the GG processes
start mgr	Start the GG manager process
obey
./dirprm/create_mysql_gg_pr
ocs.oby	Create the GG process
start extmysql	Start the ‘named’ GG process
start *	Start all the GG processes in this GG Home (listed in info all)
stats extmysql total	Get up-to-date statistics of the number of operations the GG process
has replicated
	
Common Aliases used in all
labs	
ggmysql	cd to the GG for MySQL Home
gghadoop	cd to the GG for Hadoop Home
mysqlselect	Selects * from MySQL databases: ggsource & ggtarget
loadsource	Load data into the MySQL ggsource database
dmlsource	Load changes (updates/deletes) into the MySQL ggsource database
	
Lab 3 - Aliases	
hdfsls	Lists the files in /user/ggtarget/hdfs
hdfscat	Prints the contents of the files in the hdfs dir
	
Lab 4 - Aliases	
hivels	Lists the files in the hive directories /user/ggtarget/hive/
hiveselect	Does a select * from the Hive tables: emp, dept and salgrade
hivecatavsc	Prints the contents of the avro schema files
	
Lab 5 - Aliases	
listhbasetables	Lists the tables that exist in HBase
selecthbasetable
ggtarget2hbase:dept	Does a select * from HBase table ‘dept’
counthbasetables	Does a select count(*) from HBase tables
	
Lab 6 - Aliases	
startkafkabroker	Start the Kafka Broker (run in the foreground)
showtopics	Lists topics
consumetopic
gg2kafka_json.dept	Prints the contents of the topic (example: ‘gg2kafka_json.dept’)
 
	
Lab 7 - Aliases	
startcass	Start the Cassandra database server
cassselect	Does a select * from tables in Cassandra
casscount	Does a select count(*) from tables in Cassandra
createcasskeyspace	Creates the ‘ggtarget2cass’ keyspace in Cassandra
dropcasskeyspace	Drops the keyspace ‘ggtarget2cass’
	

