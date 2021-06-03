# Introduction

## About Oracle Database 19c

Oracle Database 19c provides the most advanced SQL engine on the planet. It complies with the latest ISO SQL standard, making it not only the most comprehensive database but also the most open one. It supports highly sophisticated analytics alongside and with no impact on OLTP workloads, eliminating the need to develop and orchestrate complex, fragile, and inconsistent data movement between different specialized data stores. Oracle’s SQL engine ships with integrated machine learning algorithms and allows developers to easily apply them on the data directly, hence moving the computation to the data—rather than having to pull the data out of the database and perform the calculation within the application. Using this capability, developers can create real-time prediction models directly on the data itself and act on insights more quickly and easily than ever before.

[](youtube:LcsPSJrZDrI)

Oracle Database 19c supports fully consistent data with ACID transaction guarantees and consistent queries. This greatly simplifies application development compared to NoSQL stores. Native JSON support makes up a cornerstone for flexible schema support and Internet of Things (IoT)workloads, enabling developers to simply load JSON documents into the database natively and analyze them later on, with the full power of Oracle SQL. Oracle’s PL/SQL engine is yet another powerful tool for bringing computations to the data and providing an easy and standardized interface to them via simple SQL function or procedure calls. Interfaces such as REST allow for easy communication and integration with Oracle Database. These can be created automatically on top of tables, as well as stored procedures, giving developers the flexibility on how and what data to expose to consuming services.

Extend this with the move to autonomy provided by Oracle Autonomous Database, a self-driving, self-securing, and self-repairing approach where the database itself decides on the steps to perform for the best of the user's workload or data. Machine learning algorithms are used to help the database to decide how to tune a workload, how to secure the data, and how to take countermeasures to preserve the agreed-on SLA levels.

With the Oracle Autonomous Database, developers can fully concentrate on the applications they write and the business’s requirements, rather than having to think about the data tier. And to make this even easier the Oracle Autonomous Database environment can be provisioned in minutes with a few simple clicks or an API call to the Oracle Cloud.

## About the Oracle Database 19c New Features Workshop

This workshop lets you try out many of the Oracle Database 19c new features, including general, security, performance, Big Data and Data Warehouse, and diagnose-ability enhancements. When you reserve this workshop in the LiveLabs tenancy, you are provided two compute instances. One instance has the Oracle Database 19c installer files staged on it; the other has Oracle Database 19c already installed. To access these instances, you use SSH keys. Therefore, when you reserve this workshop in the LiveLabs tenancy, you need to provide your public SSH key on the registration page. For help on generating SSH keys, see the lab called Generate SSH Keys. If you are working in your own tenancy, whether free or paid, you are guided through the steps to create the two compute instances.

All labs are independent of each other, so you don't need to do them in any particular order. Labs 2 and 3 are special cases, however, and are described below.

### Lab 2: Install Oracle Database 19c with Automatic Root Script Execution
In Lab 2, you learn how to install Oracle Database 19c using automatic `root` script execution, which is a new feature in Oracle Database 19c. The Oracle Database 19c installer has a graphical interface. To be able to view it when you run it on a Linux operating system, you need to have VNC Server or Xll forwarding configured on your compute instance. Therefore, we've provided a few options for trying out this new feature:

- [Install Oracle Database 19c with Automatic Root Script Execution](?lab=install-db19c-auto-config-script-execution-guac.md) - In this lab, you access a prebuilt compute instance with a Guacomole Desktop, and then run the Oracle Database 19c installer immediately. VNC Server runs behind the scenes on a Guacomole desktop. This is the fastest lab because all of the database prerequisite tasks are already done for you.
- [Appendix A - Install Oracle Database 19c with Automatic Root Script Execution - X11 Forwarding](?lab=install-db19c-auto-config-script-execution-x11.md) - In this lab, you start from scratch. You create a compute instance in Oracle Cloud Infrastructure and configure X11 forwarding so that you can display the graphical Oracle Database 19c installer on your local computer. You access your compute instance from your local computer, perform preinstallation tasks, and then run the Oracle Database 19c installer. This configuration requires the least amount of software installed on your compute instance.
- [Appendix B - Install Oracle Databasae 19c with Automatic Root Script Execution - VNC Server](?lab=install-db19c-auto-config-script-execution-vnc.md) - In this lab, you create a compute instance in Oracle Cloud Infrastructure and install VNC Server on it. You access your compute instance from your local computer, perform  preinstallation tasks, and then run the Oracle Database 19c installer.


### Lab 3: Deploy an Oracle Database 19c Image

<if type="freetier paid">The purpose of Lab 3 is to help you quickly set up an environment with Oracle Database 19c (release 19.10) by using a prebuilt image from Oracle Cloud Marketplace. </if><if type="livelabs">In this lab you access a prebuilt compute instance with Oracle Database 19c (release 19.10), provided by LiveLabs. </if>This lab doesn't cover any new features in Oracle Database 19c, but is a prerequisite for the rest of the labs. The compute image provides the following resources:

- A compute instance with Oracle Linux 7 installed on it.
- Oracle Database 19.10.0.0 installed on your compute instance in ``/u01/app/oracle/product/19.10.0/dbhome_1`.
- A precreated `ORCL` container database (CDB) with one pluggable database (PDB), `PDB1`.
- The net service names for any future PDBs that you create in the labs are already logged in the `$ORACLE_HOME/network/admin/tnsnames.ora` file.

### Cleaning Up PDBs at the Beginning of Each Lab

To start fresh at the beginning of each lab, you can execute the `/home/oracle/labs/admin/cleanup_PDBs.sh` shell script. This script drops all PDBs that may have been created during the labs, and re-creates the `ORCLPDB1` PDB. Enter the following command to run the script.

```nohighlighting
$ <copy>/home/oracle/labs/admin/cleanup_PDBs.sh</copy>
...
$
```

In case you need to recreate the `ORCL` CDB and its `PDB1` PDB, use the `/home/oracle/labs/admin/recreate_ORCL.sh` shell script.

```nohighlighting
$ <copy>/home/oracle/labs/admin/recreate_ORCL.sh</copy>
...
$
```

## General Database Overall Enhancements

The following labs cover general database overall enhancements:

[Lab 1 - Install Oracle Database 19c with Automatic Root Script Execution](?lab=install-db19c-auto-config-script-execution)

<if type="freetier paid">[Lab 2 - Deploy an Oracle Database Image from Oracle Cloud Marketplace](?lab=deploy-db19c-marketplace)</if><if type="livelabs">[Lab 2 - Verify the Oracle Database](?lab=verify-database)</if>
