#  MySQL to MySQL - Unidirectional replication

## Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.

In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’

Estimated Lab Time:  30 minutes

Lab Architecture

  ![](./images/image200_1.png)

### Objectives
- Explore replication from relational source to a relational target using GoldenGate

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: Installation

## **STEP 1**: Login to the Terminal

1. Open terminal from desktop by double clicking on the icon

  ![](./images/terminal2.png)

2.  Change to the ggadmin user.  When prompted, enter the password *oracle*.  *Note: PLEASE USE ‘ggadmin’ USER FOR ALL THE LABS*
    ```` 
    <copy>su – ggadmin</copy>
    Password = oracle
    ````

3. At the prompt, type  ‘labmenu’ to display the lab.

  ![](./images/a_labmenu2.png)

3. Select Option **2**

4. Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.

## **STEP 2**: Explore GoldenGate Configuration
1. Review the content of each of these files to explore how GoldenGate is being configured.

    ````
    view /u01/gg4mysql/dirprm/create_mysql_gg_procs.oby
    view /u01/gg4mysql/dirprm/mgr.prm
    view /u01/gg4mysql/dirprm/extmysql.prm
    view /u01/gg4mysql/dirprm/pmpmysql.prm
    view /u01/gg4mysql/dirprm/repmysql.prm
    ````

2. Go to the GG Home for MySQL by typing *ggmysql*
    ````
    ggmysql
    ````

## **STEP 3**: Start GoldenGate Processes

1. Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:

  ![](./images/a_2.png)
  ![](./images/a3.png)

2. Login to ggsci (GG command line interface), to create and start the GG extract, pump and replicat
processes:

  ![](./images/a4.png)

## **STEP 4**: Load Data into Source Database

Now that the GoldenGate extract, pump and replicat processes are running, next you’ll run a script to load data into the ggsource MySQL database.

1. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt), and execute the following commands. (We’ve provided aliases to avoid errors, and focus on GoldenGate, rather than MySQL or Hadoop commands.)

  ````
  <copy>
  Put the commands here
  </copy>
  ````
*Brian where are the commands??? You have to put the text as well, the image is not enough*

   ![](./images/a5.png)
   ![](./images/a6.png)

2. At this point GoldenGate should have replicated all the data from database ggsource to database ggtarget, for all 3 tables. The rows should match. Let’s confirm that from within GoldenGate. 
   
3. Go back to the session where you have ./ggsci running, and execute the following commands to see what data GG has processed.
   
  ````
  Put the commands here
  ````
*Brian where are the commands??? You have to put the text as well, the image is not enough*
    ![](./images/a7.png)

4.  The stats command displays the statistics of the data that GoldenGate processed (grouped by insert/update/deletes). Counts should match between source and target.

  ````
  Put the commands here
  ````
*Brian where are the commands??? You have to put the text as well, the image is not enough*

  ![](./images/a8.png)
  ![](./images/a9.png)


## Summary
In summary, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local GG trail file. The pump process ‘pmpmysql’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ read the remote trail files, and applied the changes to the MySQL database ‘ggtarget’.

You may now *proceed to the next lab*.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka
* **Last Updated By/Date** - Meghana Banka, September 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
  

