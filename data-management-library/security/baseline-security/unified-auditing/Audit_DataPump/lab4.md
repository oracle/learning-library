# Unified Auditing 


In this lab you will configure the Unified Audit Trail and review an audit of Oracle Data Pump export. This is a feature of Unified Audit that is not available in traditional auditing.

In the first step, we will switch to pure Unified Audit mode. This involves shutting down the database, making a change to the binary, and restarting it. 

````
<copy>
    ./01_configure_unified_audit_trail.sh
</copy>
````    

Review the audit settings

````
<copy>    
    ./02_current_audit_settings.sh
 </copy>
````   

Generate Audit activity
````
<copy>
    ./03_generate_audit_workload.sh
 </copy>
````   
View the audit records from the activity
 ````
<copy>   
    ./04_review_audit_output.sh
 </copy>
````   
Create a Unified Audit policy to audit Data Pump activities
````
<copy>
    ./05_audit_datapump_export.sh
</copy>
````
Perform a test Data Pump Export
````
<copy>
    ./06_datapump_export_hr_table.sh
 </copy>
````   
Review the Unified Audit Trail for the Data Pump activity
````
<copy>    
    ./07_review_datapump_audit_events.sh
</copy>
````
You're ready for the next lab!


---

Move up one [directory](../README.md)

Click to return [home](/README.md)


