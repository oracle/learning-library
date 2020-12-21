# Introduction

This Oracle SOA workshop demonstrates an implementation of business use case for integration by walking through application development - validating payment for an online ordering system. The ordering system will also need to be integrated and invoked by a mobile application via https/REST. The composite SOA app built must support access through RESTful APIs.

<!-- In the advanced workshop, the order processing would also integrate with systems and apps from the packaging department to do ship orders with preferred shipping providers based on the type of shipping service (2 day, 5-7 day shipping, and so on).

The bulk fulfillment process must run according to a predefined pick-up schedule. Upon fulfillment processing and orders being sent to the packaging department, a message must be communicated to the customer (either bulk or on-demand). -->

Estimated Workshop Time, to complete 4 labs: 3 Hours

## About this workshop

* Introducing SOA development tool, JDeveloper 12c
* Design Integration composite using JDeveloper as an IDE
* Develop and build the SOA service orchestration on JDeveloper 12c
* Register the composite with Service Bus and deploy
* REST-api enabled the composite on SOA server in JDeveloper

### Objectives
- Explore **JDeveloper12c**, 12.2.1.4 as an Oracle SOA development foundation.
- Gain familiarity with Oracle JDeveloper 12c that has pre-configured with SOA extensions.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
  
*{Note: For this lab, it assumes you have access to JDeveloper12c environment, which can be run on Linux instance on OCI.}*

## STEP 1: Labs

The Integration SOA workshop consists of 4 separate labs.  The labs should be followed in order from Lab 1 to Lab 4.  There are also screen shots available throughout the labs to guide you through the exercises. 

| # | Lab | Estimate Time |
| --- | --- | --- |
| 1 | Integration using Oracle SOA | 10 min |
| 2 | Build composite integration app for validating payment | 90 min |
| 3 | Register the composite app to Service Bus | 60 min |
| 4 | Enabled REST api access for Validate Payment app | 60 min |

<!-- During the live lab, the tutorial pdf document can be found on the desktop of your OCI Linux instance.

![](../images/2/soa-tutorialpdf.png) -->

## STEP 2: Lab Environment

The workshop has been setup to expedite your SOA development process. The environment consists of JDeveloper 12c, version 12.2.1.4 with preconfigured for SOA Suite. It hosted on an Oracle Linux operating system.

The JDeveloper in this distribution is pre-configured with some JDeveloper IDE extensions so that you can create various kinds of integration orchestration applications immediately. These pre-installed IDE extensions include the following:
- Oracle BPEL Process Manager
- Oracle Human Workflow
- Oracle Business Rules
- Oracle Mediator
- Oracle Service Bus
- Oracle Enterprise Scheduler
- SOA Spring Component Design Time

A pre-installed JDeveloper 12c (12.2.1.4) on a Linux desktop has been provisioned on the Oracle Cloud (OCI). To access a pre-installed JDeveloper environment, you need any modern browser on your laptop or workstation and use the following URL http://[provided ip address]:8080/guacamole with user oracle, password: "Guac.LiveLabs_" note: an underscore character at the end.

You may now proceed to the next lab.

## Learn More

- <a href= https://cloudmarketplace.oracle.com/marketplace/en_US/listing/74792101> SOA on Oracle Marketplace </a>
-   <a href= https://www.oracle.com/middleware/technologies/soasuite.html> SOA suite </a>
-   <a href= https://www.oracle.com/middleware/technologies/soasuite-learmore.html> Tutorials </a> 
-  <a href= https://docs.oracle.com/middleware/12211/soasuite/develop/SOASE.pdf> SOA Developer </a> 
- <a href= https://apex.oracle.com/community> Community </a>
-  <a href=https://www.oracle.com/technetwork/middleware/weblogic/learnmore/reducing-middleware-costs-2327571.pdf> Oracle Middleware </a>

## Acknowledgements
* **Author for LiveLabs** - Daniel Tarudji
* **Contributors** - Rene Fontcha, Meghana Banka, Tom McGinn, Kamryn Vinson
* **Last Updated By/Date** - Kamryn Vinson, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.