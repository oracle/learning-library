# Teardown

## Introduction

In this lab, we will tear down the resources created in your tenancy and the directory in the Oracle cloud shell.

Estimates Lab Time - 10 minutes

Quick walk through to tear down the resources created in your tenancy and the directory in cloud shell.

[](youtube:vfj_hCDnp7g)

### Objectives

* Clone the setup and microservices code
* Execute the setup

### Prerequisites

* Have successfully completed the previous labs

## **STEP 1**: Delete the Workshop Resources

1. Run the following command to delete the resources created in you tenancy.  It will delete everything except the compartment.  It will take several minutes to run.  The script will delete the Object Storage bucket, OCI Registry repositories, OKE cluster, listeners, VCN and databases.

    ```
    <copy>source destroy.sh</copy>
    ```

## **STEP 2**: Delete the Directory

1. Delete the directory in your cloud shell where you installed the workshop.

    ```
    <copy>rm -rf <directory name></copy>
    ```

## **STEP 3**: Delete the Compartment

1. In the OCI console navigate to the Identity -> Compartments screen.  Select the compartment that was created for the workshop and delete it.  Note, even when the script in step 1 has completed, it can take some time for OCI to fully remove all the resources.  It will not be possible to delete the compartment until this has completed.

## Acknowledgements

* **Author** - Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020
