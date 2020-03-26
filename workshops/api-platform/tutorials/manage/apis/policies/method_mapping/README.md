# Method-mapping Policy

Method mapping allows us to handle differences between the front-end API and back-end service.  If we were to design everything from scratch, we might not need method-mapping, but oftentimes, one or more back-end services may already exist.  Using the method-mapping policy, we can handle the differences of our back-end service to achieve the behavior desired in the design of our API.

## Before you begin

1. You have an API Platform environment.  See [environments](../../../../environments/README.md) for details on procuring an API Platform environment.
1. You have completed the tutorial [Creating an API](../../create_api)
1. You have completed the tutorial [Creating a Service](../../../services/create_service)
  1. You will need to make sure you have [set up your own instance](../../../docker/compose/ticketService) of the ticketService
1. You have updated your API to use your service in the *Service Request* policy

## Exposing a query as a resource
Our back-end service that provides the TicketService has an interesting way of performing queries for the back-end data.  It turns out that it is very much a data-centered model that simply allows the caller to issue a query following the document structure.

To understand this, let's compare and contrast query approaches.

### Typical Query in a URL
[RFC3986](https://tools.ietf.org/html/rfc3986#section-3.4) defines a query string indicator as the '?' in a URL.  For example: [GET] `http://<host>:<port>/tickets?status=Unresolved`.  Here we ar performing a simple GET request for tickets where the status is *Unresolved*  In a URL, the '?' indicates the beginning of a query, typically in a key=value pair.  If we have multiple queries, we can delimit them with an '&'

Another common way is to structure our resource to provide queries in a somewhat hierarchical structure.  For example, we could have a URL like `http://<host>:<port>/tickets/Resolved` or `http://<host>:<port>/tickets/Unresolved` where the resource provides the filtering criteria 

### Query approach of our microservice
Our microservice, simply uses the [Eve](python-eve.org) framework which is a nice way to create a robust REST service with Python, Flask, MongoDB among other technologies.  [Eve](python-eve.org) does a great job managing the types of queries that can be used, but for the purposes of our training, let's assume that the developer of the service has it wide open to any query and we do not have control to change it.

Furthermore, [Eve](python-eve.org) has a novel way of specifying the query that may confuse our API Consumers.

Let's say for the purposes of our lab, our API consumers will filter by appending `/resolved` or `/unresolved` to the URI, but our underlying microservice does not understand this.

Our underlying microservice can filter on any data-field by simply including a query in our URL like the following example `http://<host>:<port>/tickets?where={"status":"Resolved"}`  Now you may look at this and say that is an invalid query, but it is indeed valid.  It is just not quite the shape we want for our API consumers.

## Convert a Resource to a Query
### Log into API Platform Cloud Service
1. Point your browser to the management portal URL as described in your chosen environment. 

> This URL is based on the [environment](../../../environments/README.md) that you have selected but it will take the form of `http(s)://<host>:<port>/apiplatform`

1.  Log in as a user that has the *API Manager* role.  

### Edit your API
1. Make sure you are on the *APIs* menu.  You should see *APIs* in the upper left-hand side as well as a *Create API* button on the right-hand side.  If you don't see this, select the menu button on the left and then select *APIs*
 
1. Search for your API that you have already created.
  1. Once you locate your API in the list of APIs.  Go ahead and click on the API name to continue editing it.
1. Expand the *Interface Management* group in the *Available Policies* and choose the *Method Mapping* policy

You will add two conditions to this policy:
- Condition 1:
  - API:
    - Resources: `resolved`
    - Methods: `GET`
  - Service:
    - Resource: `/`
    - Method: `Keep Same`

Expand the *Query Parameters* on *Condition 1*

Under *Service* set the parameter to be `where={"status":"Resolved"}`  Leave the API side blank.

Add a 2nd condition.  Following the pattern above, set the second condition to send a query for `Unresolved` tickets whenever the API receives a resource of `unresolved`

Click *Apply*
Make sure to save the API and then deploy (or re-deploy) it.  If you need a refresher on deploying an API, visit [Deploying an API](../../deploy_api)

## Conclusion
In this tutorial you learned how to:
  - Use the method-mapping policy to handle unique requirements of a back-end service