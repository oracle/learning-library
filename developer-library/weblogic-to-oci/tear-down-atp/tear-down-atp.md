# Tearing Down the Workshop Environment

## Introduction

Congratulations! You've come so far and completed the workshop, and you might wonder how to clean up resources.

Estimated Completion Time: 15 minutes

*You should not keep the instances deployed on OCI as part of this workshop running once your are done, or use in any way for actual workloads: since the DB and WebLogic credentials are publically available it would be a security issue.*

### Objectives

You will tear down the infrastructure provisioned.

## **STEP 1:** Cleaning up the on-premises environment

### If you used docker

1. stop the services and remove containers:

    ```
    <copy>
    bash
    docker-compose down
    </copy>
    ```

    Note: the ssh folder with the ssh key pair will remain locally. Key the ssh key pair securely if you intend to access the environment after destroying the demo environment

### If you used the workshop image from the marketplace

*If you intend on accessing the environment deployed after destroying the demo environment, you must extract the SSH key pair that was created inside the demo VM, or you will lose SSH access to the OCI environment*

To destroy the demo VM:

1. Go to **Resources Manager**

2. Select the **compartment** where you deployed the stack originally

3. Click the stack name for the **Workshop on-premises environment**

  ![](./images/stack.png " ")

4. In **Terraform Actions**, click **Destroy**

  ![](./images/tf-destroy.png " ")

5. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

6. Click **Delete Stack**

  ![](./images/delete-stack.png " ")

## **STEP 2:** Tear down the Application Database on OCI

1. Go to the **Autonomous Transaction Processing**

2. Click the **WLSATPDB** database

3. Click **More Actions** and **Terminate**
    You'll be prompted for the name of the DB system to terminate.

    This will take a few minutes.

4. Go to **Network Security Group**

5. Find the **ATP-NSG** Network Security Group created earlier

6. On the right edge of the row, Click the triple dot icon and click **Terminate**

7. Go to **Networking -> Virtual Cloud Networks**

8. Go to the **Private Subnet** `nonjrf-db-subnet`

9. Click **Terminate**

    Note you won't be able to proceed until the DB System itself has been terminated.

## **STEP 3:** Tear down the WebLogic environment

You need to terminate the DB subnet before you can tear down the WebLogic deployment as Resource Manager will not be able to clean up the VCN until the DB subnet is removed.

1. Go to the **Resources Manager**

2. Click the stack name for the **WebLogic Server deployment**

3. In **Terraform Actions**, click **Destroy**

  ![](./images/tf-destroy.png " ")

4. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

5. Click **Delete Stack**

  ![](./images/delete-stack.png " ")

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020
