# Identity and Access Managment - __*Crawl*__ 

## Introduction
IAM is the terminology used in OCI to govern and control acccess to resources in your tenancy.

A compartment is a logical construct used to enforce IAM policies, what we're doing here is setting up a clearly defined area __*sandbox*__ so you can see how everything works.

Users go into groups, policy defines what the groups can do.

__*This is the foundation of the framework. Start Here.*__

## IAM __*Crawl*__

The artifacts below will be created with terraform automation:
 
* **5 groups place users into each based on their role** 
    * Root_IAMAdminManagers - Super user (root) for creating Administrators and NetSecAdmins
    * User_IAMManagers - Allowed to manage all users __*excluding*__ Administrators and NetSecAdmins
    * Tenancy_NetSecAdmins - Network Security Administrators with control over ipsec components
    * Tenancy_ReadOnly - Read only access to all resources in Tenancy
    * Sandbox_Engineer - Group able to perform Engineering activities on all resources limited to the sandbox compartment. 
  
__*Add users to the Sandbox_Engineer group to experiment in the sandbox compartment.*__

* **5 policies that define what each group can do**
    * Root_IAMAdminManagers
    * User_IAMManagers
    * Tenancy_NetSecAdmins
    * Tenancy_ReadOnly
    * Sandbox_Engineer

* **5 users.. (__*optional*__, you will probably want to add your own users to the groups)**
    * Root\_IAMAdminManagers which will be added in the Root\_IAMAdminManagers group
    * User\_IAMManagers which will be added in the User\_IAMManagers group
    * Tenancy\_NetSecAdmins which will be added in the Tenancy\_NetSecAdmins group
    * Tenancy\_ReadOnly which will be added in the Tenancy\_ReadOnly group
    * Sandbox\_Engineer which will be added in the Sandbox\_Engineer group

* 1 compartment created
    * sandbox which won't be deleted on terraform destroy

The definition of each can be inspected in the **terraform.tfvars** file in this directory.

Don't forget to populate the provider with the details of your tenancy as specified in the main README.md file.

## Dependencies
Apart from the **provider.auto.tfvars**, there may be some other dependencies in the **terraform.tfvars** file that you will have to address.
In the IAM example, there are no dependencies to external variables.

## Running the code

Go to **thunder/examples/crawl/iam**
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```

__*Now you have a sandbox compartment and IAM, you're ready to build in OCI.*__

## Crawl IAM Terraform Module Detail

The IAM module is able to create compartments, groups, users and policies. In addition to this, it is also able to add users to groups.

* Groups parameters
    * name - Name of the group
    * description - Description of the group

* User parameters
    * name - Name of the user
    * description - Description of the user
    * group_name - Specify the name of the group in which the user should be automatically added at provisioning

* Compartment parameters
    * name - Name of the compartment
    * description - Description of the compartment
    * enable_delete - Whether you want to delete or not the compartment on terraform destroy

* Policies parameters
    * name - Name of the policy
    * description - Description of the policy
    * statements - A list of statements for the policies that will grant different levels of access


## Useful Links
[IAM Overview](https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/overview.htm)