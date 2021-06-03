# Get started with GraalVM on Ampere A1 on Oracle Cloud Infrastructure 

Estimated time: 45 minutes
Note : This lab can be performed on a Free Trial, Always-Free Tier, or paid subscription accounts. 

This tutorial describes how to get started with GraalVM on Ampere A1 compute platform in Oracle Cloud Infrastructure (OCI). You will first run a Spring Boot application in the JVM mode and then build and run a Micronaut.io application as a native binary. You can use GraalVM to improve the performance of your existing applications and build lightweight polyglot applications for the cloud. It’s an ideal companion for the Ampere A1 compute shapes, which provide linear scalability and an unbeatable price-performance ratio.

The Ampere A1 compute platform based on Ampere Altra CPUs represent a generational shift for enterprises and application developers that are building workloads that can scale from edge devices to cloud data centers. The unique design of this  platform delivers consistent and predictable performance as there are no resource contention within a compute core and offers more isolation and security. This new class of compute shapes on Oracle Cloud Infrastructure  provide an unmatched platform that combines power of the Altra CPUs with the security, scalability and eco-system of services on OCI.

### What is GraalVM?

GraalVM is a high-performance runtime for applications written in Java, JavaScript, LLVM-based languages such as C and C++, and other dynamic languages. It significantly improves application performance and efficiency, so it can help you run your existing applications more efficiently on cloud platforms. 

GraalVM also builds native executable binaries—native images—for existing JVM-based applications. The resulting native image contains the whole program in machine-code form for immediate execution and avoids the startup and memory footprint of the JVM itself. This capability makes GraalVM ideal for building cloud native applications, and several microservice frameworks for JVM languages include this capability today.

Estimated time: 45 minutes

### Objectives

In this tutorial, you will:

* Create an Ampere A1 compute instance 
* Install GraalVM Enterprise Edition
* Run the popular Spring Boot sample application Pet Clinic using GraalVM in JVM mode
* Build and Run a Micronaut application as a GraalVM native image 
* Evaluate the suitability of using GraalVM on Ampere A1 
* Clean up the deployments

### Prerequisites

1. An Oracle Free Tier (Trial), Paid or LiveLabs Cloud Account
1. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
1. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
1. [Familiarity with Compartments](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)
1. Basic conceptual knowledge of containers and [Podman](https://podman.io/)

### Learn More

* [OCI Arm A1 compute platform](https://developer.oracle.com/arm)


## Acknowledgements

* **Author** - Jeevan Joseph
* **Contributors** -  Orlando Gentil, Jeevan Joseph
* **Last Updated By/Date** - Jeevan Joseph, April 2021
