# Migrating WebLogic Server to Kubernetes on OCI

## Introduction

This workshop lets you practice through the process of moving an existing On-premises WebLogic application into to a Kubernetes cluster in the Oracle Public Cloud.

[![Watch Workshop Overview](./images/youtube.png)](https://videohub.oracle.com/media/WLS+to+OKE+Overview+Video/1_z6ofm0s8)

Estimated Workshop Time: 40 minutes

### About Oracle Cloud Platform
Oracle offers a complete portfolio of products, services, and differentiated capabilities to power your enterprise. For business users, Oracle offers ready-to-go networking options, server shapes, and enterprise-grade infrastructure that drives better business outcomes. With Oracle's Autonomous Database and Analytics tools, data scientists and application developers have a full suite of cloud services to build, deploy, and manage any type of solution. Machine learning is working behind the scenes in these products to automate security patching, backups, and optimize database query performance, which helps to eliminate human error and repetitive manual tasks so organizations can focus on higher-value activities.

  
### Objectives
* Create Oracle Container Engine for Kubernetes (OKE) on Oracle Cloud Infrastructure (OCI)
* Install and configure the operator
* Install and configure Traefik
* Deploy a WebLogic domain


### Prerequisites 
* An Oracle Paid or LiveLabs Cloud account.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.

## Appendix:  Workshop Assumptions
*Note:* This workshop is intended to be a comprehensive full cloud showcase. As such, it is assumed a user going through this workshop will be provisioning resources and creating users from scratch. If you decide to use existing infrastructure or resources, be aware and keep note of your namings so resources don't overlap and conflict.

*Note:* Additionally, as much as possible, do not stray away from the naming conventions used for resources in this worshop. You may run into errors if you do.

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Adapted for Cloud by** -  <Name, Group> -- optional
* **Last Updated By/Date** - Kay Malcolm, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.