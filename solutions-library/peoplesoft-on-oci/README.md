# PeopleSoft Migration to Oracle Cloud Infrastructure 

## Introduction
In this hands on lab, you will be able to bring up and configure a Cloud Manager instance in your tenancy, and provision a new PeopleSoft environment.  

The lab can be divided into the following sections:

Readme: Review the Prerequisites and set up your workstation/laptop 

## Overview of Labs

Lab 100: Setup OCI and Review VM shapes available in your account/tenancy.

Lab 200: Download and run the automation package to configure your tenancy, and deploy Cloud Manager. The automation will:

	a. Create a user
	b. Create a group
	c. Create a compartment
	d. Create a OCI policy, 
	e. Create network resources – VCN and subnets
	f. Subscribe to the Cloud Manager Marketplace image
	g. Create Cloud Manager instance 
	h. Bootstrap install Cloud Manager application

Lab 300: Configure Cloud Manager Settings 

Lab 400: Subscribe to PeopleSoft Download Channels 

Lab 500: Review and Update a Topology

Lab 600: Create a new Environment template

Lab 700: Create Environment in Peoplesoft

An additional Lab - IAM Best Practices is added. This lab guides you how to create compartments, users, policies once we log into the OCI console.

## Time duration

Review Lab 600 for details on the resources created by deployment automation. This session should take about 90 minutes approximately. 

Lab 400, when you subscribe to download channels, time taken for downloads to complete depends on network speed and the number of subscribed download channels. If only one application channel and one PeopleTools channel with only the latest patch is subscribed, then downloads should complete in about 60 to 90 minutes depending on the download speed. 

Lab500, 600, 700, should take you approximately 60 to 75 minutes, you will be able to create a Topology, an Environment Template and provision a new PeopleSoft environment.


## Reviewing Pre-requisistes

1. User already has a tenancy with Administrator user access. 

2. My Oracle Support credentials

3. Minimum resources in Home region of the tenancy:

	a. 4 x VM shapes (VM.Standard2.2 or VM.Standard2.1, VM.StandardE2.2 or VM.StandardE2.1)

	b. 1 TB block storage

4. User brings their own Windows workstation/laptop to access OCI console, PSFT Cloud Manager and provisioned instances. 

5. User has access to a Windows workstation/laptop with the following installed:

	a. Git Bash for Windows - https://git-scm.com/download/win 

	b. A web browser to connect to OCI web console and Cloud Manager PIA – Firefox or Chrome recommended.

	c. User must have admin privileges on windows laptop to update the ETC/Hosts file to be able to add URL/IP address for PSFT Cloud Manager.


