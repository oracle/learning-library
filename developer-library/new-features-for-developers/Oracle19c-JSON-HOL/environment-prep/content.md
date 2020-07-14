# Oracle Database 19c JSON Documents

## Environment Preparation

This workshop requires an Oracle Database 19c installation. The virtual machine received from the instructor contains Oracle Database 19c installed with Multitenant architecture, and one pluggable database that will be used for the execution of the following exercises.

## Lab User Schema

For this lab we will use the ***Order Entry (OE)*** sample schema that comes with Oracle Database installation. Just to make sure we have the same data in all environments, we use Data Pump to import one particular version of **OE** schema, exported in a dump file.

### Grant Required Privileges

Connect to the **PDB01** pluggable database, as SYSDBA.

````
$ <copy>sqlplus sys/Welcome_1@PDB01 as SYSDBA</copy>
````

Grant **OE** user some privileges required for the tasks we will execute in this lab.

````
<copy>GRANT SELECT ON v_$session TO oe;
GRANT SELECT ON v_$sql_plan_statistics_all TO oe;
GRANT SELECT ON v_$sql_plan TO oe;
GRANT SELECT ON v_$sql TO oe;
GRANT ALTER SYSTEM TO oe;
</copy>
````

>**Note**: The ***ALTER SYSTEM*** privilege is required to flush the Shared Pool in one exercise about performance.

### Create Network Access Control List

Our database needs to connect to a web service, and retrieve information over HTTP, and this requires an ***Access Control List (ACL)***. This ACL can be created by a user with SYSDBA privileges, SYS in this case, from the Pluggable Database called **PDB01**, by executing the following procedure.

````
<copy>begin
  DBMS_NETWORK_ACL_ADMIN.append_host_ace (
    host       => 'api.geonames.org',
    ace        => xs$ace_type(privilege_list => xs$name_list('http','connect','resolve'),
                              principal_name => 'OE',
                              principal_type => xs_acl.ptype_db));
end;
/</copy>
````

Just make sure the execution is successful.

### SQL*Plus Formatting

Close SYSDBA connection and connect as **OE** user to pluggable database PDB01. From this point, all tasks on the database side will be performed using **OE** user. For SQL*Plus, it is also useful to format the output. Feel free to use your own formatting, or just run these formatting commands every time you connect.

````
> <copy>conn oe/oe@PDB01</copy>
````

````
<copy>set linesize 130
set serveroutput on
set pages 9999
set long 90000 
column WORKSHOPNAME format a50
column LOCATION format a20
column COUNTRY format a8
column GEONAMEID format a10
column TITLE format a35
column NAME format a32
column REGION format a20
column SUB_REGION format a22
column REGION format a12
</copy>
````

For the purpose of this exercise we will use a web service, that return information in JSON format, provided by GeoNames - [geonames.org](http://www.geonames.org/). GeoNames is licensed under a [Creative Commons Attribution 4.0 License](https://creativecommons.org/licenses/by/4.0/). You are free to:

- Share — copy and redistribute the material in any medium or format;
- Adapt — remix, transform, and build upon the material for any purpose, even commercially.

Click '**login**' link on the upper right corner of GeoNames website, and create a new account.

---
