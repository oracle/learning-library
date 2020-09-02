# Create a Database Cloud Service on Bare Metal

## Overview

This template allow you to create a single DB instance on bare metal in Oracle Cloud. It's will create a VCN which including the public subnet, security list, Internet Gateway, etc.

The database is deployed in the public subnet, so it's can be accessed by the internet client tools.



## Before You Begin

Before you begin creating resources in Oracle Cloud Infrastructure, ensure that you have the following:

* Credentials for an Oracle Cloud tenancy

* Access to a computer that has the following software and access to the internet :

  * A [supported](https://docs.oracle.com/en/cloud/get-started/subscriptions-cloud/csgsg/web-browser-requirements.html) web browser for Oracle Cloud Infrastructure

### Prerequisites

* [Download](./scripts/terraform/resmgr/dbcs-baremetal.zip) the prebuilt Terraform script

### Required Parameters

| Resource                | Value                                                        |
| ----------------------- | ------------------------------------------------------------ |
| Tenancy OCID            | Locate your [Tenancy OCID](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/identifiers.htm) |
| Compartment OCID        | Locate your [Compartment OCID](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/identifiers.htm) |
| Cloud Region Identifier | Retrieve the [Cloud Region Identifier](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm) of the Cloud region |
| SSH Key Pair            | Use for SSH access to the DB system                          |
| Admin Password          | Password for the Database Adminstrator account (refer to [password rules](https://docs.cloud.oracle.com/en-us/iaas/Content/Database/Tasks/creatingDBsystem.htm)) |
| Terraform Version       | 0.11.x                                                       |



## Architecture

![image-20200302130240415](img/image-20200302130240415.png)

## Steps

- [Provision Resources](?lab=provision-resources)
- [Validate Provisioning](?lab=validate-provisioning)