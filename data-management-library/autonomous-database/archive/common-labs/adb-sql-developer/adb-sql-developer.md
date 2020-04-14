![](./media/adbtitle.png)
# DBA Exploration of ADB with SQL Developer

## Table of Contents

- [Module 1:  Exploring with SQL Developer](#module-1--exploring-with-sql-developer)
***** 

## Module 1:  Exploring with SQL Developer

In this lab you will get an overview of the DBA view in SQL Developer and how to
explore configuration and settings in your ATB environment.

For this lab make sure you connect to Autonomous Database as **admin** user.
Regular user accounts will not be able to view any system configuration
information.

1. Start SQL Developer. Connect to your database like you did before (as admin).
One of the first questions DBA’s always ask is what options are available in
ATP. They can run the simple select from **v\$option** available in any Oracle
implementation to determine the options. In your SQL screen run the following
command to get a list of options in ATP.

```
select * from v\$option
```

![](media/95f22130d2794dc209e0110f766b2fb5.png)
<p align="center">Figure 1-1</p>

2. Next you will examine the DBA view in SQL Developer. In the main screen select
**View-\>DBA. If you cannot see the DBA option under View, go to “Window” and
select “Reset Window to Factory Setting”,** this should let you see the DBA
option under View.

![](media/a4e987ffc3cf0930c96348f6b9965214.png)
<p align="center">Figure 1-2</p>

3. The DBA view appears on the bottom left. IF you have a connection box in the top
left (the box used for previous labs), close the connections box by clicking the
X on top right of the box. You should only see the DBA view. Below are
screenshots of both steps:

![](media/3717a4021a216e02b02233fe2492c7f2.png)
<p align="center">Figure 1-3</p>

4.  Click the connections green plus sign in the DBA view, it will pop up the
connections menu, select the connection you created for your **admin database
connection**
 (any service \_high or \_admin) and OK:

![](media/03eff2af47a98bab1260915d5c37f659.png)
<p align="center">Figure 1-4</p>

This will open up all the **DBA** views of the database, open Database
Configuration:

![](media/ebbc8a8a5aa50b50b7b3aa4dbed90ef1.png)
<p align="center">Figure 1-5</p>

5. In **Initialization Parameters** (click it) you can view the parameters used for
this database.

![](media/a2478beab826088901fb775e0acb0ebf.png)
<p align="center">Figure 1-6</p>

6.  In **Services** you can see five services configured and discussed in the
services lab.

![](media/b1c756a1ad650d253802b07208fa7a9a.png)
<p align="center">Figure 1-7</p>

7. In **View Database Features Usage** you can see the features currently in use.
As with other views, columns can be sorted, so for example you can sort the
CURRENTLY_USED column by TRUE to see all the features being used:

![](media/7e6b836e9f3b8f6781ed545b2385b158.png)
<p align="center">Figure 1-8</p>

8. Open up **Database Status** and double click on **Instance Viewer.** This
displays a lot of information about the instance, usage and configuration as
well as the TOP SQL running on the instance. You can **select any SQL from TOP
SQL, left click and select Details**. This will create a new tab on the top
called SQL Details and put you in that tab. You can examine the SQL specifics
there.

![](media/a9db1b0611fb38ec2a34919c10676cb7.png)
<p align="center">Figure 1-9</p>

9. The **Performance** section will contain information relating to how the
database is performing. The most familiar tool for DBA’s will be the AWR
reports, found under **AWR-\>AWR Report Viewer**

![](media/f320dc357698e43cb49167a7b88c6652.png)
<p align="center">Figure 1-10</p>

10. The **RMAN Backup/Recovery** contains information about scheduled backups,
backup sets, RMAN Settings and schedules. Customers and DBA’s often ask about
backups on ATP and those can be explored in more detail in this section. In the
screenshoot below the backup sets for this instance are displayed (your instance
may not display any backups since it was just created)

![](media/c1b43e3b7481ef1212b202e959f6861d.png)
<p align="center">Figure 1-11</p>

11. The **Resource Manager** contains information about different consumer groups
and plans defined, and the current plan in effect. Explore the entries here,
most of them will have contextual activities if you select and right click on
them. Under **Plans-\>OLTP_PLAN** you will find the current plan being used,
which you can verify by double clicking on **Settings**, the second to last
option under **Resource Manager.** This will display which plan is being used.
Under **OLTP_PLAN** if you select and right click on any of the plans, and
select **Edit Directives**, the specifics of the plan will be displayed. Below
you will see the screenshot for the **\_HIGH** plan.

![](media/804725f72580eac6209ea5e79300bd21.png)
<p align="center">Figure 1-12</p>

12. The last entry under **Resource Manager-\>Statistics** provides graphical views
into system usage by plan user. Double click on Statistics and explore the
different screens.

13. The **Security** section will be very useful to DBA’s as they can explore all
the Profiles, and Roles defined in the system, and under **Users,** roles and
system priviledges granted to the user. Spend some time examining this area.

![](media/dab2281d80c02a668aae311babeb2816.png)
<p align="center">Figure 1-13</p>

14. The **Storage** section can be used to display all the storage characteristics
of the ATP database. Most of these characteristics cannot be changed, as the
Autonomous Database automatically manages and optimizes storage for the service.
However the configurations can be examined. For example any data in a database
will be stored in the DATA Tablespace. Below is a screenshot of the parameters
of the DATA Tablespace (Expand Tablespaces and then double click on DATA to
see). Examine the different entries in this area.

![](media/30429692aa1e3208160eaed105810d2e.png)
<p align="center">Figure 1-14</p>

**This concludes the SQL Developer Lab. SQL Developer is a very comprehensive
powerful tool and you should continue to explore the different benefits it
offers. Continue to look at all the attributes in the DBA view to see what else
you can find out about your ADB instance.**

***END OF LAB***

[Back to Top](#table-of-contents)   
