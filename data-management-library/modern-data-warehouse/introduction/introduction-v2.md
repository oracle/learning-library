# Introduction

## Introduction

**Modern Data Warehouse with EBS Integration**

Lines of business, typically, don't have timely or efficient access to data and information. Analysts gather the data manually, work with it on an individual basis, and then share files through emails or file servers. With Oracle Autonomous Data Warehouse (ADW) and Oracle Analytics Cloud (OAC), you can load and optimize data from Oracle E-Business Suite (EBS) and other sources into a centralized data warehouse for analysis, so departments can gain actionable insights.

This workshop uses Oracle Data Integrator (ODI) to load data from an EBS instance into an ADW using smart import and will guide you through the process. You will also learn how to create mappings and load data from other data sources, in this case another database, into the aforementioned ADW. Thereafter, you will learn how to connect ADW to OAC, create data sets and import a prebuilt sample analysis with refined data into OAC.

Estimated workshop time: 3.5 hours

### Objectives

1. Provision the infrastructure required for the modern data warehouse.
2. Load data from multiple sources (EBS and database) into ADW using ODI.
3. Analyse data using OAC.

### Prerequisites

- Access to a paid or a Livelabs Oracle Cloud account.
- Permission to manage the following types of resources in your tenancy: vcns, internet-gateways, route-tables, network-security-groups, subnets, autonomous-database-family, analytics-instance and instances.
- Quota to create the following resources: 1 VCN, 3 subnets, 1 Internet Gateway, 1 NAT Gateway, 2 route rules, 2 ADW database instances, 1 DataCatalog instance, 1 Oracle Analytics Cloud (OAC) instance, and 3 compute instances (bastion + ODI compute node).

*Note: If you have a **Free Trial** account, when your Free Trial expires your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)***

## Labs
Lab 1 - Deploy the Stack to provision Data Integrator, Autonomous Data Warehouse and Oracle Analytics (30 minutes)

- Login to the OCI console and provision the required resources.

Lab 2 - Provision and Configure E-Business Suite and prepare all data sources (60 minutes)

- Provision an EBS instance on OCI from OCI Marketplace.
- Connect to the EBS instance, configure it and then load data into EBS.
- Provision an Autonomous Database to act as a data source and load data into it.

Lab 3 - Connect to the Oracle Data Integrator instance (15 minutes)

- Create SSH tunnel to the Data Integrator instance.
- Establish a VNC connection to ODI via VNC Viewer.

Lab 4 - Create and connect to ODI Repository (30 minutes)

- Create master and work repositories in ODI.
- Connect to work repository.

Lab 5 - Configure Integration and load data into ADW using ODI (60 minutes)

- Use Smart Import to create an integration that moves data from your EBS to the destination data warehouse.
- Connect to tables and views in the source ADW. 
- Configure mapping between source and target.
- Run integrations to move data from the two sources to ADW.

Lab 6 - Perform Analysis - Import Dashboards (15 minutes)

- Import analytics project.
- Connect to ADW and create data sets.
- Analyse data.

**You are all set. Let us begin!**

## Acknowledgements

 - **Author** - Yash Lamba, Cloud Native Solutions Architect, February 2021
 - **Contributors** - Srinidhi Koushik, Clarence Ondieki, Maharshi Desai
 - **Last Updated By/Date** - Yash Lamba, May 2021

