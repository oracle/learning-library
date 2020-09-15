# Lab 7 -  MySQL --> Cassandra

### Introduction
In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rcass’ will read the remote trail files, create the Cassandra tables and write the data to those tables.

Lab Architecture

![](./images/image701_1.png)

Time to Complete -
Approximately 60 minutes

### Objectives
- GoldenGate replication from **MySQL to Cassandra**

## Before You Begin

If at a terminal session:

su - ggadmin

User ID: ggadmin
Password:  oracle

## Steps

 Setting up the Environment For Connection to Cassandra using Goldengate.
    
**Step1:** If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

The following Lab Menu will be displayed

![](./images/lab7menu.png)

**Step2:** select R to reset the lab environment, then select 7.
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.

**Step3:** The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
view these files, same as in previous lab:

/u01/gg4mysql/dirprm/mgr.prm

/u01/gg4mysql/dirprm/extmysql.prm

/u01/gg4mysql/dirprm/pmpmysql.prm

view /u01/gg4hadoop123010/dirprm/create_cassandra_replicat.oby

view /u01/gg4hadoop123010/dirprm/rcass.prm

view /u01/gg4hadoop123010/dirprm/rcass.properties

**Step4:** First we will start the GG manager process on both the source and target. Start 2 terminal sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.

**Step5:** First, let’s start the Cassandra database server. Open a new ssh session, run the alias as shown below and leave this running until you are done with this lab.

![](./images/f2.png)

**Step6:** Open another ssh session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:

![](./images/f3.png)

**Step7:** In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

![](./images/f4.png)

**Step8:** In the GG for MySQL ggsci session, we will create and start the GG extract process:

![](./images/f5.png)

**Step9:** Now that the source side is setup, let’s configure GG on the target side (for Cassandra).

**Step10:** In the GG for Hadoop session, you’ll need to modify the Cassandra properties by removing the ‘---‘ from the highlighted values:

![](./images/f6.png)
![](./images/f7.png)

**Step11:** Now create and start the Cassandra replicat process:

![](./images/f8.png)

**Step12:** Now that GG processes have been created and started on both the source and target, we need to create the Cassandra Keyspace before loading data. A Cassandra Keyspace is equivalent to a database or schema in relational databases. This step can be done at anytime, and is not dependant on GG.

NOTE: If you re-run this lab later, you can run ‘dropcasskeyspace’ to drop the Cassandra keyspace – and then recreate with the alias below.

![](./images/f9.png)

**Step13:** Let’s check to see if any tables exist in the ggtarget2cass Cassandra keyspace. The expected result is an error “unconfigured table …” – since the tables have not been created by GG yet. That will be done when GG encounters the first transaction for a new table.

![](./images/f10.png)

**Step14:** We’ll load some data on the MySQL database ‘ggsource’ and GG will extract the data, create the Cassandra tables, and write the data to the Cassandra target tables.

**Step15:** Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

![](./images/f11.png)

**Step16:** Starting with GG version 12.3.0.1.0, GG automatically creates the Cassandra tables. Let’s take a look at the contents of the tables:

![](./images/f12.png)
![](./images/f13.png)

**Step17:** Now we’ll apply some changes to the source database

![](./images/f14.png)

**Step18:** Next we’ll do a count of the Cassandra tables to see if the changes were applied as expected. You can also do a cassselect to see all the data

![](./images/f15.png)
![](./images/f16.png)

**Step19:** Let’s confirm using GG to see statistics about data that was replicated In a GG Home for Hadoop session

![](./images/f17.png)
![](./images/f18.png)

In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rcass’ read the remote trail files, created the Cassandra tables and wrote the data to those tables.

**End of Lab 3**

**Congrats! You have completed the GoldenGate for Big Data Workshop!!**

## Acknowledgements

  * Authors ** - Brian Elliott
  * Contributors ** - Brian Elliott
  * Team ** - Data Integration Team
  * Last Updated By/Date ** - Brian Elliott, August 2020

  ## See an issue?

Please submit feedback using this link: [issues](https://github.com/oracle/learning-library/issues) 




