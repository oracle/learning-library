# Granting Access to Gateways
Gateways are where APIs actually run.  Users that have the *GatewayManager* role are primarily responsible for the monitoring and management of gateways.  Through a robust grants system, API Platform controls access to gateway.  Grants determine whether a user or groups of users can view, update, deploy to, or request an API deployment to a gateway.  Grants also control whether a user that has the *GatewayManager* role can manage a particular gateway.

## Before you begin
> Note: If you are using a shared environment and/or tenant then you may neither have the necessary grant(s) on any of the gateway(s).  If you do not have the appropriate grants, then contact the administrator, or select one of the environment options where you are the administrator.

### Required
- You have an API Platform environment.  See [environments](../../../environments/README.md) for details on procuring an API Platform environment.
- Your environment has at least one gateway deployed and your user has *Manage Gateway* grant.
- You have an *API Manager* user who is not presently granted access to the gateway.

### Optional
  - To test out the *Deploy to Gateway* or the *Request Deployment to Gateway* grant, you will need an API created.  If you do not already have an API created, you can follow the [Creating an API Policy Implementation](../../manage/create_api) lab to create an API 

## Concept Check
1.  Log into your API Platform Management Portal as the user with the *API Manager* role
  - Do you see a *Gateways* option in the menu?
  - If you select *Gateways*, do you see any gateways in the list?
  - If you do see *Gateways*, are you able to deploy an API to those gateway(s)?
  - If you do not see *Gateways*, does that mean they do not exist?

## Issuing Gateway Grants
1. Log into API Platform as a user with the *GatewayManager* role.  See [environments](../../../environments/README.md)
1. Select the Development Gateway (or whatever gateway you have deployed)
1. Click the *Grants* tab
1. Take a moment to review all of the grants.  For each grant, click on the header-tab to view the list of users who are assigned that grant
  - Manage Gateway: Gateway Manager users issued this grant are allowed to manage API deployments to this gateway and manage the gateway itself.
  - View All Details: API and Gateway Manager users issued this grant are allowed to view all information about this gateway.
  - Deploy to Gateway: API and Gateway Manager users issued this grant are allowed to deploy or undeploy APIs to this gateway.
  - Request Deployment to Gateway: API Manager users issued this grant are allowed to request API deployments to this gateway. Requests must be approved by a Gateway Manager.
  - Node Service Account: Gateway Runtime service accounts are issued this grant to allow them to download configuration and upload statistics.
1. Click the grant name that you want to assign.
  1. Click Add Grantee.
  1. The Add Grantee dialog appears.
  1. From the Add Grantee dialog, select the user(s) or group(s) to which you want to issue the grant. You can select multiple users and groups.
    - Suggestion: Choose your user that has the *API Manager* role and grant that user access to *request deployment* to the gateway.

> You cannot select users or groups that already have this grant; they are greyed out in the Add Grantee dialog.

Click Add.
The user(s) or group(s) are issued the gateway grant you chose.

## Testing the Grant
1. Sign into the management portal as the user who has the *API Manager* role
1. Try the steps in the Concept Check, what changed?
1. Request deployment of your API to the gateway.
  - What is the state of your request?  Is it *Requesting*, *Waiting* or *Deployed*
  
## Approve the Deployment
If your API is in *Requesting* state, then it will not deploy until a user with the *Deploy to Gateway* reviews your request and approves it.

1. Log into API Platform as a user who either has the *Manage Gateway* or the *Deploy to Gateway* grant(s)
1. Select *Gateways*
1. Choose your gateway
1. Select the *Deployments* side-tab
1. Select the *Requesting* header-tab
1. Expand the details of the request and review the API Implementation
1. Once you are satisfied that it can be deployed, hover over the request and click the *Approve* button
1. Add comments about your deployment approval and click *Yes*
1. Watch the request transition from *Requesting* to *Waiting* to *Deployed*

## Conclusion
In this lab you learned the following:
  - How grants control access to a gateway
  - How to assign a grant to a user
  
### Troubleshooting
Depending on your environment, you may encounter a different result
- API does not transition to *Requesting*
  - Your user may have the *Manage Gateway* or *Deploy to Gateway* grant so any deployment would simply progress from *Waiting* to *Deployed*
- API stuck in *Waiting*
  - Check your gateway node.
    - TODO: Add Gateway Node Install/manage tutorial
- API transitioned to *Failed*
  - Expand the failed request to see the error

## Learn more
To learn more about API Gateway Grants, read [Managing Gateway Grants](https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfad/managing-gateway-grants.html)