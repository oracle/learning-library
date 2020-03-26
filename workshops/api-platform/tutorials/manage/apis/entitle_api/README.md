# Entitle an API to a Plan
Before an API can be used under a plan, it must be entitled to the plan.  There are a number of paths and personas who may entitle an API.

## API Manager
An API Manager may entitle, or request entitlement of their API to be available under a plan.  For example, the API Manager may entitle to an internal dev/qa plan during the lifecycle, then may later request entitlement to a plan that is used for consumers.

## Plan Manager
A Plan Manager may choose from among a list of APIs that he/she has the *Entitle* grant on

## User with both roles
Some companies may choose to have the same person perform both roles.  If this is the case, then whenever creating an API, a checkbox is included to create a plan with the API to save the number of steps in creating plans, etc.

# Before you begin
- You have either completed [Creating a plan](../../plans/create_plan) or you have the *Entitle* grant to an existing plan
- You have either completed [Creating an API Implementation](../create_api) or you have the *Entitle* or *Manage* grant on an existing API.

# Entitling the API to the Plan
## Ensure you have the appropriate grant(s)
Make sure the API manager has the appropriate grant(s) to entitle APIs to the plan.  If needed, log in as *Plan Manager* and update the grants on the plan to allow the user or group to entitle APIs.

## Log into API Platform Cloud Service
1. Point your browser to the management portal URL as described in your chosen environment. 

> This URL is based on the [environment](../../../environments/README.md) that you have selected but it will take the form of `http(s)://<host>:<port>/apiplatform`

Log in as the *API Manager*

1. Select *APIs* and the name of the API you would like to entitle
1. Select the *Entitlements* side-tab
1. Click *Add Entitlement* button
1. Select the plan you wish to add and click the *Add* button

> Note: If your desired plan does not yet exist, you can follow [Creating a Plan](../../plans/create_plan) to create it and then return here to entitle the API to the plan.

Now your API is entitled to the plan, make sure it is *Active* and *Published* (you will have to publish it)

Publishing controls whether the API shows up in the list of APIs included in the plan.  

An API can be active or inactive.  If the API is inactive, then it won't be able to be called under the plan, until it is re-activated.  This is used for temporarily disabling access.

# Conclusion
In this lab, you learned how to:
  - Entitle an API to a Plan
  - Publish the Entitlement
