# Introduction

## About this Workshop

This lab will walk you through the process of deploying an Oracle Kubernetes Engine (OKE) cluster with the OCI Service Broker (OSB).

OCI Service Broker lets you manage the lifecycle of services such as Autonomous Database (ATP or ADW), Object Storage or Streaming as kubernetes objects.

Estimated Lab Time: 60min

### Objectives

*Deploy an OKE cluster with OCI Service Broker installed with Terraform*

In this lab, you will:
- Install the prerequisite software needed to run a terraform deployment and deploy kubernetes manifests
- Deploy an OKE cluster with the OCI Service Broker.
- Provision an example Autonomous Database with Kubernetes.
- Provision an example Object Storage Bucket with Kubernetes
- Provision an example Stream with Kubernetes.

### Prerequisites

*In order to run this workshop you need:*

* A Mac OS X, linux or Windows machine (note that installation of some pre-requisites may be different than the steps in this workshop on Windows)
* A private/public SSH key-pair
* A OCI account with a Compartment setup

If you are not an administrator on your tenancy, you must insure that the following policies have been set for you:

```
<copy>
Allow group MyGroup to manage groups in tenancy
Allow group MyGroup to manage dynamic-groups in tenancy
Allow group MyGroup to manage policies in tenancy
Allow group MyGroup to manage volume-family in tenancy
Allow group MyGroup to manage instance-family in tenancy

Allow group MyGroup to inspect tenancies in tenancy
Allow group MyGroup to use tag-namespaces in tenancy

Allow group MyGroup to manage all-resources in compartment MyCompartment
</copy>
```

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelab). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
