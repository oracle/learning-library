# Workshop Introduction and Overview #

## Introduction to Oracle Autonomous Database Dedicated ##
Oracle's Dedicated Autonomous Transaction Processing service allows an organization to Rethink Database IT, enabling a customizable private database cloud in the public cloud. The dedicated choice makes it possible to deliver a self-service database capability that aligns with organizational structure. Different lines of business or project teams can have complete autonomy in their individual execution while the company itself gets a fleet wide simplified aggregation of overall health, availability and cost management. This separation of Fleet vs Database administration allows simple budgeting controls and resource isolation without getting in the way of the line of business execution. And a dedicated database deployment will support the entire spectrum of needs from simple apps to apps that require the highest governance, consistent performance and operational controls.

Watch the video below for an overview of Autonomous Database Dedicated

[](youtube:fOKSNzDz1pk)

## Workshop Objectives
- Prepare your private network in the Oracle Cloud Infrastructure
- Provision Exadata Infrastructure in a private OCI network
- Provision an Autonomous Container Database
- Provision databases on your dedicated Autonomous Infrastructure
- Setup VPN Connectivity to your Autonomous Exadata Infrastructure
- Configure a development system for use with your dedicated autonomous database
- Build and deploy Python application stacks on dedicated autonomous infrastructure
- Build and deploy node.js application stacks on dedicated autonomous infrastructure
- Build and deploy Java application stacks on dedicated autonomous infrastructure
- Use OCI CLI commands to work with your autonomous databases
- Invoke and use the sqldevweb console
- Build apex applications on the autonomous database
- Migrate an on-prem application schema using Data Pump
- Setup live migration of business critical databases using Oracle Goldengate replication
- Build 'Always-On' application on the autonomous database
- Manage database performance with Performance Hub
- Scale your database service with zero downtime
- Protect your data with Database Vault
- Recover from user errors using flashback recovery
- Setup monitoring events and notifications
- Connect Oracle Analytics cloud with Autonomous Database Dedicated

## Lab Breakdown
These hands-on lab guides provide step-by-step directions to setting up and using your dedicated Autonomous database platform in the Oracle Cloud Infrastructure. 

*Lab 1*  - Deals with setting up the network, users and groups and requires administrator privileges on your OCI account.
*Labs 2 & 3* - Geared towards the fleet administrator role responsible for deploying the autonomous exadata infrastructure and container databases.
*Labs 4 and  6 - 12* - Intended for a regular database user, DBA or developer who simply want to spin up an autonomous database in one of the pre-provisioned containers and start building applications.
*Lab 13 +* - Demonstrate the operational aspects of the service

## A Private Database Cloud in the Oracle Public Cloud 

With Autonomous Database Dedicated, customers get their own Exadata infrastructure in the Oracle Cloud. The customers administrator simply specifies the size, region and availability domain where they want their dedicated Exadata infrastructure provisioned.  They also get to determine the update or patching schedule if they wish. Oracle automatically manages all patching activity but with Autonomous Database Dedicated service, customers have the option to customize the patching schedule.

## ADB Dedicated Architecture

Autonomous Databases on dedicated Exadata infrastructure have a three-level database architecture model that makes use of Oracle multitenant database architecture.  You must create the dedicated Exadata infrastructure resources in the following order:

1. Autonomous Exadata Infrastructure
2. Autonomous Container Database
3. Autonomous Database

### Autonomous Exadata Infrastructure

This is a hardware rack which includes compute nodes and storage servers, tied together by a high-speed, low-latency InfiniBand network and intelligent Exadata software.

### Autonomous Container Database

This resource provides a container for multiple user databases. This resource is sometimes referred to as a CDB, and is functionally equivalent to the multitenant container databases found in Oracle 12c and higher databases.

### Autonomous Database

You can create multiple Autonomous Databases within the same container database. This level of the database architecture is analogous to the pluggable databases (PDBs) found in non-Autonomous Exadata systems. Your Autonomous Database can be configured for either transaction processing or data warehouse workloads.

Please proceed to the next lab.

## Acknowledgements

- **Authors/Contributors** - Tejus Subramanian, Kris Bhanushali, Yaisah Granillo
- **Last Updated By/Date** - Kay Malcolm, April 2020
- **Workshop Expiration Date** - April 31, 2021

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request. 
