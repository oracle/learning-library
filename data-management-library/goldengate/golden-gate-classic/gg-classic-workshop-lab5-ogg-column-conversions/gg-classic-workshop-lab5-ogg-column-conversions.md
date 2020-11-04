# Lab 5 - ogg-column-conversions

### Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. I
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ and will
capture the column changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’

### Objectives
Replication of column conversions from relational source to a relational target using GoldenGate

Time to Complete -
Approximately 60 minutes

## Done by Student:

## STEPS-

## Step 1: - GoldenGate GoldenGate - Oracle Replication

1. Open a terminal session

![](./images/terminal2.png)

2. Oracle source table.

Connect to the PDBEAST database as the user "tpc".

3. Execute the following DML to create the source table:
      drop table wshop_funcs;
      create table wshop_funcs (
        row_number    	number(3,0),
        row_text		varchar2(25),
        row_insert_ts         timestamp(6),
        row_insert_by         varchar(6),
        row_update_ts         timestamp(6),
        row_update_by         varchar(6),
        primary key (row_number)
      );

      drop table cust_zip;
      create table cust_zip (
        cust_id              number(10,0),
        cust_zip             number(5,0),
        primary key (cust_id)
      ); 
## Step 2: - GoldenGate GoldenGate - MySQL Target Replication

1. MySQL target table.

Connect to the MySQL database as the user "tpc".

3. mysql -u tpc -p@Oracle1@

4. Execute the following DML to create the target tables:
      use tpc;
    	drop table wshop_funcs;
      create table wshop_funcs (
        srow_number       	numeric(3,0),
        srow_text		    varchar(55),
        srow_insert_ts     datetime(6),
        srow_insert_by     varchar(6),
        srow_update_ts     datetime(6),
        srow_update_by     varchar(6),
        gg_commit_ts      datetime(6),
        lag_extract_ms    numeric(10,0),
        lag_replicat_ms   numeric(10,0),
        src_db_name       varchar(10),
        src_db_version    varchar(75),
        src_txn_csn       numeric(9,0),
        CONSTRAINT PK_Funcs primary key (srow_number,gg_commit_ts)
      ) engine=innodb;
  
      drop table cust_city_state;
      create table cust_city_state (
        cust_id              numeric(10,0),
        cust_city            varchar(25),
        cust_state           char(2),
        cust_zip             int(5),
        CONSTRAINT PK_CustCtySt primary key (cust_id)
      ) engine=innodb;

      drop table zip_lookup;
      create table zip_lookup (
        zip         int(5),
        zip_city    varchar(25),
        zip_state   char(2),
        CONSTRAINT PK_Zplk primary key (zip)
      ) engine=innodb;

      insert into zip_lookup values (80033, 'Wheat Ridge', 'CO');
      insert into zip_lookup values (80202, 'Denver', 'CO');
      insert into zip_lookup values (94105, 'San Francisco', 'CA');
      insert into zip_lookup values (70001, 'Jefferson', 'LA');
      insert into zip_lookup values (70117, 'New Orleans', 'LA');
      commit;

## Step 3: - GoldenGate GoldenGate - Oracle Data Capture

Oracle data capture

1. Edit the parameter file for the ETPC Integrated Extract.

2. Add the following table statement:
table pdbeast.tpc.wshop_funcs, TOKENS (
           TKN-EXTLAG-MSEC = @GETENV ("LAG", "MSEC"),
           TKN-SRC-DBNAME = @GETENV ("DBENVIRONMENT", "DBNAME"),
           TKN-SRC-DBVERSION = @GETENV ("DBENVIRONMENT", "DBVERSION"),
           TKN-TXN-CSN = @GETENV ("TRANSACTION", "CSN")
         );

3. Save and close the file.

When using wildcards, where do table statements like the one above need to be placed?
Do you need to exclude the table from being captured via the wildcards? (If so, did you do this?)

## Step 4: - GoldenGate GoldenGate -MySQL Data Apply

MySQL data apply

1. Edit the parameter file for the RTPC Coordinated Replicat.

2. Add the following map statements, specifying thread "10" for the data apply:

3. Execute a query against a lookup table to get the city and state for the
incoming zip code
        MAP pdbeast.tpc.cust_zip, TARGET tpc.cust_city_state,
         SQLEXEC (ID ZIPLKUP, 
           QUERY 'select zip_city, zip_state from tpc.zip_lookup where zip = ?',
           PARAMS (p1 = cust_zip)),
         COLMAP (usedefaults,
                 cust_city = ZIPLKUP.zip_city,
                 cust_state = ZIPLKUP.zip_state
        )
MAP pdbeast.tpc.wshop_funcs, TARGET tpc.wshop_funcs,
           colmap (usedefaults,
		           srow_number = row_number,
                   srow_text = row_text,
                   srow_insert_ts = row_insert_ts,
                   srow_insert_by = row_insert_by,
                   srow_update_ts = row_update_ts,
                   srow_update_by = row_update_by,
                   gg_commit_ts = @GETENV ("GGHEADER", "COMMITTIMESTAMP"),
                   lag_extract_ms = @TOKEN ("TKN-EXTLAG-MSEC"),
                   lag_replicat_ms = @GETENV ("LAG", "MSEC"),
                   src_db_name = @TOKEN ("TKN-SRC-DBNAME"),
                   src_db_version = @TOKEN ("TKN-SRC-DBVERSION"),
                   src_txn_csn = @TOKEN ("TKN-TXN-CSN")
         )	 

4. Set the Replicat to insert all data into the table tpc.wshop_funcs, no matter the 
	      source operation.

5. Save and close the file.		


## Step 5: - GoldenGate GoldenGate - Start GoldenGate and Generate Data

Start OGG and generate data

1. Start the OGG environment:

2. Oracle: 
start etpc
       start pmysql  


3. MySQL: start rtpc
Verify all OGG Groups are running.
Generate data  
In the window connected to the database server:
Login to the PDBEAST database as the user "tpc"
sqlplus tpc@pdbeast
When prompted enter the password: Oracle
Execute the following:
		    DECLARE
              v_MainLoop     NUMBER(3);
              v_Txt          VARCHAR2(25);
            BEGIN
              FOR v_MainLoop IN 1 .. 20 LOOP
                SELECT DBMS_RANDOM.STRING('A', 25) INTO v_Txt FROM DUAL;
                INSERT INTO WSHOP_FUNCS values (v_MainLoop, v_Txt, CURRENT_TIMESTAMP, 'EAST', NULL, NULL);
                COMMIT;
              END LOOP;
   
              FOR v_MainLoop IN 1 .. 7 LOOP
                SELECT DBMS_RANDOM.STRING('A', 25) INTO v_Txt FROM DUAL;
                UPDATE WSHOP_FUNCS SET ROW_TEXT = v_Txt, ROW_UPDATE_TS = CURRENT_TIMESTAMP, ROW_UPDATE_BY = 'LOREN' WHERE ROW_NUMBER = v_MainLoop;
                COMMIT;
              END LOOP;  

              INSERT INTO CUST_ZIP VALUES (1, 80033);
              COMMIT;

              INSERT INTO CUST_ZIP VALUES (2, 70117);
              COMMIT;

              INSERT INTO CUST_ZIP VALUES (3, 94105);
              COMMIT;

              INSERT INTO CUST_ZIP VALUES (4, 80202);
              COMMIT;

              INSERT INTO CUST_ZIP VALUES (5, 70001);
              COMMIT;
   
              END;
              /
			  
4. Verify data has been replicated.

5. Use the GGSCI "send report" command to generate stats for the rtpc Coordinated Replicat.

6. View the report file to validate sqlexec execution are data apply stats.

7. Connect to the MySQL database as the user "tpc".
mysql -u tpc -p@Oracle1@
View the data in the tpc.cust_city_state table.
View the data in the tpc.wshop_funcs table.
   
8. Shutdown all Extracts and Replicats.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Brian Elliott, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

  