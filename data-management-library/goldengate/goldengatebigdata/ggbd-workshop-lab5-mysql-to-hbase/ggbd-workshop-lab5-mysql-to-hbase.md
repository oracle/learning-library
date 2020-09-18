# Lab 5 -   MySQL --> HBase

### Introduction
In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhbase’ will read the remote trail files, create the HBase tables and write the data to those tables.

Lab Architecture

![](./images/image501_1.png)

Time to Complete -
Approximately 60 minutes

### Objectives
- GoldenGate replication from **MySQL to HBase**

## Before You Begin
For the Lab terminal session:

## Steps

**1:** If at a terminal session:

su - ggadmin

User ID: ggadmin
Password:  oracle

or
    
If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

**2:** The following Lab Menu will be displayed, 
select R to reset the lab environment, then select 5.
Review the overview notes on the following screen, then select Q to quit. 

![](./images/d_labmenu5.png)

**3:** The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

<copy>./view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby</copy>

Optionally view these files, same as in previous lab:

<copy>./view /u01/gg4mysql/dirprm/mgr.prm</copy>

<copy>./view/u01/gg4mysql/dirprm/extmysql.prm</copy>

<copy>./view /u01/gg4mysql/dirprm/pmpmysql.prm</copy>

<copy>./view /u01/gg4hadoop123010/dirprm/create_hbase_replicat.oby</copy>

<copy>./view /u01/gg4hadoop123010/dirprm/rhbase.prm</copy>

<copy>./view /u01/gg4hadoop123010/dirprm/rhbase.properties</copy>


**4:** First we will start the GG manager process on both the source and target. Start 2 terminal sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.

**Start 2 terminal sessions**

<copy>su – ggadmin</copy>   pwd = oracle in each session


**5:** In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory:

![](./images/d2.png)

<copy>./cd /u01/gg4mysql</copy>

<copy>./pwd</copy>

<copy>././ggsci</copy>

<copy>./info allv</copy>	 

<copy>./start mgr</copy>	

<copy>./info all</copy>



**6:** In a second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

![](./images/d3.png)

<copy>./cd /u01/gg4hadoop123010</copy>
<copy>././ggsci</copy>
<copy>./info all</copy>
<copy>./start mgr</copy>
<copy>./info all</copy>
<copy>./exit</copy>


**7:** In the GG for MySQL ggsci session, we will create and start the GG extract process:

<copy>./obey ./dirprm/create_mysql_to_hadoop_gg_procs.oby</copy>

<copy>./info all</copy>	

<copy>./start extmysql</copy>	

<copy>./info all</copy>	

<copy>./start pmphadop</copy>

<copy>./info all</copy>


Review and Run the Highlighted commands

![](./images/d4.png)
![](./images/d5.png)

**8:** Now that the source side is setup, let’s configure GG on the target side (HBase).

**9:** In the GG for Hadoop session, you’ll need to modify the HBase properties by removing the ‘---‘ from the highlighted values:

![](./images/d6.png)

<copy>./cd dirprm</copy>

<copy>./vi rhbase.properties</copy>

<copy>./---hbase</copy>

<copy>./---cf</copy>

<copy>:wq!</copy>

**10:** Now create and start the HBase replicat process:

![](./images/d7.png)
![](./images/d8.png)

<copy>./cd .. </copy>

<copy>././ggsci</copy>	

<copy>./info all</copy>	

<copy>./obey ./dirprm/create_hbase_replicat.oby</copy>	

<copy>./info all</copy>	

<copy>./start rhbase</copy> 

<copy>./info all</copy>


**11:** Now that GG processes have been created and started on both the source and target, let’s take a look at what’s in the HBase tables – they should be empty (they don’t even exist yet). We’ll load some data on the MySQL database ‘ggsource’ and GG will extract the data, create the HBase tables, and write the data to the HBase target tables.

**12:** Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt)

Review and Run the Highlighted commands

![](./images/d9.png)

<copy>./listhbasetables</copy>
<copy>./mysqlselect</copy>
<copy>./loadsource</copy>
<copy>./mysqlselect</copy>
<copy>./listhbasetables</copy>


**13:** Note: Starting with GG version 12.2.0.1.1, GG automatically creates the HBase tables. Let’s take a look at the contents of the tables

Review and Run the Highlighted commands

![](./images/d10.png)

![](./images/d11.png)


<copy>./selecthbasetable ggtarget2hbase:dept</copy>

<copy>./counthbasetables</copy>

<copy>./dmlsource</copy>
<copy>./countbasetables</copy>


**14:** Let’s confirm that GG replicated the data that it captured. In a GG Home for Hadoop session:

![](./images/d12.png)
![](./images/d13.png)

<copy>././ggsci</copy>	
<copy>./stats rhbase total</copy>


In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rhbase’ read the remote trail files, created the HBase tables and wrote the data to those tables.

**End of Lab 5 - You may proceed to the next Lab**

**Optional:** only if VNC is available

You can also see the HBase data created by GG from Hue:

Open a Browser window>

[HUE - Click here](http://127.0.0.1:8888) 

Login to HUE: cloudera/cloudera

## Acknowledgements

  * Authors ** - Brian Elliott
  * Contributors ** - Brian Elliott
  * Team ** - Data Integration Team
  * Last Updated By/Date ** - Brian Elliott, September 2020
 
 ## See an issue?

Please submit feedback using this link: [issues](https://github.com/oracle/learning-library/issues) 
  