## Introduction

An Exadata Cloud Service DB system consists of a quarter rack, half rack, or full rack of compute nodes and
storage servers, tied together by a high-speed, low-latency Infiniband network and intelligent
Exadata software. You can configure automatic backups, optimize for different workloads, and
scale up the system to meet increased demands.

The compute nodes are each configured with a virtual machine (VM). You have root privilege for
the compute node VMs, so you can load and run additional software on them. However, you do
not have administrative access to the Exadata infrastructure components, such as the physical
compute node hardware, network switches, power distribution units (PDUs), integrated lights-out
management (ILOM) interfaces, or the Exadata Storage Servers, which are all administered by
Oracle.

You have full administrative privileges for your databases, and you can connect to your databases
by using Oracle Net Services from outside Oracle Cloud Infrastructure. You are responsible for
database administration tasks such as creating tablespaces and managing database users. You
can also customize the default automated maintenance setup, including backups, and you have
full control of the recovery process in the event of a database failure.

These hands-on lab guides provide step-by-step directions to setting up and using your Exadata Cloud Service platform in the Oracle Cloud Infrastructure.

Lab 1 - 5 deals with setting up the infrastructure and connectivity to Exadata Cloud Service.

Labs 6 & 7 are geared towards Monitoring and Managing your Exadata Cloud Service databases.

Labs 8 - 10 are intended for Backup, Recovering and Migrating your databases.

Lab 11 - 12 onwards demonstrate advanced lab guides for Database Vault and advanced Data safe lab guides.

Lab 13 - 19 are additional labs which talks about connecting your Exadata Cloud Service databases with Python application, working with OCI CLI, build APEX applications, automating with Terraform, configure and connect to Swingbench, build and connect to a Docker application, and connect to Oracle Analytics cloud.


## Goals for this workshop
1. Prepare your private network in the Oracle Cloud Infrastructure
2. Provision Exadata Cloud Service Infrastructure in a private OCI network
3. Provision databases on your Exadata Cloud Service Infrastructure
4. Configure a development system for use with your Exadata Cloud Service database
5. Setup VPN Connectivity to your Exadata Cloud Service Infrastructure
6. Setup, Discover, Manage and Monitor database with Enterprise Manager
7. Data Safe with Exadata Cloud Service
8. Migrate an on-prem application schema using Data Pump
9. Real time migration of database using Oracle Goldengate Replication
10. Backup and Recovery using Console and API's
11. Protect your data with Database Vault
12. Data Safe Advanced lab
13. Use OCI CLI commands to work with Exadata Cloud Service
14. Automation with Terraform
15. Build and deploy Python application stacks on Exadata Cloud Service
16. Build APEX application on Exadata Cloud Service
17. Install and configure Swingbench to simulate a transaction processing workload
18. Build a docker container running node.js connected to EXACS database
19. Connect Oracle Analytics Cloud to your Exadata database


# Workshop Overview

## Before You Begin
**What is Exadata Cloud Service?**

- Exadata Cloud Service is offered on Oracle Cloud Infrastructure, within OCI regions.
- Exadata Cloud Service available in quarter Rack, Half Rack or full Rack configurations.
- Exadata rack in OCI includes DB nodes, storage nodes and Infiniband switches.
- The storage and compute nodes are connected via high bandwidth Infiniband network that
provides RDMA based storage access to the compute nodes.
- Exadata storage software runs on storage servers and offloads database SQL processing
overheads.
- Currently, a single VM per compute node is supported. It allows root access for customers
while protecting hardware and network, DB nodes are virtualized using Xen based OVM.
- Oracle Manages storage cells, switches, management or IB network while customer manages
database compute nodes.
- Exadata Cloud Service provides a control Plane, a Web-based self-service management
interface for Exadata cloud service provisioning and interactive access to service administration function

**You are all set, let's begin!**


## Lab 1: Prepare your private network in the Oracle Cloud Infrastructure (demo only)

**Key Objectives**:
- Create compartments and user groups with the right set of access policies for separation of duties
- Create admin and database user accounts
- Layout a secure network for the database and application infrastructure


## Lab 2: Provision Exadata Infrastructure in a private OCI network (demo only)

**Key Objectives**:

As a fleet administrator,
- Deploy an Exadata Cloud Service Infrastructure in a pre-provisioned private network in your OCI account


## Lab 3: Provision databases on your Exadata Cloud Service Infrastructure (demo only)

**Key Objectives**:

As a database administrator,
- Deploy database onto an Exadata Cloud Service Infrastructure


## Lab 4: Configure a development system for use with your Exadata Cloud Service database

**Key Objectives**:

As a database user, DBA or application developer,

- Configure a secure connection from your application instance to your dedicated autonomous database using Oracle SQL Developer, SQLCLI and SQL*Plus.


## Lab 5: Setup VPN Connectivity to your Exadata Cloud Service Infrastructure

**Key Objectives**:
As a database user, DBA or application developer,
- Configure a VPN server in OCI based on OpenVPN software
- Configure your VPN client and connect to VPN Server



## Lab 6: Setup, Discover, Manage and Monitor database with Enterprise Manager

**Key Objectives**:

As a System admin,

- Install and configure Enterprise Manager on OCI
- Configure Enterprise Manager with Exadata Cloud Service

## Lab 7: Data Safe with Exadata Cloud Service

**Key Objectives**:

As an database admin,
- Assess the security of a database by using the Security Assessment feature in Oracle Data Safe
- Assess user security in your target database by using the User Assessment feature in Oracle Data Safe.
- Fix some of the security issues based on the assessment findings
- Discover sensitive data in database



## Lab 8: Migrate an on-prem application schema using Data Pump

**Key Objectives**:

As an database admin,
- Download a sample datapump export dump file
- Upload .dmp file to OCI Object storage bucket
- Setup cloud credentials and use data pump import to move data to your Exadata Cloud Service database



## Lab 9: Real time migration of database using Oracle Goldengate Replication

**Key Objectives**:

As an database admin,
- Replicate real time data from a simulated on-premise database to Exadata Cloud Service database.



## Lab 10: Backup and Recovery using Console and API's

**Key Objectives**:

As an application developer, DBA user,

- Configure Exadata Cloud Service database backup and Recovery using Console and API



## Lab 11: Protect your data with Database Vault

**Key Objectives**:

As a database security admin,

- Enable database vault in your Exadata Cloud Service database
- Implement separation of duties to protect sensitive data in your database



## Lab 12: Data Safe Advanced lab

**Key Objectives**:

As a database security admin,

- Configure Data Masking and Auditing and Reporting for Exadata Cloud Service database


## Lab 13: Use OCI CLI commands to work with Exadata Cloud Service


**Key Objectives**:

As a application developer, DBA or DevOps user,

- Interact with Oracle Cloud Infrastructure resources using CLI



## Lab 14: Automation with Terraform


**Key Objectives**:

As a database or System admin,

- Deploy Exadata Cloud Service database using Terraform



## Lab 15: Build and deploy Python application stacks on Exadata Cloud Service


**Key Objectives**:

As an application developer,

- Learn how to deploy a python application and connect it your Exadata Cloud Service database instance


## Lab 16: - Build APEX application on Exadata Cloud Service


**Key Objectives**:

As an application developer, DBA or DevOps user,

- Access OCI autonomous database console and get URL for apex web console
- Create a VNC connection to developer client VM and access apex on your database
- Setup additional apex developer users

## Lab 17: - Introduction to Swingbench and Oracle database


**Key Objectives**:

As an application developer, DBA or DevOps user,

- Install and configure Swingbench to simulate a transaction processing workload
- Configure Exadata Cloud Service Database with Swingbench

## Lab 18: - Docker Application with EXACS

**Key Objectives**:

As an application developer, DBA or DevOps user,

- To build a docker container running node.js
- Connect it to an Exadata Cloud Service running in the Oracle cloud
- Deploy the docker container on Oracle Compute Instance

## Lab 19: - Connect Oracle Analytics Cloud with your Exadata Cloud Service Database

**Key Objectives**:

As a LOB user

- Install and configure Remote Data Gateway in Oracle Cloud Developer Image
- Configure Remote Data Gateway with Oracle Analytics Cloud
- Connect Exadata Cloud Service Database with Oracle Analytics Cloud


## Appendix

**This covers some general help for Windows users and other occasional issues you may encounter while working with your Exadata Cloud Service.**