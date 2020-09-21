![](../../images/banner_DBSAT.PNG)

The Oracle Database Security Assessment Tool (DBSAT) helps identify sensitive data, analyzes database configurations, users, their entitlements and security policies to uncover security risks and improve the security posture of Oracle Databases within your organization.

You can use DBSAT to implement and enforce security best practices in your organization and accelerate compliance with regulations such as the EU GDPR. 

DBSAT reports on existing sensitive data, the state of user accounts, role and privilege grants, and policies that control the use of various security features in the database.

DBSAT generates two types of reports:
 - Database Security Risk Assessment report
 - Database Sensitive Data Assessment report

You can use report findings to:
 - Fix immediate short-term risks
 - Implement a comprehensive security strategy
<br><br>

**Components of DBSAT and flow**

![](images/101.png)      

DBSAT consists of three components, the DBSAT Collector, the DBSAT Reporter and the DBSAT Discoverer, that correspond to the functions of data collection, data analysis, and sensitive data discovery respectively:
- The **DBSAT Collector** executes SQL queries and runs operating system commands to collect data from the system to be assessed. It does this primarily by querying database dictionary views. The collected data is written to a file that is used by the DBSAT Reporter in the analysis phase.
- The **DBSAT Reporter** analyzes the collected data and reports its findings and recommendations in multiple formats: HTML, Excel, JSON, and Text. The Reporter can run on any machine: PC, laptop, or server. You are not limited to running it on the same server as the Collector.
- The **DBSAT Discoverer** executes SQL queries and collects data from the system to be assessed, based on the settings specified in the configuration files. It does this primarily by querying database dictionary views. The collected data is then used to generate a Database Sensitive Data Assessment Report in HTML and CSV formats. The CSV report can be loaded into Oracle Audit Vault and Database Firewall to add sensitive data context to the new Data Privacy reports. For more information about this functionality, see Importing Sensitive Data Into AVDF Repository in the Oracle Audit Vault and Database Firewall Auditor's Guide.

    ---
    **NOTE:** The Discoverer can run on any machine: PC, laptop, or server. You are not limited to running the Discoverer on the database server or the same machine as the Collector and the Collector does not need to be run before executing DBSAT Discoverer.

    ---
<br>

**Benefits of using DBSAT**

You can use DBSAT to:

- Quickly identify sensitive data and security configuration errors in your databases
- Promote security best practices
- Improve the security posture of your Oracle Databases
- Reduce the attack surface and exposure to risk
- Provide input to auditors
<br><br>

After having executed 1000s of Database Security Assessments in our customers base, we have identified that the **The Top 10 most common findings** has proven to be:
- No Database Security Policies / Strategy in place
- No patching/patch management policy in place
- No encryption of sensitive/regulated data
- No monitoring/auditing in place
- Over-privileged accounts; No personalized accounts; NO SoD
- Weak/inexistent password policies; Weak password management
- Data sent in the clear to third parties
- No OS hardening
- No sensitive data anonymization in production to DEV/TEST/Training/etc.
- Still some sample schemas in production environments out there

        ACT NOW! 

        TRY DBSAT TODAY ON YOUR DATABASES BY DOWNLOADING DBSAT FROM: 
        
            HTTPS://WWW.ORACLE.COM/DATABASE/TECHNOLOGIES/SECURITY/DBSAT.HTML 

**Note:**<br>
To mention DBSAT on social media please use:<br>
#DBSAT #SECURITY @ORACLESECURITY @ORACLEDATABASE

---
![](../../images/banner_Docs.PNG)

- [Oracle DBSAT 2.2](https://docs.oracle.com/en/database/oracle/security-assessment-tool/2.2/index.html)

---

![](../../images/banner_Video.PNG)

&nbsp; Watch DBSAT presentation on OTube (**Internal only**):
- [DBSAT Enablement Webcast](https://otube.oracle.com/media/Database+Security+Assessment+Tool+enablement+webcast/0_pnxyfsan) *(July 2016)*

---
![](../../images/banner_Labs.PNG)

Version tested in this lab: `DBSAT 2.2`

In this lab, you will be able to play with the DBSAT and understand how it works and the immediate value it provides.<br>
Many customers already benefited from running DBSAT and were able to improve their security posture.

DBSAT helps you to identify the overall security posture, who are the users and their entitlements, and to know how much and where is sensitive data located.

- [Installing DBSAT](labs/Install_DBSAT.md)

- [Collector and Reporter](labs/CollectorReporter_DBSAT.md)

- [Discover Sensitive Data](labs/Discoverer_DBSAT.md)

- [Advanced Discoverer](labs/Discoverer_Adv_DBSAT.md) (Optional Labs)

- [Processing DBSAT report JSON output](labs/JSON_Report_DBSAT.md) (Extra Mile Lab)

---

Click to return [home](/README.md)
