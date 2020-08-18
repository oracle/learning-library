# Tearing down the workshop environment

## Introduction

Congratulations! You've come so far and completed the workshop, and you might wonder how to clean up resources.

Estimated Lab Time: 15min

*You should not keep the instances deployed on OCI as part of this workshop running once your are done, or use in any way for actual workloads: since the DB and WebLogic credentials are publically available it would be a security issue.*

## **STEP 1:** Cleaning up the 'on-premises' environment

### If you used Docker

1. stop the services:

    ```
    <copy>
    bash
    docker-compose stop
    </copy>
    ```

2. Remove the containers, run:

    ```bash
    <copy>
    docker-compose rm
    </copy>
    ```

### If you used the Workshop image from the marketplace

1. Go to **Resources Manager**

2. Select the **compartment** where you deployed the stack originally

3. Click the stack name for the **Workshop on-premises environment**

  <img src="./images/stack.png"  width="50%">

4. In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy.png"  width="50%">

5. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

6. Click **Delete Stack**

  <img src="./images/delete-stack.png"  width="50%">

## **STEP 2:** Tear down the Application Database on OCI

1. Go to the **Bare Metal, VM and Exadata Menu**

2. Click the **Database System** to terminate

3. Click **More Actions** and **Terminate**
    You'll be prompted for the name of the DB system to terminate.

    This will take several minutes.

4. Go to **Networking -> Virtual Cloud Networks** 

5. Select the nonjrf_wls VCN

6. Select the private subnet that was created manually `nonjrf_db_subnet`

7. Click **Terminate** 

    Note you won't be able to proceed until the DB System itself has been terminated.

## **STEP 3:** Tear down the WebLogic environment

*You need to terminate the DB subnet before you can tear down the WebLogic deployment as Resource Manager will not be able to clean up the VCN until the DB subnet is removed.

1. Go to the **Resources Manager**

2. Click the stack name for the **WebLogic Server deployment**

3. In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy.png"  width="50%">

4. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

5. Click **Delete Stack**

  <img src="./images/delete-stack.png"  width="50%">

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
