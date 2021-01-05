# Welcome to the ExaCS for Modern Data Warehouse Workshop!

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

Lab 1 - 4 deals with setting up the infrastructure and connectivity to Exadata Cloud Service.

Lab 5 is geared towards Monitoring and Managing your Exadata Cloud Service databases.

Lab 6 is intended for Migrating your databases.

Lab 7 is around connecting your ExaCS DB to Oracle Analytics Cloud.

### Goals for this workshop

1. Prepare your private network in the Oracle Cloud Infrastructure
2. Provision Exadata Cloud Service Infrastructure in a private OCI network
3. Provision databases on your Exadata Cloud Service Infrastructure
4. Configure a development system for use with your Exadata Cloud Service database
5. Data Safe with Exadata Cloud Service
6. Real time migration of database using Oracle Goldengate Replication
7. Connect Oracle Analytics Cloud to your Exadata database

### Before You Begin

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


### Lab 1: Prepare your private network in the Oracle Cloud Infrastructure (demo only)

**Key Objectives**:
- Create compartments and user groups with the right set of access policies for separation of duties
- Create admin and database user accounts
- Layout a secure network for the database and application infrastructure


### Lab 2: Provision Exadata Infrastructure in a private OCI network (demo only)

**Key Objectives**:

As a fleet administrator,
- Deploy an Exadata Cloud Service Infrastructure in a pre-provisioned private network in your OCI account


### Lab 3: Provision databases on your Exadata Cloud Service Infrastructure (demo only)

**Key Objectives**:

As a database administrator,
- Deploy database onto an Exadata Cloud Service Infrastructure


### Lab 4: Configure a development system for use with your Exadata Cloud Service database

**Key Objectives**:

As a database user, DBA or application developer,

- Configure a secure connection from your application instance to your dedicated autonomous database using Oracle SQL Developer, SQLCLI and SQL*Plus.



### Lab 5: Data Safe with Exadata Cloud Service

**Key Objectives**:

As an database admin,
- Assess the security of a database by using the Security Assessment feature in Oracle Data Safe
- Assess user security in your target database by using the User Assessment feature in Oracle Data Safe.
- Fix some of the security issues based on the assessment findings
- Discover sensitive data in database



### Lab 6: Real time migration of database using Oracle Goldengate Replication

**Key Objectives**:

As an database admin,
- Replicate real time data from a simulated on-premise database to Exadata Cloud Service database.



### Lab 7: - Connect Oracle Analytics Cloud with your Exadata Cloud Service Database

**Key Objectives**:

As a LOB user

- Install and configure Remote Data Gateway in Oracle Cloud Developer Image
- Configure Remote Data Gateway with Oracle Analytics Cloud
- Connect Exadata Cloud Service Database with Oracle Analytics Cloud


## Acknowledgements

- **Author** - Tasbir Imam, Phani Turlapati, Abdul Rafae, Sravya Ganugapati, Sathis Muniyasamy, Albert Kwok, Padma Priya, Aubrey Patsika, Jacob Harless, Tejus Subrahmanya

- **Last Updated By/Date** - Jess Rein - Cloud Engineer, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
