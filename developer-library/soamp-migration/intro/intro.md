# Migrate SOA Suite On-premises to SOA Suite Marketplace on Oracle Cloud Infrastructure

## Introduction

This lab will walk you through the process of migrating an existing 'on-premises' SOA Suite to SOA Suite on Marketplace for Oracle Cloud Infrastructure. SOA Suite on Marketplace, SOA Cloud Service, and MFT Cloud Service can be migrated manually following these steps. Side-by-side upgrade from one version to another follows the same process. 

Attached below is a sample architecture of the final solution:
![](./images/architecture.png)

Estimated Lab Time: 90min.

### Objectives

*Perform the end-to-end migration of a local SOA suite to Oracle Cloud Infrastructure, provisioning SOA Suite on OCI with the Marketplace.*

In this workshop, you will:
- Provision a demo environment to use as the SOA 'on-premises' environment to be migrated
- Prepare your OCI tenancy and the Virtual Network to deploy the target 'SOA Suite Marketplace on OCI' environment
- Provision the Operational Database on OCI, required to deploy SOA Suite Marketplace on OCI
- Provision SOA Suite on OCI with the Marketplace
- Upgrade the SOA on-premises application to be migrated to the latest version
- Migrate the upgraded SOA on-premises application to SOA Suite on OCI

**Note:** This lab will only showcase migration of one application. For a complete guide to migrate SOA to SOA on OCI refer to the **Learn More** section below.


### Prerequisites

*In order to run this workshop you need:*

* A private/public SSH key-pair
* Firefox browser (recommended as Chrome security may prevent you from loading HTTPS self-signed certificates)
* An OCI account
* A Compartment in the tenancy with `manage all-resources` permission to provision the resources
* A SSH key pair to connect to provisioned instances

You may proceed to the next lab.

## Learn More

[SOA side-by-side upgrade guide](https://docs.oracle.com/en/cloud/paas/soa-cloud/liftshift/migration-side-side-upgrade-soa-mp.html#GUID-6F77D620-0962-43A4-A503-A70E706C3D02)

## Acknowledgements

 - **Author** - Akshay Saxena, September 2020
 - **Last Updated By/Date** - Akshay Saxena, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
