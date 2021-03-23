<table class="tbl-heading"><tr><td class="td-logo">

![](./images/obe_tag.png)

Sept 1, 2019
</td>
<td class="td-banner">
# Protect your data with Database Vault
</td></tr><table>

### Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
## Introduction


Managed database services run the risk of 'Admin snooping', allowing privileged users access to customer data. Oracle Autonomous Database provides powerful security controls within your dedicated database, restricting access to application data by privileged database users, reducing the risk of insider and outsider threats and addressing common compliance requirements.

You can deploy controls to block privileged account access to application data and control sensitive operations inside the database. Trusted paths can be used to add additional security controls to authorized data access and database changes. Through the runtime analysis of privileges and roles, you can increase the security of existing applications by implementing least privileges and reducing the attack profile of your database accounts. IP addresses, usernames, client program names and other factors can be used as part of Oracle Database Vault security controls to increase security.  Oracle Database Vault secures existing database environments transparently, eliminating costly and time consuming application changes.**
For more information, refer to the [Database Vault Administrator’s Guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/dvadm/introduction-to-oracle-database-vault.html)

## Objectives

As a database security admin,

- Configure and enable Database Vault for your dedicated database instance
- Create a realm to restrict schema access
- Add audit policy to audit Database Vault activities


## Required Artifacts

- An Oracle Cloud Infrastructure account

- A pre-provisioned instance of Oracle Developer Client image in an application subnet. Refer to [Lab2](20DeployImage.md)

- A pre-provisioned Autonomous Transaction Processing instance. Refer to [Lab 1](./10ProvisionAnATPDatabase.md)

## Steps

### **STEP 1: Set up Application Schema and Users**

Oracle Database vault comes pre-installed with your Autonomous database on dedicated infrastructure. In this lab we will enable Database Vauly (DV), add required user accounts and create a DV realm to secure a set of user tables from priviledged user access. 

Our implementation scenario looks as follow,

![](./images/DBVault/DVarchitecture.png)

The HR schema contains multiple tables. The employees table contains sensitive information such as employee names, SSN, pay-scales etc. and needs to be protected from priviledged users such as the schema owner (user HR) and admin (DBA)

The table should however be available to the application user (app). Note that while the entire HR schema can be added to DV, here we demonstrate more fine grained control by simply adding a single table to the vault.

**Let's start by creating the HR schema and the app user account**


Connect to your dedicated autonomous database instance as user 'admin' and run the following commands to build the 'HR' schema,

````
create user hr identified by WElcome_123#;
grant create session, create table to hr;
grant unlimited tablespace to hr;
create table hr.employees (id number, name varchar2 (20), salary number);
insert into hr.employees values (10,'Larry',20000);
commit;
````

Next, create the application user 'app'

````
create user appuser identified by WElcome_123#;
grant create session, read any table to appuser;
````

### **STEP 2: Configure and enable Database Vault**

We start with creating the two DV user accounts - DV Owner and DV Account Manager. The dv_owner account is mandatory as an owner of DV objects. DV account manager is an optional but recommended role. Once DV is enabled, the user 'admin' loses its ability to create/drop DB user accounts and that privilege is then with the DV Account Manager role. While DV Owner can also become DV account manager, it is recommended to maintain separation of duties via two different accounts.

Create the Database Vault owner and account manager users as shown below

````
create user dv_owner identified by WElcome_123#;
grant create session to dv_owner;
grant audit_admin to dv_owner;
create user dv_acctmgr identified by WElcome_123#;
grant create session to dv_acctmgr;
````

Configure the Database Vault user accounts,

````
exec dvsys.configure_dv('dv_owner','dv_acctmgr');

````

Next, verify if Database Vault is enabled:

````
SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';
````
![](./images/DBVault/valueFalse.png)

As you can see, DV isn't enabled yet.

Connect as the Database Vault Owner that you just configured and enable Database Vault.

````
connect dv_owner/password@tns_connect_string_for_your_db
exec dbms_macadm.enable_dv; 
````

You must “restart” the database to complete the Database Vault registration process. You may restart the database from the console as shown.

![](./images/DBVault/stopdb.png)
![](./images/DBVault/startdb.png)

Once restart completes, log in as Database Vault owner and verify DV is enabled

````
select value from v$option where parameter = 'Oracle Database Vault';
````
![](./images/DBVault/verifyDV.png)

### **STEP 3: Create security Realms and add schema objects**

Next we create a 'Realm', add objects to it and define access rules for the realm.

Let's create a realm to secure HR.EMPLOYEES table from ADMIN and HR (table owner) and grant access to APPUSER only.
As Database Vault Owner, execute the following PL/SQL statements:

````
BEGIN
 DBMS_MACADM.CREATE_REALM(
  realm_name    => 'HR App', 
  description   => 'Realm to protect HR tables', 
  enabled       => 'y', 
  audit_options => DBMS_MACUTL.G_REALM_AUDIT_OFF,
  realm_type    => 1);
END; 
/
BEGIN
 DBMS_MACADM.ADD_OBJECT_TO_REALM(
  realm_name   => 'HR App', 
  object_owner => 'HR', 
  object_name  => 'EMPLOYEES', 
  object_type  => 'TABLE'); 
END;
/
BEGIN
 DBMS_MACADM.ADD_AUTH_TO_REALM(
  realm_name   => 'HR App', 
  grantee      => 'APPUSER');
END;
/ 
````
![](./images/DBVault/realm1.png)
![](./images/DBVault/realm2.png)

### **STEP 4: Create Audit Policy to Capture Realm Violations**

You may also want to capture an audit trail of unauthorized access attempts to your realm objects. Since the Autonomous Database includes Unified Auditing, we will create a policy to audit database vault activities. For more information on Unified Auditing, refer to the [Database Security Guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/introduction-to-auditing.html)

Create an audit policy to capture realm violations

````
create audit policy dv_realm_hr
actions select, update, delete
actions component=DV Realm Violation ON "HR App";
audit policy dv_realm_hr;
````

![](./images/DBVault/audit1.png)


Finally, let's test how this all works.

To test the realm, try to access the EMPLOYEES table as HR, ADMIN and then APPUSER, you can test with a combination of SELECT and DML statements.

![](./images/DBVault/audit2.png)


**Note: The default 'admin' account in ADB has access to all objects in the database, but realm objects are now protected from admin access. In fact, even the table owner HR does not have access to this table. Only APPUSER has access.**

### **STEP 5: Review realm violation audit trail**

We can query the audit trail to generate a basic report of realm access violations. 

Connect as Audit Administrator, in this lab this is the Database Vault owner, and execute the following:

````
set head off
select os_username, dbusername, event_timestamp, action_name, sql_text 
from UNIFIED_AUDIT_TRAIL where DV_ACTION_NAME='Realm Violation Audit';
````
[](./images/DBVault/audit3.png)

You can see the access attempts from HR and Admin.

That is it! You have successfully enabled and used database vault in your autonomous database.

If you'd like to reset your database to its original state, follow the steps below -

To remove the components created for this lab and reset the database back to the original configuration. 
As Database Vault owner, execute:

````
noaudit policy dv_realm_hr;
drop audit policy dv_realm_hr;
EXEC DBMS_MACADM.DELETE_REALM('HR App');
EXEC DBMS_MACADM.DISABLE_DV;
````

Restart the database, go to the console to Stop and Start the ATP database.


<table>
<tr><td class="td-logo">

[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
### Congratulations! You successfully learnt to use  database vault in your autonomous database




</td>
</tr>
<table>
