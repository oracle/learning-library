# Deploying an API
An API must be deployed to a gateway.  After successfully deploying the API, it receives requests at the endpoint you've configured and routes successful requests to the backend service. 

## Before you begin
- You have an API Platform environment.  See [environments](../../../../environments/README.md) for details on procuring an API Platform environment.
- You have completed the tutorial [Creating an API Policy Implementation](../create_api)
  - You have the credentials of the user who created the API or a user who has the appropriate grants to *Deploy* or *Manage* the API.
- Your environment has at least one gateway deployed and the user who will deploy the API to the gateway has the  appropriate grant to [request deployments](../../gateways/grants) to that gateway.  Typically a user with the *API Manager* role
- You have the credentials of the user who can [deploy to the gateway](../../gateways/grants).  Typically a user with the *Gateway Manager* role.
  
## Deploy your API
To deploy the API:
1. Log into your API Platform management portal as the user who created the API
1. Choose the API you wish to deploy
1. Click the Deployments tab.
1. Click Deploy API.
1. Choose a Gateway
1. Select Active as the Initial Deployment State.
1. (Optional) Complete the description field in as you like.
1. Click *Deploy*.

Observe what the state of the deployment is in.  Is it Deployed?  Requesting Deployment? Waiting? or Failed?

## Completing the Deployment
If your API is in *Requesting*, then your user has the *Request Deployment to Gateway* grant but not the *Deploy to Gateway* or *Manage Gateway* grant.  If the API is in *Waiting* or *Deployed* then your user has the *Deploy to Gateway* or the *Manage Gateway* grant.  Depending the state, choose the appropriate next steps

### Deployment in *Requesting* state
The attempting to deploy the API has *Request Deployment to Gateway* so the API is in requesting state.  It will not be deployed until a user with the appropriate grant approves the deployment.

#### Approve the Deployment
If you have an API that is requesting deployment (I.E. not Deployed, Waiting or Failed) a user who has the the appropriate grant(s) will have to approve the deployment

1. Log into API Platform as a user who either has the *Manage Gateway* or the *Deploy to Gateway* grant(s)
1. Select *Gateways*
1. Choose your gateway
1. Select the *Deployments* side-tab
1. Select the *Requesting* header-tab
1. Expand the details of the request and review the API Implementation
1. Once you are satisfied that it can be deployed, hover over the request and click the *Approve* button
1. Add comments about your deployment approval and click *Yes*
1. Watch the request transition from *Requesting* to *Waiting* to *Deployed*

### Deployment is in *Waiting* or *Deployed* state
There is no further action.  If it is in *Waiting* then it should transition to *Deployed*.  
 
## Test the API (optional)
Now that the API is deployed, you can invoke it in your favorite REST client.

## Re-deploy an API
An API that has been deployed, can be re-deployed for example, when a change has been made.  There are multiple routes to perform this task depending on the role of the person logged in.

### API Manager
Person who performs the *API Manager* role and who has the deploy grant or manage grant on the API, and has at least the *Request Deployment* grant on the desired gateway 

You can either follow the same steps you did when you [deployed the API](#deploy-your-api) the first time by clicking the *Deploy API* button

or you can select the API in the list of deployments and choose to re-deploy from there.

To re-deploy the API from the list of deployments:
1. Log into your API Platform management portal as the user who created the API
1. Choose the API you wish to deploy
1. Click the Deployments tab.
1. Review the list of API Deployments (make sure to chose the *Deployed* or *Failed* top tab).
1. Choose the existing deployment you wish to re-deploy and hover your mouse over the gateway name.
  1. You will notice three buttons appear labeled *Deactivate*, *Redeploy*, and *Undeploy*
1. Click *Redeploy*
1. Choose the iteration you wish to re-deploy
1. Optionally provide comments about your re-deployment and click *Yes* to confirm your choice

### Gateway Manager
The Person who is a gateway manager and has the grant to deploy a particular API, can follow the same steps as the API Manager.  Instead of navigating to the API and choosing the deployments of that API, the gateway manager, would navigate to the gateway and choose the deployments side-tab.  Then the workflow is the same.

## Conclusion
In this tutorial you learned how to:

- Deploy an API
- Re-deploy an API
- Approve a Deployment Request
