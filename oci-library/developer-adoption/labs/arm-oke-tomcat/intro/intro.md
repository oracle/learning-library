# Get started with Arm based Kubernetes clusters in Oracle Cloud Infrastructure

Estimated time: 45 minutes
Note : This lab can be performed on a Free Trial, Always-Free Tier, or paid subscription accounts. 

## Introduction

This tutorial explains how to create Arm based Kubernetes clusters that use the Ampere A1 compute platform in Oracle Cloud Infrastructure(OCI). You will also deploy the popular web container, Apache Tomcat on the kubernetes cluster. Using the methods in this tutorial, you can create application deployments that are seamlessly portable between the Arm based kubernetes clusters and x86(Intel and AMD) based clusters. 

### Objectives

In this tutorial, you will:

* Create a Kubernetes cluster (OKE) powered by the Ampere A1 compute.
* Deploy Apache Tomcat to the cluster.
* Create deployments that are seamlessly portable across x86 and Arm based kubernetes clusters.  
* Deploy Java applications and micro services to the Tomcat web container.  

## What is the Ampere A1 Compute Platform

The Ampere A1 compute platform based on Ampere Altra CPUs represent a generational shift for enterprises and application developers that are building workloads that can scale from edge devices to cloud data centers. The unique design of this  platform delivers consistent and predictable performance as there are no resource contention within a compute core and offers more isolation and security. This new class of compute shapes on Oracle Cloud Infrastructure  provide an unmatched platform that combines power of the Altra CPUs with the security, scalability and eco-system of services on OCI.

## Introducing the Arm architecture to your environment

When introducing the Arm architecture to your application development process, your development workflows stay the same in most cases. The tools and the process that you currently use will carry over seamlessly, and your development workstation setup will remain the same. The general exception to this is low-level system applications that target specific CPU features using highly specialized tools.  In most cases, you might expect minor changes to the build or packaging steps in your workflow, to support the Arm architecture. Start by analyzing your existing workflow to identify if you have any platform-specific build or packaging steps. 

 - Platform-specific build steps can be compiler options, in the case of compiled languages like [C/C++](https://developer.amperecomputing.com/), [Go](https://github.com/golang/go/wiki/GoArm), and [Rust](https://doc.rust-lang.org/nightly/rustc/platform-support.html). In these cases, you typically add a build step to compile your application for Arm along with the x86 version of the application. If you're using a bytecode language, Just-In-Time (JIT) compiled language, or an interpreted language such as Java, JavaScript, TypeScript, Python, or Ruby, then there are usually no compile-time flags or options. These languages don't produce platform-specific executable binaries; instead, they use a platform-specific runtime, such as the Java or Node.js runtime for Arm, which runs the same source code across multiple platforms.
 - Platform-specific packaging includes packaging your applications as Docker images, custom VM images, or platform-specific deployment artifacts. In these cases, you will want to amend your build process with an additional step to produce the application package that is Arm specific. In the case of container images, for example, you will want to have a version of your application image that is for deployment on an Arm system. Container image formats support multiple architectures, so that the container runtimes of each platform can simply fetch the appropriate image and run the application. See the Docker blog to learn more about [multi-arch images](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/) and [how to build them](https://www.docker.com/blog/multi-arch-images/).


### Prerequisites

1. An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
1. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
1. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
1. [Familiarity with Compartments](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)
1. Basic conceptual knowledge of containers and Kubernetes

## Acknowledgements

* **Author** - Jeevan Joseph
* **Contributors** -  Orlando Gentil, Jeevan Joseph
* **Last Updated By/Date** - Jeevan Joseph, April 2021
