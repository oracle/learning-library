# Tearing down the workshop environment

## Introduction

Congratulations! You've come so far and completed the workshop, and you might wonder how to clean up resources.

Note:
You should not keep the instances deployed on OCI as part of this workshop running once your are done, or use in any way for actual workloads: since the DB and WebLogic credentials are publically available it would be a security issue.

## **Step 1:** Cleaning up the 'on-premises' environment

### If you used Docker

To stop the services:

<copy>
```bash
docker-compose stop
```
</copy>

to remove the containers, run:

<copy>
```bash
docker-compose rm
```
</copy>

### If you used the Workshop image from the marketplace

- 1.1. Go to **Resources Manager**

- 1.2. Select the **compartment** where you deployed the stack originally

- 1.3. Click the stack name for the **Workshop on-premises environment**

  <img src="./images/stack.png"  width="50%">

- 1.4. In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy.png"  width="50%">

- 1.5. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

- 1.6. Click **Delete Stack**

  <img src="./images/delete-stack.png"  width="50%">

## **Step 2:** Tear down the WebLogic environment

- 2.1. Go to the Bare Metal, VM and Exadata Menu

- 2.2. Click the **Database System** to terminate

- 2.3. Click **Terminate**

## **Step 3:** Tear down the WebLogic environment

- 3.1. Go to the Resources Manager

- 3.2. Click the stack name for the **WebLogic Server deployment**

- 3.3. In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy.png"  width="50%">

- 3.4. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

- 3.5. Click **Delete Stack**

  <img src="./images/delete-stack.png"  width="50%">
