# Lab 7 -  MySQL --> Cassandra
Aug 6, 2020

Lab Architecture

![](images/700/image701_1.png)


### Introduction
In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rcass’ will read the remote trail files, create the Cassandra tables and write the data to those tables.


### Objectives
- GoldenGate replication from **MySQL to Cassandra**

### Time to Complete
Approximately 60 minutes

## Before You Begin
For the Lab terminal session:

su - ggadmin/oracle

![](images/700/Lab7Menu.png)


### STEP 1: Setting up the Environment For Connection to Cassandra using Goldengate.
    
If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

The following Lab Menu will be displayed, 

select R to reset the lab environment, then select 7.
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.

![](images/700/Lab7Menu.png)

The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

1)	view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
2)	Optionally view these files, same as in previous lab:
/u01/gg4mysql/dirprm/mgr.prm
/u01/gg4mysql/dirprm/extmysql.prm
/u01/gg4mysql/dirprm/pmpmysql.prm
3)	view /u01/gg4hadoop123010/dirprm/create_cassandra_replicat.oby
4)	view /u01/gg4hadoop123010/dirprm/rcass.prm
5)	view /u01/gg4hadoop123010/dirprm/rcass.properties

First we will start the GG manager process on both the source and target. Start 2 terminal sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.


First, let’s start the Cassandra database server. Open a new ssh session, run the alias as shown below and leave this running until you are done with this lab.


![](images/ALL/F2.png)

Open another ssh session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:

![](images/ALL/F3.png)

In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

![](images/ALL/F4.png)

In the GG for MySQL ggsci session, we will create and start the GG extract process:

![](images/ALL/F5.png)

Now that the source side is setup, let’s configure GG on the target side (for Cassandra).

In the GG for Hadoop session, you’ll need to modify the Cassandra properties by removing the ‘---‘ from the highlighted values:

![](images/ALL/F6.png)
![](images/ALL/F7.png)

![](images/700/image7xx_1.png)

Now create and start the Cassandra replicat process:

![](images/ALL/F8.png)

Now that GG processes have been created and started on both the source and target, we need to create the Cassandra Keyspace before loading data. A Cassandra Keyspace is equivalent to a database or schema in relational databases. This step can be done at anytime, and is not dependant on GG.

NOTE: If you re-run this lab later, you can run ‘dropcasskeyspace’ to drop the Cassandra keyspace – and then recreate with the alias below.

![](images/ALL/F9.png)


Let’s check to see if any tables exist in the ggtarget2cass Cassandra keyspace. The expected result is an error “unconfigured table …” – since the tables have not been created by GG yet. That will be done when GG encounters the first transaction for a new table.

![](images/ALL/F10.png)

We’ll load some data on the MySQL database ‘ggsource’ and GG will extract the data, create the Cassandra tables, and write the data to the Cassandra target tables.

Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

![](images/ALL/F11.png)

Starting with GG version 12.3.0.1.0, GG automatically creates the Cassandra tables. Let’s take a look at the contents of the tables:

![](images/ALL/F12.png)
![](images/ALL/F13.png)



Now we’ll apply some changes to the source database

![](images/ALL/F14.png)

Next we’ll do a count of the Cassandra tables to see if the changes were applied as expected. You can also do a cassselect to see all the data

![](images/ALL/F15.png)
![](images/ALL/F16.png)

Let’s confirm using GG to see statistics about data that was replicated In a GG Home for Hadoop session

![](images/ALL/F17.png)
![](images/ALL/F18.png)

In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rcass’ read the remote trail files, created the Cassandra tables and wrote the data to those tables.

End of Lab 7.

## Acknowledgements

 - ** Authors ** - Brian Elliott
 - ** Contributors ** - Brian Elliott
 - ** Team ** - Data Integration Team
 - ** Last Updated By ** - Brian Elliott
 - ** Expiration Date ** – July 2021
  
# Congrats! You have completed the GoldenGate for Big Data Workshop!! 


