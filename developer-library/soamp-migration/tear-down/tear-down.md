# Tearing down the workshop environment

## Introduction

Congratulations! You've come so far and completed the workshop, and you might wonder how to clean up resources.

Estimated Lab Time: 15min

*You should not keep the instances deployed on OCI as part of this workshop running once your are done, or use in any way for actual workloads: since the DB and WebLogic credentials are publically available it would be a security issue.*

## **STEP 1:** Cleaning up the 'on-premises' environment

### If you used Local machine

1. Uninstall the Soa Suite 12.2.1.3 VM 

   
2. Uninstall the SOA Suite Quick Start 12.2.1.4

  

### If you used the Workshop image from the marketplace

1. Go to **Resources Manager**

2. Select the **compartment** where you deployed the stack originally

3. Click the stack name for the **Workshop on-premises environment**

  <img src="./images/stack.png"  width="50%">

4. In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy-local.png"  width="50%">

5. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

6. Click **Delete Stack**

  <img src="./images/delete-stack-local.png"  width="50%">

## **STEP 2:** Tear down the Application Database on OCI

1. Go to the **Bare Metal, VM and Exadata Menu**

2. Click the **Database System** `SOAMP2DB`

3. Click **More Actions** and **Terminate**
    You'll be prompted for the name of the DB system to terminate.

    This will take several minutes.

## **STEP 3:** Tear down the SOA environment

*You need to terminate the DB subnet before you can tear down the SOA deployment as Resource Manager will not be able to clean up the VCN until the DB subnet is removed.

1. Go to the **Resources Manager**

2. Click the stack name for the **SOA Server deployment** `SOAMP3`

3. In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy-soamp.png"  width="50%">

4. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

5. Click **Delete Stack**

  <img src="./images/delete-stack-soamp.png"  width="50%">

## **STEP 4:** Tear down VCN

1. Go to **Networking -> Virtual Cloud Networks** 

2. Select the `SOAMP1VCN` VCN  (or whatever VCN name you have provided)

3. Click **Terminate**

  Note you won't be able to proceed until the DB System and the SOA stack have been terminated.

You're done.

## Acknowledgements

 - **Author** - Akshay Saxena, September 2020
 - **Last Updated By/Date** - Akshay Saxena, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
