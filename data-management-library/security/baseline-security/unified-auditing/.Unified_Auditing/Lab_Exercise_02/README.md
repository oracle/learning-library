# Unified Auditing - Lab Two

---

In this lab you will configure the Unified Audit Trail and review an audit of Oracle Data Pump export. This is a feature of Unified Audit that is not available in traditional auditing.

In the first step, we will switch to pure Unified Audit mode. This involves shutting down the database, making a change to the binary, and restarting it. 

    ./01_configure_unified_audit_trail.sh
    
Review the audit settings
    
    ./02_current_audit_settings.sh
    
Generate Audit activity

    ./03_generate_audit_workload.sh
    
View the audit records from the activity
    
    ./04_review_audit_output.sh
    
Create a Unified Audit policy to audit Data Pump activities

    ./05_audit_datapump_export.sh

Perform a test Data Pump Export

    ./06_datapump_export_hr_table.sh
    
Review the Unified Audit Trail for the Data Pump activity
    
    ./07_review_datapump_audit_events.sh

You're ready for the next lab!


---

Move up one [directory](../README.md)

Click to return [home](/README.md)


