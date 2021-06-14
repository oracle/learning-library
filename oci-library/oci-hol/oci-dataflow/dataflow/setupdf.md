
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

1. Before running the application in the Data Flow service, create two storage buckets that are required in object storage.

    * From the OCI Services menu, click `Storage` and then click `Buckets` under Object Storage

       ![](../images/OBJECT-STORAGE001.png " ")

    * Click `Bucket`
       ![](../images/BUCKET001.png " ")

      **NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

    * A bucket to store the logs (both standard out and standard err) for every application run.Create a standard storage tier bucket called `dataflow-logs` in the Object Store service.

      ![](../images/CREATEBUCKET001.png " ")

    * A data warehouse bucket for Spark SQL applications. Create a standard storage tier bucket called `dataflow-warehouse` in the Object Store service.
        ![](../images/DATAWAREHOUSEBUCKET.png " ")

## **STEP 2**: Identity: Policy Set Up

A user's permissions to access services comes from the _groups_ to which they belong. The permissions for a group are defined by policies. Policies define what actions members of a group can perform, and in which compartments. Users can access services and perform operations based on the policies set for the groups of which they are members.

We'll create a user, a group, and policies to understand the concept.


1. **User Policies** : Data Flow requires policies to be set in IAM to access resources in order to manage and run applications. We categorize the Data Flow users into two groups for clear separation of authority administrator and users:

    * From the OCI Services menu, click `Identity and Security` and in identity click `Group`

        ![](../images/Groups001.png " ")

    * Create a group in your identity service called `dataflow-admin`

        ![](../images/DataflowAdminUser.png " ")

    * Click on your new group to display it. Your new group is displayed.Add users to the groups

        ![](../images/AddUsertoDFAdminGroup.png " ")

        ![](../images/AddUsers.png " ")

    * From the OCI Services menu, click `Identity and Security` and in identity click `Policies`

        ![](../images/Policies001.png " ")    

    * Create a policy called `dataflow-admin` in your `compartment` and add the following statements:

       ![](../images/CreateDFAdminPolicy.png " ")  

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

      ![](../images/DFUserGroup.png " ")

    * Create a policy called dataflow-users and add the following statements:

      ![](../images/dfcreateuserspolicies.png " ")

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

