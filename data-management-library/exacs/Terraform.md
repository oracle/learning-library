## Introduction

**DevOps** is a set of practices that works to automate and integrate the processes between software development and IT teams, so they can build, test, and release software faster and more reliably. The term **DevOps** was formed by combining the words “development” and “operations”.

**Git** is a DevOps tool used for source code management. It is a free and open-source version control system used to handle small to very large projects efficiently. Git is used to track changes in the source code, enabling multiple developers to work together on non-linear development. Linus Torvalds created Git in 2005 for the development of the Linux kernel.

**Terraform** is a really handy tech tool that lets you build, change, and version infrastructure safely and efficiently. **Terraform** is quietly revolutionizing DevOps by changing the way infrastructure is managed, and making it faster and more efficient to execute DevOps projects.

To log issues and view the Lab Guide source, go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository.

## Objectives

This lab shows how to use DevOps methodology to quickly develop and operate/maintain reliable infrastructure to deliver IT services.

Infrastructure as Code evolved to solve the problem of environment drift in the release pipeline. Without IaC, teams must maintain the settings of individual deployment environments.

* Infrastructure as Code enables DevOps teams to test applications in production-like environments early in the development cycle.
* You can repeatedly deploy your solution throughout the development life-cycle and have confidence your resources are deployed in a consistent state.
* You can define the dependencies between resources so they’re deployed in the correct order.

## Topics

* [Getting started with GitHub](?lab=lab-14-1-git-for-beginner)
    - GitHub flow is a lightweight, branch-based workflow that supports teams and projects where deployments are made regularly.
* [Getting started with Terraform](?lab=lab-14-2-terraform-for-beginner)
    - Terraform allows infrastructure to be expressed as code in a simple, human readable language called HCL (HashiCorp Configuration Language).
* [Manage Database with Terraform](?lab=lab-14-3-terraform-for-database)
    - Terraform enables you to safely and predictably create, change, and improve infrastructure that include databases.