## Introduction

**Oracle Cloud VMware Solution (OCVS)** is a fully certified, supported and secure VMware software defined data centre (SDDC) that is hosted on Oracle Cloud Infrastructure (OCI), and uses VMware software and licenses.

The base configuration includes three Oracle Cloud Infrastructure compute bare metal hosts (BM.DenseIO2.52). This configuration can be altered to allow a single Oracle Cloud VMware Solution SDDC to use 64 bare metal hosts. The base configuration also includes an Oracle Cloud Infrastructure virtual cloud network (VCN), 156 OPCUs, 2304 GB of physical memory, and 153 TB of NVMe-based raw storage.

The solution includes VMware software such as vSphere, vSAN, NSX-T, and vCenter Server. The vSAN converged storage technology ensures the availability of data and replicates data across all the bare metal hosts in the SDDC.

These hands-on lab guides provide step-by-step directions to set up and use your VMware Solution SDDC in the Oracle Cloud Infrastructure.

## Goals for this workshop
1. Provision the infrastructure for the SDDC.
2. Export and migrate on-premises workload to the SDDC.
3. Extend application running on OCVS by integrating it with OCI native services.

## Prerequisites
1. The user should have the privileges to deploy bare metal compute instances, and to create or update VCNs, load balancers and object storage buckets. 
2. 3 bare metal hosts (BM.DenseIO2.52) - Your tenancy should have access to at least 3 BM.DenseIO2.52 shape compute instances in a single Availability Domain (AD).
3. A virtual cloud network (VCN) - You need to either create a virtual cloud network or you can use an existing VCN to deploy the SDDC. We recommend using a VCN with an IP address CIDR size of /20 to run the SDDC. 
4. A CIDR block for VMWare workload that does not overlap with the VCN CIDR.

## Labs
**Lab 1 - Provision the Infrastructure**

1. Rapidly deploy OCVS on Oracle cloud Infrastructure 
2. Manage your VMware workloads

**Lab 2 - Generate Export of On-Premises workload**

1. Export a virtual machine (VM) as a .ovf file from on-premises VMWare infrastructure.
2. Create an object storage bucket and upload the OVF file 

**Lab 3 - Migrate the On-Premises workload to OCVS**

1. Import an OVF file and access the environment as part of the Oracle Cloud VMWare Service.

**Lab 4 - Extend/Integrate Apps running on OCVS to OCI native services**

1. Setup a load balancer in front of your oscommerce application
2. Provide network file system capabilities through File Storage Service (FSS) through a file storage mount point.

## Acknowledgements

**Author** - Maharshi Desai, Subramanian Viswanathan, Shikhar Mishra, Raj Hindocha, Yash Lamba, Srihareendra Bodduluri, Praveen Kumar

**Last Update** - July 17, 2020.

**You are all set. Let us begin!**