# Installing Oracle Database Vault

## Introduction
This lab shows how to install or reinstall Oracle Database Vault in a CDB by using Database Configuration Assistant (DBCA).


Estimated Lab Time: 15 minutes

### Objectives
In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Ensure Database Vault is not installed

Before starting the reinstallation of Database Vault, use the [Practice: Deinstalling Oracle Database Vault](https://oracle.github.io/learning-library/data-management-library/database/21c/fundamentals/workshops/freetier/index.html?lab=lab-uninstall-db-vault) in case Database Vault is already installed.

## **STEP 2:** Use DBCA to reinstall or install Database Vault in the CDB

1. Before running the command, replace the password in the command below for both the DV owner and the DV account manager. Ensure that the DV owner and DV account manager accounts do not exist in the CDB root. The password cannot have any repeating consecutive characters and so the password had to change.


    ```

    $ <copy>$ORACLE_HOME/bin/dbca -silent -configureDatabase -sourceDB CDB21 -dvConfiguration true -olsConfiguration true -dvUserName c##dvo -dvUserPassword WElcome123#! -dvAccountManagerName c##dvacctmgr -dvAccountManagerPassword WElcome123#! </copy>

    Enter password for the TDE wallet: <i> password </i>

    [WARNING] [DBT-16002] The database will be restarted in order to configure the chosen options.

    Prepare for db operation

    22% complete

    Preparing to Configure Database

    24% complete

    29% complete

    38% complete

    40% complete

    44% complete

    Oracle Database Vault

    89% complete

    Completing Database Configuration

    100% complete

    The database configuration has completed successfully.

    Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDB21/CDB212.log" for further details.

    $

    ```

2. Connect to the CDB root as `C##DVO` to verify the status of Database Vault.


    ```

    $ <copy>sqlplus c##dvo</copy>

    Enter password: <i>password</i>
    ```
    ```

    SQL> <copy>SELECT * FROM DVSYS.DBA_DV_STATUS;</copy>

    NAME                STATUS

    ------------------- --------------

    DV_CONFIGURE_STATUS TRUE

    DV_ENABLE_STATUS    TRUE

    DV_APP_PROTECTION   NOT CONFIGURED

    SQL> <copy>SELECT * FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';</copy>

    PARAMETER                 VALUE   CON_ID

    ------------------------- ------- ------

    Oracle Database Vault     TRUE         0

    SQL>

    ```

You may now [proceed to the next lab](#next).


## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
