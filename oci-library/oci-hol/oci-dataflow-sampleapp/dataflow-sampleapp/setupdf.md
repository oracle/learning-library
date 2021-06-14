
## Setting up Oracle Cloud Infrastructure Data Flow

This tutorial introduces you how to setup Oracle Cloud Infrastructure Data Flow.

*Estimated Lab Time*: 20 minutes

### Objectives

In this lab you will learn about Oracle Cloud Infrastructure Data Flow, what it is, what you need to do before you begin using it, including setting up policies and storage, loading data, and how to import and bundle Spark applications. Before you can create, manage and execute applications in Data Flow, the tenant administrator (or any user with elevated privileges to create buckets and modify IAM) must create specific storage buckets and associated policies in IAM. These set up steps are required in Object Store and IAM for Data Flow to function. This lab will set the foundation for future labs to follow.

  ![](../images/DF_Overview1.png " ")

### Prerequisites

Before you Begin with Data Flow lab, you must have:

* An Oracle Cloud Infrastructure account. Trial accounts can be used to demo Data Flow.
* A Service Administrator role for your Oracle Cloud services. When the service is activated, Oracle sends the credentials and URL to the designated Account Administrator. The Account Administrator creates an account for each user who needs access to the service.
* A supported browser, such as:
    * Microsoft Internet Explorer 11.x+
    * Mozilla Firefox ESR 38+
    * Google Chrome 42+
* Familiarity with Object Storage Service.



## **STEP 1**: Object Store: Setting Up Storage

1. Before running application in Data Flow service, create two storage buckets that are required in object storage. If you   are 

     * A bucket to store the logs (both standard out and standard err) for every application run.Create a standard storage tier bucket called `dataflow-logs` in the Object Store service. The location of the bucket must follow the pattern:

       ```
       <copy>oci://dataflow-logs@<Object_Store_Namespace>/</copy>
       ```

     * A data warehouse bucket for Spark SQL applications. Create a standard storage tier bucket called `dataflow-warehouse` in the Object Store service. The location of the warehouse must follow the pattern:

      ```
       <copy>oci://dataflow-warehouse@<Object_Store_Namespace>/</copy>
      ```
## **STEP 2**: Identity: Policy Set Up

1. **User Policies** : Data Flow requires policies to be set in IAM to access resources in order to manage and run applications. We categorize the Data Flow users into two groups for clear separation of authority administrator and users:

    * Create a group in your identity service called `dataflow-admin` and add users to this group.

    * Create a policy called `dataflow-admin` and add the following statements:

      ```
      <copy>
      ALLOW GROUP dataflow-admin TO READ buckets IN TENANCY
      </copy>
      ```

      ```
      <copy>
      ALLOW GROUP dataflow-admin TO MANAGE dataflow-family IN TENANCY
      </copy>
      ```
      ```
      <copy>
      ALLOW GROUP dataflow-admin TO MANAGE objects IN TENANCY WHERE ALL
          {target.bucket.name='dataflow-logs', any {request.permission='OBJECT_CREATE',
          request.permission='OBJECT_INSPECT'}}
      </copy>
      ```
    * Create a group in your identity service called dataflow-users and add users to this group.
    * Create a policy called dataflow-users and add the following statements:

      ```
      <copy>
      ALLOW GROUP dataflow-users TO READ buckets IN TENANCY
      </copy>
      ```
      ```
      <copy>
      ALLOW GROUP dataflow-users TO USE dataflow-family IN TENANCY
      </copy>
      ```
      ```
      <copy>
      ALLOW GROUP dataflow-users TO MANAGE dataflow-family IN TENANCY WHERE ANY {request.user.id = target.user.id, request.permission = 'DATAFLOW_APPLICATION_CREATE', request.permission = 'DATAFLOW_RUN_CREATE'}
      </copy>
      ```
      *Note: Replace <tenancy> with the name of your tenancy*

2. **Service Policies** : The Data Flow service needs permission to perform actions on behalf of the user or group on objects within the tenancy.To set it up, create a policy called `dataflow-service` and add the following statement:

      ```
      <copy>
      ALLOW SERVICE dataflow TO READ objects IN tenancy WHERE target.bucket.name='dataflow-logs'
      </copy>
      ```

## Acknowledgements

- **Author** - Anand Chandak
- **Adapted by** -  
- **Contributors** -
- **Last Updated By/Date** -

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/DataFlow). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
