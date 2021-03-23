# Introduction

## Introduction

High Performance Computing is changing product development and research enabling customers to solve complex problems faster. This means fewer prototypes, accelerates testing, and decreases time to market. Oracle offers on-demand HPC infrastructure, suitable for any HPC workload, based on the most advanced compute, storage, networking, and software technologies. You get all this at a fraction of the cost of building it yourself and avoid capacity utilization issues.

Oracle provides the most elastic and scalable cloud infrastructure to run your HPC applications. With virtually unlimited capacity, engineers, researchers, and HPC system owners can innovate beyond the limitations of on-premises HPC infrastructure. Oracle delivers an integrated suite of services that provides everything needed to quickly and easily build and manage HPC clusters in the cloud to run the most compute intensive workloads across various industry verticals. These workloads span the traditional HPC applications, like genomics, computational chemistry, financial risk modeling, computer aided engineering, seismic imaging, and weather prediction, as well as emerging applications, like machine learning, deep learning, and autonomous driving.

With Oracle Cloud Infrastructure, businesses can run performance intensive HPC workloads requiring millions of IOPs, millisecond latency, and many GB/s of bandwidth, on a pay per-use or non- metered model, saving 32% on a 3-year TCO.

These hands-on lab guides provide step-by-step process of deploying NAMD on Oracle Cloud using 2 methods, Resource Manager, available on Oracle Cloud Console, and Web Console. 

Estimated Workshop Time: 30 minutes 

### About High Performance Computing (HPC)

HPC, or supercomputing, is like everyday computing, only more powerful. It is a way of processing huge volumes of data at very high speeds using multiple computers and storage devices as a cohesive fabric. HPC makes it possible to explore and find answers to some of the world’s biggest problems in science, engineering, and business.

A cluster network is a pool of high performance computing (HPC) instances that are connected with a high-bandwidth, ultra low-latency network. Each node in the cluster is a bare metal machine located in close physical proximity to the other nodes. A remote direct memory access (RDMA) network between nodes provides latency as low as single-digit microseconds, comparable to on-premises HPC clusters.

High Performance Computing is offered on Oracle Cloud Infrastructure, within OCI regions.

High Performance Computing Instance available in Oracle Marketplace Image and BM.HPC2.36 in OCI.

High Performance Computing rack in Oracle Marketplace Image includes HPC cluster nodes, cluster network and NFS share.

The compute nodes are connected via cluster network that provides RDMA based storage access to the compute nodes.

Currently, a single BM per compute node is supported. It allows root access for customers while protecting hardware and network, compute nodes are virtualized using BM.HPC2.36.

### Objectives

In this lab, you will:
* Log In
* Deployment
* Resource Manager
* Licensing
* Running the Application
* Post-Processing


### Prerequisites

* Some understanding of cloud and database terms is helpful
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful
* Familiarity with networking is helpful


## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.