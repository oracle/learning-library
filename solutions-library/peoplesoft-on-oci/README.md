# PeopleSoft Migration to Oracle Cloud Infrastructure (OCI)

## Introduction
In this hands-on lab, the users are provided with step-by-step instructions on setting up a user group, creating and adding users to a group, and creating a compartment and respective policies in the **Oracle Cloud Infrastructure (OCI)**. Subsequently, this guide instructs how to install the Cloud Manager 11 using Marketplace. The final section provides the steps to provision a PeopleSoft Environment followed by some simple hands-on exercises for you to get familiar with the system.

The lab is divided into the following sections:

## Overview of Labs

**Lab 100**: Setting up Oracle Cloud Infrastructure.  

**Lab 200**: Creating Identity and Access Management (IAM) resources.  

**Lab 300**: Provisioning the Peoplesoft Cloud Manager using Marketplace.  

**Lab 400**: Configuring Cloud Manager Settings.  

**Lab 500**: Subscribing to PeopleSoft Download Channels.   

**Lab 600**: Reviewing and Updating a Topology.  

**Lab 700**: Creating a new Environment template.  

**Lab 800**: Creating Environment in Peoplesoft.  

## Time duration

**Lab 100** - 10 mins   
**Lab 200** - 20 mins   
**Lab 300** - 30 mins configuration + 1 hour waiting   
**Lab 400** - 10 mins   
**Lab 500** - 5 mins configuration + maximum 3 hours waiting   
**Lab 600** - 5 mins   
**Lab 700** - 10 mins   
**Lab 800** - 15 mins configuration + 1.5 hours waiting   


## Reviewing Prerequisite

1. User already has a tenancy with Administrator user access. 

2. My Oracle Support credentials. Please make sure that you can successfully login to [Oracle Support](https://support.oracle.com). Note down this login credential in a notepad. You will use it later to configure Cloud Manager.

3. User should bring their own workstation/laptop to access the OCI console, PSFT Cloud Manager, and provisioned instances. 

4. User has access to a workstation/laptop with the following installed:

    a. If you have a windows machine, please download Git Bash for Windows from here: https://git-scm.com/download/win  

    b. User must have admin privileges on their laptop to update the **etc/hosts** file to add URL/IP address for PSFT Cloud Manager. Please let the team know if you can't get this access.

    **NOTE: If you don't have admin privileges in your local machine, please make sure to follow the "Windows VM Compute" Lab during Lab 300 before starting Part 6. You can use the windows compute to follow this Workshop. Please also make sure to install Git Bash in Windows Compute.**

    You will also need to install **Remote Desktop Connection** in your local machine from this [link](https://www.microsoft.com/en-us/p/microsoft-remote-desktop/9wzdncrfj3ps).

    c. A web browser to connect to OCI web console and Cloud Manager PIA – Firefox or Chrome recommended.
	