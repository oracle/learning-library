#!/bin/bash

### Generate Audit Workload ###


# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo
echo "Running Audit Workload ....."
echo
$ORACLE_HOME/bin/sqlplus -s sys/Oracle123 as sysdba << EOF

set echo on

connect c##zeus/Oracle123@pdb1
alter user oe identified by oe account unlock;
alter user sh identified by sh account unlock;
alter user scott identified by tiger account unlock;
alter user pm identified by pm account unlock;
alter user hr identified by hr account unlock;
alter user bi identified by bi account unlock;

create user jtaylor identified by jtaylor;
grant dba to jtaylor with admin option;

grant alter any operator to jtaylor;

grant dv_acctmgr to system;
grant dv_acctmgr to jtaylor;

drop user audusr cascade;

drop user jschaffer cascade;

drop user rmtusr cascade;

create user audusr identified by audusr;
grant dv_acctmgr to audusr;
grant dba to audusr;

create user jschaffer identified by jschaffer;
grant dv_acctmgr to jschaffer;

grant create session to audusr;
grant create session to jschaffer;
grant resource to jschaffer;
grant resource to audusr;
grant all on scott.emp to audusr;

grant all on scott.dept to audusr;

grant create user to audusr;

grant alter user to audusr;

grant drop user to audusr;

grant create database link to audusr;

grant drop public database link to audusr;

REM Audit user session events
AUDIT CREATE SESSION BY audusr;

REM Audit object mgmt events
AUDIT CREATE TABLE BY audusr;
AUDIT CREATE VIEW BY audusr;

REM Audit application mgmt events
AUDIT CREATE PROCEDURE BY audusr;
AUDIT CREATE TRIGGER BY audusr;

AUDIT SELECT TABLE BY audusr;
AUDIT INSERT TABLE BY audusr;
AUDIT UPDATE TABLE BY audusr;
AUDIT DELETE TABLE BY audusr;

connect audusr/audusr@pdb1


CREATE USER rmtusr IDENTIFIED BY rmtusr;

create table emp as select * from scott.emp;

connect system/Oracle123@pdb1 

REM Audit role and privilege management events
AUDIT GRANT ON audusr.EMP BY ACCESS;

REM Audit DML activity
AUDIT SELECT ON audusr.EMP BY ACCESS;

REM Audit role and privilege management events
AUDIT GRANT ON audusr.EMP BY ACCESS;

REM Audit DML activity
AUDIT SELECT ON audusr.EMP BY ACCESS;

connect audusr/audusr@pdb1

CREATE DATABASE LINK abc.com CONNECT TO rmtusr IDENTIFIED BY rmtusr;

connect system/Oracle123@pdb1 

AUDIT ALL BY jschaffer;

CONN jschaffer/jschaffer@pdb1

create table src_tab (id number,
                      name varchar2(25),
                      sal number,
                      pos number,
		      primary key (name));
commit;

create table src_tab1 (id number,
                         dept varchar2(25),
                         loc  varchar2(30),
			 primary key (dept));

commit;

create table nusr_tab(id number,
                       name varchar2(25),
                       dept char(20),
                       tstz timestamp with time zone,
                       sal float,
                       dt date);
commit;

connect system/Oracle123@pdb1 

AUDIT SELECT TABLE BY jschaffer;
AUDIT INSERT TABLE BY jschaffer;
AUDIT UPDATE TABLE BY jschaffer;
AUDIT DELETE TABLE BY jschaffer;

connect sys/Oracle123@pdb1 as sysdba

-- Roles and Privilege events
GRANT CREATE ANY CLUSTER, DROP ANY CLUSTER, ALTER ANY CLUSTER
                 TO jschaffer; 

GRANT ALTER SYSTEM, ALTER DATABASE, AUDIT SYSTEM TO jschaffer;

GRANT CREATE ANY OPERATOR, DROP ANY OPERATOR, ALTER ANY OPERATOR, EXECUTE ANY OPERATOR
      TO jschaffer;

GRANT CREATE ANY PROCEDURE, DROP ANY PROCEDURE, ALTER ANY PROCEDURE, EXECUTE ANY PROCEDURE
      TO jschaffer;

GRANT CREATE ROLE TO jschaffer;

GRANT ALL PRIVILEGES TO jschaffer;

connect system/Oracle123@pdb1 

DROP ROLE NEW_ROLE;

CREATE ROLE NEW_ROLE IDENTIFIED BY NEW_ROLE;

connect sys/Oracle123@pdb1 as sysdba

GRANT CREATE SESSION, CREATE USER TO NEW_ROLE;

connect system/Oracle123@pdb1

ALTER ROLE NEW_ROLE IDENTIFIED BY GLOBALLY;

GRANT NEW_ROLE TO rmtusr IDENTIFIED BY rmtusr;


-- Auccount management
CREATE PROFILE NPFILE LIMIT PASSWORD_REUSE_MAX 10 PASSWORD_REUSE_TIME 50;

ALTER PROFILE NPFILE LIMIT FAILED_LOGIN_ATTEMPTS 5;

DROP PROFILE NPFILE;

REM FGA Policy event
BEGIN
  DBMS_FGA.ADD_POLICY(object_schema => 'audusr',
                      object_name => 'EMP',
                      policy_name => 'TEST_FGA_POLICY',
                      audit_condition => '1=1');

  DBMS_FGA.ADD_POLICY(object_schema => 'jschaffer',
                        object_name => 'src_tab',
                        policy_name => 'TEST_FGA_POLICY2',
                        statement_types => 'INSERT, UPDATE, DELETE');
 
    dbms_fga.add_policy (
        object_schema=>'jschaffer',
        object_name=>'src_tab',
        policy_name=>'TEST_FGA_POLICY3',
        statement_types => 'INSERT, UPDATE, DELETE');
  
    dbms_fga.add_policy (
        object_schema=>'jschaffer',
        object_name=>'src_tab1',
        policy_name=>'TEST_FGA_POLICY4',
        audit_condition=> 'dept=''defen''',
        statement_types => 'INSERT, UPDATE, DELETE');
  
    dbms_fga.add_policy (
        object_schema=>'jschaffer',
        object_name=>'src_tab',
        policy_name=>'TEST_FGA_POLICY5',
        audit_condition=>'id > 200',
        statement_types => 'INSERT, UPDATE, DELETE');
  
    dbms_fga.add_policy (
        object_schema=>'jschaffer',
        object_name=>'src_tab1',
        policy_name=>'TEST_FGA_POLICY6',
        audit_column=> 'loc, dept',
        statement_types => 'INSERT, UPDATE, DELETE');
  
    dbms_fga.add_policy (
        object_schema=>'jschaffer',
        object_name=>'src_tab',
        policy_name=>'TEST_FGA_POLICY7',
        audit_column=>'id, sal',
        statement_types => 'INSERT, UPDATE, DELETE');
  
 
    dbms_fga.add_policy (
        object_schema=>'jschaffer',
        object_name=>'NUSR_TAB',
        policy_name=>'TEST_FGA_POLICY8',
        audit_column=>'name, tstz,dt',
       statement_types => 'INSERT, UPDATE, DELETE');
 
  
    dbms_fga.add_policy (
        object_schema=>'jschaffer',
        object_name=>'NUSR_TAB',
        policy_name=>'TEST_FGA_POLICY9',
        audit_column=>'id, dept,sal',
        statement_types => 'INSERT, UPDATE, DELETE');
  
  
    dbms_fga.add_policy (
        object_schema=>'jschaffer',
        object_name=>'NUSR_TAB',
        policy_name=>'TEST_FGA_POLICY10',
        audit_condition=>'id>10',
        audit_column=>'id, dept,sal',
        statement_types => 'INSERT, UPDATE, DELETE');

END;
/



REM Capture changes to a user-defined table
CREATE TABLE audusr.test_basic_type
(
  a VARCHAR2(10),
  b CHAR(1),
  c RAW(10),
  d DATE,
  e TIMESTAMP,
  f TIMESTAMP WITH TIME ZONE,
  g INTERVAL DAY(5) TO SECOND,
  h INTERVAL YEAR TO MONTH,
  x BINARY_FLOAT,
  y BINARY_DOUBLE,
  z NUMBER
);


-- Auccount management
CREATE PROFILE NPFILE LIMIT PASSWORD_REUSE_MAX 10 PASSWORD_REUSE_TIME 50;

ALTER PROFILE NPFILE LIMIT FAILED_LOGIN_ATTEMPTS 5;

DROP PROFILE NPFILE;

connect sys/Oracle123@pdb1 as sysdba

GRANT ALL PRIVILEGES TO jschaffer;

connect system/Oracle123@pdb1

AUDIT ALL BY audusr;
AUDIT ALL BY rmtusr;
AUDIT ALL BY jschaffer;

CONN jschaffer/jschaffer@pdb1

-- Application Management

create or replace procedure proc1(x number) IS
begin
	dbms_output.put_line('Given number is ' || x);
end;
/

show errors;

create or replace procedure proc2( vr varchar2) IS
begin
	dbms_output.put_line('Given value is ' || vr);
end;
/

show errors;

create or replace procedure rmtusr.rproc1(x number) IS
begin
        dbms_output.put_line('Given number is ' || x);
end;
/

show errors;

create or replace procedure  rmtusr.rproc2( vr varchar2) IS
begin
        dbms_output.put_line('Given value is ' || vr);
end;
/

show errors;


create or replace function func1(x number) return number IS
	rnum number;
begin
	dbms_output.put_line('Given number is ' || x);
	rnum := x + 100;
	return rnum;
end;
/

show errors;

create or replace function func2(x number) return number IS
        rnum number;
begin
        dbms_output.put_line('Given number is ' || x);
        rnum := x * 10;
        return rnum;
end;
/

show errors;

variable xnum number;

CALL func2(100) into :xnum;

print xnum;

create or replace trigger trig before insert or update of name, sal on
		jschaffer.src_tab
		for each row 
		begin 
		  if (:new.sal > 5000 ) then
			dbms_output.put_line('new value is more than 5k');
		  else
			dbms_output.put_line('new values is less than 5k');
		  end if;
		end;
/

show errors;

create or replace type typ AS OBJECT
(
	ox number,
	member procedure oproc
);
/

show errors;

create or replace type rmtusr.rtyp AS OBJECT
(
        ox number,
        member procedure roproc
);
/

show errors;

create or replace type typ2 AS OBJECT
(
	ofx varchar2(25),
	member function ofunc(nm varchar2) return varchar2
);
/

show errors;

create or replace type rmtusr.rtyp2 AS OBJECT
(
        ofx varchar2(25),
        member function rofunc(nm varchar2) return varchar2
);
/

show errors;

create type body typ IS
	member procedure oproc IS
	begin
		dbms_output.put_line('This is a member procedure');
	end;
	end;
/

show errors;

create type body typ2 IS
	member function ofunc(nm varchar2) return varchar2 IS
		name varchar2(25);
	begin
		name := nm;
		return name;
	end;
	end;
/

show errors;

create type body rmtusr.rtyp IS
        member procedure roproc IS
        begin
                dbms_output.put_line('This is a member procedure');
        end;
        end;
/

show errors;

create type body rmtusr.rtyp2 IS
        member function rofunc(nm varchar2) return varchar2 IS
                name varchar2(25);
        begin
                name := nm;
                return name;
        end;
        end;
/

show errors;

create or replace package pack AS
	function pfunc(nu number) return number;
end pack;
/

show errors;

create or replace package body pack AS
	function pfunc(nu number) return number IS
		num number;
	begin
		num := nu + 200;
		return num;
	end;
end pack;
/

show errors;

set serverout on

variable x number;

CALL pack.pfunc(10) into :x;

print x;


create or replace directory tmp_dir AS '$T_WORK';
/

show errors;

create or replace library mylib AS 'tmp_dir/mylib.so';
/

show errors;

create or replace function opfunc (a number, b number) return number IS
begin
	if (a > b) then
		return a;
	else
		return b;
	end if;
end;
/

show errors;

create or replace operator myopr binding (number, number) return number 
		  using opfunc;
/

show errors;

create or replace function rmtusr.ropfunc (a number, b number) return number IS
begin
        if (a < b) then
                return a;
        else
                return b;
        end if;
end;
/

show errors;

create or replace operator rmtusr.rmyopr binding (number, number) return number
                  using rmtusr.ropfunc;
/

show errors;

create java source named "jsrc" AS 
	public class jsrc {
		public static String jsrc()
		{
			return "Hello";
		} };
/

show errors;

set serverout on

declare
	var varchar2(25);
begin
	var := 'thiru';
	proc1(100);
	proc2(var);
end;
/

declare
	var varchar2(25);
begin
	var := 'remote';
	rmtusr.rproc1(420);
	rmtusr.rproc2(var);
end;
/

declare
	rn number;
begin
	rn := func1(719);
	dbms_output.put_line(rn);
end;
/

declare
        rn number;
begin
        rn := func2(419);
        dbms_output.put_line(rn);
end;
/
	-- Alter data

conn jtaylor/jtaylor@pdb1 

alter procedure  jschaffer.proc1 compile;
/

alter trigger jschaffer.trig disable;
/

alter trigger jschaffer.trig enable;
/

alter type jschaffer.typ
	add member function ofunc return number;


conn jtaylor/jtaylor@pdb1 

alter package jschaffer.pack compile package;

alter package jschaffer.pack compile body;

alter operator jschaffer.myopr compile;

-- Data Access

conn jschaffer/jschaffer@pdb1

truncate table src_tab;

insert into src_tab values(201, 'santu', 30000, 6);

insert into src_tab values(245, 'king', 25000, 9);

insert into src_tab values(250, 'kong', 28000, 7);

insert into src_tab values(251, 'arnold', 35000, 3);

insert into src_tab values(199, 'jimmy', 2000, 100);

insert into src_tab values(150, 'tommy', 4500, 87);

insert into src_tab values(20, 'tom', 26000, 8);

select * from src_tab;

update src_tab set sal=55000 where name='santu';

update src_tab set pos=2 where name='santu';

update src_tab set id=29 where name='tom';

delete from src_tab where name='jimmy';


-- Object Management

truncate table src_tab1;

insert into src_tab1 values(151, 'defen', 'NY');

insert into src_tab1 values(221, 'Air', 'IN');

insert into src_tab1 values(265, 'Pol', 'SA');

insert into src_tab1 values(267, 'bang', 'KNR');

insert into src_tab1 values(201, 'exs', 'SL');

insert into src_tab1 values(420, 'INC', 'BR');

insert into src_tab1 values(421, 'COM', 'MB');

insert into src_tab1 values(450, 'SAL', 'HY');

select * from src_tab;

update src_tab1 set loc='PJ' where id=221;

update src_tab1 set loc='BHR' where id=267;

update src_tab1 set loc='NPL' where id=420;

delete from src_tab1 where id>400;

truncate table nusr_tab;

insert into nusr_tab values(20, 'rani', 'exc',
                            timestamp'2005-05-28 08:45:45.32-5:40', 23987.50,
                            '21-dec-2001');

insert into nusr_tab values(40, 'bunty', 'inc',
                            timestamp'2002-05-28 09:15:45.32-5:40', 34562.34,
                            '10-july-2002');

insert into nusr_tab values(60, 'bty', 'army',
                            timestamp'2004-05-28 09:15:45.32-5:40', 98749.23,
                            '19-OCT-01');

insert into nusr_tab values(80, 'tyme', 'Rmy',
                            timestamp'2000-09-08 09:15:45.32-5:40', 58749.23,
                            '19-oct-01');

update nusr_tab set name='San' where dept='inc';

update nusr_tab set dt='19-oct-06' where id>15;

delete from nusr_tab where id>50;


create index srcind on src_tab(id);

create index srcind1 on src_tab1(id);

create sequence seq1 
	start with 100
	increment by 2;

create sequence seq2
        start with 500
        increment by 5;

create public synonym sy_tab for jschaffer.src_tab;

create public synonym sy_tab1 for jschaffer.src_tab1;

create public synonym myprc1 for jschaffer.proc1;

create public synonym myprc2 for jschaffer.proc2;

create public synonym myfnc1 for jschaffer.func1;

create public synonym myfnc2 for jschaffer.func2;

create view vw_tab AS select name, sal*10 tsal, pos from src_tab;

create view vw_tab1 AS select * from src_tab1;

create materialized view log on src_tab 
		with primary key 
		including new values;

create materialized view mvw 
		build immediate 
		refresh fast on commit 
		as select * from src_tab;

create materialized view log on src_tab1
                with primary key
                including new values;

create materialized view mvw1
		build immediate 
		refresh fast on commit 
		as select * from src_tab1;

insert into src_tab values(678, 'tinky', 4110, 11);

insert into src_tab values(467, 'chinky', 26000, 8);

select * from mvw;

insert into src_tab1 values(921, 'CKT', 'IND');

insert into src_tab1 values(690, 'FTB', 'BZ');

select * from mvw1;

alter sequence seq2 MAXVALUE 5000;

alter sequence seq1 MAXVALUE 2500;

create outline ndata for category special
               on select sal, name from src_tab;

alter outline ndata rebuild;

set transaction read only name 'Thiru';

savepoint svpt1;

rollback to savepoint svpt1;

lock table src_tab in exclusive mode nowait;

lock table src_tab1 in exclusive mode nowait;

create schema authorization jschaffer
              create table nschma_tab ( nu number);

create context ncontx USING pack;

commit;

set role all;

rename seq1 to nseq;

rename vw_tab to nvw;

rename vw_tab1 to nvw1;

delete src_tab;

delete src_tab1;

DROP VIEW nvw;

DROP outline ndata;

DROP context ncontx;

DROP VIEW nvw1;

DROP PUBLIC SYNONYM sy_tab;

DROP PUBLIC SYNONYM sy_tab1;

DROP PUBLIC SYNONYM myprc1;

DROP PUBLIC SYNONYM myprc2;

DROP PUBLIC SYNONYM myfnc1;

DROP PUBLIC SYNONYM myfnc2;

DROP SEQUENCE nseq;

DROP INDEX srcind;

DROP INDEX srcind1;

DROP JAVA SOURCE "jsrc";

DROP OPERATOR myopr;

DROP OPERATOR rmtusr.rmyopr;

DROP FUNCTION opfunc;

DROP FUNCTION rmtusr.ropfunc;

DROP LIBRARY mylib;

DROP DIRECTORY tmp_dir;

DROP PACKAGE pack;

DROP TYPE BODY typ;

DROP TYPE typ;

DROP TYPE BODY rmtusr.rtyp;

DROP TYPE rmtusr.rtyp;

DROP TYPE BODY typ2;

DROP TYPE typ2;

DROP TYPE BODY rmtusr.rtyp2;

DROP TYPE rmtusr.rtyp2;

DROP TRIGGER trig;

DROP FUNCTION func1;

DROP PROCEDURE proc1;

DROP PROCEDURE proc2;

DROP PROCEDURE rmtusr.rproc1;

DROP PROCEDURE rmtusr.rproc2;

DROP materialized view mvw;

DROP materialized view mvw1;
 
connect sys/Oracle123@pdb1 as sysdba 

-- Roles and Privilege Events
REVOKE CREATE ANY CLUSTER, DROP ANY CLUSTER, ALTER ANY CLUSTER
                 FROM jschaffer;

REVOKE ALTER SYSTEM, ALTER DATABASE, AUDIT SYSTEM FROM jschaffer;

REVOKE CREATE ANY OPERATOR, DROP ANY OPERATOR, ALTER ANY OPERATOR, EXECUTE ANY OPERATOR
      FROM jschaffer;

REVOKE CREATE ANY PROCEDURE, DROP ANY PROCEDURE, ALTER ANY PROCEDURE FROM jschaffer;

REVOKE CREATE ROLE FROM jschaffer;

connect sys/Oracle123@pdb1 as sysdba 

exec DBMS_FGA.DROP_POLICY('audusr','EMP','TEST_FGA_POLICY');
exec DBMS_FGA.DROP_POLICY('jschaffer','src_tab','TEST_FGA_POLICY2');
exec DBMS_FGA.DROP_POLICY('jschaffer','src_tab','TEST_FGA_POLICY3');
exec DBMS_FGA.DROP_POLICY('jschaffer','src_tab1','TEST_FGA_POLICY4');
exec DBMS_FGA.DROP_POLICY('jschaffer','src_tab','TEST_FGA_POLICY5');
exec DBMS_FGA.DROP_POLICY('jschaffer','src_tab1','TEST_FGA_POLICY6');
exec DBMS_FGA.DROP_POLICY('jschaffer','src_tab','TEST_FGA_POLICY7');
exec DBMS_FGA.DROP_POLICY('jschaffer','NUSR_TAB','TEST_FGA_POLICY8');
exec DBMS_FGA.DROP_POLICY('jschaffer','NUSR_TAB','TEST_FGA_POLICY9');
exec DBMS_FGA.DROP_POLICY('jschaffer','NUSR_TAB','TEST_FGA_POLICY10');

connect jschaffer/jschaffer 

DROP TABLE src_tab;

DROP TABLE src_tab1;

connect audusr/audusr

alter user jschaffer identified by abcdef;

drop database link abc.com;

drop user jschaffer cascade;

drop user rmtusr cascade;

connect fred/fred@pdb1;
connect tammy/see@pdb1;
connect sys/fred as sysoper@pdb1;
connect apps/go@pdb1;
connect apps/go@pdb1;
connect apps/go@pdb1;

connect sys/Oracle123 as sysdba
alter system switch logfile;
alter system switch logfile;
alter system switch logfile;

spool off
set echo off

exit
EOF

