# Warranty Claim

## Introduction

NexGen is a company that as a wide variety of products.  As a part of selling products, NexGen offers warranty coverage and on occasion, a customer needs to make a claim for service under the warranty agreement.  NexGen management is growing concerned that as their product line increases, the costs of maintaining the warranty fulfillment are growing considerably.  In a recent strategy session, NexGen identified a number of areas that they could improve their warranty claims management.  

### Identified Pain-points
Here are some of the current pain-points:
1. The claim in-take is manual and increasingly expensive.  Each case may be received via phone, or paper often resulting in requiring personnel to contact the customer to get details.
1. The handling of service requests are spread across manual processes and legacy systems due to acquisitions over the years
1. The company has to maintain a large staff to peform the actual repairs and are finding it increasingly difficult to maintain skill-sets for certain products in its portfolio

### Proposed Solution
Here are some of the key aspects of the solution
- Use a modern service ticketing system.  
  - NexGen selected and implemented **Oracle Service Cloud**.  This makes it easier for all of NexGen sales and service employees to take care of the customer
- Create a modern web interface for customers to be able to submit warranty claims.  This interface should be part of a process management system that has the ability to connect to various legacy back-end systems as well as SaaS applications.  
  - NexGen selected and implemented **Oracle Integration Cloud**.  This eliminates many manual, error-prone steps as well as provides great flexibility for the future
-  Enter into a series of partnerships with service firms who can take care of repairs for certain product lines.  These partners are expected to represent NexGen by completing the repair and updating ticket statuses as if the product were repaired or replaced directly by NexGen
  - After performing extensive research, NexGen chose **API Platform Cloud Service** which is the only solution that provides complete support for the API Management lifecycle
  - Using **API Platform Cloud Service**, NexGen will provide an API to partners to be able to query and update incidents. 
    - This API will give the partner the necessary access without having to add the partner to back-end/SaaS applications like **Oracle Service Cloud**
  - The partner has its own microservice based service ticket system and uses **API Platform Cloud Service** to provide an API for creating, querying, and updating Service Tickets

### Products in the solution
1. Oracle Integration Cloud (Covered in other labs)
  1. Create web-form and connect it to a warranty claim business process (Process Cloud)
  1. Connect to Service Cloud with a REST interface that reshapes the message and provides orchestration where necessary (Integration Cloud)
1. Oracle API Platform Cloud (*Covered in this lab*)
  1. Create an API that interacts with a Microservice (we can initially use a mock-service that is created for us).
    1. The microservice architectural style essentially takes a specific function and encapsulates it into one service.  For example in this case, s ServiceTicket is everything to do with creating, updating, querying a service ticket, but it does not do anything with things like customers, partners, parts, etc.  It maintains its own copy of data, even though the data is also in other systems.
  1. Link the API with the Integration Service.  Whenever a partner updates a service ticket, we can automatically carry that update over to other internal systems to update service requests as if the partner were a user of those internal systems.

This series of learning paths and tutorials will primarily leverage the *API* portion of this scenario but to "see the big picture" here is an overview diagram of the use-case
![](./TicketService.png)

## Implementing the Warranty Claim Ticket Service API
Now that you understand NexGen's use-case above, here are the project requirements below that you received from your project manager.

### Before you begin
As you progress through this use-case, you will need to gain access to Oracle API Platform Cloud Service and Oracle Apiary Cloud Service.  At the point of the tutorial where you will need access, the tutorial will advise you.  

### Choose your Environment
If you are in an instructor-led event, your instructor may guide you on what environment you are using.  If you are accessing this on your own, you will need to make the choice.

To learn more about the available environments, visit [API Platform Demo Environments](../../environments/README.md)

>Note: Whenever there is a link, open it in a new tab (right-click->"Open Link in New Tab").  This way you will maintain your place this lab guide without having to re-orient yourself after completing a task from a linked tutorial, etc


### Design the API
Design is critical as a first step for great APIs.  Collaboration ensures that we are creating the correct design.  We need our API to be well documented and we need to create a mock service in order to rapidly prototype our API
- Follow the [Designing an API](../../tutorials/design/design_api) tutorial, to Design your API

Now you have an API Design that all of your stakeholders clearly understand and have agreed to.  Your engineering teams can leverage the mock service as they develop their respective components.  You know that this will ultimately be made available to partners, so you want to get started on the policy enforcement implementation

### Creating an API Policy Implementation
A great API extends beyond just a simple REST service by providing a managed end-point for only approved users to gain access under a proper SLA.  To create this managed end-point, we will begin with creating an API Policy Implementation


- Follow the [Creating an API Policy Implementation](../../tutorials/manage/apis/create_api) tutorial to create your API.  

>Note: Whenever there is a link, open it in a new tab (right-click->"Open Link in New Tab").  This way you will maintain your place this lab guide without having to re-orient yourself after completing a task from a linked tutorial, etc

At this point, you have a simple API Policy Implementation that provides the *proxy pattern*.  The *proxy pattern* is simply one end-point that receives a request and routes that request to another end-point.  Of course, you only have the API defined, it is not running anywhere! 

- Follow the [Deploying an API](../../tutorials/manage/apis/deploy_api) tutorial to deploy your API
  - Be aware that you may need to apply certain grant(s) to your gateway.  If so, follow the [Managing Access Grants on Gateways](../../tutorials/manage/gateways/grants)


Depending on your needs, an API manager can create the API Implementations and another person will handle the deployment to a gateway.  This makes the most sense in the case of a production gateway where you want to restrict access to deployments.

You now have an API that simply receives the request and routes it to the back-end service.  That back-end service at this point is simply the mock service from Apiary.  Do you know why we would use the mock-service URL?  Oftentimes, there are multiple teams participating in the development process.  There may be front-end developers creating a new mobile app or chatbot, there can be a back-end services and integration team and of course the API team.  If the back-end service is not yet ready, you can start creating the API implementation and point it to the mock-service.

Perhaps you may want to begin with a basic implementation so your front-end developers are already pointing to the API, even before it is fully operational.

#### Test the API
Now that the API is deployed, you can invoke in to test if everything works as expected.

See [Invoking an API](../../tutorials/manage/apis/invoke_api/README.md) if you need help on how to invoke an API

##### Invoke the API
Choose your favorite REST client.  For this exercise, you could simply use a web-browser because it is a simple _GET_ request. 

- Use *Load Balancer URL* (see [Invoking an API](../../tutorials/manage/apis/invoke_api/README.md) for how to get the Load Balancer URL if you don't already know how to do this)
  - _Example: http://`<host>`:`<port>`/ticketService/1/tickets_
- Verb: GET
- Headers (optional):
  - Accept: application/json
- Send the request to the API

Because you have not applied any policies, the request is passed to the backend service without further validation.  This is simply the “proxy pattern”. You should have received a response similar to the following. 

```json
        {
              "_items": [
                {
                  "customer": "ACME Corp",
                  "status": "Resolved",
                  "product": "Widget",
                 "_id": "589a3774ebee507f7268bcff",
                 "_updated": "Tue, 07 Feb 2017 22:05:38 GMT",
                 "summary": "Customer reports the widget stopped working",
                  "_links": {
                    "self": {
                      "href": "tickets/589a3774ebee507f7268bcff",
                      "title": "Ticket"
                    }
                  },
                  "_created": "Thu, 01 Jan 1970 00:00:00 GMT",
                  "ticketID": "45001",
                  "_etag": "bd584d9a460eabdc979e428e1e0220923b0c5793",
                  "subject": "Widget stopped working"
                },
                {
                  "customer": "ACME Corp",
                  "status": "Unresolved",
                  "product": "Widget",
                  "ticketID": "45002",
                  "_updated": "Tue, 07 Feb 2017 21:44:21 GMT",
                  "summary": "Customer reports the widget stopped working",
                  "_links": {
                    "self": {
                      "href": "tickets/589a3fb534605c000176ef5f",
                      "title": "Ticket"
                    }
                  },
                  "_created": "Tue, 07 Feb 2017 21:44:21 GMT",
                  "_id": "589a3fb534605c000176ef5f",
                  "_etag": "cfe52a36fa7a1c738acc994f6e49a8f3f86ce4bf",
                 "subject": "Widget stopped working"
                },
                {
                  "customer": "ACME Corp",
                  "status": "Unresolved",
                  "product": "Widget",
                  "ticketID": "45002",
                 "_updated": "Tue, 07 Feb 2017 21:44:37 GMT",
                  "summary": "Customer reports the widget stopped working",
                 "_links": {
                   "self": {
                     "href": "tickets/589a3fc534605c000176ef60",
                     "title": "Ticket"
                   }
                 },
                  "_created": "Tue, 07 Feb 2017 21:44:37 GMT",
                  "_id": "589a3fc534605c000176ef60",
                  "_etag": "dbcf344b1bcaf9fc6781846ed944d147a875394c",
                  "subject": "Widget stopped working"
                },
               {
                 "status": "Resolved",
                  "_updated": "Tue, 07 Feb 2017 21:57:59 GMT",
                  "_links": {
                    "self": {
                     "href": "tickets/589a4133fbcb600001ac564b",
                      "title": "Ticket"
                   }
                 },
                 "_created": "Tue, 07 Feb 2017 21:50:43 GMT",
                 "_id": "589a4133fbcb600001ac564b",
                 "_etag": "a8706300f0a38c1d6aa871901475d2f7a9e29e1d"
               },
               {
                "customer": "Smithers Corp",
                "status": "Unresolved",
                "product": "Idea tablet",
                "ticketID": "45003",
                "_updated": "Sun, 12 Feb 2017 21:28:52 GMT",
                "summary": "When powering up unit, the display is blank",
                "_links": {
                 "self": {
                    "href": "tickets/58a0d394e0577b0001bcc981",
                    "title": "Ticket"
                    }
                 },
                 "_created": "Sun, 12 Feb 2017 21:28:52 GMT",
                 "_id": "58a0d394e0577b0001bcc981",
                 "_etag": "7a898301b641f1f28dbcf69a6c0dfadf292d6861",
                 "subject": "Display blank"
               }
             ],
              "_links": {
               "self": {
                 "href": "tickets",
                "title": "tickets"
              },
              "parent": {
                "href": "/",
                "title": "home"
              }
            },
             "_meta": {
               "max_results": 25,
               "total": 5,
              "page": 1
             }
            }
            
```
 
> Extra Credit: Find the analytics that will show your call.  Log in as the API Manager, choose the API and click the analytics side-tab.  Sign in as the gateway manager, choose the gateway and click the the analytics side-tab.  What are some of the differences between the analytic views for the gateway manager vs. the api manager?
 
### Add and Configure Policies to your API
Policies in API Platform Cloud Service serve a number of purposes. You can apply any number of policies to an API definition to secure, throttle, limit traffic, route, or log requests sent to your API. Depending on the policies applied, requests can be rejected if they do not meet criteria you specify when configuring each policy. Policies are run in the order they appear on the Request and Response tabs. A policy can be placed only in certain locations in the execution flow. This lab explicitly indicates where you should place each policy.

In these exercises, you will apply the following policies: 

- Security
  - Key Validation (_Draft_)
- Traffic Management
  - Application Rate Limiting (_Draft_)
- Interface Management
  - Header Validation
  - Interface Filtering
- Other
  - Groovy Script

> Note: You apply the key validation and application rate limiting policies as **Draft** here. You activate them later in the lab. These require that you create and register an application, which is described in a later section.

Believe it or not, you have already applied policies!  The *API Request* and the *Service Request* are policies so you should already be familiar with the general steps of applying a policy.  Here we are going to provide you with the policies and the configuration values you should use.  See if you can make your way through without having to refer to the examples.  Don't worry though, if you get confused, then the examples should help you through.

If you are not already at the *API Implementation*
- Log into API Platform as *API Manager*
- Select *APIs*
- Choose your API
- Click the *API Implementation* side-tab

> Note: you have policies on the right-hand side that are collapsed in groups.  You can expand the groups to see the policies.

To apply a policy
- Hover your mouse over that policy in the right-hand list and click *Apply*
- Complete fields in the wizard which may be multiple panels.
- When you have your policy configured and are satisfied you can click *Save* or *Save as Draft*
  - *Save* saves the policy entry
  - *Save as Draft* saves it, but it won't be active until you return and *Save* it

Now, let's apply policies to this API

#### Security
Beginning with security, we are going to configure a *Key Validation* policy.  However, we are going to save it as draft at this point because we want to have it in our API, but not yet enforcing requests.  This allows us to work with our implementation and collaborate with others before our changes become active.  See if you can add a *Key Validation* policy that satisfies the requirements below.

##### Key Validation (Draft)
- Key Delivery Approach: Header
- Key Header: app-key

*Apply as Draft*

#### Traffic Management
A great API makes sure that no one consumer abuses the API.  We want to apply an *Application Rate Limiting* policy which simply controls the number of requests any one application can make within a time-period.  Since we are not yet activating the *Key Validation* policy, we will save this one as draft also.

##### Application Rate Limiting (Draft)
- Place after the following Policy: Key Validation
- Rate Limit Per Application: 10
- Time Interval: Minute

*Apply as Draft*

#### Interface Management
Sometimes we need to make sure the request contains a certain header, or ensure that header is within a certain value range.  We can apply the *Header Validation* policy.  Make sure we validate the header only after the *Key Validation* and the *Application Rate Limiting* policy.  This policy is not related to an application, so we can go ahead and apply it once we have configured it.

##### Header Validation
- Place after the following Policy: Application Rate Limiting
- PASS request if ANY of the following header conditions are met
- tenant-id >= 1

*Apply* the Policy

> Now is a good time to click *Save*

Take a moment to review your implementation so far.  Notice the difference between the *Key Validation*, *Application Rate Limiting* and *Header Validation* policies in your API?  The first two should have a dotted line indicating that they are saved as draft.

###### Extra Credit
Go ahead and re-deploy your API.  Follow [Deploying an API](../../tutorials/manage/apis/deploy_api) if you need a reminder of how to do this.  Once deployed, or requesting deployment, look at the API Deployment from the gateway perspective.  Expand the API deployment.  Do you see the policies that are in draft?
 
##### Interface Filtering
Apply the *Interface Filtering* policy, which is used to filter requests based on the resources and methods specified in the request. Here, you’ll configure this policy to pass GET requests to one resource, /tickets (which returns all tickets) but reject any other type of request.

- Place after the following Policy: Header Validation
- *Pass* the request if the resource and method combination is listed below
  - Condition 1
    - Resources: /tickets
    - Methods: GET
    
*Apply* the Policy

#### Other
##### Groovy Script
The Groovy Script policy opens up many opportunities to add functionality when a policy does not yet exist.  In this exercise, we will add a very simple Groovy script to see how this policy works.  Our script is very simple for the purposes of our exercise and it is as follows:
```
if (context.apiRequest.getHeader("Content-Type") == null)
    context.serviceRequest.setHeader("Content-Type", "application/json")
```

Add the groovy policy as follows:
- Place after the following Policy: Interface Filtering
- Enter the groovy script above.

*Apply* the policy

*Save* your API 
  
Go ahead and re-deploy your API with your new changes.

### Invoke the API
Now that you have successfully added policies to your API, you can send requests to ensure the policies work as intended.  You have already invoked your API, so return to your favorite REST client and invoke the API again.  You can revisit the [Invoke the API](#invoke-the-api) portion of this lab.
  
This time when you invoke the API, the request is rejected with a _Bad Request_ message. Why? Because of the header validation policy, you need to include a tenant-id header with a value of 1 or greater.

In your REST client, add the following request header

- Name: tenant-id
- Value: 1

You should now get a response like you did in the [Invoke the API](#invoke-the-api) tutorial

Now, let's try calling a different resource

In your REST client, replace *tickets* with *partners* in your URL and send the request again. 

If you configured your Interface Filtering policy, you should have received the following:
The request is rejected with a *Method not allowed* message. Why? Because of the interface filtering policy, requests to this resource are rejected. The policy rejects requests to any resource other than /tickets*. This is designed to protect the underlying API from callers trying to call resources you don’t intend to expose.

### Publish the API
Follow [Publishing an API](../../tutorials/manage/apis/publish_api) to publish your API

- When selecting your end-point, be aware if you are using a shared environment, you may need to modify it to keep it unique.

### Creating an API Plan
Now your API is published to the developer portal, consumers can learn about it, but it needs to be entitled to a plan in order for consumers to register to use it.

API Plans represent the intersection of APIs and Applications.  Both the API and the Application are entitled to a plan.  

Before we can entitle an API, we need the *Service Manager* to create the plan.

> Note: If you are using the *Demo/Training* environment, you can skip this step and just choose *Developer Plan* when you entitle the API.  You of course can create your own plan, but you would need to make sure you provide the sequence like you do with API names, etc.

Follow [Creating a Plan](../../tutorials/manage/plans/create_plan) to create a new Plan for your APIs.

### Entitle the API to a plan
When you added the *Key Validation* policy (in draft), you completed the initial step to control access to the API by requiring application(s) to be entitled to call the API.  Later, you will activate that policy requiring your consumers identify their calls with a registered application in order to call your API.  That API must be entitled with a plan and the application will also be entitled with to a plan that entitles the API.  The the association of Applications to APIs are accomplished through plans.

Entitling applications to call APIs, requires two primary tasks.

1. Create an (or select an existing) API Plan
  - To create a plan, you need to have the *PlanManagers* role.
  - To select an existing plan, the plan manager needs to have given you the *Entitle* grant
1. Create an (or select an existing) application and entitle that application to the plan
  - As an *API Manager* or an *App Developer* you can create applications.
  
Follow [Entitle an API to a Plan](../../tutorials/manage/apis/entitle_api) to entitle your API to *DeveloperPlan*

#### Register App
As the *API Manager*, select the *Applications* menu.

1. Create an Application following the provided naming convention

Click on the created app, and click on the left-hand *Subscriptions* tab.  Click *Subscribe to Plan* to add an *Entitlement* for the *DeveloperPlan*

Capture the Application Key for later use.

#### Request Register App Grant (informational--no activity in this section)
Like the Register App grant, the Request Register App grant is issued to Application Developers or API Managers. Users issued this grant can only request a registration. While their request is being reviewed by an API Manager, they cannot use the API. An API Manager must approve the registration request for the runtime key validation policy to approve requests sent to an API using this application’s key.
 
### API Catalog
The Developer Portal provides discovery, learning, and registration for APIs. It is the web page where you subscribe to APIs and get the necessary information to invoke them. 

When you access the Developer Portal, the API Catalog page appears. All the APIs that have been published to the portal are listed.

Get ready to learn about: 

- Discovering APIs
- API Portal
- API Portal Documentation

#### Discover APIs
You can search for an API by entering keywords in the field at the top of the catalog. The list is narrowed to the APIs that have that word in the name or the description. If you enter multiple words, the list contains all APIs with either of the words; APIs with both words appear at the top of the list. If a keyword or keywords have been applied to the list, they appear in a bar at the top of the page. Filters can also be applied to the list. You can also sort the list in alphabetical order or by newest to oldest API.

In this task you sign in as Application Developer User from the previous section. You granted this user the Application Developer role, meaning they are able to view APIs in the catalog and register them to applications without requesting approval.

To log in as Application Developer User:
- In an incognito window, a private browser session, or an entirely different browser, navigate to the developer portal for your [environment](../../environments) This is the Developer Portal UI. You use incognito mode as the session persists between the Management Portal and the Developer Portal if you use the same browser session.

Only APIs that have been published appear in the catalog. If you have not published your API, see [Publish the API](#publish-the-api): To view an API, the Application Developer must also have the View API Details grant or another grant that implies these privileges.
 
##### To discover APIs in the catalog:
- From the API catalog page, enter Ticket, or another query, in the search box at the top, and then press Enter. All of the APIs matching this query appear.
- To clear the results, in the blue bar below the search field, click the X. You can also click Clear All to clear all the search terms.
- Click +Filters to apply a filter. In the Status section, click Released. This is the default status of an API. If you create APIs with different statuses, those statuses appear as options in this filter list.
- Click Clear All to clear all filters.
- To sort the APIs by creation date, from the Sort by list, click Newest. To sort the APIs by name, from the Sort by list, click Alphabetical.
- API Portal (informational--no activity in this section)
When you select an API from the API Catalog, its API Portal details page appears. This page displays information about an API. You can see the state of an API (Beta, Released, Deprecated, etc), whether you can register to it, any applications that you have already registered to it, registration requests awaiting approval, etc. Overview text describing the API’s basic features also appears on this page.
- API Portal Documentation (informational--no activity in this section)
The Documentation tab embeds the documentation reference you specified on the General Settings tab when you created the API. Depending on how you configured this, the documentation appears inside a frame as a website, as text, or the documentation on Apiary.

### Connect your API to the actual REST back-end service
Up until now, your API has simply invoked the mock-service, but now it is time to connect it to the actual REST back-end service.  Here you have a few options.

1. If you are using the *Demo/Training Environment* then you can simply use the existing *ServiceTicketImpl* service.
1. If you are using a different environment, or you simply want to explore the role of the *Service Manager*, then you can follow [Creating a Service](../tutorials/manage/services/create_service/README.md)

> Note: [Creating a Service](../tutorials/manage/services/create_service/README.md) will reference the option to deploy your own instance of the microservice.  If this is your first time using this lab, we recommend that you simply use the hosted version of the microservice.

1. Open your API and choose the *Implementation* side-tab.
1. Edit the *Service Request* policy
1. Switch the *Service* radio-button to *Select Existing* and click the *Select Service >* button.
1. Choose the service you want to use.

Make sure to save your API.

### Re-deploy your API
Go ahead and re-deploy your API.  Visit [Deploying an API](../../tutorials/manage/apis/deploy_api) if you need a refresher.

### Invoke your API
It is a good idea once your API is re-deployed to invoke it so you can confirm that everything is working properly with the back-end service.

### Activate Draft Policies
Now that you have confirmed everything is working, Return to your API Implementation, edit the draft policies and save them.  Then save your API.

### Re-deploy your API
You need to re-deploy your API to activate the key validation and application rate limiting policies you just added.  Visit [Deploying an API](../../tutorials/manage/apis/deploy_api) if you need a refresher.

### Invoke your API 
Now that you have successfully created an application and gathered your app keys, you’ll send requests to the API to ensure the policies work as intended.

Re-send your previous API Request

The request is rejected with a 401 error. Why? Because of the key validation policy, you need to include a valid application key in an app-key header sent with the request.

Add to the headers or your request the app-key you captured from the application you linked with this API
 
Send your request again.

You should now see the results with an HTTP 200 OK

1.	Now, try clicking Send repeatedly until you hit the rate limit

Once you hit the rate limit, you should then get rejections advising you that you are over your limit.

## Analytics
API Platform Cloud Service includes analytics that you can use to determine how, when, and why your APIs are being used; review how often and why requests are rejected; and track trends in this data over time.

Note that in the initial release of API Platform Cloud Service, analytics are per object (per API, per gateway, or per application). Org-level analytics are planned for a future release.

Get ready to learn about:
- API Analytics
- Gateway Analytics

### API Analytics
In this section you’ll view five of the charts available to API Managers and preview the additional charts that will be available in the first version of the product.

To view analytics for your API:
1. Back in the Management Portal click the Analytics tab for your API. The Analytics tab is the last on the left.
1. If it is not already selected, click the General page. The General page displays the Request Volume, Response Time, Payload Size, and Requests by Resource charts. The other charts are displayed on the Applications and Errors and Rejections tabs.

The time controls on this page allow you to retrieve data for a specific period of time. By default, data from today (from 12:00AM to the current time) appears. Click Last 24 Hours to display data for a period 24 hours previous to the current time. If you want to display data for a different period, you can:
- select a pre-defined time period (current hour or week, specific month or year, last minute, hour, etc.) from the Other list, or
- click the time interval below the Other list to manually specify a start time, an end time, and a date.

To return data for a specific gateway, enter the name(s) of the gateways to which the API is deployed. Analytics data is aggregated for all of the selected gateways; removing a gateway from this field also removes the data from the Analytics tab. You can further filter data by application. In the Applications field, you can enter the name(s) of applications registered to this API to display data for only these applications. Requests from unregistered applications are also collected; you can view data for all of these requests by selecting Unknown Applications from this list.

Changes to any of these filters (time, gateway, or application) affects all of the data on the Analytics tab.

#### Request Volume Chart
The request volume chart displays how many requests an API deployed to a gateway received. For a given time, you can configure the chart to display all requests, only successful requests, only rejected requests, or only errored requests.

The request volume chart provides a general overview of the traffic an API is receiving, how the requests are trending over time, and the overall health of the traffic in terms of rejected requests and other errors. 

#### Response Time Chart
The response time chart displays, in milliseconds, the range of round-trip request and response times for a selected API. The ranges, represented by a gray bar, indicate the shortest and longest response times during the indicated time period. The median round-trip time is indicated by a blue bar in the range for a time period. For a given time, you can configure the charts to display the range of round-trip calls, the range of time spent in the API layer, and the range of time spent in the service layer.

The response time chart gives API Managers an idea of the ranges and medians of response times for requests, how these trend over time, and how response times are split between the API and service layers.
 
#### Payload Size Chart
The Payload Size chart displays the size of the payloads sent with each request. You can filter this chart to display the size of request or response payloads.

- You didn’t send any requests with response payloads; click Response to view the size of response payloads sent from the backend services.

#### Requests by Resource Chart
The Requests by Resource chart, at the bottom of the General page, displays the number and distribution of requests to your service’s resources.

This chart the resources. For each resource, this chart displays:

- The total number of requests to each resource
- The percentage (of total requests) of requests to each resource
- The total number of policy rejections for requests to each resource
- The percentage (of total rejections) of rejected requests to each resource
- The total number of service errors for requests to each resource
- The percentage (of total errors) of errored requests to each resource
 
You should not have received any errors; these columns in the table should be blank. If you sent requests to other resources, an entry for each requested resource also appears here.

#### Requests by Application Chart
1. Click the Applications page to view the Requests by Application chart.

The Requests by Application chart displays the number and distribution of requests from each application, identified by the app key passed with each request. This chart displays two entries: one for the application you created in the lab, and another for the Customer Mobile App you registered to your API. For each resource, this chart displays:

- The total number of requests from each application
- The percentage (of total requests) of requests from each application
- The total number of policy rejections for requests from each application
- The percentage (of total rejections) of rejected requests from each application
- The total number of service errors for requests from each application
- The percentage (of total errors) of errored requests from each application

 
You should not have received any errors; these columns in the table should be blank. If you sent requests from other applications, an entry for each application also appears here.

#### Rejection Rate Chart
1. Click the Errors and Rejections page to view the Rejection Rate chart.

The Rejection Rate chart displays the number of requests to your API rejected by policy conditions. You sent a couple of rejected requests in the lab; this chart should display a few rejections. 

You can filter this chart to display all rejections, rejections from policies in the request flow, rejections from policies in the response flow, and rejections from the backend service. You can also filter the chart to display only rejections from specific policy types. Select Header Validation from the Select a policy list. This displays only rejections by the header validation policy.

#### Rejection Distribution Chart
The Rejection Distribution chart displays the number and distribution of rejections of your requests. You send a couple of rejected requests in the lab; this chart should display a few rejections.

You can filter this chart to display all rejections, rejections from policies in the request flow, rejections from policies in the response flow, and rejections from the backend service. Select Show Policy Types to show the number of rejections for each policy type; select Show Policy Instances to show rejections from each instance of a policy. For example, if you have multiple header validation policies, selecting Show Policy Types displays all header validation policy rejections as a single data point. If you select Show Policy Instances, rejections from each of the header validation policies are displayed as separate data points.

#### Other Analytics Charts (informational--no activity in this section)
These charts are also available in API Platform Cloud Service:

- Error Rate: Displays number of occurrences and percent of total errors over time, per API. You can filter this chart to display all errors, policy errors, service errors, or a specific error. API and Gateway Managers can use this to see how many errors have occurred and the ratio of errored requests to total request volume.
- Error Distribution: Displays the number of occurrences and percent of total errors, per API. You can filter this chart to display all errors, policy errors, or service errors. API and Gateway Managers can use this to see the frequency at which each error occurs.
- Requests by API: Displays the following information, collected for requests on a gateway:
  - API Name
  - # of Requests
  - % of Total Requests (across all resources)
  - # of Rejections
  - % of Rejections
  - # of Errors
  - % of Errors
Gateway Managers can use this to see which APIs are driving traffic to their gateways.
- Application Error Distribution: Shows the codes, count, and percentage (of total) of errors received, per API. Application Developers can use this to see the distributions of errors generated by their requests.
- Application Error Rate: Shows the number of errors or percentage (of total) of errors out of total requests, per API. You can filter this chart to display all errors or a specific error. Application Developers can use this to see how many errors, per application, their requests generate over time.

### Gateway Analytics 
In this version of API Platform Cloud Service, the charts available on the Gateway Analytics tab are the same as those available on the API Analytics tab. The difference is that the data displayed on the Gateway Analytics tab represents all APIs deployed to a gateway (unless you apply filters); the data displayed on the API Analytics tab represents only the selected API.

To view analytics for all APIs deployed to a gateway:
1. Click the Gateways tab.
1. Click Development Gateway.
1. Click the Analytics tab.

## Conclusion
Throughout this scenario, you learned how to:
1. Design an API
1. Create an API Policy Enforcement Implementation
1. Document and Publish an API for consumption
1. Add an API into an appropriate API Plan

Congratulations on finishing this part of the lab!  Now let’s go have some fun!

## Extras
We encourage you to keep learning!  Visit the [tutorials](../../tutorials) to discover what other exercises you can try out!
