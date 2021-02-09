# Running OpenFOAM Projects on HPC Clusters and Standard VM's on OCI

## Introduction

This runbook is designed to assist in the assessment of the OpenFOAM CFD Software in Oracle Cloud Infrastructure. It automatically downloads and configures OpenFOAM. OpenFOAM is the free, open source CFD software released and developed primarily by OpenCFD Ltd since 2004. It has a large user base across most areas of engineering and science, from both commercial and academic organisations. OpenFOAM has an extensive range of features to solve anything from complex fluid flows involving chemical reactions, turbulence and heat transfer, to acoustics, solid mechanics and electromagnetics.

### **About High Performance Computing (HPC)**
HPC, or supercomputing, is like everyday computing, only more powerful. It is a way of processing huge volumes of data at very high speeds using multiple computers and storage devices as a cohesive fabric. HPC makes it possible to explore and find answers to some of the world’s biggest problems in science, engineering, and business.

A cluster network is a pool of high performance computing (HPC) instances that are connected with a high-bandwidth, ultra low-latency network. Each node in the cluster is a bare metal machine located in close physical proximity to the other nodes. A remote direct memory access (RDMA) network between nodes provides latency as low as single-digit microseconds, comparable to on-premises HPC clusters.

High Performance Computing is offered on Oracle Cloud Infrastructure, within OCI regions.

High Performance Computing Instance available in Oracle Marketplace Image and BM.HPC2.36 in OCI.

High Performance Computing rack in Oracle Marketplace Image includes HPC cluster nodes, cluster network and NFS share.

The compute nodes are connected via cluster network that provides RDMA based storage access to the compute nodes.

Currently, a single BM per compute node is supported. It allows root access for customers while protecting hardware and network, compute nodes are virtualized using BM.HPC2.36.


*Estimated Lab Time*: 2 hours

### Objectives

In this lab, you will:
* Run OpenFOAM projects using HPC instances interconnected through Remote Direct Memory Access (RDMA)
* Run OpenFOAM projects using regular standard Virtual Machines (VMs) on Oracle Cloud Infrastructure (OCI)

### Prerequisites

- An Oracle Cloud Infrastructure account with privileges to create a compartment as well as a stack.
- Familiarity with the OCI Console and Oracle Cloud resources (i.e. Virtual Cloud Networks, Compute and Storage) is helpful.
- Assumption that you have completed the OCI Cloud Architect Associate Exam.

## About this Workshop

- Lab 1: Run OpenFOAM projects using HPC Cluster

- Lab 2: Run OpenFOAM projects using Standard VM on OCI



#### All Done! Please proceed to the next lab.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca
* **Last Updated By/Date** - Harrison Dvoor, January 2021


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

**You may now proceed to the next lab**