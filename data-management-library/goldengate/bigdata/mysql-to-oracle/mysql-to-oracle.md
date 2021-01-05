# MySQL to Oracle (using jdbc)

## Introduction

This **read only** lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.
In this lab is a read-only example on how we use goldengate for bigdata Java Database Connectivity (JDBC) Handler to replicate source transactional data to a target or database.

*Estimated Lab Time*:  60 minutes

### Objectives
- Explore replication from **MySQL to Oracle using jdbc**

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Deploy GoldenGate for Big Data

## **STEP 0:** Running your Lab
### Login to Host using SSH Key based authentication
Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
  - Authentication OS User - “*opc*”
  - Authentication method - *SSH RSA Key*
  - OS User – “*oracle*”.

1. First login as “*opc*” using your SSH Private Key

2. Then sudo to “*oracle*”. E.g.

    ```
    <copy>sudo su - oracle</copy>
    ```
## **STEP 1**: Oracle GoldenGate Configuration

1. Review the trail file located in the GGBD home. We will be using the same trail file to replicate .

2. Setup the Oracle jdbc driver as user `oracle`.

    ```
    <copy>mkdir -p /u01/app/jars/oracle_jdbc
    cd /u01/app/jars/oracle_jdbc
    cp /home/oracle/Downloads/ojdbc8-full.tar.gz /u01/app/jars/oracle_jdbc/
    tar -xvzf ojdbc8-full.tar.gz</copy>
    ```

 2. Login to ggsci (GG command line interface)

    ```  
    <copy>./ggsci</copy>
    ```
3. Add the replicat with the below commands by logging into ggsci prompt

    ```
    <copy>add replicat rjdbc, exttrail ./dirdat/eb
    edit param rjdbc</copy>
    ```

4. Add the below parameters in the parameter file :

    ```
    REPLICAT rjdbc
    ----------------------------------------------------------------------------------------
    -- Trail file for this example is located in "AdapterExamples/trail" directory
    -- Command to add REPLICAT
    -- add replicat rjdbc, exttrail ./dirdat/eb
    --TARGETDB LIBFILE libggjava.so SET property=dirprm/jdbc_mysql_with_mdp.props
    ----------------------------------------------------------------------------------------
    TARGETDB LIBFILE libggjava.so SET property=dirprm/jdbc_oracle_with_mdp.props
    REPORTCOUNT EVERY 1 MINUTES, RATE
    GROUPTRANSOPS 1000

    REPERROR DEFAULT, DISCARD
    DISCARDFILE ./dirrpt/rjdbc.dsc, APPEND

    MAP employees.employees,    TARGET EMPLOYEES.EMPLOYEES,   KEYCOLS(EMP_NO);
    MAP employees.departments,  TARGET EMPLOYEES.DEPARTMENTS, KEYCOLS(DEPT_NO);
    MAP employees.dept_manager, TARGET EMPLOYEES.DEPT_MANAGER,KEYCOLS(EMP_NO,DEPT_NO);
    MAP employees.dept_emp,     TARGET EMPLOYEES.DEPT_EMP,    KEYCOLS(EMP_NO,DEPT_NO);
    MAP employees.titles,       TARGET EMPLOYEES.TITLES,      KEYCOLS(EMP_NO,TITLE,FROM_DATE);
    MAP employees.salaries,     TARGET EMPLOYEES.SALARIES,    KEYCOLS(EMP_NO,FROM_DATE);
    ```

5. Now edit the `dirprm/jdbc_oracle_with_mdp.props` file with the below parameters. You can use sample property files found in `$GGBD_HOME/AdapterExamples/big-data/jdbc`.

    ```
    <copy>exit
    cd dirprm
    vi jdbc_oracle_with_mdp.props</copy>
    ```

6. Verify and use the parameters.

    ```
    <copy>gg.handlerlist=jdbcwriter
    gg.handler.jdbcwriter.type=jdbc

    #Handler properties for Oracle database target with JDBC Metadata provider
    gg.handler.jdbcwriter.DriverClass=oracle.jdbc.driver.OracleDriver
    gg.handler.jdbcwriter.connectionURL=jdbc:oracle:thin:@129.213.97.81:1521/PDB1
    gg.handler.jdbcwriter.userName=employees
    gg.handler.jdbcwriter.password=employees
    gg.classpath=/u01/app/jars/oracle_jdbc/ojdbc8-full/ojdbc8.jar
    #JDBC Metadata provider for Oracle target
    gg.mdp.type=jdbc
    gg.mdp.ConnectionUrl=jdbc:oracle:thin:@129.213.97.81:1521/PDB1
    gg.mdp.DriverClassName=oracle.jdbc.driver.OracleDriver
    gg.mdp.UserName=employees
    gg.mdp.Password=employees

    goldengate.userexit.writers=javawriter
    javawriter.stats.display=TRUE
    javawriter.stats.full=TRUE
    gg.log=log4j
    gg.log.level=INFO
    gg.report.time=30sec
    javawriter.bootoptions=-Xmx512m -Xms32m -Djava.class.path=.:ggjava/ggjava.jar:./dirprm</copy>
    ```

5. Now Goto ggsci command prompt and start the replicat. 
```
<copy>start rjdbc</copy>
```
   We can see the stats of the replicat

6. Login to the database `cdb1`

    ```
    <copy>. oraenv</copy>
    ORACLE_SID = [cdb1] 
    ```
    ```
    <copy>sqlplus employees/employees@pdb1</copy>
    ```

7. Now run the below script to get the tables counts

    ```
    <copy>select 'employees       table -> '|| count(1) as Target from employees.employees UNION ALL
    select 'departments     table -> '|| count(1) from employees.departments UNION ALL
    select 'dept_manager    table -> '|| count(1) from employees.dept_manager UNION ALL
    select 'dept_emp        table -> '|| count(1) from employees.dept_emp UNION ALL
    select 'titles          table -> '|| count(1) from employees.titles UNION ALL
    select 'salaries        table -> '|| count(1) from employees.salaries;</copy>
    ```

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, October 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
