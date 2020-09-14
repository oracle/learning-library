# Lab 4 -  MySQL --> Hive (Avro format)

## Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.

In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and wrote them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhive’ will read the trail file, create the Hive tables, write the data and the schema files (avsc) to the HDFS target directory for Hive: /user/ggtarget/hive/data/* and /user/ggtarget/hive/schema/*

Estimated Lab Time: 60 minutes

Lab Architecture

![](./images/image401_1.png)

### Objectives
- Explore GoldenGate replication from **MySQL to Hive**

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: Installation

## Steps: 

For the Lab terminal session:

* Use ggadmin/oracle to log into your new Lab4

Setting up the Environment For MySQL.
    
If you are already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

**Step1:** The following Lab Menu will be displayed, select R to reset the lab environment, then option 4

  ![](./images/lab4menu.png)

**Step2:** The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

  ````
  view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
  view these files, same as in previous lab

  /u01/gg4mysql/dirprm/mgr.prm
  /u01/gg4mysql/dirprm/extmysql.prm
  /u01/gg4mysql/dirprm/pmpmysql.prm

  view /u01/gg4hadoop123010/dirprm/create_hive_replicat.oby

  view /u01/gg4hadoop123010/dirprm/rhive.prm

  view /u01/gg4hadoop123010/dirprm/rhive.properties
  ````

**Step3:** The first tast is to start the GG manager process on both the source and target. Start two putty sessions and connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.

**Step4:** In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:

  ![](./images/c2.png)

**Step5:** In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

  ![](./images/c3.png)

**Step6:** In the GG for MySQL ggsci session, we will create and start the GG extract process:

  ![](./images/c4.png)
  ![](./images/c5.png)

**Step7:** Now that the source side is setup, let’s configure GG on the target side (Hive Avro format).

**Step8:** In the GG for Hadoop session, you’ll need to modify the Hive properties by removing the ‘---‘ from the highlighted values:

  ![](./images/c6.png)

**Step9:** Now create and start the Hive replicat process:

  ![](./images/c7.png)

**Step10:** Now that GG processes have been created and started on both the source and target, let us take a look at what is in the Hive directories (schema & data) – they should be empty. We can then load some data on
the MySQL database ‘ggsource’ and GG will extract and write it to the Hive target. GG will create a subdirectory for each table in the base directory /user/ggtarget/hive/data.

**Step11:** Start a new session and connect to ggadmin/oracle (then click Q to get to a prompt):

  ![](./images/c8.png)

**Step12:** There should be several .avro files in the data directory, and three .avsc files in the schema directory. You will notice that a new directory has been created for each table in the data directory.

  ![](./images/c9.png)

**Step13:** Starting with GG version 12.2.0.1.1, GG automatically creates the Hive tables with .avsc schema file. Let us take a look at the contents of the tables:

  ![](./images/c10.png)
  ![](./images/c11.png)

**Step14:** Also take a look at the Avro schema files created by GG, it’s created in the ./dirdef directory in the GG Home for Hadoop:

  ![](./images/c12.png)

To summarize, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rhive’ read the remote trail files, created the Hive tables, wrote the data and the schema files (avsc) to the HDFS target directory for Hive: /user/ggtarget/hive/data/* and
/user/ggtarget/hive/schema

**Step15:** You can also see the files that are created in the Hive directory in HDFS:

**Step16:** Click on File Browser (Manage HDFS) > Navigate to /user/ggtarget/hive… Take a look at the .avro and the schema .avsc files:

  ![](./images/c18.png)
  ![](./images/c19.png)

**End of Lab 4 - You may proceed to the next Lab**

**Optional:** Only if VNC is available

You can also see the Hive data created by GG from Hue:

Open a Browser window>
[HUE - Click here](http://127.0.0.1:8888) 

Login to Hue: cloudera/cloudera

1-	Click on Query Editor, Hive
2-	Pull down on Database selection, and select ggtarget2hive_avro
3-	Then hover the mouse over the emp table, and click the ‘preview sample data’ –small grey icon Hue screens:

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka
* **Last Updated By/Date** - Meghana Banka, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
