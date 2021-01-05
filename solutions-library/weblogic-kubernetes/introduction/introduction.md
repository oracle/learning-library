# Introduction

## About this Workshop

This lab shows you how to deploy and run a WebLogic domain container-packaged web application on a Kubernetes cluster using [Oracle WebLogic Server Kubernetes Operator 3.0.0](https://github.com/oracle/weblogic-kubernetes-operator) (the "operator").

The sample web application is a simple JSP page which shows WebLogic Server domain MBean attributes to demonstrate operator features.

### About Product/Technology

A WebLogic domain can be located either in a persistent volume (PV) or in a Docker image. There are advantages to both approaches, and sometimes there are technical limitations of various cloud providers that may make one approach better suited to your needs. See
[Choose a model](https://oracle.github.io/weblogic-kubernetes-operator/userguide/managing-domains/choosing-a-model/).

This tutorial uses the Docker image with the WebLogic domain inside the image deployment. This means that all the artifacts and domain-related files are stored within the image. There is no central, shared domain folder from the pods. This is similar to the standard installation topology where you distribute your domain to different hosts to scale out Managed Servers. The main difference is that by using a container-packaged WebLogic domain, you don't need to use the pack/unpack mechanism to distribute domain binaries and configuration files between multiple hosts.

![](images/architecture.png)

In a Kubernetes environment, the operator ensures that only one Administration Server and multiple Managed Servers will run in the domain. An operator is an application-specific controller that extends Kubernetes to create, configure, and manage instances of complex applications. The Oracle WebLogic Server Kubernetes Operator simplifies the management and operation of WebLogic domains and deployments.

Helm is a framework that helps you manage Kubernetes applications, and helm charts help you define and install Helm applications in a Kubernetes cluster.

This tutorial has been tested on the Oracle Cloud Infrastructure Container Engine for Kubernetes (OKE).

[](youtube:yVdr4GmpxqY)

### Objectives

* Set up an Oracle Kubernetes Engine instance on the Oracle Cloud Infrastructure
* Install the WebLogic Server Kubernetes Operator
* Install a Traefik software load balancer
* Deploy a WebLogic domain
* Scale a WebLogic cluster
* Update a deployed application by a rolling restart of the new image
* Assign WebLogic pods to nodes (a scenario simulating a cluster spanning 2 data centers)](node.selector.ocishell.md)

### Prerequisites

An Oracle Paid or LiveLabs Cloud account.

## Learn More

* [WebLogic Kubernetes Operator Documentation](https://oracle.github.io/weblogic-kubernetes-operator)

## Acknowledgements
* **Author** - Maciej Gruszka, Peter Nagy, September 2020
* **Last Updated By/Date**

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
