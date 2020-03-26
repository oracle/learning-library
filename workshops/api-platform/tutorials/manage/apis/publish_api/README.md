# Publishing an API
A great API can be discovered by potential consumers.  Publishing the API makes it available in the developer portal for developers who are creating a wide variety of applications.  Developers search for and learn about APIs in the developer portal.  The API Manager typically publishes the API when it is ready for other users to be able to consume it.  Some examples are:

- An API is ready to be made available for general consumption:  This is typically an API in production with all of the work completed.
- An API that is released just to a select group of developers: This is typically an API that is not yet ready for production, but a select group of developers are provided access in order to try the API while it is under development.

In this exercise, you will learn about:
- Configuring the full Developer Portal URL
- Configuring the Overview Text
- Configuring the Documentation Page
- Previewing the Content
- Publishing, Re-Publishing, and Un-Publishing

## Before you begin
- You have an API Platform environment.  See [environments](../../../../environments/README.md) for details on procuring an API Platform environment.
- You have completed the tutorial [Creating an API Policy Implementation](../create_api)
  - You have the credentials of the user who created the API or a user who has the appropriate grants to *Manage* the API.  See [API Grants](../grant_api) if you need to grant access.
  
## Publish your API
To publish the API:
- Log into your API Platform management portal as the user who created the API, or a user that has the *Manage* grant.
- Choose the API you wish to publish
- Click the *Publication* side-tab.

### API Portal URL
- Update the API Portal URL, this serves as the “permalink” for your API’s developer portal page.  Notice that the URL begins with `<not published>`  This is a placeholder that will update to the actual developer portal location.  The value you are providing is the end-point for your APIs developer portal page.  You can use any value you want, but we suggest you just use the name of your API.

### Developer Portal API Overview
- You can provide an overview in markdown or HTML either with a file, URL, or by entering the text directly.  Go ahead and enter a small sample just to see how the overview will display.

### Documentation
- If you have chosen the specification from Apiary under the *Specification* side-tab, then you can simply elect to *Use API Specification as Documentation*.
  - If you did not choose the specification under the *Specification* side-tab but you wish to link it here, you can, as long as your API belongs to your Apiary team.
- You do have the option to *Provide Documentation Separately* which you can follow the same process to include a file, URL or entering the text directly just like you did for the overview.

> Note: If you are using the *Apiary Free* plan, you won't be able to link the specification to your API Implementation.  However, you can include the documentation if your API design is publicly available.  Documentation for APIs created under the *Apiary Free* plan are always publicly available so you can reference the documentation to make it appear in the developer portal.  
>
> To display your documentation, select your API in Apiary, and click the *Documentation* top-tab.  Note the URL that will look something like `https://airport4.docs.apiary.io/#`  
>
> Under *Documentation*, select *HTML* and choose *link*.  Put the documentation URL from your Apiary design into the field that says *Enter documentation link*

#### Concept Check
If we can simply include the documentation link, why do we have the option to link a specification?

> A feature of Apiary teams is to be able to collaborate on APIs among a team, but that you do not want to share with the rest of the world.  When you link the Apiary design in API Platform, you then use API Platform's robust granting system to manage who can access your documentation, ensuring only the right people can learn about and register to use your API.

### Publish to the Portal
Save your changes, then click *Publish to Portal*

Now, you can select the > next to the API Portal URL, to open the APIs developer portal page

You may have to log in, just use your *API Manager* credentials.  You should then see the Portal page for your API which includes your API Blueprint or documentation!
 
#### Publishing, Re-Publishing, and Un-Publishing
Whenever you make changes to the General Settings tab, including updating an API’s description, overview text, or documentation, you must republish for the latest changes to be pushed to the Developer Portal.

Note: API Platform Cloud Service retains only the current iteration of an API in the Developer Portal. When saved, updates to an API (including publishing, republishing, and unpublishing), take immediate effect. When you publish, the most recently saved version API details are pushed to the Developer Portal.

You can un-publish an API from the Developer Portal. If unpublished, Application Developers will no longer be able to discover and subscribe to your API. Requests are still handled by the gateway as usual until the API is deactivated or un-deployed from the gateway.

## Conclusion
In this tutorial you learned how to:

- Provide documentation of your API
- Link to other HTML sources for documentation
- Link your API documentation to your API specification in Apiary
- Publish your API to the consumption portal
