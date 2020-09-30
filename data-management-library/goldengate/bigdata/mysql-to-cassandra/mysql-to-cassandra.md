#  MySQL --> Cassandra

## Introduction

In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rcass’ will read the remote trail files, create the Cassandra tables and write the data to those tables.

*Estimated Lab Time*:  60 minutes

#### Lab Architecture

 ![](./images/image701_1.png)

![](./mysql-to-cassandra/terminal2.png)

### Objectives
- Explore replication of GoldenGate from **MySQL to Cassandra**

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: Installation

## Steps
If at a terminal session:

<copy>$ ssh opc@xxx.xxx.xx.xx</copy>

<copy>sudo su - ggadmin</copy>

User ID: ggadmin
Password:  oracle
Setting up the Environment For Connection to Cassandra using Goldengate.
    
**Step1:** If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

<copy>labmenu</copy>

The following Lab Menu will be displayed

  ![](./images/lab7menu.png)

**Step2:** select R to reset the lab environment, then select **7**.
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided to allow cut/paste file names to another session, to avoid typos.

**Step3:** The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

  <copy> cd /u01/gg4mysql/dirprm</copy>

  <copy>view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby</copy>

  view these files, same as in previous lab:

  <copy>view /u01/gg4mysql/dirprm/mgr.prm</copy>

  <copy>view /u01/gg4mysql/dirprm/extmysql.prm</copy>

  <copy>view /u01/gg4mysql/dirprm/pmpmysql.prm</copy>

<copy> cd /u01/gg4hadoop/dirprm</copy>

  <copy>view /u01/gg4hadoop123010/dirprm/create_cassandra_replicat.oby</copy>

  <copy>view /u01/gg4hadoop123010/dirprm/rcass.prm</copy>

  <copy>view /u01/gg4hadoop123010/dirprm/rcass.properties</copy>

**Step4:** Start the GG manager process on both the source and target. Start two terminal sessions and connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.

**Step5:** First task is to start the Cassandra database server. Open a new ssh session, run the alias as shown below and leave this running until you are done

  <copy>startcass</copy>

**Step6:** Open another ssh session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql

  ![](./images/f3.png)

<copy>cd /u01/gg4mysql</copy>

<copy>./ggsci</copy>

<copy>info all</copy>	

<copy>start mgr</copy>	

<copy>info all</copy>


**Step7:** In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

  ![](./images/f4.png)

<copy>cd /u01/gg4hadoop123010</copy>

<copy>./ggsci</copy>

<copy>info all</copy>
	
<copy>start mgr</copy>	

<copy>info all</copy>	

<copy>exit</copy> 


**Step8:** In the GG for MySQL ggsci session, we will create and start the GG extract process:

  ![](./images/f5.png)

<copy>cd /u01/gg4hadoop123010</copy>

<copy>./ggsci</copy>

<copy>info all</copy>
	
<copy>start mgr</copy>	

<copy>info all</copy>	

<copy>exit</copy> 


**Step9:** Now that the source side is setup, let us configure GG on the target side (for Cassandra).



**Step10:** In the GG for Hadoop session, you will need to modify the Cassandra properties by removing the ‘---‘ from the highlighted values:

  ![](./images/f6.png)
  ![](./images/f7.png)

  
<copy>cd /u01/gg4hadoop123010</copy>

<copy>cd dirprm</copy>

<copy>vi rcass.properties</copy>

<copy>---cassandra</copy>

<copy>---CREATE,ADD,DROP</copy>



**Step11:** Now create and start the Cassandra replicat process:

  ![](./images/f8.png)

  <copy>cd ..</copy>

<copy>./ggsci	</copy>

<copy>info all</copy>		

<copy>obey ./dirprm/create_cassandra_replicat.oby</copy>	

<copy>info all</copy>	

<copy>start rcass</copy>	

<copy>info all</copy>


**Step12:** Now that GG processes have been created and started on both the source and target, we need to create the Cassandra Keyspace before loading data. A Cassandra Keyspace is equivalent to a database or schema in relational databases. This step can be done at anytime, and is not dependant on GG.

NOTE: If you re-run this lab later, you can run ‘dropcasskeyspace’ to drop the Cassandra keyspace – and then recreate with the alias below.

  ![](./images/f9.png)

  <copy>createcasskeyspace</copy>

**Step13:** Let us check to see if any tables exist in the ggtarget2cass Cassandra keyspace. The expected result is an error “unconfigured table …” – since the tables have not been created by GG yet. That will be done when GG encounters the first transaction for a new table.

  ![](./images/f10.png)

  <copy>createcasskeyspace</copy>

**Step14:** We will load some data on the MySQL database ‘ggsource’ and GG will extract the data, create the Cassandra tables, and write the data to the Cassandra target tables.

**Step15:** Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

  ![](./images/f11.png)

  <copy>mysqlselect</copy>

<copy>loadsource</copy>

<copy>mysqlselect</copy>


**Step16:** Starting with GG version 12.3.0.1.0, GG automatically creates the Cassandra tables. Let us take a look at the contents of the tables:

  ![](./images/f12.png)
  ![](./images/f13.png)

<copy>cassselect</copy>

**Step17:** Now we will apply some changes to the source database

  ![](./images/f14.png)

  <copy>dmlsource</copy>

**Step18:** Next we will do a count of the Cassandra tables to see if the changes were applied as expected. You can also do a cassselect to see all the data

  ![](./images/f15.png)
  ![](./images/f16.png)

  <copy>casscount</copy> 

**Step19:** Let us confirm using GG to see statistics about data that was replicated In a GG Home for Hadoop session

  ![](./images/f17.png)
  ![](./images/f18.png)

  <copy>./ggsci</copy>
  
<copy>stats rcass total</copy> 


In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rcass’ read the remote trail files, created the Cassandra tables and wrote the data to those tables.

You may now *proceed to the next lab*.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Brian Elliott, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.




