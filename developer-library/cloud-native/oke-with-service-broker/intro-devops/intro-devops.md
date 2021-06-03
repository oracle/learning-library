# Introduction

## About this Workshop

Developing on Kubernetes while connecting to services that only live on the cluster can be challenging.

This lab will walk you through a template for developing applications for Kubernetes on a live cluster, publishing the application and service images, and deploying to dev, staging and production environments.

We'll cover how to set up the Kubernetes resource and use **Kustomize** to templatize for different environments, as well as develop and debug containers on a remote cluster with **Skaffold**.

This workshop makes use of the Oracle Cloud Infrastructure (OCI) Service Broker to manage the lifecycle of a streaming service and an Autonomous Transaction Processing Database. We'll go over deploying an Oracle Kubernetes Engine (OKE) cluster with the OCI Service Broker (OSB).

Estimated Lab Time: 60 minutes.

### Objectives

*Discover how to develop, debug, and deploy applications for Kubernetes on a live OKE cluster*.

In this lab, you will:
- Install the prerequisite software needed to run a Terraform deployment and deploy Kubernetes manifests.
- Deploy an OKE cluster with the OCI Service Broker.
- Learn how to use Kustomize (the templating utility for Kubernetes) to parametrize multiple environments.
- Learn to use Skaffold to develop container applications.
- Learn to use Skaffold to debug containers on a live cluster.
- Learn to use GitHub Actions to automate testing and deployment.

### Prerequisites

*In order to run this workshop you need:*

* A Mac OS X, Linux or Windows machine with Windows Subsystem for Linux as all commands to be used are shell commands.
* An SSH key-pair.
* A OCI account with a compartment set up.
* Terraform installed.

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

If you do not have permission to create users and group, you can use your own user when a user would otherwise be created. Provide your user_ocid for each user_ocid variable required. This is not recommended for security reasons.

You should also provide an auth token if you have one, or have enough slots open to create one token.

This template also creates an API key on each user that requires one, so you must have at most 2 API keys on your user if you will provide your own user.

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, February 2021
 - **Last Updated By/Date** - Emmanuel Leroy, February 2021
