# Deploy ADG Process

This procedure is basically the same as migrating the database from on-premise to OCI. The Data Guard setup for a Single Instance (SI) or RAC should be the same. In the following steps you will setup Data Guard from an SI on-premise to an SI in the cloud infrastructure. If you want to setup Data Guard from an SI on-premise to a 2-Node RAC in the cloud infrastructure or RAC on-premise to an SI in the cloud infrastructure please refer to the whitepaper [hybrid-dg-to-oci-5444327](https://www.oracle.com/technetwork/database/availability/hybrid-dg-to-oci-5444327.pdf).

##Lab Prerequisites

This lab assumes you have already completed the following labs:

- Prepare On Premise Database (with LVM)
- Provision DBCS on OCI
- Setup Connectivity between on-premise and DBCS

**Note: The following steps is for the cloud database using LVM for the storage management in Lab5. If you chose ASM for the storage, please use the other Lab for ASM.**

##Step 1: Manually Delete the Database Created by Tooling 

Please perform the below operations to delete the starter database files in the cloud and we will restore the on-premise database using RMAN. 

To delete the starter database, use the manual method of removing the database files from OS file system. Do not use DBCA as this will also remove the srvctl registration as well as the /etc/oratab entries which should be retained for the standby. 

To manually delete the database on the cloud host, run the steps below.

1. Connect to the DBCS VM which you created in Lab5 with opc user. Use putty tool (Windows) or command line (Mac, linux)

   ```
   ssh -i labkey opc@xxx.xxx.xxx.xxx
   ```

   

2. Switch to the **oracle** user. 

   ```
   <copy>sudo su - oracle</copy>
   ```

   

3. Connect database as sysdba. Get the current `db_unique_name` for the Cloud database. 

```
SQL> select DB_UNIQUE_NAME from v$database;

DB_UNIQUE_NAME
------------------------------
ORCL_nrt1d4
```

4. Copy the following scripts, replace the `ORCL_nrt1d4` with the standby `DB_UNIQUE_NAME` which you got in the previous step.

   ```
   <copy>
   set heading off linesize 999 pagesize 0 feedback off trimspool on
   spool /tmp/files.lst
   select 'rm '||name from v$datafile union all select 'rm '||name from v$tempfile union all select 'rm '||member from v$logfile;
   spool off
   create pfile='/tmp/ORCL_nrt1d4.pfile' from spfile;
   </copy>
   ```

   

5. Run in sqlplus as sysdba. This will create a script to remove all database files. 

```
[oracle@dbstby ~]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Fri Jan 31 08:20:03 2020
Version 19.7.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
Version 19.7.0.0.0

SQL> set heading off linesize 999 pagesize 0 feedback off trimspool on
SQL> spool /tmp/files.lst
SQL> select 'rm '||name from v$datafile union all select 'rm '||name from v$tempfile union all select 'rm '||member from v$logfile;
rm /u02/app/oracle/oradata/ORCL_nrt1d4/PDB1/system01.dbf
rm /u02/app/oracle/oradata/ORCL_nrt1d4/PDB1/sysaux01.dbf
rm /u02/app/oracle/oradata/ORCL_nrt1d4/PDB1/undotbs01.dbf
rm /u02/app/oracle/oradata/ORCL_nrt1d4/PDB1/users01.dbf
rm /u02/app/oracle/oradata/ORCL_nrt1d4/temp01.dbf
rm /u02/app/oracle/oradata/ORCL_nrt1d4/pdbseed/temp012020-01-23_14-38-01-789-PM.dbf
rm /u02/app/oracle/oradata/ORCL_nrt1d4/PDB1/temp01.dbf
rm /u03/app/oracle/oradata/ORCL_nrt1d4/srl_redo01.log
rm /u03/app/oracle/oradata/ORCL_nrt1d4/srl_redo02.log
rm /u03/app/oracle/oradata/ORCL_nrt1d4/srl_redo03.log
rm /u03/app/oracle/oradata/ORCL_nrt1d4/redo04.log
...
SQL> spool off
SQL> create pfile='/tmp/ORCL_nrt1d4.pfile' from spfile;
SQL>  
```

6. Shutdown the database. 

```
SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> exit
Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
Version 19.7.0.0.0
[oracle@dbstby ~]$ 
```

7. Remove database files 

 Remove the existing data files, log files, and tempfile(s). The password file will be replaced and the spfile will be reused. 

 Edit /tmp/files.lst created previously to remove any unneeded lines from sqlplus. Leaving all lines beginning with 'rm'. Then run it.

 ```
 [oracle@dbstby ~]$ chmod 777 /tmp/files.lst
 [oracle@dbstby ~]$ vi /tmp/files.lst
 [oracle@dbstby ~]$ . /tmp/files.lst
 [oracle@dbstby ~]$ 
 ```

 All files for the starter database have now been removed. 



## Step 2: Copy the Password File to the Cloud host 

As **oracle** user, copy the on-premise database password file to cloud host `$ORACLE_HOME/dbs` directory. 

1. Copy the following command, change the (xxx.xxx.xxx.xxx) to the on-premise host public ip.

```
<copy>scp oracle@xxx.xxx.xxx.xxx:/u01/app/oracle/product/19c/dbhome_1/dbs/orapwORCL $ORACLE_HOME/dbs</copy>
```

2. Run the command as **oracle** user.

```
[oracle@dbstby ~]$ scp oracle@xxx.xxx.xxx.xxx:/u01/app/oracle/product/19c/dbhome_1/dbs/orapwORCL $ORACLE_HOME/dbs
orapwORCL 100% 2048    63.5KB/s   00:00    
[oracle@dbstby ~]$
```



## Step 3: Copying the wallet file to the Cloud host. 

Make sure that `$ORACLE_HOME/network/admin/sqlnet.ora` contains the following line wallet file location is defined as `ENCRYPTION_WALLET_LOCATION` parameter in sqlnet.ora.

   - From on-premise side

   ```
   ENCRYPTION_WALLET_LOCATION =
      (SOURCE = (METHOD = FILE)
        (METHOD_DATA =
         (DIRECTORY = /u01/app/oracle/admin/ORCL/wallet)
        )
      )
   ```

   - From cloud side

   ```
   ENCRYPTION_WALLET_LOCATION=(SOURCE=(METHOD=FILE)(METHOD_DATA=(DIRECTORY=/opt/oracle/dcs/commonstore/wallets/tde/$ORACLE_UNQNAME)))
   ```

1. Copy the following command, change the (xxx.xxx.xxx.xxx) to the on-premise host public ip.  Change `ORCL_nrt1d4` to the unique name of your standby db.

   ```
   <copy>
   scp oracle@xxx.xxx.xxx.xxx:/u01/app/oracle/admin/ORCL/wallet/ewallet.p12 /opt/oracle/dcs/commonstore/wallets/tde/ORCL_nrt1d4
   scp oracle@xxx.xxx.xxx.xxx:/u01/app/oracle/admin/ORCL/wallet/cwallet.sso /opt/oracle/dcs/commonstore/wallets/tde/ORCL_nrt1d4
   chmod 600 /opt/oracle/dcs/commonstore/wallets/tde/ORCL_nrt1d4/*wallet*
   </copy>
   ```

   

2. Run this command as **oracle user**, copy the wallet files from on-premise host and change the files mode to 600.

```
[oracle@dbstby ~]$ scp oracle@xxx.xxx.xxx.xxx:/u01/app/oracle/admin/ORCL/wallet/ewallet.p12 /opt/oracle/dcs/commonstore/wallets/tde/ORCL_nrt1d4
ewallet.p12                                                                                       100% 5467   153.2KB/s   00:00    
[oracle@dbstby ~]$ scp oracle@xxx.xxx.xxx.xxx:/u01/app/oracle/admin/ORCL/wallet/cwallet.sso /opt/oracle/dcs/commonstore/wallets/tde/ORCL_nrt1d4
cwallet.sso                                                                                       100% 5512   147.4KB/s   00:00    
[oracle@dbstby ~]$ chmod 600 /opt/oracle/dcs/commonstore/wallets/tde/ORCL_nrt1d4/*wallet*
[oracle@dbstby ~]$
```



## Step 4: Configure Static Listeners 

A static listener is needed for initial instantiation of a standby database. The static listener enables remote connection to an instance while the database is down in order to start a given instance. See MOS 1387859.1 for additional details.  A static listener for Data Guard Broker is optional. 

1. From on-premise side

   - Switch to the **oracle** user, edit listener.ora

   ```
   <copy>vi $ORACLE_HOME/network/admin/listener.ora</copy>
   ```

   - Add following lines into listener.ora

```
<copy>
SID_LIST_LISTENER=
  (SID_LIST=
    (SID_DESC=
     (GLOBAL_DBNAME=ORCL)
     (ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1)
     (SID_NAME=ORCL)
    )
    (SID_DESC=
     (GLOBAL_DBNAME=ORCL_DGMGRL)
     (ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1)
     (SID_NAME=ORCL)
    )
  )
</copy>
```

   - Reload the listener

   ```
   [oracle@workshop ~]$ lsnrctl reload

   LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 31-JAN-2020 11:27:23

   Copyright (c) 1991, 2019, Oracle.  All rights reserved.

   Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=workshop)(PORT=1521)))
   The command completed successfully
   [oracle@dbstby ~]$ 
   ```

2. From cloud side

   - Switch to the **oracle** user, edit listener.ora

   ```
   <copy>vi $ORACLE_HOME/network/admin/listener.ora</copy>
   ```

   - Add following lines into listener.ora, replace `ORCL_nrt1d4` with your standby db unique name.

```
<copy>
SID_LIST_LISTENER=
  (SID_LIST=
    (SID_DESC=
     (GLOBAL_DBNAME=ORCL_nrt1d4)
     (ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1)
     (SID_NAME=ORCL)
    )
    (SID_DESC=
     (GLOBAL_DBNAME=ORCL_nrt1d4_DGMGRL)
     (ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1)
     (SID_NAME=ORCL)
    )
  )
</copy>
```

   - Reload the listener

   ```
   [oracle@dbstby ~]$ $ORACLE_HOME/bin/lsnrctl reload

   LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 31-JAN-2020 11:39:12

   Copyright (c) 1991, 2019, Oracle.  All rights reserved.

   Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=IPC)(KEY=LISTENER)))
   The command completed successfully
   [oracle@dbstby ~]$ 
   ```

3. Mount the Standby database.

```
[oracle@dbstby ~]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 10:50:18 2020
Version 19.7.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> startup mount
ORACLE instance started.

Total System Global Area 1.6106E+10 bytes
Fixed Size		    9154008 bytes
Variable Size		 2080374784 bytes
Database Buffers	 1.3992E+10 bytes
Redo Buffers		   24399872 bytes
Database mounted.
SQL> exit
Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
Version 19.7.0.0.0
[oracle@dbstby ~]$ 
```



## Step 5: TNS Entries for Redo Transport 

1. From on-premise side, switch as **oracle** user, edit the tnsnames.ora

```
<copy>vi $ORACLE_HOME/network/admin/tnsnames.ora</copy>
```

Add following lines into tnsnames.ora, replace xxx.xxx.xxx.xxx with the public ip or hostname of the cloud hosts, replace `ORCL_nrt1d4` with your standby db unique name.

```
ORCL_nrt1d4 =
  (DESCRIPTION =
   (SDU=65536)
   (RECV_BUF_SIZE=134217728)
   (SEND_BUF_SIZE=134217728)
   (ADDRESS_LIST =
    (ADDRESS = (PROTOCOL = TCP)(HOST = xxx.xxx.xxx.xxx)(PORT = 1521))
   )
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = ORCL_nrt1d4)
      (UR=A)
    )
  )
```

2. From cloud side, switch as **oracle** user, edit the tnsnames.ora

```
vi $ORACLE_HOME/network/admin/tnsnames.ora
```

In the `ORCL_NRT1D4`(Standby db unique name) description, delete the domain name of the SERVICE_NAME. Add the ORCL description, replace xxx.xxx.xxx.xxx with the public ip or hostname of the on-premise hosts.  It's looks like the following.  Replace `ORCL_nrt1d4` with your standby db unique name.

**Note:** The different database domain name will get an error when doing the DML Redirection, in this lab, we don't use database domain name.

```
# tnsnames.ora Network Configuration File: /u01/app/oracle/product/19.0.0.0/dbhome_1/network/admin/tnsnames.ora
# Generated by Oracle configuration tools.

ORCL_NRT1D4 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = dbstby)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = ORCL_nrt1d4)
    )
  )

LISTENER_ORCL =
  (ADDRESS = (PROTOCOL = TCP)(HOST = dbstby)(PORT = 1521))
  
ORCL =
  (DESCRIPTION =
   (SDU=65536)
   (RECV_BUF_SIZE=134217728)
   (SEND_BUF_SIZE=134217728)
   (ADDRESS_LIST =
    (ADDRESS = (PROTOCOL = TCP)(HOST = XXX.XXX.XXX.XXX)(PORT = 1521))
   )
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = ORCL)
      (UR=A)
    )
  )
```

3. Set TCP socket size, adjust all socket size maximums to 128MB or 134217728. This is only needed  to set in the on-premise side, the cloud side has already been set by default

- From on-premise side, switch to **opc** user, edit the config file.

```
<copy>sudo vi /etc/sysctl.conf</copy>
```

- Search and modify following entry to the values, save and exit.

```
<copy>
net.core.rmem_max = 134217728 
net.core.wmem_max = 134217728
</copy>
```

- Reload and check the values.

```
[opc@adgstudent1 ~]$ sudo /sbin/sysctl -p
fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 134217728
net.core.wmem_default = 262144
net.core.wmem_max = 134217728
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
[opc@adgstudent1 ~]$ sudo /sbin/sysctl -a | egrep net.core.[w,r]mem_max
net.core.rmem_max = 134217728
net.core.wmem_max = 134217728
sysctl: reading key "net.ipv6.conf.all.stable_secret"
sysctl: reading key "net.ipv6.conf.default.stable_secret"
sysctl: reading key "net.ipv6.conf.ens3.stable_secret"
sysctl: reading key "net.ipv6.conf.lo.stable_secret"
[opc@adgstudent1 ~]$ 
```



## Step 6: Instantiate the Standby Database 

The standby database can be created from the active primary database.

1. From Cloud side, switch to **oracle** user, create pdb directory, Replace `ORCL_nrt1d4` with your standby db unique name. If the directory exist, ignore the error

```
[oracle@dbstby ~]$ mkdir -p /u02/app/oracle/oradata/ORCL_nrt1d4/pdbseed
mkdir: cannot create directory '/u02/app/oracle/oradata/ORCL_nrt1d4/pdbseed': File exists
[oracle@dbstby ~]$ mkdir -p /u02/app/oracle/oradata/ORCL_nrt1d4/orclpdb
[oracle@dbstby ~]$ mkdir -p /u03/app/oracle/redo/ORCL_nrt1d4/onlinelog
```

2. Copy the following command, Replace `ORCL_nrt1d4` with your standby db unique name.

   ```
   <copy>
   alter system set db_file_name_convert='/u01/app/oracle/oradata/ORCL','/u02/app/oracle/oradata/ORCL_nrt1d4' scope=spfile;
   alter system set db_create_online_log_dest_1='/u03/app/oracle/redo/ORCL_nrt1d4/onlinelog' scope=spfile;
   alter system set log_file_name_convert='/u01/app/oracle/oradata/ORCL','/u03/app/oracle/redo/ORCL_nrt1d4/onlinelog' scope=spfile;
   alter system set db_domain='' scope=spfile;
   </copy>
   ```

   

3. Run the command in sqlplus as sysdba. This will modify the db and log file name convert parameter, unset `db_domain`. 

**Note:** The different database domain name of the on-premise and cloud will cause DML Redirection error, in this lab, we don't use the database domain.

```
SQL> ALTER SYSTEM SET db_file_name_convert='/u01/app/oracle/oradata/ORCL','/u02/app/oracle/oradata/ORCL_nrt1d4' scope=spfile;

System altered.
SQL> alter system set db_create_online_log_dest_1='/u03/app/oracle/redo/ORCL_nrt1d4/onlinelog' scope=spfile;

System altered.

SQL> alter system set log_file_name_convert='/u01/app/oracle/oradata/ORCL','/u03/app/oracle/redo/ORCL_nrt1d4/onlinelog' scope=spfile;

System altered.
SQL> alter system set db_domain='' scope=spfile;

System altered.
SQL> 
```

4. Shutdown the database, connect with RMAN. Then startup database nomount.

```
SQL> shutdown immediate
ORA-01109: database not open


Database dismounted.
ORACLE instance shut down.
SQL> exit
Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
Version 19.7.0.0.0
[oracle@dbstby ~]$ rman target /

Recovery Manager: Release 19.0.0.0.0 - Production on Fri Jan 31 12:41:27 2020
Version 19.7.0.0.0

Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

connected to target database (not started)

RMAN> startup nomount

Oracle instance started

Total System Global Area   16106126808 bytes

Fixed Size                     9154008 bytes
Variable Size               2181038080 bytes
Database Buffers           13891534848 bytes
Redo Buffers                  24399872 bytes

RMAN> 
```

5. Restore control file from on-premise database and mount the cloud database.

```
RMAN> restore standby controlfile from service 'ORCL';

Starting restore at 01-FEB-20
using target database control file instead of recovery catalog
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=11 device type=DISK

channel ORA_DISK_1: starting datafile backup set restore
channel ORA_DISK_1: using network backup set from service ORCL
channel ORA_DISK_1: restoring control file
channel ORA_DISK_1: restore complete, elapsed time: 00:00:02
output file name=/u02/app/oracle/oradata/ORCL_nrt1d4/control01.ctl
output file name=/u03/app/oracle/fast_recovery_area/ORCL_nrt1d4/control02.ctl
Finished restore at 01-FEB-20

RMAN> alter database mount;

released channel: ORA_DISK_1
Statement processed

RMAN> 
```

6. Now, restore database from on-premise database.

```
RMAN> restore database from service 'ORCL' section size 5G;

Starting restore at 01-FEB-20
Starting implicit crosscheck backup at 01-FEB-20
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=17 device type=DISK
Crosschecked 2 objects
Finished implicit crosscheck backup at 01-FEB-20

Starting implicit crosscheck copy at 01-FEB-20
using channel ORA_DISK_1
Finished implicit crosscheck copy at 01-FEB-20

searching for all files in the recovery area
cataloging files...
cataloging done

channel ORA_DISK_1: starting datafile backup set restore
channel ORA_DISK_1: using network backup set from service ORCL
channel ORA_DISK_1: specifying datafile(s) to restore from backup set
channel ORA_DISK_1: restoring datafile 00001 to /u02/app/oracle/oradata/ORCL_nrt1d4/system01.dbf
channel ORA_DISK_1: restoring section 1 of 1
channel ORA_DISK_1: restore complete, elapsed time: 00:00:16
channel ORA_DISK_1: starting datafile backup set restore
channel ORA_DISK_1: using network backup set from service ORCL
channel ORA_DISK_1: specifying datafile(s) to restore from backup set
channel ORA_DISK_1: restoring datafile 00003 to /u02/app/oracle/oradata/ORCL_nrt1d4/sysaux01.dbf
channel ORA_DISK_1: restoring section 1 of 1
channel ORA_DISK_1: restore complete, elapsed time: 00:00:16
channel ORA_DISK_1: starting datafile backup set restore
channel ORA_DISK_1: using network backup set from service ORCL
channel ORA_DISK_1: specifying datafile(s) to restore from backup set
channel ORA_DISK_1: restoring datafile 00004 to /u02/app/oracle/oradata/ORCL_nrt1d4/undotbs01.dbf
channel ORA_DISK_1: restoring section 1 of 1
channel ORA_DISK_1: restore complete, elapsed time: 00:00:04
channel ORA_DISK_1: starting datafile backup set restore
channel ORA_DISK_1: using network backup set from service ORCL
channel ORA_DISK_1: specifying datafile(s) to restore from backup set
channel ORA_DISK_1: restoring datafile 00005 to /u02/app/oracle/oradata/ORCL_nrt1d4/pdbseed/system01.dbf
......
......
channel ORA_DISK_1: restoring section 1 of 1
channel ORA_DISK_1: restore complete, elapsed time: 00:00:02
Finished restore at 01-FEB-20

RMAN> 
```

7. Shutdown the database, connect to sqlplus as sysdba and mount the database again.

```
RMAN> shutdown immediate

database dismounted
Oracle instance shut down

RMAN> exit


Recovery Manager complete.
[oracle@dbcloud ~]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 11:16:31 2020
Version 19.7.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> startup mount
ORACLE instance started.

Total System Global Area 1.6106E+10 bytes
Fixed Size		    9154008 bytes
Variable Size		 2080374784 bytes
Database Buffers	 1.3992E+10 bytes
Redo Buffers		   24399872 bytes
Database mounted.
SQL> 
```



## Step 7: Clear all online and standby redo logs 

1. Copy the following command.

   ```
   <copy>
   set pagesize 0 feedback off linesize 120 trimspool on
   spool /tmp/clearlogs.sql
   select distinct 'alter database clear logfile group '||group#||';' from v$logfile;
   spool off
   @/tmp/clearlogs.sql
   </copy>
   ```

   

2. Run the command in sqlplus as sysdba, this will clear or create new online and standby redo log, ignore the unknown command.

```
SQL> set pagesize 0 feedback off linesize 120 trimspool on
SQL> spool /tmp/clearlogs.sql
SQL> select distinct 'alter database clear logfile group '||group#||';' from v$logfile;
alter database clear logfile group 1;
alter database clear logfile group 2;
alter database clear logfile group 3;
alter database clear logfile group 4;
alter database clear logfile group 5;
alter database clear logfile group 6;
alter database clear logfile group 7;
SQL> spool off
SQL> @/tmp/clearlogs.sql
SP2-0734: unknown command beginning "SQL> selec..." - rest of line ignored.

SP2-0734: unknown command beginning "SQL> spool..." - rest of line ignored.
SQL> 
```



## Step 8: Configure Data Guard broker

1. Copy the following command.

   ```
   <copy>
   show parameter dg_broker_config_file;
   show parameter dg_broker_start;
   alter system set dg_broker_start=true;
   select pname from v$process where pname like 'DMON%';
   </copy>
   ```

   

2. Run the command on primary and standby database to enable the data guard broker.

- From on-premise side,

```
SQL> show parameter dg_broker_config_file;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
dg_broker_config_file1		     string	 /u01/app/oracle/product/19.0.0
						 /dbhome_1/dbs/dr1ORCL.dat
dg_broker_config_file2		     string	 /u01/app/oracle/product/19.0.0
						 /dbhome_1/dbs/dr2ORCL.dat
SQL> show parameter dg_broker_start

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
dg_broker_start 		     boolean	 FALSE
SQL> alter system set dg_broker_start=true;

System altered.

SQL> select pname from v$process where pname like 'DMON%';

PNAME
-----
DMON

SQL> 
```

- From cloud side

```
SQL> show parameter dg_broker_config_file

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
dg_broker_config_file1		     string	 /u01/app/oracle/product/19.0.0
						 .0/dbhome_1/dbs/dr1ORCL_nrt1d4
						 .dat
dg_broker_config_file2		     string	 /u01/app/oracle/product/19.0.0
						 .0/dbhome_1/dbs/dr2ORCL_nrt1d4
						 .dat
SQL> show parameter dg_broker_start

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
dg_broker_start 		     boolean	 FALSE
SQL> alter system set dg_broker_start=true;

System altered.

SQL> select pname from v$process where pname like 'DMON%';

PNAME
-----
DMON

SQL> 
```

3. Register the database via DGMGRL. Replace `ORCL_nrt1d4` with your standby db unique name.

```
[oracle@dbstby ~]$ dgmgrl sys/Ora_DB4U@ORCL
DGMGRL for Linux: Release 19.0.0.0.0 - Production on Sat Feb 1 03:51:49 2020
Version 19.7.0.0.0

Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

Welcome to DGMGRL, type "help" for information.
Connected to "ORCL"
Connected as SYSDBA.
DGMGRL> CREATE CONFIGURATION adgconfig AS PRIMARY DATABASE IS ORCL CONNECT IDENTIFIER IS ORCL;
Configuration "adgconfig" created with primary database "orcl"
DGMGRL> ADD DATABASE ORCL_nrt1d4 AS CONNECT IDENTIFIER IS ORCL_nrt1d4 MAINTAINED AS PHYSICAL;
Database "orcl_nrt1d4" added
DGMGRL> enable configuration;
Enabled.
DGMGRL> SHOW CONFIGURATION;

Configuration - adgconfig

  Protection Mode: MaxPerformance
  Members:
  orcl        - Primary database
    orcl_nrt1d4 - Physical standby database 

Fast-Start Failover:  Disabled

Configuration Status:
SUCCESS   (status updated 42 seconds ago)
```

if there is a warning message, Warning: ORA-16809: multiple warnings detected for the member. You can wait serveral minutes and show configuration again.

Now, the Hybrid Data Guard is ready. The standby database is in mount status.

