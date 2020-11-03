# Tear Down the Workshop

## Introduction

In this lab, we will tear down the infrastructure deployed on OCI as well as the local Docker environment

Estimated Lab Time: 5min

### Objectives

In this lab, you will:

* Tear down and clean up resources.


## **STEP 1:** Tear down terraform resources

1. Simply run the terraform destroy command

    ```
    <copy>
    terraform destroy
    </copy>
    ```

    You will be prompted to say `yes` to confirm

## **STEP 2:** Tear down the local Docker environment

1. Exit any container you may still be logged into

    ```bash
    <copy>
    exit
    </copy>
    ```

2. Tear down the docker-compose environment
    ```
    <copy>
    docker-compose down
    </copy>
    ```

3. Optionally you may also remove all the unused images and objects

    Attention: this removes anything not in use, so if you have other Docker images you want to keep, you may prefer to selectively delete the images of this workshop only.

    ```
    <copy>
    # Delete all images not in use
    docker rmi $(docker images -a -q)
    # clean up and reduce memory usage
    docker system prune
    </copy>
    ```

## Acknowledgements
 - **Author** - Subash Singh, Emmanuel Leroy, October 2020
 - **Last Updated By/Date** - Emmanuel Leroy, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.