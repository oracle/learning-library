#   MySQL --> HBase

## Introduction

In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhbase’ will read the remote trail files, create the HBase tables and write the data to those tables.

*Estimated Lab Time*:  60 minutes

#### Lab Architecture

  ![](./images/image501_1.png)

### Objectives
- Explore GoldenGate replication from **MySQL to HBase**

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: Installation

## STEPS
For the Lab terminal session:

**Step1:** Open a terminal session locally

<copy>$ ssh opc@xxx.xxx.xx.xx</copy>

Use Public IP allocated from LiveLabs

**Note: PLEASE USE ‘ggadmin’ USER FOR ALL THE LABS**
    
    <copy>sudo su – ggadmin</copy>
    Password = oracle
    

If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

**Step2:** The following Lab Menu will be displayed, 
**select R** to reset the lab environment, then select **5**.
Review the overview notes on the following screen, then select Q to quit. 

  ![](./images/d_labmenu5.png)

**Step3:** The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

<copy> cd /u01/gg4mysql</copy>

<copy>view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby</copy>

Optionally view these files, same as in previous lab:

<copy> cd /u01/gg4mysql/dirprm</copy>

<copy>view /u01/gg4mysql/dirprm/mgr.prm</copy>

<copy>view /u01/gg4mysql/dirprm/extmysql.prm</copy>

<copy>view /u01/gg4mysql/dirprm/pmpmysql.prm</copy>

<copy> cd /u01/gg4hadoop/dirprm</copy>

<copy>view /u01/gg4hadoop123010/dirprm/create_hbase_replicat.oby</copy>

<copy>view /u01/gg4hadoop123010/dirprm/rhbase.prm</copy>

<copy>view /u01/gg4hadoop123010/dirprm/rhbase.properties</copy>


**Step4:** Start the GG manager process on both the source and target. **Start two terminal sessions**, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.

<copy>su – ggadmin</copy>
  	pwd = oracle in each session


**Step5:** In the first session, go to the **GG Home for MySQL**, and start the manager process. You can cd to the directory:

  ![](./images/d2.png)

<copy>cd /u01/gg4mysql</copy>

<copy>pwd</copy>

<copy>./ggsci</copy>

<copy>info all</copy>	 

<copy>start mgr</copy>	

<copy>info all</copy>


**Step6:** In a second session, go to the **GG Home for Hadoop**, and start the manager process. You can cd to the directory:

  ![](./images/d3.png)

<copy>cd /u01/gg4hadoop123010</copy>

<copy>./ggsci</copy>

<copy>info all</copy>

<copy>start mgr</copy>

<copy>info all</copy>

<copy>exit</copy>


**Step7:** In the **GG for MySQL ggsci session**, we will create and start the GG extract process:

  ![](./images/d4.png)
  ![](./images/d5.png)

<copy>obey ./dirprm/create_mysql_to_hadoop_gg_procs.oby</copy>

<copy>info all</copy>	

<copy>start extmysql</copy>	

<copy>info all</copy>	

<copy>start pmphadop</copy>

<copy>info all</copy>



**Step8:** Now that the source side is setup, let us configure GG on the target side (HBase).

**Step9:** In the **GG for Hadoop session**, you will need to modify the HBase properties by removing the ‘---‘ from the highlighted values:

  ![](./images/d6.png)

<copy>cd dirprm</copy>

<copy>vi rhbase.properties</copy>

**Remove "--" below**

<copy>---hbase</copy>

<copy>---cf</copy>

**Step10:** Now create and start the HBase replicat process:

![](./images/d7.png)
![](./images/d8.png)

<copy>cd .. </copy>

<copy>./ggsci</copy>	

<copy>info all</copy>	

<copy>obey ./dirprm/create_hbase_replicat.oby</copy>	

<copy>info all</copy>	

<copy>start rhbase</copy>

<copy>info all</copy>


**Step11:** Now that GG processes have been created and started on both the source and target, let us take a look at what is in the HBase tables – they should be empty (they don’t even exist yet). We will load some data on the MySQL database ‘ggsource’ and GG will extract the data, create the HBase tables, and write the data to the HBase target tables.

**Step12:** **Start a new session**, connect to ggadmin/oracle (then click Q to get to a prompt):

  ![](./images/d9.png)

<copy>listhbasetables</copy>

<copy>mysqlselect</copy>

<copy>loadsource</copy>

<copy>mysqlselect</copy>

<copy>listhbasetables</copy>


**Step13:** Starting with GG version 12.2.0.1.1, GG automatically creates the HBase tables. Let us take a look at the contents of the tables

  ![](./images/d10.png)

  ![](./images/d11.png)

<copy>selecthbasetable ggtarget2hbase:dept</copy>

<copy>counthbasetables</copy>

<copy>dmlsource</copy>

<copy>countbasetables</copy>


**Step14:** Let us confirm that GG replicated the data that it captured. In a **GG Home for Hadoop session:**

  ![](./images/d12.png)
  ![](./images/d13.png)

<copy>./ggsci</copy>	

<copy>stats rhbase total</copy>


In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rhbase’ read the remote trail files, created the HBase tables and wrote the data to those tables.

You may now *proceed to the next lab*.

**Optional:** only if VNC is available

You can also see the HBase data created by GG from Hue:

Open a Browser window>

[HUE - Click here](http://quickstart.cloudera:8888) 

Login to HUE: cloudera/cloudera

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Brian Elliott, September 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
