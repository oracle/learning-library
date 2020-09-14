# Migrating WebLogic Server to Kubernetes on OCI

## Introduction

This workshop explores the process of moving an existing on-premises WebLogic application into to a Kubernetes cluster in the Oracle  Cloud.

[![Watch Workshop Overview](./images/youtube.png)](https://videohub.oracle.com/media/WLS+to+OKE+Overview+Video/1_z6ofm0s8)

Estimated Workshop Time: 40 minutes

### About OCI Container Engine for Kubernetes (OKE)
Oracle Cloud Infrastructure Container Engine for Kubernetes (OKE) is a fully-managed, scalable, and highly available service that you can use to deploy your containerized applications to the cloud. Use Container Engine for Kubernetes (sometimes abbreviated to just OKE) when your development team wants to reliably build, deploy, and manage cloud-native applications. You specify the compute resources that your applications require, and Container Engine for Kubernetes provisions them on Oracle Cloud Infrastructure in an existing OCI tenancy. 

  
### Objectives
* Create OKE on OCI
* Install and configure the operator
* Install and configure Traefik
* Deploy a WebLogic domain


### Prerequisites 
* An Oracle Paid or LiveLabs Cloud account.

## Appendix:  Workshop Assumptions
*Note:* This workshop is intended to be a comprehensive full cloud showcase. As such, it is assumed a user going through this workshop will be provisioning resources and creating users from scratch. If you decide to use existing infrastructure or resources, be aware and keep note of your namings so resources don't overlap and conflict.

*Note:* Additionally, as much as possible, do not stray away from the naming conventions used for resources in this worshop. You may run into errors if you do.

## Acknowledgements
* **Author** - Sasanka Abeysinghe, Senior Cloud Engineer, Oracle
* **Last Updated By/Date** - Kay Malcolm, DB Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.