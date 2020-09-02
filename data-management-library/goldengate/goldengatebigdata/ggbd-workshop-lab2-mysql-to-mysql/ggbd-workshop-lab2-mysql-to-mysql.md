#  Lab 2 -  MySQL  -> MySQL unidirectional replication

## Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ will
capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process
‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’

### Objectives
Replication from relational source to a relational target using GoldenGate

Lab Architecture

  ![](./images/image200_1.png)

Time to Complete -
Approximately 30 minutes

If at a terminal session:

User and Password
User ID: ggadmin
Password:  oracle

'>su – ggadmin
Password = oracle

or Execute the alias ‘labmenu’

The following Lab Menu will be displayed:
Select Option 2

## Steps


  ![](./images/a_labmenu2.png)


(If you are just starting the Labs, you don’t need to reset the environment).

**Step1:** Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.


**Step2:** The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator can review the content of each of these files to explain how GoldenGate is being configured.

view /u01/gg4mysql/dirprm/create_mysql_gg_procs.oby
view /u01/gg4mysql/dirprm/mgr.prm
view /u01/gg4mysql/dirprm/extmysql.prm
view /u01/gg4mysql/dirprm/pmpmysql.prm
view /u01/gg4mysql/dirprm/repmysql.prm

Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:

**Step3:** Go to the GG Home for MySQL. You can either cd to the directory, or call the alias ggmysql:

  ![](./images/a_2.png)
  ![](./images/a3.png)

**Step4:** Login to ggsci (GG command line interface), to create and start the GG extract, pump and replicat
processes:

  ![](./images/a4.png)

**Step5:** Now that the GoldenGate extract, pump and replicat processes are running, next you’ll run a script to load data into the ggsource MySQL database.

**Step6:** Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt), and execute the following commands. (We’ve provided aliases to avoid errors, and focus on GoldenGate, rather than MySQL or Hadoop commands.)

   ![](./images/a5.png)
   ![](./images/a6.png)

**Step7:** At this point GoldenGate should have replicated all the data from database ggsource to database
ggtarget, for all 3 tables. The rows should match. Let’s confirm that from within GoldenGate. Go back to the session where you have ./ggsci running, and execute the following commands to see what data GG has processed:

    ![](./images/a7.png)

**Step8:** The stats command displays the statistics of the data that GoldenGate processed (grouped by insert/update/deletes). Counts should match between source and target.

  ![](./images/a8.png)
  ![](./images/a9.png)


In summary, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local GG trail file. The pump process
‘pmpmysql’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ read the remote trail files, and applied the changes to the MySQL database ‘ggtarget’.


**End of Lab 2 - - You may proceed to the next Lab**

## Acknowledgements

  * Authors ** - Brian Elliott, Data Integration
  * Contributors ** - Brian Elliott
  * Team ** - Data Integration Team
  * Last Updated By/Data ** - Brian Elliott, August 2020

## See an issue?

Please submit feedback using this link: [issues](https://github.com/oracle/learning-library/issues) 
  

