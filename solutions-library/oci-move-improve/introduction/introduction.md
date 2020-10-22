# OCI Move and Improve Workshop

## Introduction
This workshop series is part of *Oracle Cloud Infrastructure's Third Party Move & Improve* workshop. This series will walk you through the process of migrating an existing eCommerce application from an on-prem environment to being natively deployed within the cloud. It will walk you through how to capture a custom image of this app and deploy it on OCI with necessary infrastructure like Networking, Security Lists and route rules. The workshop will also walk you through the process of making the application highly-avaiworkshople in the case of disaster scenarios by leveraging Oracle's DNS services for traffic steering. Finally, the workshop will leverage PaaS services such as Autonomous Data Warehouse (ADW), Oracle Analytics Cloud (OAC), and Oracle Integration Cloud (OIC) in order to show how you can gain even more insight into your application data.

For a technical overview of the workshop, watch the following video below.
[](youtube:KuT6DksQpKc)

Attached below is a sample architecture of the final solution:
![](/images/Architecture.png)

Estimated Workshop Time:  xx minutes

### About Oracle Cloud Platform
Oracle offers a complete portfolio of products, services, and differentiated capabilities to power your enterprise. For business users, Oracle offers ready-to-go networking options, server shapes, and enterprise-grade infrastructure that drives better business outcomes. With Oracle's Autonomous Database and Analytics tools, data scientists and application developers have a full suite of cloud services to build, deploy, and manage any type of solution. Machine learning is working behind the scenes in these products to automate security patching, backups, and optimize database query performance, which helps to eliminate human error and repetitive manual tasks so organizations can focus on higher-value activities.

### Objectives
* Provision custom compute with OSCommerce Image
* Provision underlying infrastructure such as networking, security lists etc
* Make application Highly Avaiworkshople with Traffic Steering Policies and Active Failover
* Provision Oracle Analytics Cloud instace, Oracle Integration Cloud instance, and Autonomous Data Warehouse Instance
* Pull data from MySQL database into Oracle Autonomous Data Warehouse
* Perform Analytics with Oracle Analytics Cloud

### Prerequisites 
* An Oracle Paid or LiveLabs Cloud account.
* A cloud tenancy where you have the resources avaiworkshople to provision an ADW instance with 2 OCPUs, an OAC instance with 2 OCPUs, and an ODA instance.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.

## Appendix:  Workshop Assumptions
*Note:* This workshop is intended to be a comprehensive full cloud showcase. As such, it is assumed a user going through this workshop will be provisioning resources and creating users from scratch. If you decide to use existing infrastructure or resources, be aware and keep note of your namings so resources don't overlap and conflict.

*Note:* Additionally, as much as possible, do not stray away from the naming conventions used for resources in this worshop. You may run into errors if you do.

## Acknowledgements
* **Author** - Akinade Oladipupo, Saurabh Salunkhe, Mitsu Mehta, Ken Keil 
* **Adapted for Cloud by** -  Akinade Oladipupo, Saurabh Salunkhe, Mitsu Mehta, Ken Keil
* **Last Updated By/Date** - Kay Malcolm, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
