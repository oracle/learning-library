# Invoke an API
APIs are made to be used by *API Consumers* and your *Application Developers* will ultimately use them with their applications, but you may want to invoke the API to test it out.

First you need to identify how you will invoke your API.  This is a combination of the API Specification, and the end-point, or URL where the API is deployed

## Before you begin
- You have an API Platform environment.  See [environments](../../../../environments/README.md) for details on procuring an API Platform environment.
- You have completed the tutorial [Designing an API](../../../design/design_api) (optional)
- You have completed the tutorial [Creating an API Policy Implementation](../create_api)

## Identify the URL to use
In order to invoke your API, you need to identify the URL.  To do this, you can view the deployment.  You can do this at the API level or the Gateway level depending on the user you are logged in as.

### API Gateway Manager
If you are logged in as a user who manages the gateway, you can view the URL from the Deployments tab of the gateway
1. Select Gateways
1. Select your Gateway
1. Click the *Deployments* left-tab
1. Make sure the *Deployed* top-tab is highlighted
1. Find your API
1. Notice the *Load Balancer URL* and the _copy_ icon next to it.  You can click the _copy_ icon to copy the URL into your buffer

### API Manager
If you are logged in as a user who manages the API, you can view the API URL from the Deployments tab of the API
1. Select APIs
1. Select your API
1. Click the *Deployments* left-tab
1. Make sure the *Deployed* top-tab is highlighted
1. Find the gateway (one API can be deployed to multiple gateways)
1. Notice the *Load Balancer URL* and the _copy_ icon next to it.  You can click the _copy_ icon to copy the URL into your buffer

## Understand how you will invoke your API
Now that you know the address (URL) of the API, you need to know how you should interact with it.  For this you can use the API Design in Apiary (or other documentation).

> When using Apiary, you may see the mock-service end-point.  Make sure you are using the load balancer address of the gateway that you identified in the previous section

## Invoke the API
Choose your favorite REST client.  For this exercise, you could simply use a web-browser because it is a simple _GET_ request. 
- Define the URL to be the *Load Balancer URL* you captured in the previous section, plus the resource.
  - Example: http://'<host>':'<port>'/ticketService/1/tickets 
- Verb: Set the verb according to the API Design (e.g. GET)
- Headers (optional):
  - Your design document will indicate any headers that may be necessary.  Additionally if you are completing this tutorial as part of a tutorial, then you may have guidance from there as well.
- Send the request to the API
