## IMPORTANT: How to prepare for this workshop

**Get an Oracle Cloud Account**
- Oracle provides several methods for gaining access to Oracle Cloud Accounts used to complete the Labs in this Hands-on-Workshop.
    - For some workshop events, cloud environments will be provided.
    - For others events (e.g. **Oracle Code**), or when completing this workshop in a self-service model, you must gain access to your own Trial account. Trial accounts can be obtained at [Try It](http://cloud.oracle.com/tryit)
    - If you are attending an Oracle sponsored event, please **review your Event invitation** for more instruction on how to gain access to your Workshop Account.

## How to View the Lab Guides

- The lab guides are best viewed using the Workshop's [GitHub Pages Website URL](https://oracle.github.io/learning-library/workshops/goldengate/)

- If you are using a hardcopy printed version but wish to access the on-line version (recommended) go to this URL:  https://oracle.github.io/learning-library/workshops/goldengate/

- Once you are viewing the Workshop's GitHub Pages website, you can see a list of Lab Guides at any time by clicking on the **Menu Icon**

    ![](images/WorkshopMenu.png)  

- You will be accessing several Oracle Cloud Services throughout the labs.  Most of the services have been set up in advance for you, but you will need to configure these services and request new ones.  To simplify and clarify the services and their required credentials we have prepared a ***one-page GoldenGate Cloud Services Workshop handout*** with the required information.  The handout will be provided prior to starting your labs.  The different fields in the handout have been coded (eg CS1, CS2) to make it easy to locate the required field referenced in the lab guides.

- To log issues and view the lab guide source, go to the [github oracle](https://github.com/pcdavies/GoldenGateCloudService/tree/master/workshops/goldengate) repository.

## Prerequisites

- Ensure your laptop does not mandate the use of VPN.  Although these guides can be viewed on or off a corporate VPN, ***access to Oracle Cloud Services MUST BE OFF VPN***.

- Confirm you can access https://cloud.oracle.com.

- Install VNC.  The labs require a [VNC Viewer](https://www.realvnc.com/download/viewer/) to connect to an Image running on Oracle's IaaS Compute Service.  If you do not have a VNC Viewer you can download and install from the [VNC Viewer Website](https://www.realvnc.com/download/viewer/).

## Oracle GoldenGate Cloud Services Workshop

This Oracle Public Cloud GoldenGate Cloud Services workshop will give you a basic understanding of the Oracle GoldenGate Cloud Service and many of the capabilities around real time data replication and migration.  Three use cases will be covered.  The first will walk you through setting up zero downtime migration with one-way replication between an Oracle 11g database and a DBCS 12c database.  The second lab will show you how to configure GGCS to perform one-way DML and DDL replication between a DBCS 12c database and an on-prem Oracle 11g database.  The third lab is designed to configure GGCS to replicate data between two DBCS 12c Pluggable Databases with data transformations, and show BICS dashboards against replicated data.  Lastly you will review GGCS monitoring services.


## Workshop Details

**Reference the following Lab Guides by opening their Documentation Files.  ***Note if you are using Internet Explorer you will need to use the menu (upper left) to access the lab docs rather than using the links listed below.  We recommend Firefox, Chrome, or Safari***:**

## Lab 100: Introduction to GoldenGate Cloud Service

**Documentation**: [LabGuide100.md](LabGuide100.md)

### Objectives

- Introduce you to the Oracle Cloud environment and services that will be used in the following labs.
- Walk through the steps to create a GoldenGate Cloud Service that will manage data replication between on-premise and cloud environments, and manage replication between different cloud environments.

## Lab 200: On-Premise to Cloud Zero Downtime Migration

**Documentation**: [LabGuide200.md](LabGuide200.md)

### Objectives

- Introduce you to an on-premise 11g Database environment that will be replicated to a DBCS 12c environment.  Note: this is set up as an image running in Oracle IAAS/compute, but process and configuration steps are the same as though the image was running outside the cloud.
- Configure SQLDeveloper to access the source and target databases.
- Use Oracle Datapump to migrate data from 11g on-premise to DBCS 12c.
- Configure an on-premise GoldenGate to extract data from a 11g Database.
- Configure GoldenGate Cloud Service to replicate data to a DBCS 12c Pluggable Database.
- Generate transactions to showcase real time data replication, while tracking data consistency between environments.

## Lab 300: Cloud to Cloud Replication with Transformations

**Documentation**: [LabGuide300.md](LabGuide300.md)

### Objectives

- Configure GGCS extract and replicat processes for data replication between DBCS 12c Pluggable Databases.
- Process data transformations as part of the data replication process.
- Review auditing support for before/after image (record) capture.

## Lab 400: GoldenGate Cloud Service Monitoring

**Documentation**: [LabGuide400.md](LabGuide400.md)

### Objectives

- Configure GGCS for monitoring.
- Start monitoring services and review activity.


## Lab 500: Cloud to On-Premise Replication with DDL (Optional)

**Documentation**: [LabGuide500.md](LabGuide500.md)

### Objectives

- Configure GGCS extract processes for data replication to 11g Database on-premise.
- Configure OGG replicat processes for data replication from DBCS 12c in the Cloud.
- Generate Transactions and view data movement statistics to monitor activity.

## FAQ:  [faq.md](faq.md)
