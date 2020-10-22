# Introduction

## Integration and Orchestration

### Overview

This Oracle SOA workshop demonstrates an implementation of business use case by walking through application development of validating payment processing for an online ordering system. The ordering system will integrate with a mobile application. The composite SOA app built must be able to support access through RESTful APIs.

In the advanced workshop, the order processing would also integrate with systems and apps from the packaging department to do ship orders with preferred shipping providers based on the type of shipping service (2 day, 5-7 day shipping, and so on).

The bulk fulfillment process must run according to a predefined pick-up schedule. Upon fulfillment processing and orders being sent to the packaging department, a message must be communicated to the customer (either bulk or on-demand).

### Objectives

* Introducing SOA development tool, JDeveloper 12c
* Design SOA composite application using JDeveloper
* Develop service orchestration with SOA process automation
* Deploy the composite application on the embedded Weblogic in JDeveloper

Estimated Workshop Time: 4 Hours

*{Note: For this lab, it assumes you have accessed to JDeveloper12c environment, which can be run on Linux instance on OCI.}*

## Modules

| # | Module | Estimate Time |
| --- | --- | --- |
| 1 | Introduction to SOA | 10 min |
| 2 | Build composite integration app for validating payment | 90 min |
| 3 | Register the composite app to Service Bus | 60 min |
| 4 | Enabled REST api access for Validate Payment app | 60 min |

<!-- ## Navigating the Lab
To return to this page from anywhere within the lab click on the "hamburger-menu" icon on the right-hand side.
![](images/0/new-lab-header.png)
Click the navigation menu icon, in the upper-left corner of the header, to see a list of modules in this lab. Click any of the list entries to navigate directly to that module.  -->

When you're ready to proceed, please click the Contents menu on the right-hand.

![](images/0/new-lab-menu.png)

<!-- During the live lab, the tutorial pdf document can be found on the desktop of your OCI Linux instance.

![](images/2/soa-tutorialpdf.png) -->

## Learn More

- <a href= https://cloudmarketplace.oracle.com/marketplace/en_US/listing/74792101> SOA on Oracle Marketplace </a>
-   <a href= https://www.oracle.com/middleware/technologies/soasuite.html> SOA suite </a>
-   <a href= https://www.oracle.com/middleware/technologies/soasuite-learmore.html> Tutorials </a> 
-  <a href= https://docs.oracle.com/middleware/12211/soasuite/develop/SOASE.pdf> SOA Developer </a> 
- <a href= https://apex.oracle.com/community> Community </a>
-  <a href=https://www.oracle.com/technetwork/middleware/weblogic/learnmore/reducing-middleware-costs-2327571.pdf> Oracle Middleware </a>

## Acknowledgements
* **Author for LiveLabs** - Daniel Tarudji
* **Contributors** - Tom McGinn, Kamryn Vinson
* **Last reviewed By/Date** - Kamryn Vinson, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.