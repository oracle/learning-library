# SQL and PL/SQL - Sequences

## Introduction

This lab walks you through the use of SEQUENCES in a RAC database.

Estimated Lab Time: 10 Minutes
### Prerequisites
- An Oracle LiveLabs or Paid Oracle Cloud account
- Lab: Generate SSH Key
- Lab: Build a DB System
- Lab: Fast Application Notification
- Lab: Install Sample Schema
- Lab: Services

Watch the video below for an overview of the SQL and PL/SQL Sequences lab
[](youtube:x8UkHPBkwJo)

## **STEP 1:**  Build Tom Kyte's RUNSTATS package

1.  If you aren't already logged in to the Oracle Cloud, open up a web browser and re-login to Oracle Cloud.

2.  Start Cloud Shell

    *Note:* You can also use Putty or MAC Cygwin if you chose those formats in the earlier lab.  
    ![](../clusterware/images/start-cloudshell.png " ")

3.  Connect to **node 1** as the *opc* user (you identified the IP address of node 1 in the Build DB System lab).

    ````
    ssh -i ~/.ssh/sshkeyname opc@<<Node 1 Public IP Address>>
    ````
    ![](../clusterware/images/racnode1-login.png " ")

4.  Connect to the pluggable database, **PDB1** as SYSDBA.  Replace the password below with the password you used to provision your system.

    ````
    <copy>
    sudo su - oracle
    srvctl config scan
    sqlplus sys/W3lc0m3#W3lc0m3#@//<PutScanNameHere>/pdb1.pub.racdblab.oraclevcn.com as sysdba
    </copy>
    ````
    ![](./images/seq-step1-num4.png " ")

5. Build the **runstats** package by pasting this in your sql prompt

    ````
    <copy>
    create global temporary table run_stats
    ( runid varchar2(15),
      name varchar2(80),
      value int )
    on commit preserve rows;

    create or replace view stats
    as select 'STAT...' || a.name name, b.value
       from v$statname a, v$mystat b
       where a.statistic# = b.statistic#
       union all
       select 'LATCH.' || name,  gets
          from v$latch
	     union all
	     select 'STAT...Elapsed Time', hsecs from v$timer;


    create or replace package runstats_pkg
    as
       procedure rs_start;
       procedure rs_middle;
       procedure rs_stop( p_difference_threshold in number default 0 );
    end;
   /

   create or replace package body runstats_pkg
   as

    g_start number;
    g_run1  number;
    g_run2  number;

    procedure rs_start
    is
      begin
      delete from run_stats;

      insert into run_stats
      select 'before', stats.* from stats;

      g_start := dbms_utility.get_time;
    end;

    procedure rs_middle
    is
      begin
      g_run1 := (dbms_utility.get_time-g_start);

      insert into run_stats
      select 'after 1', stats.* from stats;
      g_start := dbms_utility.get_time;
    end;

    procedure rs_stop(p_difference_threshold in number default 0)
    is
     begin
     g_run2 := (dbms_utility.get_time-g_start);

     dbms_output.put_line ( 'Run1 ran in ' || g_run1 || ' hsecs' );
     dbms_output.put_line  ( 'Run2 ran in ' || g_run2 || ' hsecs' );
     dbms_output.put_line  ( 'run 1 ran in ' || round(g_run1/g_run2*100,2) || '% of the time' );
     dbms_output.put_line( chr(9) );

     insert into run_stats select 'after 2', stats.* from stats;

     dbms_output.put_line ( rpad( 'Name', 30 ) || lpad( 'Run1', 12 ) || lpad( 'Run2', 12 ) || lpad( 'Diff', 12 ) );

     for x in
       ( select rpad( a.name, 30 ) ||
             to_char( b.value-a.value, '999,999,999' ) ||
             to_char( c.value-b.value, '999,999,999' ) ||
             to_char( ( (c.value-b.value)-(b.value-a.value)), '999,999,999' ) data
         from run_stats a, run_stats b, run_stats c
         where a.name = b.name
         and b.name = c.name
         and a.runid = 'before'
         and b.runid = 'after 1'
         and c.runid = 'after 2'
         -- and (c.value-a.value) > 0
         and abs( (c.value-b.value) - (b.value-a.value) ) > p_difference_threshold
        order by abs( (c.value-b.value)-(b.value-a.value))
       ) loop
          dbms_output.put_line( x.data );
       end loop;

     dbms_output.put_line( chr(9) );
     dbms_output.put_line ( 'Run1 latches total versus runs -- difference and pct' );
     dbms_output.put_line ( lpad( 'Run1', 12 ) || lpad( 'Run2', 12 ) || lpad( 'Diff', 12 ) || lpad( 'Pct', 10 ) );

     for x in
       ( select to_char( run1, '999,999,999' ) ||
             to_char( run2, '999,999,999' ) ||
             to_char( diff, '999,999,999' ) ||
             to_char( round( run1/run2*100,2 ), '99,999.99' ) || '%' data
        from ( select sum(b.value-a.value) run1, sum(c.value-b.value) run2,
                      sum( (c.value-b.value)-(b.value-a.value)) diff
                 from run_stats a, run_stats b, run_stats c
                where a.name = b.name
                  and b.name = c.name
                  and a.runid = 'before'
                  and b.runid = 'after 1'
                  and c.runid = 'after 2'
                  and a.name like 'LATCH%'
                )
         ) loop
            dbms_output.put_line( x.data );
         end loop;
     end;
    end;
    /
    </copy>
    ````

    ![](./images/seq-step1-num4.png " ")

## **STEP 2:** Sequence Test

1. Open a connection to the pluggable database PDB1 as SYS on each node. We are forcing connections to a given instance.

2. You should still be connected as the *sys* user on **node 1**.  If you disconnected, connect to **node 1** as the *opc* user and switch to the *oracle* user.  *Remember to replace the password as you did in Step 1.*

    ````
    <copy>
    sudo su - oracle
    sqlplus sys/W3lc0m3#W3lc0m3#@//<PutHostNameHere>:1521/unisrv.pub.racdblab.oraclevcn.com as sysdba
    </copy>
    ````
3. Connect to **node 2** as the *opc* user and switch to the *oracle* user.  *Remember to replace the password as you did in Step 1.*

    ````
    <copy>
    sudo su - oracle
    sqlplus sys/W3lc0m3#W3lc0m3#@//<PutHostNameHere>:1521/unisrv.pub.racdblab.oraclevcn.com as sysdba
    </copy>
    ````
    ![](./images/sqlplus-node2.png " ")

4. Create the following SEQUENCES on *one* **node 1**

    ````
    <copy>
    create table SEQTEST (seqid varchar2(30), highval number);
    insert into SEQTEST values ('MYTABLE', 1);
    commit;
    create sequence SEQTEST_O_NC ORDER NOCACHE;
    create sequence SEQTEST_O_C ORDER CACHE 100;
    create sequence SEQTEST_NO_NC NOORDER NOCACHE;
    create sequence SEQTEST_NO_C NOORDER CACHE 100;
    set serveroutput on;
    </copy>
    ````
    ![](./images/create-seq.png " ")

5. On **node 1** run the following statements 2 or 3 times in the sqlplus window you are still logged into.

    ````
    <copy>
    exec runstats_pkg.rs_start;
    DECLARE myval number;
    BEGIN FOR counter IN 1..10
      LOOP
         select highval into myval from SEQTEST where seqid='MYTABLE' for update;
         update SEQTEST set highval=highval+1 where seqid='MYTABLE';
         dbms_lock.sleep(0.5);
         commit;
      END LOOP;
    END;
    /
    exec runstats_pkg.rs_middle;
    DECLARE myval number;
    BEGIN FOR counter IN 1..10
       LOOP
          myval := SEQTEST_O_C.NEXTVAL;
	        dbms_lock.sleep(0.5);
	        commit;
       END LOOP;
    END;
    /
    exec runstats_pkg.rs_stop;
    </copy>
    ````

6. The runstats results will show similar to:
    ````
    SQL> Run1 ran in 502 hsecs
         Run2 ran in 502 hsecs
         run 1 ran in 100% of the time
    ````
Deduct 500 hsecs from this value to account for the 0.5 seconds in DBMS_LOCK.sleep

4. Create some contention on node 2
Start an anonymous PL/SQL block that retrieves a value every half second.
    ````
    <copy>
    DECLARE myval number;
    BEGIN
       LOOP
          select highval into myval from SEQTEST where seqid='MYTABLE' for update;
          update SEQTEST set highval=highval+1 where seqid='MYTABLE';
          select SEQTEST_O_NC.NEXTVAL into myval from dual;
          select SEQTEST_O_C.NEXTVAL into myval from dual;
          select SEQTEST_NO_NC.NEXTVAL into myval from dual;
          select SEQTEST_NO_C.NEXTVAL into myval from dual;
          dbms_lock.sleep(0.5);
          commit;
       END LOOP;
    END;
    /
    </copy>
    ````

5. Repeat step 3 on node 1 and observe the run statistics.
Contention plays a part.
    ````
    SQL> Run1 ran in 6312 hsecs
         Run2 ran in 501 hsecs
         run 1 ran in 1259.88% of the time
    ````
Notice the difference between operations that use sequence that CACHE versus NOCACHE, ORDER versus NOORDER and combinations of these.

6. Perform more tests, comparing different types of sequences. What conclusions can you draw about sequences? Does caching matter for ORDERed sequences?

    ````
    <copy>
    DECLARE myval number;
    BEGIN
       FOR counter IN 1..10
         LOOP
	          myval := SEQTEST_O_NC.NEXTVAL;
	          dbms_lock.sleep(0.5);
            commit;
        END LOOP;
    END;
    /
    exec runstats_pkg.rs_middle;
    DECLARE myval number;
    BEGIN
       FOR counter IN 1..10
          LOOP
	           myval := SEQTEST_O_C.NEXTVAL;
		         dbms_lock.sleep(0.5);
		         commit;
	        END LOOP;
    END;
    /
    exec runstats_pkg.rs_stop;
    </copy>
    ````
You may now *proceed to the next lab*.  


## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** - Kay Malcolm, Kamryn Vinson
* **Last Updated By/Date** - Kamryn Vinson, March 2021
