# Tearing Down the Workshop Environment

## Introduction

Congratulations! You've come so far and completed the workshop, and you might wonder how to clean up resources.

Estimated Lab Time: 15 minutes

*You should not keep the instances deployed on OCI as part of this workshop running once your are done, or use in any way for actual workloads: since the DB and WebLogic credentials are publically available it would be a security issue.*

### Objectives

In this lab you will tear down the infrastructure provisioned.

## **STEP 1:** Cleaning up the 'on-premises' environment

### If you used docker

1. stop the services and remove containers:

    ```
    <copy>
    bash
    docker-compose down
    </copy>
    ```

### If you used the workshop image from the marketplace

1. Go to **Resources Manager**

2. Select the **compartment** where you deployed the stack originally

3. Click the stack name for the **Workshop on-premises environment**

  <img src="./images/stack.png"  width="50%">

4. In **Terraform Actions**, click **Destroy**

  <img src="./images/tf-destroy.png"  width="50%">

5. Once the job completed, click **stack details** in the bread-crumbs menu to get back to the stack details.

6. Click **Delete Stack**

  <img src="./images/delete-stack.png"  width="50%">

<if type="dbcs">
## **STEP 2:** Tear down the Application Database on OCI

1. Go to the **Bare Metal, VM and Exadata Menu**

2. Click the **Database System** to terminate

3. Click **More Actions** and **Terminate**
    You'll be prompted for the name of the DB system to terminate.

    This will take several minutes.

4. Go to **Networking -> Virtual Cloud Networks**

5. Go to the **Private Subnet** `nonjrf_db_subnet`

6. Select the `nonjrf-db-security-list` in the list of security lists and click the far-right 3 dots icon to open further options and click *Remove*

7. Go to **Security Lists**

8. Select the `nonjrf-db-security-list` Security List and click *Terminate*

9. Click **Subnets**

10. Select the private subnet that was created manually `nonjrf_db_subnet`

11. Click **Terminate**

    Note you won't be able to proceed until the DB System itself has been terminated.
</if>
<if type="atp">
## **STEP 2:** Tear down the Application Database on OCI

1. Go to the **Autonomous Transaction Processing**

2. Click the **WLSATPDB** Database

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
</if>
## **STEP 3:** Tear down the WebLogic environment

You need to terminate the DB subnet before you can tear down the WebLogic deployment as Resource Manager will not be able to clean up the VCN until the DB subnet is removed.

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

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
