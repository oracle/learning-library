###API Grants

This section provides information and procedures for issuing API grants. Every action a user performs on an object in API Platform Cloud Service is made possible by a grant. Each role is eligible to receive only select grants. This section describes different grants for an API object.

These are the available API grants:
- Manage API
- View API Details
- View API Public Details
- Deploy API
- Register App
- Request Register App

#### Manage API Grant (informational--no activity in this section)
The Manage API grant is available only to an API Manager. It is given automatically to the person who creates an API. Administrators do not specifically need this grant.

The Manage API grant gives an API Manager the right to view and edit API details, deploy or delete an API, and to issue grants to other API Managers.

#### View API Details Grant (informational--no activity in this section)
The View API Details grant allows API Managers and Gateway Managers to view the details of an API in read-only format in both the Management and Developer Portals.

The information available includes general information, implementation, deployed endpoints, users, applications, and analytics. In this lab, the View API Details grant would be given to other employees of the company to allow them to view API implementation details.
6.3: View API Public Details Grant (informational--no activity in this section)
The View API Public Details grant is available to Application Developers. It allows them to view an API’s details page on the Developer Portal. 

This grant does not allow Application Developers to register or to request registration of their applications to this API; the Register App grant is described in a later section.
 
#### Deploy API Grant (informational--no activity in this section)
To allow a Gateway Manager to deploy an API without making a formal request, the API Manager who created the API gives the Gateway Manager the Deploy API grant.

API Managers already have permission to deploy APIs they own due to being issued the Manage API Grant. A Deploy API grant can be given to an API Manager to allow them to deploy an API they did not create.