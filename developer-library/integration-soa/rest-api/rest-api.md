# Enable REST API for Validate Payment Composite

## Introduction
With a mobile app launch in progress, this new validate-payment composite app must support access via RESTful API.

In SOA 12c, SOA composites can use end-to-end JSON. This means that the REST service can receive the REST request and route it to the BPEL engine without translating it to XML. The BPEL component can use the JavaScript action, and also use JavaScript in conditional and iterative constructs, to work on JSON objects directly. The REST reference can receive the REST message from the BPEL engine and route it to an external REST endpoint without translation.

*Estimated Lab Time*: 60 minutes

### Objectives
- Use JDeveloper12c to REST-enabled API an existing Proxy service constructed on the Oracle Service Bus.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Initialize Environment
    - Lab: Develop SOA Composite App Validate Payment
    - Lab: Register Validate Payment App to the Service Bus

## **STEP 1**: REST-Enabled the Service Bus Proxy End-Point

1. In the Components swimlane, right-click the left wired connection of validatePaymentProcess, and select **Expose as REST**.

### Video Preview

Watch this video on how to enable REST-API for SOA composite, start at 3:25

   [](youtube:50i0b8ry-z8)

## **STEP 2**: Review Post workshop

Congratulations you've completed developing the validate payment service using SOA composite app; register it to Oracle Service Bus. You've also enabled the app so it can be invoked using https protocol, REST api.

Salient points about Oracle SOA. It is a platform to address application **integration**, for both cloud SaaS and on-premise. Oracle SOA can be deployed on customer's datacenter, OCI or your choice of IaaS, Cloud provider:

- Companies can develop applications without replacing existing enterprise applications or system of record.
- SOA allows reusing the service of an existing system, alternately building new services from existing applications or system of record. It can provide REST API-enabled from existing system or enterprise business service.
- It offers reliable applications in which you can test and debug the independent services as compared to a large set of huge lines of code.

SOA complement Microservices architecture by
- Maximizing service reusability and decoupling
- It can use lightweight protocols like HTTP, REST, or Thrift APIs.
- Quick and easy deployment with docker and Kubernetes
- Strong emphasis on DevOps and Continuous Delivery
- Communicate through an API layer.

Congratulations you've exposed a REST-api end-point from the Oracle Service Bus. You've also completed the Integration-SOA workshop.

<!-- You may proceed to next module in the advance workshop - build the process order application using soa composite. -->

<!-- The advance workshop
Once this workshop is completed. Next step is an advance workshop. In the advance workshop is to build a new order processing system for Avitek, referred to as ProcessOrder.

For the new business requirements in Avitek ‘s new order processing system:
1. Many different types of clients will access it over different protocols and data formats, including mobile devices.
2. With a mobile app launch in progress, next year at the latest, the new order processing system must support access via RESTful API.
3. It must allow existing systems to place orders using xml files and CSV files. These should be processed and fulfilled using the same new order provisioning infrastructure.

To build new order processing composite application, you will use templates. This is a new feature in SOA Suite 12c that can be used in BPEL. As well as Service Bus application. Here are the steps needed for this module:
1. Open e2e-1201-servicebus application and import Pipeline template resources (new feature!).
2. Next steps:
   - Configure ProcessOrder Business Service.
   - Configure Pipeline and Proxy using Pipeline template.
   - Test your application end-to-end.

You will leverage the validatePayment service you built in previous module.
At the end of this module, your solution will look similar to the following process flow diagram:

![](images/3/Module3-SOA.png) -->


 <!-- [Click here to navigate to Module 4](4-add-new-channel-for-ordering.md) -->

## Learn More

To find more detail about Service Bus development using JDeveloper, check out [Oracle Service Bus](https://docs.oracle.com/en/middleware/soa-suite/service-bus/12.2.1.4/develop/getting-started-oracle-service-bus-jdeveloper.html#GUID-669A9F6F-EE55-499A-AF33-D2FF7DB651B4)

Further details about generating REST Services can be found on [here](https://docs.oracle.com/en/middleware/soa-suite/service-bus/12.2.1.4/develop/creating-rest-services-oracle-service-bus.html#GUID-50F6B4C8-D34F-4729-BC8E-7785CEE66DA5)

## Acknowledgements
* **Author for LiveLabs** - Daniel Tarudji
* **Contributors** - Kamryn Vinson, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
