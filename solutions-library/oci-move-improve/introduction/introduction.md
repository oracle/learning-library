# OCI Move and Improve Workshop

## Introduction
This workshop series is a part of *Oracle Cloud Infrastructure's Third Party Move & Improve* workshop. This series will walk you through the process of migrating an existing eCommerce application from an on-prem environment to being natively deployed within the cloud. It will walk you through how to capture a custom image of this app and deploy it on OCI with the necessary infrastructure like Networking, Security Lists, and route rules. The workshop will also walk you through the process of making the application highly-available. Later you will learn how to handle the case of high availability by leveraging Oracle's Load Balancer and DNS services for traffic steering. The workshop also focuses on how to connect your eCommerce application to MDS (MySQL Database Service) on OCI. Finally, the workshop will leverage PaaS services such as Autonomous Data Warehouse (ADW), Oracle Analytics Cloud (OAC), and Oracle Integration Cloud (OIC) to show how you can gain even more insight into your application data.

For a technical overview of the workshop, watch the following video below.
[](youtube:KuT6DksQpKc)

Attached below is a sample architecture of the final solution:
![](/images/Architecture.png)

Estimated Workshop Time:  8 hours

### About Oracle Cloud Platform
Oracle offers a complete portfolio of products, services, and differentiated capabilities to power your enterprise. For business users, Oracle offers ready-to-go networking options, server shapes, and enterprise-grade infrastructure that drives better business outcomes. With Oracle's Autonomous Database and Analytics tools, data scientists and application developers have a full suite of cloud services to build, deploy, and manage any type of solution. Machine learning is working behind the scenes in these products to automate security patching, backups and optimize database query performance, which helps eliminate human error and repetitive manual tasks so organizations can focus on higher-value activities.

### Objectives
* Provision custom compute with OSCommerce Image
* Provision underlying infrastructure such as networking, security lists, etc
* Make application Highly Available with Traffic Steering Policies and Active Failover
* Provision MDS (MySQL Database Service) and connect e-commerce application with MDS
* Provision Oracle Analytics Cloud instance, Oracle Integration Cloud instance, and Autonomous Data Warehouse Instance
* Pull data from MySQL database into Oracle Autonomous Data Warehouse
* Perform Analytics with Oracle Analytics Cloud

### Prerequisites
* An Oracle Paid or LiveLabs Cloud account.
* A cloud tenancy where you have the resources available to provision an ADW instance with 2 OCPUs, an OAC instance with 2 OCPUs, and an ODA instance.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.

## Appendix:  Workshop Assumptions
*Note:* Please note below :
* This workshop is intended to be a comprehensive full cloud showcase. It assumes that the user following through this workshop will be provisioning resources and creating users from scratch. If you decide to use existing infrastructure or resources, be aware of your namings, so resources don't overlap and conflict.
* This workshop is not intended to be used as the only means / best-practice to lift and shift on-prem third-party application to OCI. Its sole purpose is to make you aware of OCI Services involved in lift and shift of Lamp Stack Application to Oracle Cloud.
* For simplicity, this workshop focuses on the migration of VMDK file to OCI. However, in real-world scenarios, you would need to migrate your Application to OCI and configure the Server along with the required libraries to make your application up and running.

*Note:* Additionally, as much as possible, do not stray away from the naming conventions used for resources in this workshop. You may run into errors if you do.

## Acknowledgements
* **Author** - Rajsagar Rawool, Akinade Oladipupo, Saurabh Salunkhe, Mitsu Mehta, Ken Keil
* **Last Updated By/Date** - Rajsagar Rawool, January 2021

## Need Help?
If you are doing this module as part of an instructor-led lab, take advantage and ask the instructor.

If you are working through this module self-guided, please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please mention your workshop name and lab name.  Please also have screenshots and attach files when appropriate.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one