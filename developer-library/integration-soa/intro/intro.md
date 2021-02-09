# Introduction

## About this Workshop

This Oracle SOA workshop demonstrates an implementation of business use case for integration by walking through application development - validating payment for an online ordering system. The ordering system will also need to be integrated and invoked by a mobile application via *https/REST*. The following are covered under this workshop:

- Introducing SOA development tool, JDeveloper 12c
- Design Integration composite using JDeveloper as an IDE
- Develop and build the SOA service orchestration on JDeveloper 12c
- Register the composite with Service Bus and deploy
- REST-api enabled the composite on SOA server in JDeveloper

This workshop consists of 4 separate labs and are recommended to be performed in the order provided.  

| # | Lab | Estimate Time |
| --- | --- | --- |
| 1 | Integration using Oracle SOA | 10 min |
| 2 | Build composite integration app for validating payment | 90 min |
| 3 | Register the composite app to Service Bus | 60 min |
| 4 | Enabled REST api access for Validate Payment app | 60 min |

<!-- In the advanced workshop, the order processing would also integrate with systems and apps from the packaging department to do ship orders with preferred shipping providers based on the type of shipping service (2 day, 5-7 day shipping, and so on).

The bulk fulfillment process must run according to a predefined pick-up schedule. Upon fulfillment processing and orders being sent to the packaging department, a message must be communicated to the customer (either bulk or on-demand). -->

*Estimated Lab Time*: 220 minutes

### About Product/Technology
The workshop has been setup to expedite your SOA development process. The environment consists of JDeveloper 12c, version 12.2.1.4 preconfigured for SOA Suite. It's hosted on an Oracle Linux operating system.

The JDeveloper in this distribution is pre-configured with some JDeveloper IDE extensions so that you can create various kinds of integration orchestration applications immediately. These pre-installed IDE extensions include the following:
- Oracle BPEL Process Manager
- Oracle Human Workflow
- Oracle Business Rules
- Oracle Mediator
- Oracle Service Bus
- Oracle Enterprise Scheduler
- SOA Spring Component Design Time

Watch a preview of Oracle SOA Composite development on JDeveloper 12c[](youtube:cCWpGUL7jYA)

### Objectives
  - Explore **JDeveloper12c**, 12.2.1.4 as an Oracle SOA development foundation.
  - Gain familiarity with Oracle JDeveloper 12c that has pre-configured with SOA extensions.


### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account

You may now proceed to the next lab.

## Learn More
- [SOA on Oracle Marketplace](https://cloudmarketplace.oracle.com/marketplace/en_US/listing/74792101)
- [SOA suite](https://www.oracle.com/middleware/technologies/soasuite.html)
- [Tutorials](https://www.oracle.com/middleware/technologies/soasuite-learmore.html)
- [SOA Developer](https://docs.oracle.com/middleware/12211/soasuite/develop/SOASE.pdf)
- [Community](https://apex.oracle.com/community)
- [Oracle Middleware](https://www.oracle.com/technetwork/middleware/weblogic/learnmore/reducing-middleware-costs-2327571.pdf)

## Acknowledgements
* **Author for LiveLabs** - Daniel Tarudji
* **Contributors** - Rene Fontcha, Meghana Banka, Tom McGinn, Kamryn Vinson
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
