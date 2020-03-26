![](images/400/400.JPG)  
Updated: June 19, 2017

## Introduction

In this lab, you learn about "In memory" options in Oracle Database how to use them. 


Oracle Database In-Memory is designed for mixed workloads. Its unique dual-format approach accelerates analytics while ensuring that the most up-to-date transactional data is constantly available—no moving of data out to a separate database.


//TO DO add more description

Documentation for Oracle In memory features can be found here: https://docs.oracle.com/database/122/INMEM/toc.htm.  

Please direct comments to: Ram Posham () /Sadhana avasarala (sadhana.avasarala@oracle.com)

## Objectives

- Learn how to work with Oracle In memory feature

## Required Artifacts

- A provisioned DBCS intance

# Procedure 
## Prework 
## Step1:  Create Table spaces for loading the data (Star schema)

- Run the following commands and wait until last command returns.  It might take a few mins

. oraenv <<EOF
salescA
EOF
sqlplus system/Manager123#@salesA << EOF
drop tablespace ts_temp;
create temporary tablespace ts_temp tempfile '/u02/app/oracle/oradata/salescZ/salesZ/ts_temp01.dbf' size 1G reuse autoextend on;
drop tablespace ts_data including contents and datafiles;
create tablespace ts_data datafile '/u02/app/oracle/oradata/salescZ/salesZ/ts_data01.dbf' size 2G autoextend on;
EOF

- ![](images/900/Inmemory-create-tablespace.gif) 

### **STEP 2**: Download Data to be loaded

Open SSH session to DBCS instance as shown in provisioning DBCS notebook

Download the star schema export dump file using the following command. 
wget -O /tmp/star-schema-benchmark-ssb.zip https://www.dropbox.com/s/vfea4snh8my3ngx/ssb.zip?dl=0 

### **STEP 3** Create ssb user

- ![](images/900/create-import-ssb.gif) 

sqlplus system/Manager123#@ [[databaseinstancename]] << EOF
drop user ssb cascade;
create user ssb identified by ssb default tablespace ts_data temporary tablespace ts_temp;
grant dba to ssb;
connect ssb/ssb@[[databaseinstancename]]
create or replace directory expdumpdir1 as '/tmp';
EOF

### **STEP 4** Import Schema 

cd /tmp
unzip star-schema-benchmark-ssb.zip
impdp ssb/ssb@[[Databse instance name]] parallel=4 directory=expdumpdir1  schemas=ssb dumpfile=ssb%u.dmp;

## In memory workshop 

### **STEP 1**: Configure database for analytics -- Allocate memory for columnar store

- Set inmemory databse size
- set mememory sizes and sga size
- Restart the database

. oraenv << EOF
salescZ
EOF
sqlplus / as sysdba  << EOF
alter system set memory_target=4608M scope=spfile;
alter system set memory_max_target=4608M scope=spfile;
alter system set sga_max_size=3584M scope=spfile;
alter system set inmemory_size=1536M scope=spfile;
startup force;
EOF

#### Please note database startup is needed after changing inmemory setting
- ![](images/900/set-inmemory-params.gif) 

### **STEP 2**: Buffer Cache ssb tables schema to compare with inmemory columnar

sqlplus ssb/ssb@ [[database instance name]]   << EOF
alter table PART cache;
alter table CUSTOMER cache;
alter table SUPPLIER cache;
alter table LINEORDER cache;
alter table DATE_DIM cache;
EOF

### **STEP 3**: Store the ssb schema tables in IN-MEMORY Columnar Store

sqlplus ssb/ssb@ [[ databaseinstancename]]  << EOF
alter table PART inmemory;
alter table CUSTOMER inmemory;
alter table SUPPLIER inmemory;
alter table LINEORDER inmemory;
alter table DATE_DIM inmemory;
EOF

### **STEP 4**: Verify inmemory settings 

- Connect to SQL developer as described in provisioning DBCS document
- Execute following commands to verify in memory settings and current inmemory object status

    - show sga
    - show parameter inmemory
    - select * from v$inmemory_area;
    - SELECT v.owner, v.segment_name name, v.populate_status status
FROM v$im_segments v;

- ![](images/900/inmemory-settings.gif)

###   **STEP 5**: Populate inmemory Store
- Execute select with noparallel to force oracle database to load objects to columnar store

SELECT /*+ full(d) noparallel (d )*/ Count(*) FROM date_dim d;
SELECT /*+ full(s) noparallel (s )*/ Count(*) FROM supplier s;
SELECT /*+ full(p) noparallel (p )*/ Count(*) FROM part p;
SELECT /*+ full(c) noparallel (c )*/ Count(*) FROM customer c;
SELECT /*+ full(lo) noparallel (lo )*/ Count(*) FROM lineorder lo;


###   **STEP 6**: Verify the compression status and data in memory
-check the compression ratios. Higher the datasize, better compression.

- ![](images/900/compress.jpg)

SELECT v.owner, v.segment_name,
v.bytes orig_size,
v.inmemory_size in_mem_size,
ROUND(v.bytes / v.inmemory_size, 2) comp_ratio
FROM v$im_segments v
ORDER BY 5;

###   **STEP 7**: Verify with analytic queries

In this step,  you can write your own querries or execute following sample queries and record the results
         
 - SELECT Max(lo_ordtotalprice) most_expensive_order FROM lineorder;
 - SELECT lo_orderkey, lo_custkey, lo_revenue WHERE lo_orderkey = 5000000;
 - SELECT lo_orderkey, lo_custkey, lo_revenue FROM lineorder WHERE lo_custkey = 5641 AND lo_shipmode = 'XXX AIR'
AND lo_orderpriority = '5-LOW';
- SELECT  Max(lo_supplycost) most_expensive_bluk_order FROM lineorder WHERE lo_quantity > 52;
- SELECT d.d_year, c.c_nation, SUM(lo_revenue - lo_supplycost) profit FROM lineorder l, date_dim d,part p,
supplier s,customer c  
WHERE l.lo_orderdate = d.d_datekey
AND l.lo_partkey = p.p_partkey
AND l.lo_suppkey = s.s_suppkey
AND l.lo_custkey = c.c_custkey
AND s.s_region = 'AMERICA'
AND c.c_region = 'AMERICA'
GROUP BY d.d_year, c.c_nation
ORDER BY d.d_year, c.c_nation;

###   **STEP 8**: Verify with analytic queries

Repeat the SQL queries in Step 7 with inmemory setting set to disabled

- alter session SET INMEMORY_QUERY=DISABLE;
- Execute queries in Step 7.
- Record the results
      





# What you Learned


# Next Steps

- Proceed to the next Lab to learn how to add Oracle Event Hub Cloud Service to the our Lab architcture and how to leverage DBCS ->GGCS in our architecture