
# Unified Audit - Enable Mixed Mode Auditing

![](../../images/banner_UA.PNG)

Oracle Unified Auditing was introduced in Oracle Database 12c.<br>

It will replace the traditional auditing and fine grain auditing of previous releases. By default, database at version 12c and newer will operating in mixed-mode, meaning both Unified and traditional auditing are enabled. 


**Technical Documentation**

- [Oracle Unified Auditing 20c](https://docs.oracle.com/en/database/oracle/oracle-database/20/dbseg/administering-the-audit-trail.html#GUID-9F298B8A-6196-4206-A889-A7CEB0924CF1)

---
![](../../images/OTube_Logo.PNG)<br>
&nbsp; Watch Unified Auditing presentation on OTube (**Internal only**):
- Nothing for the moment!



Version tested in this lab: `Oracle DB 19.5`

- Finally, if you wish to restore to the point in time prior to enabling TDE, follow the steps in lab [Enable_Mixed_Mode_Auditing](Enable_Mixed_Mode_Auditing/README.md). 


## Lab 1

This lab probably isn't necessary but if you want to move back to Mixed Mode (Unified and Traditional Auditing) you can run this script.




**DEFAULT Oracle Database AUDIT Settings**

````
<copy>

Audit alter any table by access;

Audit create any table by access;

Audit drop any table by access;

Audit Create any procedure by access;

Audit Drop any procedure by access;

Audit Alter any procedure by access;

Audit Grant any privilege by access;

Audit grant any object privilege by access;

Audit grant any role by access;

Audit audit system by access;

Audit create external job by access;

Audit create any job by access;

Audit create any library by access;

Audit create public database link by access;

Audit exempt access policy by access;

Audit alter user by access;

Audit create user by access;

Audit role by access;

Audit create session by access;

Audit drop user by access;

Audit alter database by access;

Audit alter system by access;

Audit alter profile by access;

Audit drop profile by access;

Audit database link by access;

Audit system audit by access;

Audit profile by access;

Audit public synonym by access;

Audit system grant by access;
</copy>
````

## Lab 2 


In this lab you will configure the Unified Audit Trail and review an audit of Oracle Data Pump export. This is a feature of Unified Audit that is not available in traditional auditing.

1. In the first step, we will switch to pure Unified Audit mode. This involves shutting down the database, making a change to the binary, and restarting it. 

````
<copy>
./01_configure_unified_audit_trail.sh
</copy>
```` 
2. Review the audit settings
````
<copy>    
./02_current_audit_settings.sh
</copy>
````    
3. Generate Audit activity
````
<copy>
./03_generate_audit_workload.sh
</copy>
````    
4. View the audit records from the activity
````
<copy>   
./04_review_audit_output.sh
 </copy>
````   
5. Create a Unified Audit policy to audit Data Pump activities
````
<copy>
./05_audit_datapump_export.sh
</copy>
````
6. Perform a test Data Pump Export
````
<copy>
./06_datapump_export_hr_table.sh
 </copy>
````   
7. Review the Unified Audit Trail for the Data Pump activity
````
<copy>   
./07_review_datapump_audit_events.sh
</copy>
````
You're ready for the next lab!


## Lab 3 


In this lab, you will create an Audit policy for activity that happens outside of the application tier.


Create a Unified Audit policy that audits any user, other than `EMPLOYEESEARCH_PROD`, who accesses the `DEMO_HR_EMPLOYEES` table. 

````
<copy>
    ./01_create_audit_policy_outside_hr_app.sh
</copy>
````
Generate an audit workload and review the results.
````
<copy>
    ./02_generate_audit_workload.sh
</copy>
````   
You have completed this lab!





