

### What Is Unified Auditing?
In unified auditing, the unified audit trail captures audit information from a variety of sources.

Unified auditing enables you to capture audit records from the following sources:

* Audit records (including SYS audit records) from unified audit policies and AUDIT settings

* Fine-grained audit records from the DBMS_FGA PL/SQL package

* Oracle Database Real Application Security audit records

* Oracle Recovery Manager audit records

* Oracle Database Vault audit records

* Oracle Label Security audit records

* Oracle Data Mining records

* Oracle Data Pump

* Oracle SQL*Loader Direct Load

The unified audit trail, which resides in a read-only table in the AUDSYS schema in the SYSAUX tablespace, makes this information available in a uniform format in the UNIFIED_AUDIT_TRAIL data dictionary view, and is available in both single-instance and Oracle Database Real Application Clusters environments. In addition to the user SYS, users who have been granted the AUDIT_ADMIN and AUDIT_VIEWER roles can query these views. If your users only need to query the views but not create audit policies, then grant them the AUDIT_VIEWER role.

When the database is writeable, audit records are written to the unified audit trail. If the database is not writable, then audit records are written to new format operating system files in the $ORACLE_BASE/audit/$ORACLE_SID directory.

### Benefits of the Unified Audit Trail

* After unified auditing is enabled, it does not depend on the initialization parameters that were used in previous releases.

* The audit records, including records from the SYS audit trail, for all the audited components of your Oracle Database installation are placed in one location and in one format, rather than your having to look in different places to find audit trails in varying formats.

* The management and security of the audit trail is also improved by having it in single audit trail.

* Overall auditing performance is greatly improved. By default, the audit records are automatically written to an internal relational table in the AUDSYS schema.

* You can create named audit policies that enable you to audit the supported components listed at the beginning of this section, as well as SYS administrative users. Furthermore, you can build conditions and exclusions into your policies.

* If you are using an Oracle Audit Vault and Database Firewall environment, then the unified audit trail greatly facilitates the collection of audit data, because all of this data will come from one location.

### Getting Started

Mixed mode auditing is the default auditing in a newly installed database. Mixed mode auditing enables both traditional (that is, the audit facility from releases earlier than release 12c) and the new audit facilities (unified auditing).

Mixed mode is intended to introduce unified auditing, so that you can have a feel of how it works and what its nuances and benefits are. Mixed mode enables you to migrate your existing applications and scripts to use unified auditing. Once you have decided to use pure unified auditing, you can relink the oracle binary with the unified audit option turned on and thereby enable it as the one and only audit facility the Oracle database runs. If you decide to revert back to mixed mode, you can.

In this environment, we have already migrated this Oracle Database to pure unified auditing mode.  For more information on mixed mode versus pure unified, and how to migrate, see the documentation [here](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/introduction-to-auditing.html).

![](../../images/banner_Docs.PNG)
- [Introduction to Auditing](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/introduction-to-auditing.html)  
- [Monitoring Database Activity with Auditing](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/part_6.html)  


---
![](../../images/banner_Video.PNG)

&nbsp; Watch Unified Audit presentations on OTube (**Internal only**):
- [Second Thursday: Unified Auditing](https://otube.oracle.com/media/t/1_vrdcd9bu/102007862)) *(February 2019)*

&nbsp; Watch Unified Auditing on AskTom (**External**)

- [Ask Tom Database Security Office House: Unified Auditing](https://asktom.oracle.com/pls/apex/f?p=100:551::::RP,551:P551_CLASS_ID:5561&cs=19441D5563F4162EB642A53CB283440F2)


![](../../images/banner_Labs.PNG)

We have several labs for Unified Auditing. Start with the `First Steps` lab but then you can choose any of the other labs to complete. 

* [First Steps](First_Steps/README.md)
* [Audit_EmpSearch_Usage](Audit_EmpSearch_Usage/README.md)
* [Audit Junior Database Role](Audit_DB_Role/README.md)
* [Audit DataPump Usage](Audit_DataPump/README.md)



---

Move up one [directory](../README.md)

Click to return [home](/README.md)


