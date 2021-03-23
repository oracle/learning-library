# Introduction

## About this Workshop

Developing on Kubernetes while connecting to services that only live on the cluster can be challenging.

This lab will walk you through a template for developing applications for Kubernetes on a live cluster, publishing the application and service images, and deploying to dev, staging and production environments.

We'll cover how to setup the kubernetes resource and use **Kustomize** to templatize for different environments, as well as develop and debug containers on a remote cluster with **Skaffold**.

This workshop makes use of the OCI Service Broker to manage the lifecycle of a streaming service and an Autonomous Transaction Processing Database. We'll go over deploying an Oracle Kubernetes Engine (OKE) cluster with the OCI Service Broker (OSB).

Estimated Lab Time: 60min

### Objectives

*Discover how to develop, debug, and deploy applications for Kubernetes on a live OKE cluster*

In this lab, you will:
- Install the prerequisite software needed to run a terraform deployment and deploy kubernetes manifests
- Deploy an OKE cluster with the OCI Service Broker.
- Learn how to use Kustomize (the templating utility for Kubernetes) to parametrize multiple environments.
- Learn to use Skaffold to develop container applications
- Learn to use Skaffold to debug containers on a live cluster
- Learn to use Github Actions to automate testing and deployment.

### Prerequisites

*In order to run this workshop you need:*

* A Mac OS X, linux or Windows machine with Windows Subsystem for Linux as all commands to be used are shell commands.
* A private/public SSH key-pair
* A OCI account with a Compartment setup

***If you are not an administrator on your tenancy, you must insure that the following policies have been set for you:***

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
***If your administrator won't let you create users and groups / policies, as required, you may need to have the administrator perform the OKE deployment steps and provide access to the cluster.***


You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, February 2021
 - **Last Updated By/Date** - Emmanuel Leroy, February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelab). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
