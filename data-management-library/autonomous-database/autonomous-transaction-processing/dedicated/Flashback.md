<table class="tbl-heading"><tr><td class="td-logo">

![](./images/obe_tag.png)

Sept 1, 2019
</td>
<td class="td-banner">
# Recover from user errors using flashback recovery
</td></tr><table>

To **log issues**, click [here](https://github.com/oracle/learning-library/issues/new) to go to the github oracle repository issue submission form.

## Introduction


**The Oracle Autonomous Database service comes pre-configured with a set of features collectively known as Flashback Technology that supports viewing past states of data, and winding and rewinding data back and forth in time, without requiring the restore of the database from backup. Depending on the changes to your database, Flashback Technology can often reverse the unwanted changes more quickly and with less impact on database availability.**

## Objectives

As an adminstrator,
- Learn how to set up recovery points in database change scripts
- Learn to recover from user errors such as unwanted commits and table drops


## Required Artifacts

- An Oracle Cloud Infrastructure account

- A pre-provisioned instance of Oracle Developer Client image in an application subnet. Refer to [Lab 5](ConfigureDevClient.md)

- A pre-provisioned Autonomous Transaction Processing instance. Refer to [Lab 4](./ProvisionADB.md)

## Steps

### **STEP 1: Log in to the Oracle Cloud Developer image and invoke SQL Developer**

To connect to your Oracle Cloud Developer image please refer to [Lab 5](ConfigureDevClient.md). If  you are already connected from the previous lab skip to **STEP 2**.  

**The remainder of this lab assumes you are connected to the image through VNC Viewer and are operating from the image itself and not your local machine (except if noted)**

- Connect to your developer client machine over VNC and invoke SQL Developer. Refer to [Lab 5](./1ConfigureDevClient.md) for detailed instructions 


- Next, open a connection to your dedicated autonomous DB instance. Once again, refer to [Lab 5](./1ConfigureDevClient.md) if you do not know how to do that. Alternatively, you may also use sqlcl or sql*plus clients for this lab but screenshots here are based on SQL Developer.


### **STEP 2: Recover from erroneous transactions**

**Lets first see how to recover from an accidental data loss.**

In SQL Developer worksheet, lets first make sure the database is in archivelog mode. An autonomous database is always created in archivelog mode.

````
select log_mode from v$database;
````
![](./images/Flashback/log_mode.png)


The Query result should indicate the database is in ARCHIVELOG mode

Next, lets create a sample table, insert and commit a row using the following script,

````
create table items(itemid NUMBER(5), qty Number(2), price Number(6,2));
insert into items values(1, 2, 10);
commit;
````

Before you can use Flashback Table, you must ensure that row movement is enabled on the table to be flashed back, or returned to a previous state. Row movement indicates that rowids will change after the flashback occurs

````
Alter table items enable row movement;
````

Now lets insert and commit a row in the items table.

````
insert into items values(1, 2, 10);
commit;
````


Let's assume a database change requires certain DML operations. As a best practice, you create a restore point at the start of the change.

````
create restore point BEFORE_DML;

````

Confirm your restore point was created

````
select * from v$restore_point;
````
![](./images/Flashback/restore_point2.png)

Next, execute and commit this delete statement
````
delete from items;
commit;
````

The data in table items is all gone. Now lets flashback the table to the restore point to recover the data.

````
flashback table items to restore point BEFORE_DML;

````
![](./images/Flashback/flashback.png)


And we are back in the game! 

Of Course, you can always run a check on the items table with a, 

````
select count(*) from items;

````



<table>
<tr><td class="td-logo">

[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
### Congratulations! You successfully learnt to recover from user errors using Oracle flashback.




</td>
</tr>
<table>