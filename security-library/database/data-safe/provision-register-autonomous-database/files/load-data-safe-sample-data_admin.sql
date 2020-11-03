--Loads the Oracle Data Safe sample data into an Autonomous Database
--Last updated: October 15, 2020
--Be sure to run this script AFTER you register your Autonomous Database

/*************************************************************************************************/

/* BEGIN: ScriptDefinitions */

select null as "ScriptDefinitions" from dual;

-- Grant the Data Masking role to DS$ADMIN
-- by default, all other roles are automatically granted to DS$ADMIN

EXECUTE DS_TARGET_UTIL.GRANT_ROLE('DS$DATA_MASKING_ROLE');


def DBA_ROLE = PDB_DBA



/*************************************************************************************************/


/* BEGIN: Setup Environment */

select null as "SetupEnv" from dual;

show user;

-- The following drop statements will error if the users have not yet been created. That is acceptable.

drop user HCM1 cascade;
drop user DBA_DEBRA cascade;
drop user PU_PETE cascade;
drop user DBA_HARVEY cascade;
drop user EVIL_RICH cascade;
drop user SECURE_STEVE cascade;
drop user MALFOY cascade;
drop user APP_USER cascade;
drop user APPX cascade;


-- create our sample users

create user HCM1 identified by Oracle123_Oracle123;
create user DBA_DEBRA identified by Oracle123_Oracle123;
create user PU_PETE identified by Oracle123_Oracle123;
create user DBA_HARVEY identified by Oracle123_Oracle123;
create user EVIL_RICH identified by Oracle123_Oracle123;
create user SECURE_STEVE identified by Oracle123_Oracle123;
create user MALFOY identified by Oracle123_Oracle123;
create user APP_USER identified by Oracle123_Oracle123;


-- Grant our sample users connect, resource

grant connect, resource to HCM1;
grant connect, resource to DBA_DEBRA;
grant connect, resource to PU_PETE;
grant connect, resource to DBA_HARVEY;
grant connect, resource to EVIL_RICH;
grant connect, resource to SECURE_STEVE;
grant connect, resource to MALFOY;
grant connect, resource to APP_USER;


-- Grant our sample users unlimited tablespace

grant unlimited tablespace to HCM1;
grant unlimited tablespace to DBA_DEBRA;
grant unlimited tablespace to PU_PETE;
grant unlimited tablespace to DBA_HARVEY;
grant unlimited tablespace to EVIL_RICH;
grant unlimited tablespace to SECURE_STEVE;
grant unlimited tablespace to MALFOY;
grant unlimited tablespace to APP_USER;


-- Grant DBA roles to DBA_HARVEY and EVIL_RICH

grant PDB_DBA to DBA_HARVEY;
grant PDB_DBA to EVIL_RICH;




/*************************************************************************************************/

/* BEGIN: Load_HCM_Data */

--
--additional grants to schema HCM1
--
grant create session to HCM1;
grant select any table to HCM1;
grant update any table to HCM1;

--
--create the hcm1 schema
--
alter session set current_schema=HCM1;


--
-- This is our DDL and data loading script
--
CREATE TABLE "HCM1"."EMPLOYEES"
   (	"EMPLOYEE_ID" NUMBER(6,0),
	"FIRST_NAME" VARCHAR2(20 BYTE),
	"LAST_NAME" VARCHAR2(25 BYTE) CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE,
	"EMAIL" VARCHAR2(25 BYTE) CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE,
	"PHONE_NUMBER" VARCHAR2(20 BYTE),
	"HIRE_DATE" DATE CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE,
	"JOB_ID" VARCHAR2(10 BYTE) CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE,
	"SALARY" NUMBER(8,2),
	"COMMISSION_PCT" NUMBER(2,2),
	"MANAGER_ID" NUMBER(6,0),
	"DEPARTMENT_ID" NUMBER(4,0),
	 CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) ENABLE,
	 CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ENABLE,
	 CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ENABLE ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);

CREATE TABLE "HCM1"."DEPARTMENTS"
   (	"DEPARTMENT_ID" NUMBER(4,0),
	"DEPARTMENT_NAME" VARCHAR2(30 BYTE) CONSTRAINT "DEPT_NAME_NN" NOT NULL ENABLE,
	"MANAGER_ID" NUMBER(6,0),
	"LOCATION_ID" NUMBER(4,0),
	 CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ;

CREATE TABLE "HCM1"."COUNTRIES"
   (	"COUNTRY_ID" CHAR(2 BYTE) CONSTRAINT "COUNTRY_ID_NN" NOT NULL ENABLE,
	"COUNTRY_NAME" VARCHAR2(40 BYTE),
	"REGION_ID" NUMBER,
	 CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
 PCTTHRESHOLD 50;


CREATE TABLE "HCM1"."LOCATIONS"
   (	"LOCATION_ID" NUMBER(4,0),
	"STREET_ADDRESS" VARCHAR2(40 BYTE),
	"POSTAL_CODE" VARCHAR2(12 BYTE),
	"CITY" VARCHAR2(30 BYTE) CONSTRAINT "LOC_CITY_NN" NOT NULL ENABLE,
	"STATE_PROVINCE" VARCHAR2(25 BYTE),
	"COUNTRY_ID" CHAR(2 BYTE),
	 CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
;


CREATE TABLE "HCM1"."REGIONS"
   (	"REGION_ID" NUMBER CONSTRAINT "REGION_ID_NN" NOT NULL ENABLE,
	"REGION_NAME" VARCHAR2(25 BYTE),
	 CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
;

  CREATE TABLE "HCM1"."JOB_HISTORY"
   (	"EMPLOYEE_ID" NUMBER(6,0) CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL ENABLE,
	"DATE_OF_HIRE" DATE CONSTRAINT "JHIST_DATE_OF_HIRE_NN" NOT NULL ENABLE,
	"DATE_OF_TERMINATION" DATE CONSTRAINT "JHIST_DATE_OF_TERMINATION_NN" NOT NULL ENABLE,
	"JOB_ID" VARCHAR2(10 BYTE) CONSTRAINT "JHIST_JOB_NN" NOT NULL ENABLE,
	"DEPARTMENT_ID" NUMBER(4,0),
	 CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "DATE_OF_HIRE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
;


CREATE TABLE "HCM1"."JOBS"
   (    "JOB_ID" VARCHAR2(10),
        "JOB_TITLE" VARCHAR2(35) CONSTRAINT "JOB_TITLE_NN" NOT NULL ENABLE,
        "MIN_SALARY" NUMBER(6,0),
        "MAX_SALARY" NUMBER(6,0),
         CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
;

CREATE INDEX "HCM1"."EMP_DEPARTMENT_IX" ON "EMPLOYEES" ("DEPARTMENT_ID");

CREATE INDEX "HCM1"."EMP_JOB_IX" ON "EMPLOYEES" ("JOB_ID");

CREATE INDEX "HCM1"."EMP_MANAGER_IX" ON "EMPLOYEES" ("MANAGER_ID");

CREATE INDEX "HCM1"."EMP_NAME_IX" ON "EMPLOYEES" ("LAST_NAME", "FIRST_NAME");

CREATE INDEX "HCM1"."DEPT_LOCATION_IX" ON "DEPARTMENTS" ("LOCATION_ID");

CREATE INDEX "HCM1"."LOC_CITY_IX" ON "LOCATIONS" ("CITY");

CREATE INDEX "HCM1"."LOC_STATE_PROVINCE_IX" ON "LOCATIONS" ("STATE_PROVINCE");

CREATE INDEX "HCM1"."LOC_COUNTRY_IX" ON "LOCATIONS" ("COUNTRY_ID");

CREATE INDEX "HCM1"."JHIST_JOB_IX" ON "JOB_HISTORY" ("JOB_ID");

CREATE INDEX "HCM1"."JHIST_EMPLOYEE_IX" ON "JOB_HISTORY" ("EMPLOYEE_ID");

CREATE INDEX "HCM1"."JHIST_DEPARTMENT_IX" ON "JOB_HISTORY" ("DEPARTMENT_ID");

CREATE TABLE HCM1.CONDITIONS(CONDITION_ID NUMBER, CONDITION VARCHAR2(2000));

CREATE OR REPLACE FUNCTION HCM1.RETURN_CONDITION RETURN VARCHAR2 IS
V_CONDITION VARCHAR2(2000);
V_CONDITION_ID NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,10));
BEGIN
  SELECT CONDITION INTO V_CONDITION FROM CONDITIONS WHERE CONDITION_ID=V_CONDITION_ID;
  DBMS_OUTPUT.PUT_LINE('CONDITION_ID IS:'||V_CONDITION_ID);
  RETURN V_CONDITION;
END;
/

CREATE SEQUENCE HCM1.EMPID START WITH 300;

CREATE TABLE HCM1.SUPPLEMENTAL_DATA (PERSON_ID NUMBER, USERNAME VARCHAR2(50),
TAXPAYER_ID VARCHAR2(20), LAST_INS_CLAIM VARCHAR2(2000), BONUS_AMOUNT NUMBER);

--conditions
insert into HCM1.conditions values (1,'Broken Arm');
insert into HCM1.conditions values (2,'Hair Loss');
insert into HCM1.conditions values (3,'Halitosis');
insert into HCM1.conditions values (4,'Social Disease');
insert into HCM1.conditions values (5,'Cavity');
insert into HCM1.conditions values (6,'Myopia');
insert into HCM1.conditions values (7,'Hangnail');
insert into HCM1.conditions values (8,'Common Cold');
insert into HCM1.conditions values (9,'Embarrassing Skin Condition');

--employees supplemental
insert into HCM1.supplemental_data values(100,'SKING','','','');
insert into HCM1.supplemental_data values(101,'NKOCHHAR','','','');
insert into HCM1.supplemental_data values(102,'LDEHAAN','','','');
insert into HCM1.supplemental_data values(103,'AHUNOLD','','','');
insert into HCM1.supplemental_data values(104,'BERNST','','','');
insert into HCM1.supplemental_data values(105,'DAUSTIN','','','');
insert into HCM1.supplemental_data values(106,'VPATABAL','','','');
insert into HCM1.supplemental_data values(107,'DLORENTZ','','','');
insert into HCM1.supplemental_data values(108,'NGREENBE','','','');
insert into HCM1.supplemental_data values(109,'DFAVIET','','','');
insert into HCM1.supplemental_data values(110,'JCHEN','','','');
insert into HCM1.supplemental_data values(111,'ISCIARRA','','','');
insert into HCM1.supplemental_data values(112,'JMURMAN','','','');
insert into HCM1.supplemental_data values(113,'LPOPP','','','');
insert into HCM1.supplemental_data values(114,'DRAPHEAL','','','');
insert into HCM1.supplemental_data values(115,'AKHOO','','','');
insert into HCM1.supplemental_data values(116,'SBAIDA','','','');
insert into HCM1.supplemental_data values(117,'STOBIAS','','','');
insert into HCM1.supplemental_data values(118,'GHIMURO','','','');
insert into HCM1.supplemental_data values(119,'KCOLMENA','','','');
insert into HCM1.supplemental_data values(120,'MWEISS','','','');
insert into HCM1.supplemental_data values(121,'AFRIPP','','','');
insert into HCM1.supplemental_data values(122,'PKAUFLIN','','','');
insert into HCM1.supplemental_data values(123,'SVOLLMAN','','','');
insert into HCM1.supplemental_data values(124,'KMOURGOS','','','');
insert into HCM1.supplemental_data values(125,'JNAYER','','','');
insert into HCM1.supplemental_data values(126,'IMIKKILI','','','');
insert into HCM1.supplemental_data values(127,'JLANDRY','','','');
insert into HCM1.supplemental_data values(128,'SMARKLE','','','');
insert into HCM1.supplemental_data values(129,'LBISSOT','','','');
insert into HCM1.supplemental_data values(130,'MATKINSO','','','');
insert into HCM1.supplemental_data values(131,'JAMRLOW','','','');
insert into HCM1.supplemental_data values(132,'TJOLSON','','','');
insert into HCM1.supplemental_data values(133,'JMALLIN','','','');
insert into HCM1.supplemental_data values(134,'MROGERS','','','');
insert into HCM1.supplemental_data values(135,'KGEE','','','');
insert into HCM1.supplemental_data values(136,'HPHILTAN','','','');
insert into HCM1.supplemental_data values(137,'RLADWIG','','','');
insert into HCM1.supplemental_data values(138,'SSTILES','','','');
insert into HCM1.supplemental_data values(139,'JSEO','','','');
insert into HCM1.supplemental_data values(140,'JPATEL','','','');
insert into HCM1.supplemental_data values(141,'TRAJS','','','');
insert into HCM1.supplemental_data values(142,'CDAVIES','','','');
insert into HCM1.supplemental_data values(143,'RMATOS','','','');
insert into HCM1.supplemental_data values(144,'PVARGAS','','','');
insert into HCM1.supplemental_data values(145,'JRUSSEL','','','');
insert into HCM1.supplemental_data values(146,'KPARTNER','','','');
insert into HCM1.supplemental_data values(147,'AERRAZUR','','','');
insert into HCM1.supplemental_data values(148,'GCAMBRAU','','','');
insert into HCM1.supplemental_data values(149,'EZLOTKEY','','','');
insert into HCM1.supplemental_data values(150,'PTUCKER','','','');
insert into HCM1.supplemental_data values(151,'DBERNSTE','','','');
insert into HCM1.supplemental_data values(152,'PHALL','','','');
insert into HCM1.supplemental_data values(153,'COLSEN','','','');
insert into HCM1.supplemental_data values(154,'NCAMBRAU','','','');
insert into HCM1.supplemental_data values(155,'OTUVAULT','','','');
insert into HCM1.supplemental_data values(156,'JKING','','','');
insert into HCM1.supplemental_data values(157,'PSULLY','','','');
insert into HCM1.supplemental_data values(158,'AMCEWEN','','','');
insert into HCM1.supplemental_data values(159,'LSMITH','','','');
insert into HCM1.supplemental_data values(160,'LDORAN','','','');
insert into HCM1.supplemental_data values(161,'SSEWALL','','','');
insert into HCM1.supplemental_data values(162,'CVISHNEY','','','');
insert into HCM1.supplemental_data values(163,'DGREENE','','','');
insert into HCM1.supplemental_data values(164,'MMARVINS','','','');
insert into HCM1.supplemental_data values(165,'DLEE','','','');
insert into HCM1.supplemental_data values(166,'SANDE','','','');
insert into HCM1.supplemental_data values(167,'ABANDA','','','');
insert into HCM1.supplemental_data values(168,'LOZER','','','');
insert into HCM1.supplemental_data values(169,'HBLOOM','','','');
insert into HCM1.supplemental_data values(170,'TFOX','','','');
insert into HCM1.supplemental_data values(171,'WSMITH','','','');
insert into HCM1.supplemental_data values(172,'EBATES','','','');
insert into HCM1.supplemental_data values(173,'SKUMAR','','','');
insert into HCM1.supplemental_data values(174,'EABEL','','','');
insert into HCM1.supplemental_data values(175,'AHUTTON','','','');
insert into HCM1.supplemental_data values(176,'JTAYLOR','','','');
insert into HCM1.supplemental_data values(177,'JLIVINGS','','','');
insert into HCM1.supplemental_data values(178,'KGRANT','','','');
insert into HCM1.supplemental_data values(179,'CJOHNSON','','','');
insert into HCM1.supplemental_data values(180,'WTAYLOR','','','');
insert into HCM1.supplemental_data values(181,'JFLEAUR','','','');
insert into HCM1.supplemental_data values(182,'MSULLIVA','','','');
insert into HCM1.supplemental_data values(183,'GGEONI','','','');
insert into HCM1.supplemental_data values(184,'NSARCHAN','','','');
insert into HCM1.supplemental_data values(185,'ABULL','','','');
insert into HCM1.supplemental_data values(186,'JDELLING','','','');
insert into HCM1.supplemental_data values(187,'ACABRIO','','','');
insert into HCM1.supplemental_data values(188,'KCHUNG','','','');
insert into HCM1.supplemental_data values(189,'JDILLY','','','');
insert into HCM1.supplemental_data values(190,'TGATES','','','');
insert into HCM1.supplemental_data values(191,'RPERKINS','','','');
insert into HCM1.supplemental_data values(192,'SBELL','','','');
insert into HCM1.supplemental_data values(193,'BEVERETT','','','');
insert into HCM1.supplemental_data values(194,'SMCCAIN','','','');
insert into HCM1.supplemental_data values(195,'VJONES','','','');
insert into HCM1.supplemental_data values(196,'AWALSH','','','');
insert into HCM1.supplemental_data values(197,'KFEENEY','','','');
insert into HCM1.supplemental_data values(198,'DOCONNEL','','','');
insert into HCM1.supplemental_data values(199,'DGRANT','','','');
insert into HCM1.supplemental_data values(200,'JWHALEN','','','');
insert into HCM1.supplemental_data values(201,'MHARTSTE','','','');
insert into HCM1.supplemental_data values(202,'PFAY','','','');
insert into HCM1.supplemental_data values(203,'SMAVRIS','','','');
insert into HCM1.supplemental_data values(204,'HBAER','','','');
insert into HCM1.supplemental_data values(205,'SHIGGINS','','','');
insert into HCM1.supplemental_data values(206,'WGIETZ','','','');
--msad supplemental
insert into HCM1.supplemental_data values(empid.nextval,'auser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'buser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'cuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'duser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'euser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'fuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'guser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'huser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'iuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'juser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'kuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'luser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'muser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'nuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'ouser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'puser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'quser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'ruser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'suser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'tuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'uuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'vuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'wuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'xuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'yuser','','','');
insert into HCM1.supplemental_data values(empid.nextval,'zuser','','','');
--oud/oid supplemental
insert into HCM1.supplemental_data values(empid.nextval,'aworker','','','');
insert into HCM1.supplemental_data values(empid.nextval,'bworker','','','');
insert into HCM1.supplemental_data values(empid.nextval,'cworker','','','');
insert into HCM1.supplemental_data values(empid.nextval,'dworker','','','');
insert into HCM1.supplemental_data values(empid.nextval,'eworker','','','');
insert into HCM1.supplemental_data values(empid.nextval,'fworker','','','');
insert into HCM1.supplemental_data values(empid.nextval,'gworker','','','');
insert into HCM1.supplemental_data values(empid.nextval,'hworker','','','');
insert into HCM1.supplemental_data values(empid.nextval,'amanager','','','');
insert into HCM1.supplemental_data values(empid.nextval,'bmanager','','','');
insert into HCM1.supplemental_data values(empid.nextval,'cmanager','','','');
insert into HCM1.supplemental_data values(empid.nextval,'dmanager','','','');
insert into HCM1.supplemental_data values(empid.nextval,'adirector','','','');
insert into HCM1.supplemental_data values(empid.nextval,'bdirector','','','');
insert into HCM1.supplemental_data values(empid.nextval,'aadmin','','','');
insert into HCM1.supplemental_data values(empid.nextval,'badmin','','','');
commit;
desc dbms_workload_replay
update HCM1.supplemental_data set taxpayer_id=to_char(trunc(dbms_random.value(100,999)))||'-'||to_char(trunc(dbms_random.value(10,99)))||'-'||to_char(trunc(dbms_random.value(1000,9999)));
update HCM1.supplemental_data set bonus_amount=trunc(dbms_random.value(1000,99999));
commit;
update HCM1.supplemental_data set LAST_INS_CLAIM= return_condition;
update HCM1.supplemental_data set LAST_INS_CLAIM='Unverified Complaint' where LAST_INS_CLAIM is null;
commit;
drop table HCM1.conditions;
drop function HCM1.return_condition;
alter table HCM1.supplemental_data add (payment_acct_no varchar2(20));
update HCM1.supplemental_data set payment_acct_no=to_char(trunc(dbms_random.value(1,4)))||to_char(trunc(dbms_random.value(100,999)))||'-'||to_char(trunc(dbms_random.value(1000,9900)))||'-'||to_char(trunc(dbms_random.value(1000,9900)))||'-'||to_char(trunc(dbms_random.value(1000,9900)));
commit;

select null as "Insert into COUNTRIES..." from dual;

--REM INSERTING into COUNTRIES
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('AR','Argentina',2);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('AU','Australia',3);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BE','Belgium',1);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BR','Brazil',2);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CA','Canada',2);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CH','Switzerland',1);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CN','China',3);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DE','Germany',1);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DK','Denmark',1);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('EG','Egypt',4);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('FR','France',1);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IL','Israel',4);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IN','India',3);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IT','Italy',1);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('JP','Japan',3);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('KW','Kuwait',4);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ML','Malaysia',3);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('MX','Mexico',2);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('NG','Nigeria',4);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('NL','Netherlands',1);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('SG','Singapore',3);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('UK','United Kingdom',1);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('US','United States of America',2);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ZM','Zambia',4);
insert into HCM1.countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ZW','Zimbabwe',4);

select null as "Insert into DEPARTMENTS..." from dual;
--REM INSERTING into departments
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (10,'Administration',200,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (20,'Marketing',201,1800);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (30,'Purchasing',114,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (40,'Human Resources',203,2400);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (50,'Shipping',121,1500);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (60,'IT',103,1400);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (70,'Public Relations',204,2700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (80,'Sales',145,2500);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (90,'Executive',100,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (100,'Finance',108,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (110,'Accounting',205,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (120,'Treasury',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (130,'Corporate Tax',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (140,'Control And Credit',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (150,'Shareholder Services',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (160,'Benefits',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (170,'Manufacturing',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (180,'Construction',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (190,'Contracting',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (200,'Operations',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (210,'IT Support',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (220,'NOC',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (230,'IT Helpdesk',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (240,'Government Sales',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (250,'Retail Sales',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (260,'Recruiting',null,1700);
insert into HCM1.departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (270,'Payroll',null,1700);


select null as "Insert into EMPLOYEES..." from dual;

insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (198,'Donald','OConnell','DOCONNEL@ORACLE.COM','650.507.9833',to_timestamp('21-JUN-07','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',2600,null,124,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (199,'Douglas','Grant','DGRANT@ORACLE.COM','650.507.9844',to_timestamp('13-JAN-08','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',2600,null,124,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (200,'Jennifer','Whalen','JWHALEN@ORACLE.COM','515.123.4444',to_timestamp('17-SEP-03','DD-MON-RR HH.MI.SSXFF AM'),'AD_ASST',4400,null,101,10);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (201,'Michael','Hartstein','MHARTSTE@ORACLE.COM','515.123.5555',to_timestamp('17-FEB-04','DD-MON-RR HH.MI.SSXFF AM'),'MK_MAN',13000,null,100,20);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (202,'Pat','Fay','PFAY@ORACLE.COM','603.123.6666',to_timestamp('17-AUG-05','DD-MON-RR HH.MI.SSXFF AM'),'MK_REP',6000,null,201,20);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (203,'Susan','Mavris','SMAVRIS@ORACLE.COM','515.123.7777',to_timestamp('07-JUN-02','DD-MON-RR HH.MI.SSXFF AM'),'HR_REP',6500,null,101,40);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (204,'Hermann','Baer','HBAER@ORACLE.COM','515.123.8888',to_timestamp('07-JUN-02','DD-MON-RR HH.MI.SSXFF AM'),'PR_REP',10000,null,101,70);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (205,'Shelley','Higgins','SHIGGINS@ORACLE.COM','515.123.8080',to_timestamp('07-JUN-02','DD-MON-RR HH.MI.SSXFF AM'),'AC_MGR',12008,null,101,110);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (206,'William','Gietz','WGIETZ@ORACLE.COM','515.123.8181',to_timestamp('07-JUN-02','DD-MON-RR HH.MI.SSXFF AM'),'AC_ACCOUNT',8300,null,205,110);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (100,'Steven','King','SKING@ORACLE.COM','515.123.4567',to_timestamp('17-JUN-03','DD-MON-RR HH.MI.SSXFF AM'),'AD_PRES',24000,null,null,90);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (101,'Neena','Kochhar','NKOCHHAR@ORACLE.COM','515.123.4568',to_timestamp('21-SEP-05','DD-MON-RR HH.MI.SSXFF AM'),'AD_VP',17000,null,100,90);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (102,'Lex','De Haan','LDEHAAN@ORACLE.COM','515.123.4569',to_timestamp('13-JAN-01','DD-MON-RR HH.MI.SSXFF AM'),'AD_VP',17000,null,100,90);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (103,'Alexander','Hunold','AHUNOLD@ORACLE.COM','590.423.4567',to_timestamp('03-JAN-06','DD-MON-RR HH.MI.SSXFF AM'),'IT_PROG',9000,null,102,60);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (104,'Bruce','Ernst','BERNST@ORACLE.COM','590.423.4568',to_timestamp('21-MAY-07','DD-MON-RR HH.MI.SSXFF AM'),'IT_PROG',6000,null,103,60);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (105,'David','Austin','DAUSTIN@ORACLE.COM','590.423.4569',to_timestamp('25-JUN-05','DD-MON-RR HH.MI.SSXFF AM'),'IT_PROG',4800,null,103,60);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (106,'Valli','Pataballa','VPATABAL@ORACLE.COM','590.423.4560',to_timestamp('05-FEB-06','DD-MON-RR HH.MI.SSXFF AM'),'IT_PROG',4800,null,103,60);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (107,'Diana','Lorentz','DLORENTZ@ORACLE.COM','590.423.5567',to_timestamp('07-FEB-07','DD-MON-RR HH.MI.SSXFF AM'),'IT_PROG',4200,null,103,60);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (108,'Nancy','Greenberg','NGREENBE@ORACLE.COM','515.124.4569',to_timestamp('17-AUG-02','DD-MON-RR HH.MI.SSXFF AM'),'FI_MGR',12008,null,101,100);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (109,'Daniel','Faviet','DFAVIET@ORACLE.COM','515.124.4169',to_timestamp('16-AUG-02','DD-MON-RR HH.MI.SSXFF AM'),'FI_ACCOUNT',9000,null,108,100);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (110,'John','Chen','JCHEN@ORACLE.COM','515.124.4269',to_timestamp('28-SEP-05','DD-MON-RR HH.MI.SSXFF AM'),'FI_ACCOUNT',8200,null,108,100);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (111,'Ismael','Sciarra','ISCIARRA@ORACLE.COM','515.124.4369',to_timestamp('30-SEP-05','DD-MON-RR HH.MI.SSXFF AM'),'FI_ACCOUNT',7700,null,108,100);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (112,'Jose Manuel','Urman','JMURMAN@ORACLE.COM','515.124.4469',to_timestamp('07-MAR-06','DD-MON-RR HH.MI.SSXFF AM'),'FI_ACCOUNT',7800,null,108,100);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (113,'Luis','Popp','LPOPP@ORACLE.COM','515.124.4567',to_timestamp('07-DEC-07','DD-MON-RR HH.MI.SSXFF AM'),'FI_ACCOUNT',6900,null,108,100);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (114,'Den','Raphaely','DRAPHEAL@ORACLE.COM','515.127.4561',to_timestamp('07-DEC-02','DD-MON-RR HH.MI.SSXFF AM'),'PU_MAN',11000,null,100,30);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (115,'Alexander','Khoo','AKHOO@ORACLE.COM','515.127.4562',to_timestamp('18-MAY-03','DD-MON-RR HH.MI.SSXFF AM'),'PU_CLERK',3100,null,114,30);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (116,'Shelli','Baida','SBAIDA@ORACLE.COM','515.127.4563',to_timestamp('24-DEC-05','DD-MON-RR HH.MI.SSXFF AM'),'PU_CLERK',2900,null,114,30);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (117,'Sigal','Tobias','STOBIAS@ORACLE.COM','515.127.4564',to_timestamp('24-JUL-05','DD-MON-RR HH.MI.SSXFF AM'),'PU_CLERK',2800,null,114,30);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (118,'Guy','Himuro','GHIMURO@ORACLE.COM','515.127.4565',to_timestamp('15-NOV-06','DD-MON-RR HH.MI.SSXFF AM'),'PU_CLERK',2600,null,114,30);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (119,'Karen','Colmenares','KCOLMENA@ORACLE.COM','515.127.4566',to_timestamp('10-AUG-07','DD-MON-RR HH.MI.SSXFF AM'),'PU_CLERK',2500,null,114,30);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (120,'Matthew','Weiss','MWEISS@ORACLE.COM','650.123.1234',to_timestamp('18-JUL-04','DD-MON-RR HH.MI.SSXFF AM'),'ST_MAN',8000,null,100,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (121,'Adam','Fripp','AFRIPP@ORACLE.COM','650.123.2234',to_timestamp('10-APR-05','DD-MON-RR HH.MI.SSXFF AM'),'ST_MAN',8200,null,100,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (122,'Payam','Kaufling','PKAUFLIN@ORACLE.COM','650.123.3234',to_timestamp('01-MAY-03','DD-MON-RR HH.MI.SSXFF AM'),'ST_MAN',7900,null,100,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (123,'Shanta','Vollman','SVOLLMAN@ORACLE.COM','650.123.4234',to_timestamp('10-OCT-05','DD-MON-RR HH.MI.SSXFF AM'),'ST_MAN',6500,null,100,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (124,'Kevin','Mourgos','KMOURGOS@ORACLE.COM','650.123.5234',to_timestamp('16-NOV-07','DD-MON-RR HH.MI.SSXFF AM'),'ST_MAN',5800,null,100,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (125,'Julia','Nayer','JNAYER@ORACLE.COM','650.124.1214',to_timestamp('16-JUL-05','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',3200,null,120,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (126,'Irene','Mikkilineni','IMIKKILI@ORACLE.COM','650.124.1224',to_timestamp('28-SEP-06','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2700,null,120,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (127,'James','Landry','JLANDRY@ORACLE.COM','650.124.1334',to_timestamp('14-JAN-07','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2400,null,120,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (128,'Steven','Markle','SMARKLE@ORACLE.COM','650.124.1434',to_timestamp('08-MAR-08','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2200,null,120,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (129,'Laura','Bissot','LBISSOT@ORACLE.COM','650.124.5234',to_timestamp('20-AUG-05','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',3300,null,121,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (130,'Mozhe','Atkinson','MATKINSO@ORACLE.COM','650.124.6234',to_timestamp('30-OCT-05','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2800,null,121,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (131,'James','Marlow','JAMRLOW@ORACLE.COM','650.124.7234',to_timestamp('16-FEB-05','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2500,null,121,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (132,'TJ','Olson','TJOLSON@ORACLE.COM','650.124.8234',to_timestamp('10-APR-07','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2100,null,121,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (133,'Jason','Mallin','JMALLIN@ORACLE.COM','650.127.1934',to_timestamp('14-JUN-04','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',3300,null,122,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (134,'Michael','Rogers','MROGERS@ORACLE.COM','650.127.1834',to_timestamp('26-AUG-06','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2900,null,122,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (135,'Ki','Gee','KGEE@ORACLE.COM','650.127.1734',to_timestamp('12-DEC-07','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2400,null,122,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (136,'Hazel','Philtanker','HPHILTAN@ORACLE.COM','650.127.1634',to_timestamp('06-FEB-08','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2200,null,122,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (137,'Renske','Ladwig','RLADWIG@ORACLE.COM','650.121.1234',to_timestamp('14-JUL-03','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',3600,null,123,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (138,'Stephen','Stiles','SSTILES@ORACLE.COM','650.121.2034',to_timestamp('26-OCT-05','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',3200,null,123,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (139,'John','Seo','JSEO@ORACLE.COM','650.121.2019',to_timestamp('12-FEB-06','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2700,null,123,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (140,'Joshua','Patel','JPATEL@ORACLE.COM','650.121.1834',to_timestamp('06-APR-06','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2500,null,123,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (141,'Trenna','Rajs','TRAJS@ORACLE.COM','650.121.8009',to_timestamp('17-OCT-03','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',3500,null,124,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (142,'Curtis','Davies','CDAVIES@ORACLE.COM','650.121.2994',to_timestamp('29-JAN-05','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',3100,null,124,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (143,'Randall','Matos','RMATOS@ORACLE.COM','650.121.2874',to_timestamp('15-MAR-06','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2600,null,124,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (144,'Peter','Vargas','PVARGAS@ORACLE.COM','650.121.2004',to_timestamp('09-JUL-06','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',2500,null,124,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (145,'John','Russell','JRUSSEL@ORACLE.COM','011.44.1344.429268',to_timestamp('01-OCT-04','DD-MON-RR HH.MI.SSXFF AM'),'SA_MAN',14000,0.4,100,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (146,'Karen','Partners','KPARTNER@ORACLE.COM','011.44.1344.467268',to_timestamp('05-JAN-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_MAN',13500,0.3,100,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (147,'Alberto','Errazuriz','AERRAZUR@ORACLE.COM','011.44.1344.429278',to_timestamp('10-MAR-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_MAN',12000,0.3,100,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (148,'Gerald','Cambrault','GCAMBRAU@ORACLE.COM','011.44.1344.619268',to_timestamp('15-OCT-07','DD-MON-RR HH.MI.SSXFF AM'),'SA_MAN',11000,0.3,100,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (149,'Eleni','Zlotkey','EZLOTKEY@ORACLE.COM','011.44.1344.429018',to_timestamp('29-JAN-08','DD-MON-RR HH.MI.SSXFF AM'),'SA_MAN',10500,0.2,100,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (150,'Peter','Tucker','PTUCKER@ORACLE.COM','011.44.1344.129268',to_timestamp('30-JAN-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',10000,0.3,145,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (151,'David','Bernstein','DBERNSTE@ORACLE.COM','011.44.1344.345268',to_timestamp('24-MAR-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',9500,0.25,145,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (152,'Peter','Hall','PHALL@ORACLE.COM','011.44.1344.478968',to_timestamp('20-AUG-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',9000,0.25,145,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (153,'Christopher','Olsen','COLSEN@ORACLE.COM','011.44.1344.498718',to_timestamp('30-MAR-06','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',8000,0.2,145,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (154,'Nanette','Cambrault','NCAMBRAU@ORACLE.COM','011.44.1344.987668',to_timestamp('09-DEC-06','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',7500,0.2,145,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (155,'Oliver','Tuvault','OTUVAULT@ORACLE.COM','011.44.1344.486508',to_timestamp('23-NOV-07','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',7000,0.15,145,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (156,'Janette','King','JKING@ORACLE.COM','011.44.1345.429268',to_timestamp('30-JAN-04','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',10000,0.35,146,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (157,'Patrick','Sully','PSULLY@ORACLE.COM','011.44.1345.929268',to_timestamp('04-MAR-04','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',9500,0.35,146,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (158,'Allan','McEwen','AMCEWEN@ORACLE.COM','011.44.1345.829268',to_timestamp('01-AUG-04','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',9000,0.35,146,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (159,'Lindsey','Smith','LSMITH@ORACLE.COM','011.44.1345.729268',to_timestamp('10-MAR-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',8000,0.3,146,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (160,'Louise','Doran','LDORAN@ORACLE.COM','011.44.1345.629268',to_timestamp('15-DEC-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',7500,0.3,146,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (161,'Sarath','Sewall','SSEWALL@ORACLE.COM','011.44.1345.529268',to_timestamp('03-NOV-06','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',7000,0.25,146,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (162,'Clara','Vishney','CVISHNEY@ORACLE.COM','011.44.1346.129268',to_timestamp('11-NOV-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',10500,0.25,147,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (163,'Danielle','Greene','DGREENE@ORACLE.COM','011.44.1346.229268',to_timestamp('19-MAR-07','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',9500,0.15,147,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (164,'Mattea','Marvins','MMARVINS@ORACLE.COM','011.44.1346.329268',to_timestamp('24-JAN-08','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',7200,0.1,147,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (165,'David','Lee','DLEE@ORACLE.COM','011.44.1346.529268',to_timestamp('23-FEB-08','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',6800,0.1,147,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (166,'Sundar','Ande','SANDE@ORACLE.COM','011.44.1346.629268',to_timestamp('24-MAR-08','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',6400,0.1,147,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (167,'Amit','Banda','ABANDA@ORACLE.COM','011.44.1346.729268',to_timestamp('21-APR-08','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',6200,0.1,147,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (168,'Lisa','Ozer','LOZER@ORACLE.COM','011.44.1343.929268',to_timestamp('11-MAR-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',11500,0.25,148,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (169,'Harrison','Bloom','HBLOOM@ORACLE.COM','011.44.1343.829268',to_timestamp('23-MAR-06','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',10000,0.2,148,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (170,'Tayler','Fox','TFOX@ORACLE.COM','011.44.1343.729268',to_timestamp('24-JAN-06','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',9600,0.2,148,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (171,'William','Smith','WSMITH@ORACLE.COM','011.44.1343.629268',to_timestamp('23-FEB-07','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',7400,0.15,148,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (172,'Elizabeth','Bates','EBATES@ORACLE.COM','011.44.1343.529268',to_timestamp('24-MAR-07','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',7300,0.15,148,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (173,'Sundita','Kumar','SKUMAR@ORACLE.COM','011.44.1343.329268',to_timestamp('21-APR-08','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',6100,0.1,148,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (174,'Ellen','Abel','EABEL@ORACLE.COM','011.44.1644.429267',to_timestamp('11-MAY-04','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',11000,0.3,149,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (175,'Alyssa','Hutton','AHUTTON@ORACLE.COM','011.44.1644.429266',to_timestamp('19-MAR-05','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',8800,0.25,149,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (176,'Jonathon','Taylor','JTAYLOR@ORACLE.COM','011.44.1644.429265',to_timestamp('24-MAR-06','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',8600,0.2,149,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (177,'Jack','Livingston','JLIVINGS@ORACLE.COM','011.44.1644.429264',to_timestamp('23-APR-06','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',8400,0.2,149,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (178,'Kimberely','Grant','KGRANT@ORACLE.COM','011.44.1644.429263',to_timestamp('24-MAY-07','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',7000,0.15,149,null);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (179,'Charles','Johnson','CJOHNSON@ORACLE.COM','011.44.1644.429262',to_timestamp('04-JAN-08','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',6200,0.1,149,80);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (180,'Winston','Taylor','WTAYLOR@ORACLE.COM','650.507.9876',to_timestamp('24-JAN-06','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3200,null,120,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (181,'Jean','Fleaur','JFLEAUR@ORACLE.COM','650.507.9877',to_timestamp('23-FEB-06','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3100,null,120,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (182,'Martha','Sullivan','MSULLIVA@ORACLE.COM','650.507.9878',to_timestamp('21-JUN-07','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',2500,null,120,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (183,'Girard','Geoni','GGEONI@ORACLE.COM','650.507.9879',to_timestamp('03-FEB-08','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',2800,null,120,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (184,'Nandita','Sarchand','NSARCHAN@ORACLE.COM','650.509.1876',to_timestamp('27-JAN-04','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',4200,null,121,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (185,'Alexis','Bull','ABULL@ORACLE.COM','650.509.2876',to_timestamp('20-FEB-05','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',4100,null,121,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (186,'Julia','Dellinger','JDELLING@ORACLE.COM','650.509.3876',to_timestamp('24-JUN-06','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3400,null,121,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (187,'Anthony','Cabrio','ACABRIO@ORACLE.COM','650.509.4876',to_timestamp('07-FEB-07','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3000,null,121,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (188,'Kelly','Chung','KCHUNG@ORACLE.COM','650.505.1876',to_timestamp('14-JUN-05','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3800,null,122,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (189,'Jennifer','Dilly','JDILLY@ORACLE.COM','650.505.2876',to_timestamp('13-AUG-05','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3600,null,122,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (190,'Timothy','Gates','TGATES@ORACLE.COM','650.505.3876',to_timestamp('11-JUL-06','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',2900,null,122,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (191,'Randall','Perkins','RPERKINS@ORACLE.COM','650.505.4876',to_timestamp('19-DEC-07','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',2500,null,122,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (192,'Sarah','Bell','SBELL@ORACLE.COM','650.501.1876',to_timestamp('04-FEB-04','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',4000,null,123,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (193,'Britney','Everett','BEVERETT@ORACLE.COM','650.501.2876',to_timestamp('03-MAR-05','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3900,null,123,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (194,'Samuel','McCain','SMCCAIN@ORACLE.COM','650.501.3876',to_timestamp('01-JUL-06','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3200,null,123,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (195,'Vance','Jones','VJONES@ORACLE.COM','650.501.4876',to_timestamp('17-MAR-07','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',2800,null,123,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (196,'Alana','Walsh','AWALSH@ORACLE.COM','650.507.9811',to_timestamp('24-APR-06','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3100,null,124,50);
insert into HCM1.employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (197,'Kevin','Feeney','KFEENEY@ORACLE.COM','650.507.9822',to_timestamp('23-MAY-06','DD-MON-RR HH.MI.SSXFF AM'),'SH_CLERK',3000,null,124,50);

select null as "Insert into JOBS..." from dual;

--REM INSERTING into jobs
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_PRES','President',20080,40000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_VP','Administration Vice President',15000,30000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_ASST','Administration Assistant',3000,6000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('FI_MGR','Finance Manager',8200,16000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('FI_ACCOUNT','Accountant',4200,9000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AC_MGR','Accounting Manager',8200,16000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AC_ACCOUNT','Public Accountant',4200,9000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SA_MAN','Sales Manager',10000,20080);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SA_REP','Sales Representative',6000,12008);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('PU_MAN','Purchasing Manager',8000,15000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('PU_CLERK','Purchasing Clerk',2500,5500);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_MAN','Stock Manager',5500,8500);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_CLERK','Stock Clerk',2008,5000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SH_CLERK','Shipping Clerk',2500,5500);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('IT_PROG','Programmer',4000,10000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_MAN','Marketing Manager',9000,15000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_REP','Marketing Representative',4000,9000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('HR_REP','Human Resources Representative',4000,9000);
insert into HCM1.jobs (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('PR_REP','Public Relations Representative',4500,10500);

select null as "Insert into JOB_HISTORY..." from dual;

--REM INSERTING into job_history
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (102,to_timestamp('13-JAN-01','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('24-JUL-06','DD-MON-RR HH.MI.SSXFF AM'),'IT_PROG',60);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (101,to_timestamp('21-SEP-97','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('27-OCT-01','DD-MON-RR HH.MI.SSXFF AM'),'AC_ACCOUNT',110);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (101,to_timestamp('28-OCT-01','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('15-MAR-05','DD-MON-RR HH.MI.SSXFF AM'),'AC_MGR',110);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (201,to_timestamp('17-FEB-04','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('19-DEC-07','DD-MON-RR HH.MI.SSXFF AM'),'MK_REP',20);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (114,to_timestamp('24-MAR-06','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('31-DEC-07','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',50);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (122,to_timestamp('01-JAN-07','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('31-DEC-07','DD-MON-RR HH.MI.SSXFF AM'),'ST_CLERK',50);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (200,to_timestamp('17-SEP-95','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('17-JUN-01','DD-MON-RR HH.MI.SSXFF AM'),'AD_ASST',90);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (176,to_timestamp('24-MAR-06','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('31-DEC-06','DD-MON-RR HH.MI.SSXFF AM'),'SA_REP',80);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (176,to_timestamp('01-JAN-07','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('31-DEC-07','DD-MON-RR HH.MI.SSXFF AM'),'SA_MAN',80);
insert into HCM1.job_history (EMPLOYEE_ID,DATE_OF_HIRE,DATE_OF_TERMINATION,JOB_ID,DEPARTMENT_ID) values (200,to_timestamp('01-JUL-02','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('31-DEC-06','DD-MON-RR HH.MI.SSXFF AM'),'AC_ACCOUNT',90);


select null as "Insert into LOCATIONS..." from dual;
--REM INSERTING into locations
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1000,'1297 Via Cola di Rie','00989','Roma',null,'IT');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1100,'93091 Calle della Testa','10934','Venice',null,'IT');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1300,'9450 Kamiya-cho','6823','Hiroshima',null,'JP');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1500,'2011 Interiors Blvd','99236','South San Francisco','California','US');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1700,'2004 Charade Rd','98199','Seattle','Washington','US');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2000,'40-5-12 Laogianggen','190518','Beijing',null,'CN');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2300,'198 Clementi North','540198','Singapore',null,'SG');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2400,'8204 Arthur St',null,'London',null,'UK');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2600,'9702 Chester Road','09629850293','Stretford','Manchester','UK');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2800,'Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (3000,'Murtenstrasse 921','3095','Bern','BE','CH');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL');
insert into HCM1.locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (3200,'Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');

select null as "Insert into REGIONS..." from dual;

--REM INSERTING into REGIONS
insert into HCM1.regions (REGION_ID,REGION_NAME) values (1,'Europe');
insert into HCM1.regions (REGION_ID,REGION_NAME) values (2,'Americas');
insert into HCM1.regions (REGION_ID,REGION_NAME) values (3,'Asia');
insert into HCM1.regions (REGION_ID,REGION_NAME) values (4,'Middle East and Africa');

select null as "Applying Contraints..." from dual;

--REM Applying constraints
alter table HCM1.employees add CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID")REFERENCES EMPLOYEES ("EMPLOYEE_ID") ENABLE;
alter table HCM1.employees add CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID")REFERENCES JOBS ("JOB_ID") ENABLE;
alter table HCM1.employees add  CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")REFERENCES DEPARTMENTS ("DEPARTMENT_ID") ENABLE;
alter table HCM1.departments add CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID")REFERENCES EMPLOYEES ("EMPLOYEE_ID") ENABLE;
alter table HCM1.departments add CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID")REFERENCES LOCATIONS ("LOCATION_ID") ENABLE;
alter table HCM1.countries add CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID")REFERENCES REGIONS ("REGION_ID") ENABLE;
alter table HCM1.locations add CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID")REFERENCES COUNTRIES ("COUNTRY_ID") ENABLE;
alter table HCM1.job_history add CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")REFERENCES DEPARTMENTS ("DEPARTMENT_ID") ENABLE;
alter table HCM1.job_history add CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID")REFERENCES EMPLOYEES ("EMPLOYEE_ID") ENABLE;
alter table HCM1.job_history add CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID")REFERENCES JOBS ("JOB_ID") ENABLE;


select null as "Create and Update EMP_EXTENDED TABLE..." from dual;

--REM employees extended table
CREATE TABLE HCM1.EMP_EXTENDED AS SELECT EMPLOYEE_ID FROM EMPLOYEES;
alter table HCM1.EMP_EXTENDED ADD CONSTRAINT EMP_EXTENDED_EMPID_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);

alter table HCM1.EMP_EXTENDED ADD (TAXPAYERID VARCHAR2(15), PAYMENTACCOUNTNO VARCHAR2(20));

update HCM1.emp_extended set taxpayerID='123-45-6100', paymentAccountNo='4321123454326100' where employee_id=100;
update HCM1.emp_extended set taxpayerID='123-45-6101', paymentAccountNo='4321123454326101' where employee_id=101;
update HCM1.emp_extended set taxpayerID='123-45-6102', paymentAccountNo='4321123454326102' where employee_id=102;
update HCM1.emp_extended set taxpayerID='123-45-6103', paymentAccountNo='4321123454326103' where employee_id=103;
update HCM1.emp_extended set taxpayerID='123-45-6104', paymentAccountNo='4321123454326104' where employee_id=104;
update HCM1.emp_extended set taxpayerID='123-45-6105', paymentAccountNo='4321123454326105' where employee_id=105;
update HCM1.emp_extended set taxpayerID='123-45-6106', paymentAccountNo='4321123454326106' where employee_id=106;
update HCM1.emp_extended set taxpayerID='123-45-6107', paymentAccountNo='4321123454326107' where employee_id=107;
update HCM1.emp_extended set taxpayerID='123-45-6108', paymentAccountNo='4321123454326108' where employee_id=108;
update HCM1.emp_extended set taxpayerID='123-45-6109', paymentAccountNo='4321123454326109' where employee_id=109;
update HCM1.emp_extended set taxpayerID='123-45-6110', paymentAccountNo='4321123454326110' where employee_id=110;
update HCM1.emp_extended set taxpayerID='123-45-6111', paymentAccountNo='4321123454326111' where employee_id=111;
update HCM1.emp_extended set taxpayerID='123-45-6112', paymentAccountNo='4321123454326112' where employee_id=112;
update HCM1.emp_extended set taxpayerID='123-45-6113', paymentAccountNo='4321123454326113' where employee_id=113;
update HCM1.emp_extended set taxpayerID='123-45-6114', paymentAccountNo='4321123454326114' where employee_id=114;
update HCM1.emp_extended set taxpayerID='123-45-6115', paymentAccountNo='4321123454326115' where employee_id=115;
update HCM1.emp_extended set taxpayerID='123-45-6116', paymentAccountNo='4321123454326116' where employee_id=116;
update HCM1.emp_extended set taxpayerID='123-45-6117', paymentAccountNo='4321123454326117' where employee_id=117;
update HCM1.emp_extended set taxpayerID='123-45-6118', paymentAccountNo='4321123454326118' where employee_id=118;
update HCM1.emp_extended set taxpayerID='123-45-6119', paymentAccountNo='4321123454326119' where employee_id=119;
update HCM1.emp_extended set taxpayerID='123-45-6120', paymentAccountNo='4321123454326120' where employee_id=120;
update HCM1.emp_extended set taxpayerID='123-45-6121', paymentAccountNo='4321123454326121' where employee_id=121;
update HCM1.emp_extended set taxpayerID='123-45-6122', paymentAccountNo='4321123454326122' where employee_id=122;
update HCM1.emp_extended set taxpayerID='123-45-6123', paymentAccountNo='4321123454326123' where employee_id=123;
update HCM1.emp_extended set taxpayerID='123-45-6124', paymentAccountNo='4321123454326124' where employee_id=124;
update HCM1.emp_extended set taxpayerID='123-45-6125', paymentAccountNo='4321123454326125' where employee_id=125;
update HCM1.emp_extended set taxpayerID='123-45-6126', paymentAccountNo='4321123454326126' where employee_id=126;
update HCM1.emp_extended set taxpayerID='123-45-6127', paymentAccountNo='4321123454326127' where employee_id=127;
update HCM1.emp_extended set taxpayerID='123-45-6128', paymentAccountNo='4321123454326128' where employee_id=128;
update HCM1.emp_extended set taxpayerID='123-45-6129', paymentAccountNo='4321123454326129' where employee_id=129;
update HCM1.emp_extended set taxpayerID='123-45-6130', paymentAccountNo='4321123454326130' where employee_id=130;
update HCM1.emp_extended set taxpayerID='123-45-6131', paymentAccountNo='4321123454326131' where employee_id=131;
update HCM1.emp_extended set taxpayerID='123-45-6132', paymentAccountNo='4321123454326132' where employee_id=132;
update HCM1.emp_extended set taxpayerID='123-45-6133', paymentAccountNo='4321123454326133' where employee_id=133;
update HCM1.emp_extended set taxpayerID='123-45-6134', paymentAccountNo='4321123454326134' where employee_id=134;
update HCM1.emp_extended set taxpayerID='123-45-6135', paymentAccountNo='4321123454326135' where employee_id=135;
update HCM1.emp_extended set taxpayerID='123-45-6136', paymentAccountNo='4321123454326136' where employee_id=136;
update HCM1.emp_extended set taxpayerID='123-45-6137', paymentAccountNo='4321123454326137' where employee_id=137;
update HCM1.emp_extended set taxpayerID='123-45-6138', paymentAccountNo='4321123454326138' where employee_id=138;
update HCM1.emp_extended set taxpayerID='123-45-6139', paymentAccountNo='4321123454326139' where employee_id=139;
update HCM1.emp_extended set taxpayerID='123-45-6140', paymentAccountNo='4321123454326140' where employee_id=140;
update HCM1.emp_extended set taxpayerID='123-45-6141', paymentAccountNo='4321123454326141' where employee_id=141;
update HCM1.emp_extended set taxpayerID='123-45-6142', paymentAccountNo='4321123454326142' where employee_id=142;
update HCM1.emp_extended set taxpayerID='123-45-6143', paymentAccountNo='4321123454326143' where employee_id=143;
update HCM1.emp_extended set taxpayerID='123-45-6144', paymentAccountNo='4321123454326144' where employee_id=144;
update HCM1.emp_extended set taxpayerID='123-45-6145', paymentAccountNo='4321123454326145' where employee_id=145;
update HCM1.emp_extended set taxpayerID='123-45-6146', paymentAccountNo='4321123454326146' where employee_id=146;
update HCM1.emp_extended set taxpayerID='123-45-6147', paymentAccountNo='4321123454326147' where employee_id=147;
update HCM1.emp_extended set taxpayerID='123-45-6148', paymentAccountNo='4321123454326148' where employee_id=148;
update HCM1.emp_extended set taxpayerID='123-45-6149', paymentAccountNo='4321123454326149' where employee_id=149;
update HCM1.emp_extended set taxpayerID='123-45-6150', paymentAccountNo='4321123454326150' where employee_id=150;
update HCM1.emp_extended set taxpayerID='123-45-6151', paymentAccountNo='4321123454326151' where employee_id=151;
update HCM1.emp_extended set taxpayerID='123-45-6152', paymentAccountNo='4321123454326152' where employee_id=152;
update HCM1.emp_extended set taxpayerID='123-45-6153', paymentAccountNo='4321123454326153' where employee_id=153;
update HCM1.emp_extended set taxpayerID='123-45-6154', paymentAccountNo='4321123454326154' where employee_id=154;
update HCM1.emp_extended set taxpayerID='123-45-6155', paymentAccountNo='4321123454326155' where employee_id=155;
update HCM1.emp_extended set taxpayerID='123-45-6156', paymentAccountNo='4321123454326156' where employee_id=156;
update HCM1.emp_extended set taxpayerID='123-45-6157', paymentAccountNo='4321123454326157' where employee_id=157;
update HCM1.emp_extended set taxpayerID='123-45-6158', paymentAccountNo='4321123454326158' where employee_id=158;
update HCM1.emp_extended set taxpayerID='123-45-6159', paymentAccountNo='4321123454326159' where employee_id=159;
update HCM1.emp_extended set taxpayerID='123-45-6160', paymentAccountNo='4321123454326160' where employee_id=160;
update HCM1.emp_extended set taxpayerID='123-45-6161', paymentAccountNo='4321123454326161' where employee_id=161;
update HCM1.emp_extended set taxpayerID='123-45-6162', paymentAccountNo='4321123454326162' where employee_id=162;
update HCM1.emp_extended set taxpayerID='123-45-6163', paymentAccountNo='4321123454326163' where employee_id=163;
update HCM1.emp_extended set taxpayerID='123-45-6164', paymentAccountNo='4321123454326164' where employee_id=164;
update HCM1.emp_extended set taxpayerID='123-45-6165', paymentAccountNo='4321123454326165' where employee_id=165;
update HCM1.emp_extended set taxpayerID='123-45-6166', paymentAccountNo='4321123454326166' where employee_id=166;
update HCM1.emp_extended set taxpayerID='123-45-6167', paymentAccountNo='4321123454326167' where employee_id=167;
update HCM1.emp_extended set taxpayerID='123-45-6168', paymentAccountNo='4321123454326168' where employee_id=168;
update HCM1.emp_extended set taxpayerID='123-45-6169', paymentAccountNo='4321123454326169' where employee_id=169;
update HCM1.emp_extended set taxpayerID='123-45-6170', paymentAccountNo='4321123454326170' where employee_id=170;
update HCM1.emp_extended set taxpayerID='123-45-6171', paymentAccountNo='4321123454326171' where employee_id=171;
update HCM1.emp_extended set taxpayerID='123-45-6172', paymentAccountNo='4321123454326172' where employee_id=172;
update HCM1.emp_extended set taxpayerID='123-45-6173', paymentAccountNo='4321123454326173' where employee_id=173;
update HCM1.emp_extended set taxpayerID='123-45-6174', paymentAccountNo='4321123454326174' where employee_id=174;
update HCM1.emp_extended set taxpayerID='123-45-6175', paymentAccountNo='4321123454326175' where employee_id=175;
update HCM1.emp_extended set taxpayerID='123-45-6176', paymentAccountNo='4321123454326176' where employee_id=176;
update HCM1.emp_extended set taxpayerID='123-45-6177', paymentAccountNo='4321123454326177' where employee_id=177;
update HCM1.emp_extended set taxpayerID='123-45-6178', paymentAccountNo='4321123454326178' where employee_id=178;
update HCM1.emp_extended set taxpayerID='123-45-6179', paymentAccountNo='4321123454326179' where employee_id=179;
update HCM1.emp_extended set taxpayerID='123-45-6180', paymentAccountNo='4321123454326180' where employee_id=180;
update HCM1.emp_extended set taxpayerID='123-45-6181', paymentAccountNo='4321123454326181' where employee_id=181;
update HCM1.emp_extended set taxpayerID='123-45-6182', paymentAccountNo='4321123454326182' where employee_id=182;
update HCM1.emp_extended set taxpayerID='123-45-6183', paymentAccountNo='4321123454326183' where employee_id=183;
update HCM1.emp_extended set taxpayerID='123-45-6184', paymentAccountNo='4321123454326184' where employee_id=184;
update HCM1.emp_extended set taxpayerID='123-45-6185', paymentAccountNo='4321123454326185' where employee_id=185;
update HCM1.emp_extended set taxpayerID='123-45-6186', paymentAccountNo='4321123454326186' where employee_id=186;
update HCM1.emp_extended set taxpayerID='123-45-6187', paymentAccountNo='4321123454326187' where employee_id=187;
update HCM1.emp_extended set taxpayerID='123-45-6188', paymentAccountNo='4321123454326188' where employee_id=188;
update HCM1.emp_extended set taxpayerID='123-45-6189', paymentAccountNo='4321123454326189' where employee_id=189;
update HCM1.emp_extended set taxpayerID='123-45-6190', paymentAccountNo='4321123454326190' where employee_id=190;
update HCM1.emp_extended set taxpayerID='123-45-6191', paymentAccountNo='4321123454326191' where employee_id=191;
update HCM1.emp_extended set taxpayerID='123-45-6192', paymentAccountNo='4321123454326192' where employee_id=192;
update HCM1.emp_extended set taxpayerID='123-45-6193', paymentAccountNo='4321123454326193' where employee_id=193;
update HCM1.emp_extended set taxpayerID='123-45-6194', paymentAccountNo='4321123454326194' where employee_id=194;
update HCM1.emp_extended set taxpayerID='123-45-6195', paymentAccountNo='4321123454326195' where employee_id=195;
update HCM1.emp_extended set taxpayerID='123-45-6196', paymentAccountNo='4321123454326196' where employee_id=196;
update HCM1.emp_extended set taxpayerID='123-45-6197', paymentAccountNo='4321123454326197' where employee_id=197;
update HCM1.emp_extended set taxpayerID='123-45-6198', paymentAccountNo='4321123454326198' where employee_id=198;
update HCM1.emp_extended set taxpayerID='123-45-6199', paymentAccountNo='4321123454326199' where employee_id=199;
update HCM1.emp_extended set taxpayerID='123-45-6200', paymentAccountNo='4321123454326200' where employee_id=200;
update HCM1.emp_extended set taxpayerID='123-45-6201', paymentAccountNo='4321123454326201' where employee_id=201;
update HCM1.emp_extended set taxpayerID='123-45-6202', paymentAccountNo='4321123454326202' where employee_id=202;
update HCM1.emp_extended set taxpayerID='123-45-6203', paymentAccountNo='4321123454326203' where employee_id=203;
update HCM1.emp_extended set taxpayerID='123-45-6204', paymentAccountNo='4321123454326204' where employee_id=204;
update HCM1.emp_extended set taxpayerID='123-45-6205', paymentAccountNo='4321123454326205' where employee_id=205;
update HCM1.emp_extended set taxpayerID='123-45-6206', paymentAccountNo='4321123454326206' where employee_id=206;
commit;
--
--Add column comments
comment on column employees.employee_id is 'This is the unqiue employee identifier.';
comment on column employees.email is 'This is the email address.';
comment on column employees.salary is 'This is the employees salary - treat as sensitive.';
comment on column job_history.date_of_hire is 'This is the hire date.';
comment on column job_history.date_of_termination is 'This is the termination date.';
comment on column supplemental_data.last_ins_claim is 'Insurance claim must have the healthcare provider details.';
--END of HRPROD


select null as "Gather Schema Statistics on HCM1..." from dual;



--Collect schema statistics

EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'HCM1');


-- Grant selects on HCM1 tables

grant select on HCM1.EMPLOYEES to DBA_HARVEY;
grant select on HCM1.EMPLOYEES to DBA_DEBRA;
grant select on HCM1.EMPLOYEES to MALFOY;
grant select on HCM1.EMPLOYEES to PU_PETE;
grant select on HCM1.EMPLOYEES to APP_USER;

grant select on HCM1.SUPPLEMENTAL_DATA to DBA_HARVEY;
grant select on HCM1.SUPPLEMENTAL_DATA to DBA_DEBRA;
grant select on HCM1.SUPPLEMENTAL_DATA to MALFOY;
grant select on HCM1.SUPPLEMENTAL_DATA to PU_PETE;
grant select on HCM1.SUPPLEMENTAL_DATA to APP_USER;

grant select on HCM1.EMP_EXTENDED to DBA_HARVEY;
grant select on HCM1.EMP_EXTENDED to DBA_DEBRA;
grant select on HCM1.EMP_EXTENDED to MALFOY;
grant select on HCM1.EMP_EXTENDED to PU_PETE;
grant select on HCM1.EMP_EXTENDED to APP_USER;



/* END: Load_HCM_Data */


/*************************************************************************************************/

/* BEGIN: SetupTicketProcedure */

alter session set current_schema=admin;

-- Drop existing, if any, custom package, synonym, and context objects. These statements will cause error the first time you run the script. That is acceptable.

drop package TICKETINFO_PKG;
drop public synonym TICKETINFO_PKG;
drop context TICKETINFO;


select null as "SetupTicketProcedure" from dual;

--
-- This section creates our Change Control Ticketing Package, Procedure, and Context.
-- We audit this data with our custom auditing policies.
--

grant execute on dbms_ldap to SECURE_STEVE with grant option;

create context TICKETINFO using TICKETINFO_PKG;

create or replace package TICKETINFO_PKG as
    procedure set_value_in_context(p_value in varchar2);
end TICKETINFO_PKG;
/

commit;

create or replace package body TICKETINFO_PKG as
    procedure set_value_in_context(p_value in varchar2) is
    begin
         dbms_session.set_context('TICKETINFO', 'TICKET_ID', p_value);
      end set_value_in_context;
 end TICKETINFO_PKG;
 /

commit;

grant execute on ticketinfo_pkg to public;

create public synonym TICKETINFO_PKG for TICKETINFO_PKG;

AUDIT CONTEXT NAMESPACE TICKETINFO ATTRIBUTES TICKET_ID;


/*************************************************************************************************/

/* BEGIN: SetupAuditPolicies */


-- Create 3 audit policies
select null as "SetupAuditPolicies" from dual;

-- Create audit policy app_user_not_app_server
-- The CLIENT_PROGRAM_NAME will not be useful in this example unless you change it to meet your environment.
-- The concept still works as all users connecting as "HCM_USER" will not meet this criteria and ALL actions will be audited
-- This policy is purposely not enabled. Students enable it during workshop.


-- The following 2 statements will error the first time you run this script. This is expected.
NOAUDIT POLICY app_user_not_app_server;
DROP AUDIT POLICY app_user_not_app_server;

CREATE AUDIT POLICY app_user_not_app_server
  ACTIONS ALL
     WHEN 'SYS_CONTEXT(''USERENV'', ''SESSION_USER'') in (''APP_USER'',''HCM1'') AND SYS_CONTEXT(''USERENV'', ''CLIENT_PROGRAM_NAME'') != ''AppServer@slc11wwu (TNS V1-V3)'''
 EVALUATE PER SESSION;

-- Create a second sample Unified Audit Policy to audit whenever PU_PETE SELECTs data from an "HCM" table called "EMPLOYEES"
-- The following 2 statements will error the first time you run this script. This is expected.
NOAUDIT POLICY EMPSEARCH_SELECT_USAGE_BY_PETE;
DROP AUDIT POLICY EMPSEARCH_SELECT_USAGE_BY_PETE;

CREATE AUDIT POLICY EMPSEARCH_SELECT_USAGE_BY_PETE
     ACTIONS SELECT ON HCM1.EMPLOYEES
        WHEN 'SYS_CONTEXT(''USERENV'',''SESSION_USER'') = ''PU_PETE'''
    EVALUATE PER SESSION;
AUDIT POLICY EMPSEARCH_SELECT_USAGE_BY_PETE;

-- Create a third sample Unified Audit Policy to audit employee record changes
-- The following 2 statements will error the first time you run this script. This is expected.
NOAUDIT POLICY EMP_RECORD_CHANGES;
DROP AUDIT POLICY EMP_RECORD_CHANGES;

create audit policy EMP_RECORD_CHANGES
  ACTIONS INSERT ON HCM1.EMPLOYEES
        , INSERT ON HCM1.EMP_EXTENDED
        , update ON HCM1.EMPLOYEES
        , update ON HCM1.EMP_EXTENDED
	    , DELETE ON HCM1.EMPLOYEES
        , DELETE ON HCM1.EMP_EXTENDED
     WHEN 'SYS_CONTEXT(''USERENV'', ''SESSION_USER'') != ''HCM1'''
 EVALUATE PER SESSION;
AUDIT POLICY EMP_RECORD_CHANGES;

-- Enable other audit policies on Autonomous Data Warehouse.

AUDIT POLICY ORA_DV_AUDPOL2;
AUDIT POLICY ORA_CIS_RECOMMENDATIONS;
AUDIT POLICY ORA_ACCOUNT_MGMT;
AUDIT POLICY ORA_DATABASE_PARAMETER;
AUDIT POLICY ORA_LOGON_FAILURES;
AUDIT POLICY ORA_DV_AUDPOL;
AUDIT POLICY ORA_SECURECONFIG;
AUDIT POLICY ORA_RAS_SESSION_MGMT;
AUDIT POLICY ORA_RAS_POLICY_MGMT;



/*************************************************************************************************/

-- ADMIN user activities to audit

select null as "Admin activities" from dual;


-- Switch logfile is an example of an action a DBA might take.

alter system switch logfile;
--ERROR: insufficent privileges (This is expected and can be used for auditing practice)

-- Count sessions
select count(*) From v$session;

-- Query instance name
select * from gv$instance;

-- Query processes
select count(*) from v$process;

-- Query current session information
select sessions_max, sessions_current, sessions_highwater, users_max from v$license;

-- another query
select b.paddr , b.name nme, b.description descr, to_char(b.error) cerror from  v$bgprocess b, v$process p where  b.paddr = p.addr;

-- query log information
select sequence#, group#, first_change#, first_time, archived, bytes from v$log order by sequence#, group#;

-- another query
select count(*)
from sys.dba_segments a
where a.tablespace_name not like 'T%MP%'
   and nvl(a.next_extent,a.initial_extent) * 1 >
    (select max(b.bytes) from dba_free_space b where a.tablespace_name = b.tablespace_name);

-- another query
SELECT count(*)
FROM (SELECT tablespace_name, SUM (blocks) ublocks
        FROM dba_segments
        GROUP BY tablespace_name) s,
     (SELECT tablespace_name, SUM (blocks) fblocks
        FROM dba_free_space
        GROUP BY tablespace_name) f,
     (SELECT tablespace_name, SUM(blocks) ablocks
        FROM dba_data_files
        GROUP BY tablespace_name) a
WHERE s.tablespace_name = f.tablespace_name and
      s.tablespace_name = a.tablespace_name and
      s.tablespace_name not in ('SYSTEM','SYSAUX','TOOLS','UNDO01') and
      ((s.ublocks/a.ablocks)*100) > 50;



select null as "Rebuilding Indexes..." from dual;

-- Rebuilding indexes is an example of action a DBA might take

begin
for x in (select owner, index_name from dba_indexes where owner = 'HCM1') loop

begin
dbms_output.put_line('rebuilding '||x.owner||'.'||x.index_name||'...');
execute immediate 'alter index '||x.owner||'.'||x.index_name||' rebuild';
exception when others then
 null;
end;

end loop;
end;
/


select null as "Grant privileges to PU_PETE..." from dual;
-- granting selects to users

grant select on HCM1.SUPPLEMENTAL_DATA to PU_PETE;
grant select on HCM1.EMPLOYEES to PU_PETE;
grant select on HCM1.EMP_EXTENDED to PU_PETE;
grant select on HCM1.LOCATIONS to PU_PETE;



select null as "Show initialization parameter for Optimizer Indexes..." from dual;
-- ADMIN activities

--show parameter processes

select * from v$parameter where name like '%optimizer_index%';

-- the following statements produce errors (insufficient privileges). This is expected and can be used for auditing practice
alter system set OPTIMIZER_INDEX_COST_ADJ = 40;
alter system set timed_statistics = TRUE scope=memory;

select null as "Alter EMPLOYEES table..." from dual;

alter table HCM1.employees modify phone_number varchar2(20);



-- Drop users

select null as "DROP USERS..." from dual;

drop user MALFOY cascade;
drop user APP_USER cascade;

-- The following statements will cause an error  the first time you run this script. This is expected.
drop user VOLDEMORT cascade;
drop user GRINDELWALD cascade;
drop user WEASLEY;
drop user LESTRANGE cascade;
drop user SKEETER cascade;
drop user APP_USER cascade;



-- Create users

select null as "CREATE USERS..." from dual;

-- creating POWERUSERS PROFILE
-- The following statement will cause an error the first time you run this script. This is expected.
drop profile POWERUSERS;

create profile POWERUSERS limit
   FAILED_LOGIN_ATTEMPTS 5
   PASSWORD_LIFE_TIME 60
   PASSWORD_REUSE_TIME 60
   PASSWORD_REUSE_MAX 5
   PASSWORD_VERIFY_FUNCTION null
   PASSWORD_LOCK_TIME 1/24
   PASSWORD_GRACE_TIME 10;


create user MALFOY identified by Oracle123_Oracle123;

create user VOLDEMORT identified by Oracle123_Oracle123 profile POWERUSERS password EXPIRE;
-- ERROR: profile POWERUSERS does not exist  (try creating the profile. if not, take out; remove everything after profile)

create user GRINDELWALD identified by Oracle123_Oracle123;

-- Will get privileges to be flagged as Non-Privileged, Medium Risk
create user WEASLEY identified by Oracle123_Oracle123;
create user LESTRANGE identified by Oracle123_Oracle123;
create user SKEETER identified by Oracle123_Oracle123;


create user APP_USER identified by Oracle123_Oracle123;


-- User APPX will show up on User Assessment as "Schema" and with Status "Expired and Locked"
create user APPX identified by Oracle123_Oracle123 account lock password expire;
-- ERROR: user name 'APPX' conflicts with another user or role name. This is expected.

--
-- grants
--
select null as "Run Grants..." from dual;

grant connect to DBA_HARVEY, MALFOY, PU_PETE, APP_USER, LESTRANGE, SKEETER, VOLDEMORT;
grant AUDIT_ADMIN to SKEETER;
grant SYSDBA to LESTRANGE;
-- ERROR: insufficient privileges (more audit activity)

grant SYSDG to MALFOY;
-- ERROR: insufficient privileges (more audit activity)

grant SYSKM to VOLDEMORT;
-- ERROR: insufficient privileges (more audit activity)

grant PDB_DBA to PUBLIC;

grant PDB_DBA to MALFOY;

grant PDB_DBA to PU_PETE;

grant PDB_DBA to DBA_DEBRA;


select null as "Grant Roles and System Privileges..." from dual;

grant CAPTURE_ADMIN to DBA_DEBRA;

grant SELECT ANY TABLE to VOLDEMORT;

grant ALTER DATABASE LINK to WEASLEY;
-- ERROR: ORA-01031: insufficient privileges (good for auditing)

grant CREATE ANY OPERATOR to WEASLEY;
grant ALTER RESOURCE COST to WEASLEY;
grant CREATE ROLLBACK SEGMENT to WEASLEY;
grant SELECT ANY TABLE to WEASLEY;


grant update ANY TABLE to WEASLEY;

--The following statement is expected to cause an error (good for auditing)
grant EXPORT FULL DATABASE to WEASLEY;
grant SELECT ANY TABLE to HCM1;
grant update ANY TABLE to HCM1;

select null as "Create Database Directories..." from dual;

create directory BENIGN as '/tmp';
-- ERROR: ORA-65254: invalid path specified for the directory (create audit info)

create directory TRUSTME as '/tmp';
-- ERROR: ORA-65254: invalid path specified for the directory (create audit info)

-- To raise 'Directory Objects' finding to High Risk
grant write, execute on directory BENIGN to GRINDELWALD;
-- ERROR: ORA-04042: procedure, function, package, or package body does not exist (create audit info)

select null as "Highlight Indirect Grant Privileges..." from dual;

-- To highlight indirect privileges
-- The following three statements will cause an error the first time you run this script. This is expected.
drop role approle1;
drop role approle2;
drop role approle3;


create role approle1;
create role approle2;
create role approle3;
grant create session to approle1;
grant resource to approle1;
grant select any table to approle2;
grant PDB_DBA to approle3;
grant approle3 to approle2;
grant approle2 to approle1;
grant approle1 to GRINDELWALD;
grant EXECUTE on SYS.DBMS_BACKUP_RESTORE to GRINDELWALD;
-- ERROR: ORA-00942: table or view does not exist (creates audit info)


select null as "Try to grant access to Database Link Passwords..." from dual;

-- To turn "Access to Password Verifier Tables" Evaluate
grant select on sys.link$ to GRINDELWALD;
-- ERROR: ORA-00942: table or view does not exist (creates audit info)

drop directory BENIGN;
-- ERROR: ORA-04043: object BENIGN does not exist (creates audit info)

drop directory TRUSTME;
-- ERROR: ORA-04043: object TRUSTME does not exist (creates audit info)


select null as "Run an Explain Plan on EMPLOYEES..." from dual;
--
-- This section is is an example of normal DBA, Application, End-user activity.
-- These queries should return successful. Queries might fail in ADB.
--

explain plan for
select FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, SALARY,COMMISSION_PCT,MANAGER_ID from HCM1.EMPLOYEES where department_id = 80 order by manager_id;


/*************************************************************************************************/

-- verify that the sample data loaded successfully

select null as "Verify Data Loaded Succesfully..." from dual;

select count(*) as EMPLOYEES from HCM1.EMPLOYEES;
select count(*) as DEPARTMENTS from HCM1.DEPARTMENTS;
select count(*) as COUNTRIES from HCM1.COUNTRIES;
select count(*) as LOCATIONS from HCM1.LOCATIONS;
select count(*) as REGIONS from HCM1.REGIONS;
select count(*) as JOB_HISTORY from HCM1.JOB_HISTORY;
select count(*) as JOBS from HCM1.JOBS;

select null as "End of script" from dual;
