# MySQL to Kafka

## Introduction
In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rkafka’ will read the remote trail files, act as a producer and write the messages to an auto- created topic for each table in the source database.

Estimated Lab Time:  60 minutes

#### Lab Architecture

![](./images/image601_1.png " ")


### Objectives
- GoldenGate replication from **MySQL to Kafka **

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: Installation
* Lab: MySQL to MySQL



## **STEP 1**: Login to the Terminal

1. Open terminal from desktop by double clicking on the icon

  ![](./images/terminal2.png " ")

2.  Change to the ggadmin user.  When prompted, enter the password *oracle*.  *Note: PLEASE USE ‘ggadmin’ USER FOR ALL THE LABS*
    ````
    <copy>su – ggadmin</copy>
    Password = oracle
    ````

3. Display the Lab Menu by typing the alias **labmenu**. The following lab menu will be displayed.
      ````
    <copy>
    labmenu
    </copy>
    ````

    ![](./images/lab6menu.png " ")

4. Select **R** to reset the lab environment
5. Select **6** (this step may take a couple of minutes)
6. Review the overview notes on the following screen
7. Select **Q** to quit.

## **STEP 2**:  Review
The step above copied the GoldenGate configuration files to the GG Home directories, under ./dirprm.
1. Review the content of each of these files to explore how GoldenGate is being configured.

    ````
    <copy>
    view /u01/gg4mysql/dirprm/mgr.prm
    view /u01/gg4mysql/dirprm/extmysql.prm
    view /u01/gg4mysql/dirprm/pmpmysql.prm
    view /u01/gg4hadoop123010/dirprm/create_kafka_replicat.oby
    view /u01/gg4hadoop123010/dirprm/rkafka.prm
    view /u01/gg4hadoop123010/dirprm/rkafka.properties
    view /u01/gg4hadoop123010/dirprm/custom_kafka_producer.properties
    view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
    </copy>
    ````
## **STEP 3**: Configuration
1.  First we will start the GG manager process on both the source and target. Start 2 terminal sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.

2. In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:

  ````
  <copy>
  Put the commands here
  </copy>
  ````
*Brian where are the commands??? You have to put the text as well, the image is not enough*

  ![](./images/e2.png " ")

3.  In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:
  ````
  <copy>
  Put the commands here
  </copy>
  ````
*Brian where are the commands??? You have to put the text as well, the image is not enough*
  ![](./images/e3.png " ")

4.  In the GG for MySQL ggsci session, we will create and start the GG extract process:

  ````
  <copy>
  Put the commands here
  </copy>
  ````
*Brian where are the commands??? You have to put the text as well, the image is not enough*
  ![](./images/e4.png " ")
  ![](./images/e5.png " ")

**Step8:** Now that the source side is setup, let’s configure GG on the target side (Kafka).

**Step9:** In the GG for Hadoop session, you’ll need to modify the Kafka properties by removing the ‘---‘ from the highlighted values:

![](./images/e6.png " ")

**Step10:** Now create the Kafka replicat process:

![](./images/e7.png " ")

**Before we start the GG Kafka replicat process, we need to start the Kafka Broker. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):**

![](./images/e8.png " ")

**Step11:** Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

![](./images/e9.png " ")

**Step12:** Now that GG processes have been created and the Kafka Broker has been started, let’s start the GG replicat for Kafka. Go back to the GG Home for Hadoop ggsci session:

![](./images/e10.png " ")

**Step13:** Now go back to the previous session, where you ran ‘showtopics’; we’ll load some data on the MySQL database ‘ggsource’ and GG will extract and write it to the Kafka topics.

![](./images/E11.png " ")

**Step14:** Also take a look at the Kafka schema files created by GG, it’s created in the ./dirdef directory in the GG Home for Hadoop:

![](./images/e12.png " ")

**Step15:** Next we’ll apply more DML to the source, then we’ll consume the emp topic, and see the additional data get appended to the topic. Run this from another session, since the consumetopic command runs in the foreground, and outputs the results. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

![](./images/e13.png " ")

**Step16:** Now go back to the previous session, and run the DML script:

![](./images/e14.png " ")

**Step17:** Now go back to the session running ‘consumetopic gg2kafka_json.emp’, you should see the new messages written to the emp topics. Scroll up to see "op-type" "U" or "D". For Updates, GG will write the before and after image of the operation

![](./images/e15.png " ")

**Step18:** Let’s confirm that GG replicated the data that it captured. In the GG for Hadoop home

![](./images/e16.png " ")



## Summary
In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process ‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rkafka’ read the remote trail files, acted as a producer and wrote the messages to an auto-created topic for each table in the source database.

You may now *proceed to the next lab*.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka
* **Last Updated By/Date** - Meghana Banka, September 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
