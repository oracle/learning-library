# Lab3 one-way-replication-mysql-to-oracle

## Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ will
capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process
‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’

### Objectives
Replication from relational source to a relational target using GoldenGate

Time to Complete -
Approximately 60 minutes

## Done by Student:


## STEPS-


Open a terminal session

![](./images/terminal2.png)

STEPS -
1. Oracle data capture
   a) To configure the Oracle Integrated Extract:
      i. Execute the GGSCI command: edit param etpc
	  ii. Enter the following settings:
	      extract etpc
          exttrail ./dirdat/et
          useridalias oggcapture
          reportcount every 120 seconds, rate
          ddloptions report
          warnlongtrans 60m, checkinterval 15m
          table pdbeast.tpc.*;
	  iii. Add the parameter that will cause Integrated Extract to capture DDL operations that are of mapped scope.
	  iv. Add the parameter that will cause Integrated Extract to encrypt its OGG Trail files.
	  v.Save and close the file.
   
2. Data transmission to MySQL
   a) This is not technically required because the OGG and MySQL installations are on the same machine. However, if data is being transmitted over a LAN/WAN an Extract Data Pump is required.
   b) To configure the Oracle to MySQL Extract Data Pump:
      i. Execute the GGSCI command: edit param pmysql
	  ii. Enter the following settings:
	      extract pmysql
          rmthost localhost, mgrport 8809
          rmttrail ./dirdat/rt
          reportcount every 120 seconds, rate
          table pdbeast.tpc.*;
	  iii. Add the RMTHOST option that will cause the Extract Data Pump to encrypt data transmissions with the aes256 algorithm.
	  iv. Save and close the file.
	  
3. Oracle data apply
   a) To configure the Parallel Replicat:
      i. Execute the GGSCI command: edit param rtpc
	  ii. Enter the following settings:
	      replicat rtpc
          useridalias ggapplywest
          map_parallelism 3
          split_trans_recs 1000
		  ddl include mapped
		  ddloptions report
          reportcount every 120 seconds, rate
          map pdbeast.tpc.*, target pdbwest.tpc.*;
iii. Add the parameters to auto-tune the number of Appliers; with a minimum of 3 and a maximum of 12.
	  iv. Save and close the file.

4. MySQL data apply
   a) To configure the Coordinated Replicat in the MySQL OGG environment:
       i. Execute the GGSCI command: edit param rtpc
	   ii. Enter the following settings:
	       replicat rtpc
           targetdb tpc@db-ora19-mysql:3306, useridalias ggapply
           reportcount every 120 seconds, rate
           usededicatedcoordinationthread
		   map pdbeast.tpc.categories, target "tpc"."categories", thread (20);
           map pdbeast.tpc.categories_description, target "tpc"."categories_description", thread (20);
           map pdbeast.tpc.customers, target "tpc"."customers", thread (20);
           map pdbeast.tpc.customers_info, target "tpc"."customers_info", thread (20);
           map pdbeast.tpc.customers_lkup, target "tpc"."customers_lkup", thread (20);
           map pdbeast.tpc.next_cust, target "tpc"."next_cust", thread (20);
           map pdbeast.tpc.next_order, target "tpc"."next_order", thread (20);
           map pdbeast.tpc.orders_total, target "tpc"."orders_total", thread (20);
           map pdbeast.tpc.products, target "tpc"."products", thread (20);
           map pdbeast.tpc.products_description, target "tpc"."products_description", thread (20);
           map pdbeast.tpc.products_to_categories, target "tpc"."products_to_categories", thread (20);
	   ii. Enter "MAP" statements for the following:
	       1) Operations for the table "tpc.orders" are to be applied by thread 1.
		   2) Operations for the table "tpc.orders_products" and to be ranged across threads 2, 3, and 4.
		   3) Operations for the table "tpc.orders_status_history" are to be ranged across threads 6 and 7.
	   iii. Save and close the file.
	
5. Enable schema level supplemental logging in source.
    a) To enable schema level supplemental logging in the source Oracle PDB:
	   i. Execute the GGSCI commands:
	      1) dblogin useridalias oggcapture
		  2) add schematrandata pdbeast.tpc
		  
6. Create the OGG replication Groups
   a) Create the OGG Groups by executing the following commands:
      i. Oracle Integrated Extract:
	     1) dblogin useridalias oggcapture
		 2) add extract etpc, integrated tranlog, begin now
		 3) register extract etpc, database, container (*)
		 4) add exttrail ./dirdat/et, extract etpc, megabytes 250
      ii. Oracle Extract Data Pump:
	     1) add extract pmysql, exttrailsource ./dirdat/et
		 2) add rmttrail ./dirdat/rt, extract pmysql, megabytes 250
      iii. Oracle Parallel Apply
	       1) dblogin useridalias ggapplywest
		   2) add replicat rtpc, parallel, exttrail ./dirdat/et, checkpointtable pdbwest.ggadmin.ggchkpoint
      iv. MySQL Coordinated Replicat
          1) dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias ggrep
          2) add replicat rtpc, coordinated, exttrail ./dirdat/rt

7. Start OGG and generate data
   a) Start the OGG environment:
      i. Oracle: start er *   
	  ii. MySQL: start er *
   b) Verify all OGG Groups are running.
   c) Generate data
      i. In the window connected to the database server:
	     1) Change to the "/Test_Software/Scripts/Oracle/orderentry" directory.
		 2) Login to the database as the user "tpc"
		    A) sqlplus tpc@pdbeast
			B) When prompted enter the password: Oracle1
			C) At the SQL> prompt, enter: @gentrans.sql
			D) Enter "100" at the prompt, and return.

8. Verify data has been replicated
   a) Check that all OGG Groups remain running.			
       i. For any STOPPED or ABEND groups, view their report file to find the error.
   b) Use the ggsci "stats" command to see how many operations were processed by each Extract and Replicat.
   c) Use the ggsci "view report" command to see how many operations were processed per second by each Extract and Replicat.
   d) For MySQL, use the ggsci command "info rtpc, detail" to see how many Replicats were spawned.
   e) On the database server:
      i. Login to PDBWEST as ggadmin: sqlplus ggadmin@pdbwest
	  ii. When prompted enter the password: Oracle1
	  iii. Execute the following query to see additional information about lag:  
      set heap on
      set wrap off
      set line 300
      column Extract format a9
      column Data_Pump format a10
      column Replicat format a9
select to_char(incoming_heartbeat_ts,'DD-MON-YY HH24:MI:SSxFF') Source_HB_Ts
       , incoming_extract Extract
       , extract (day from (incoming_extract_ts - incoming_heartbeat_ts))*24*60*60+
         extract (hour from (incoming_extract_ts - incoming_heartbeat_ts))*60*60+
         extract (minute from (incoming_extract_ts - incoming_heartbeat_ts))*60+
         extract (second from (incoming_extract_ts - incoming_heartbeat_ts)) Extract_Lag
       , incoming_routing_path Data_Pump
       , extract (day from (incoming_routing_ts - incoming_extract_ts))*24*60*60+
         extract (hour from (incoming_routing_ts - incoming_extract_ts))*60*60+
         extract (minute from (incoming_routing_ts - incoming_extract_ts))*60+
         extract (second from (incoming_routing_ts - incoming_extract_ts)) Data_Pump_Read_Lag
       , incoming_replicat Replicat
       , extract (day from (incoming_replicat_ts - incoming_routing_ts))*24*60*60+
         extract (hour from (incoming_replicat_ts - incoming_routing_ts))*60*60+
         extract (minute from (incoming_replicat_ts - incoming_routing_ts))*60+
         extract (second from (incoming_replicat_ts - incoming_routing_ts)) Replicat_Read_Lag
       , extract (day from (heartbeat_received_ts - incoming_replicat_ts))*24*60*60+
         extract (hour from (heartbeat_received_ts - incoming_replicat_ts))*60*60+
         extract (minute from (heartbeat_received_ts - incoming_replicat_ts))*60+
         extract (second from (heartbeat_received_ts - incoming_replicat_ts)) Replicat_Apply_Lag
       , extract (day from (heartbeat_received_ts - incoming_heartbeat_ts))*24*60*60+
         extract (hour from (heartbeat_received_ts - incoming_heartbeat_ts))*60*60+
         extract (minute from (heartbeat_received_ts - incoming_heartbeat_ts))*60+
         extract (second from (heartbeat_received_ts - incoming_heartbeat_ts)) Total_Lag
      from ggadmin.gg_heartbeat_history order by heartbeat_received_ts desc;

 9. Replicate Oracle DDL 
    a) On the database server:
      i. Login to PDBEAST as tpc: sqlplus tpc@pdbeast
	  ii. When prompted enter the password: Oracle1
	  iii. Execute the following:
	       create table ddltest (
           cola number(15,0) not null,
           colb timestamp(6) not null,
           colc varchar(100),
           primary key (cola)
           );
           insert into ddltest values (1, CURRENT_TIMESTAMP, 'Row 1 insert');
           insert into ddltest values (2, CURRENT_TIMESTAMP, 'Row 2 insert');
           insert into ddltest values (3, CURRENT_TIMESTAMP, 'Row 3 insert');
           insert into ddltest values (4, CURRENT_TIMESTAMP, 'Row 4 insert');
           insert into ddltest values (5, CURRENT_TIMESTAMP, 'Row 5 insert');
           commit;

           update ddltest set colb=CURRENT_TIMESTAMP, colc='Row 3 update' where cola=3;
           delete from ddltest where cola=2;
           commit;
    b) View the Oracle Replicat report file to validate the DDL was applied.
	c) Execute the GGSCI "stats" command to see information for the table ddltest
	   i. stats rtpc, table pdbwest.tpc.ddltest 

 10. Shutdown all Extracts and Replicats.

**End of Lab 3 - You may proceed to the next Lab**

## Acknowledgements

  * Authors ** - Brian Elliott, Zia Khan
  * Contributors ** - Brian Elliott, Zia Khan
  * Team ** - Data Integration Team
  * Last Updated By/Date ** - Brian Elliott / September 2020
