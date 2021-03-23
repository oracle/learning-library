# Introduction

## Introduction

**Modern Data Warehouse with EBS Integration**

Lines of business, typically, don't have timely or efficient access to data and information. Analysts gather the data manually, work with it on an individual basis, and then share files through emails or file servers. With Oracle Autonomous Data Warehouse (ADW) and Oracle Analytics Cloud (OAC), you can load and optimize data from Oracle E-Business Suite (EBS) and other sources into a centralized data warehouse for analysis, so departments can gain actionable insights.

This workshop uses Oracle Data Integrator (ODI) to load data from a database emulating EBS into an ADW and will guide you through the process. Thereafter, you will learn how to connect ADW to OAC and import a prebuilt sample analysis with refined data into OAC. If you have access to an EBS environment, please feel free to use your own data from EBS to create visualizations.

Estimated workshop time: 2 hours

### Objectives

1. Provision the infrastructure required for the modern data warehouse.
2. Load data from EBS-emulating Database into ADW using ODI.
2. Analyse data using OAC.

### Prerequisites

- Access to a paid or a Livelabs Oracle Cloud account.
- Permission to manage the following types of resources in your tenancy: vcns, internet-gateways, route-tables, network-security-groups, subnets, autonomous-database-family, and instances.
- Quota to create the following resources: 1 VCN, 2 subnets, 1 Internet Gateway, 1 NAT Gateway, 2 route rules, 1 ADW database instance, 1 DataCatalog instance, 1 Oracle Analytics Cloud (OAC) instance, and 2 compute instances (bastion + ODI compute node).

## Labs
Lab 1 - Deploy the Stack to provision Data Integrator, Autonomous Data Warehouse and Oracle Analytics (30 minutes)

- Login to the OCI console and provision the required resources.

Lab 2 - Connect to the Oracle Data Integrator instance (15 minutes)

- Create SSH tunnel to the Data Integrator instance.
- Establish a VNC connection to ODI via VNC Viewer.

Lab 3 - Create and connect to ODI Repository and prepare the data source (40 minutes)

- Load Data into ADW emulating the EBS database.
- Create master and work repositories in ODI.
- Connect to work repository.

Lab 4 - Configure Integration and load data from Source into ADW using ODI (25 minutes)

- Connect to the source tables and views. 
- Configure mapping between source and target.
- Run integration to move data from source to ADW.

Lab 5 - Perform Analysis - Import Dashboards (10 minutes)

- Upload DVA file to OAC.
- Connect ADW to Analytics instance.
- Make Dashboards work of data sets in ADW.

**You are all set. Let us begin!**

## Acknowledgements

 - **Author** - Yash Lamba, Cloud Native Solutions Architect, February 2021
 - **Contributors** - Clarence Ondieki, Maharshi Desai
 - **Last Updated By/Date** - Yash Lamba, February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.