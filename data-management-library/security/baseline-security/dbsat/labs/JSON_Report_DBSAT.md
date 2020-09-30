![](../../../images/banner_DBSAT.PNG)

# Processing DBSAT report JSON output

## **1. DBSAT Reporter JSON Report**

In this exercise, you will be exposed to the DBSAT utilities (dbsat_diff & dbsat_extract), the JSON output report, and how to get a relational view from it. 

The primary purpose of the JSON report is to open DBSAT reporter to integration with 3rd party tools. Another use case could be to build a model to load data from multiple databases and be able to compare/generate side-by-side reports.

---
**NOTE:** These sample utilities can be downloaded from My Oracle Support Doc ID `2138254.1` but the zip file is included in the DBSec Lab VM image for your convenience.

---

- Open a SSH session on your DBSec-Lab VM as Oracle User
````
<copy>
        sudo su - oracle
</copy>
````
- Go to the scripts directory
````
<copy>
        cd $DBSEC_HOME/workshops/Database_Security_Labs/DBSAT
</copy>
````        
- Unzip `dbsat_util.zip`
````
<copy>
        unzip dbsat_util.zip -d dbsat22

    ![](../images/DBSAT_011.PNG)
</copy>
````

## **2. Using dbsat_extract**

- `dbsat_extract` enables you to extract findings by their identifiers

- Execute the following to extract `CRYPT.TDE` and `CONF.PWDFILE` findings from the previously generated hol_report.json file: 

        python dbsat_extract -i CRYPT.TDE -i CONF.PWDFILE -v dbsat22/pdbhol_report.json

    ![](../images/dbsat22-util-dbsat-extract.png)


## **3. Using dbsat_diff**

- `dbsat_diff` enables you to compare two reports and find the differences

- You will need two different dbsat reporter output reports in JSON format for the command to produce useful output. You can do some configuration changes and run dbsat collect and report again so you can have two different reports to compare.
As an example, generate a second report:
````
<copy>
        cd dbsat22
        ./dbsat collect dbsat_admin@pdb1 pdbhol2
        ./dbsat report pdbhol2
        unzip pdbhol2_report.zip
</copy>
````
- Run: 
````
<copy>        
        python dbsat_diff pdbhol_report.json pdbhol2_report.json
</copy>
````
- You should see this:

    ![](../images/DBSAT_012.PNG)


## **4. Loading the JSON report into the database for further processing**

In this simple case, we will load the JSON document into the Oracle Database and execute a query to get the findings in a relational view.

- Connect as `DBA_DEBRA`
````
<copy>
        sqlplus dba_debra/Oracle123@pdb1
                
 </copy>
````       
- Create a directory object to read from the dbsat installation directory: 
````
<copy>
        create or replace directory DBSAT_DIR as '/home/oracle/DBSecLab/workshops/Database_Security_Labs/DBSAT/dbsat22';
</copy>
````
- Create a table to store the JSON report: 
````
<copy>
    create table DBSAT_FOO(
            docname varchar2(32),
            doc CLOB check (DOC IS JSON)); 
 </copy>
````           
- Insert the JSON report into the table: 
````
<copy>
        insert into DBSAT_FOO values ('pdbhol_report.json', bfilename('DBSAT_DIR','pdbhol_report.json')); 
        commit;
</copy>
````
- Execute the following:
````
<copy>
        col docname format a17 
        col title format a50 
        col remarks format a60 
        set lines 400 
        set pages 100 
        
        select docname, severity, title, remarks
        from DBSAT_FOO, JSON_TABLE( 
                doc, 
                '$[*].items[*]' columns TYPE VARCHAR2(32) PATH '$.type', 
                severity NUMBER PATH '$.severity', 
                title VARCHAR2(128) PATH '$.title', 
                remarks VARCHAR2(4000) PATH '$.remarks' ) 
        where TYPE = 'finding' 
        order by docname, severity
        /
</copy>
````
- You should see this:

    ![](../images/dbsat22-json-loading-and-query.png)

---

Move up one [directory](../README.md)

Click to return [home](/README.md)
