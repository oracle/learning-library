# Verify the Setup

In this lab, you verify that you can connect to both of your compute instances (`workshop-staged` and `workshop-installed`).

## Objectives

- Obtain the public IP addresses of your compute instances
- Connect to your compute instances
- Discover the container database (CDB) and pluggable database (PDB) on `workshop-installed`

### Prerequisites

Be sure that the following tasks are completed before you start:

- You have an Oracle Free Tier or Paid Cloud account.
- You have two compute instances available in Oracle Cloud Infrastructure. One compute instance named `workshop-staged` has the Oracle Database 19c installer files staged on it. The other compute instance named `workshop-installed` has Oracle Database 19c fully installed and configured on it.

### Assumptions

- You are signed in to Oracle Cloud Infrastructure.



## **STEP 1**: Obtain the public IP addresses of your compute instances

1. From the navigation menu in the Oracle Cloud Infrastructure Console, select **Compute**, and then **Instances**.

2. Select the compartment that contains your compute instances. You should have two compute instances:

    - `workshop-staged`
    - `workshop-installed`

3. Find the public IP addresses of both your compute instances and jot them down. The IP addresses are displayed in the table next to the compute instance names.



## **STEP 2**: Connect to your compute instances

Test that you can connect to both of your compute instances. The `compute-staged` instance has a Guacamole desktop available, so you can connect to it via a browser. To connect to the `workshop-installed` compute instance, you can use Cloud Shell in Oracle Cloud Infrastructure.


### Connect to `workshop-staged`

1. On your local computer, open a browser, and enter the following url. Replace `compute-public-ip` with the public IP address of your `workshop-staged` compute instance.

    ```nohighlighting
    <copy>compute-public-ip:8080/guacamole</copy>
    ```

2. Enter `oracle` as the username and `Guac.LiveLabs_` as the password, and then click Login. Don't forget the underscore at the end of the password!
    (guacamole-login-page.png)

   You are presented with a Guacamole desktop. The desktop provides shortcuts to Firefox and a terminal window.

3. To enable copying and pasting on your compute instance, enter **CTRL+ALT+SHIFT** (Windows) or **CTRL+CMD+SHIFT** (Mac). Select **Text Input**.

  A black Text Input field is added to the bottom of your screen. In this field, you can paste any text copied from your local environment.

  ![](./images/guacamole-clipboard-2.png " ")

4. Test copy and pasting the following text. Prior to pasting, ensure that the cursor is placed at the location where you want to paste the text, then right-click inside the black **Text Input** field, and paste the text.

    ```nohighlighting
    <copy>echo "This text was copied from my local desktop on to my remote session"</copy>
    ```
    ![](./images/guacamole-clipboard-3.png " ")




###  Connect to `workshop-installed`

1. On the toolbar in Oracle Cloud Infrastructure, click the Cloud Shell icon to launch Cloud Shell.

  ![Cloud Shell icon](images/cloud-shell-icon.png)

  A terminal window opens at the bottom of the page.

2. Enter the following `ssh` command to connect to your compute instance. Replace `public-ip-address` with the public IP address of your compute instance.

  `cloudshellkey` is the name of the private key file that you created in the [Generate SSH Keys - Cloud Shell](?lab=https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/generate-ssh-keys-cloud-shell.md) lab. If your private key has a different name, then replace `cloudshellkey` with it.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/cloudshellkey opc@public-ip-address</copy>
    ```

    A message states that the authenticity of your compute instance can't be established. Do you want to continue connecting?

3. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  You are now connected to your new compute instance via Cloud Shell.


## **STEP 3**: Discover the container database (CDB) and pluggable database (PDB) on `workshop-installed`

1. In Cloud Shell, switch to the `oracle` user on the `workshop-installed` compute instance.

    ```nohighlighting
    [opc@workshop ~]$ <copy>sudo su - oracle</copy>
    ```

2. Track the database installation and configuration by viewing the `dbsingle.log` file.

    ```nohighlighting
    [oracle@workshop ~]$ <copy>tail -f /u01/ocidb/buildsingle.log</copy>
    ```
    ...
    INFO (node:workshop): Creating database (ORCL) (Single Instance)
    ...
    Prepare for db operation
    8% complete
    Copying database files
    31% complete
    Creating and starting Oracle instance
    32% complete
    36% complete
    ...
    ```

3. Wait for the log to state the following information. It takes *approximately 20-30 minutes* for the database to be configured and ready for use.

    ```nohighlighting
    ...
    21-04-18 22:29:38:[buildsingle:Done :workshop] Building 19c Single Instance
    2021-04-18 22:29:38:[buildsingle:Time :workshop] Completed successfully in 2367 seconds (0h:39m:27s)
    ```

4. Run the following command to verify the database is running.

    ```nohighlighting
    $ <copy>ps -ef | grep ORCL</copy>

    ...
    oracle   12100     1  0 22:40 ?        00:00:00 ora_w00e_ORCL
    oracle   12104     1  0 22:40 ?        00:00:00 ora_w00f_ORCL
    opc      12412 10323  0 22:44 pts/1    00:00:00 grep --color=auto ORCL
    ```

5. Verify the listener is running.

    ```nohighlighting
    $ <copy>ps -ef | grep tns</copy>

    root        61     2  0 21:49 ?        00:00:00 [netns]
    oracle    4574     1  0 21:50 ?        00:00:00 /u01/app/oracle/product/19c/dbhome_1/bin/tnslsnr LISTENER -inherit
    opc      12602 10323  0 22:46 pts/1    00:00:00 grep --color=auto tns
    ```

6. Set the environment variables to point to the Oracle binaries. When prompted for the SID (Oracle Database System Identifier), enter **ORCL**.

    ```nohighlighting
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? ORCL
    The Oracle base has been set to /u01/app/oracle
    [oracle@workshop ~]$
    ```

7. Using SQLPlus, connect to the `root` container of your database. SQL*Plus is an interactive and batch query tool that is installed with every Oracle Database installation.

    ```nohighlighting
    $ <copy>sqlplus / as sysdba</copy>

    SQL*Plus: Release 19.0.0.0.0 - Production on Wed Apr 14 22:52:11 2021
    Version 19.10.0.0.0

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0

    SQL>
    ```

8. Verify that you are logged in to the `root` container as the `SYS` user.

    ```nohighlighting
    SQL> <copy>SHOW user</copy>

    USER is "SYS"
    SQL>
    ```

9. Find the current container name. Because you're currently connected to the `root` container, the name is `CDB$ROOT`.

    ```nohighlighting
    SQL> <copy>SHOW con_name</copy>

    CON_NAME
    -------------------
    CDB$ROOT
    SQL>
    ```

10. List all of the containers in the CDB by querying the `V$CONTAINERS` view. The results list three containers - the `root` container (`CDB$ROOT`), the seed PDB (`PDB$SEED`), and the pluggable database (`ORCLPDB`).

    ```nohighlighting
    SQL> <copy>COLUMN name FORMAT A8</copy>
    SQL> <copy>SELECT name, con_id FROM v$containers ORDER BY con_id;</copy>

    NAME         CON_ID
    -------- ----------
    CDB$ROOT          1
    PDB$SEED          2
    ORCLPDB           3
    SQL>
    ```

11. Exit SQL*Plus.

    ```nohighlighting
    SQL> <copy>EXIT</copy>

    $
    ```
12. Using SQL*Plus, connect to the pluggable database `orclpdb` as the `oracle` user.

  *REVIEWER: Why do we say connect as the oracle user? Isn't this the SYSTEM user?*

    ```nohighlighting
    $ <copy>sqlplus system/Ora_DB4U@localhost:1521/orclpdb</copy>      
    ```
13. Exit SQL*Plus.

    ```nohighlighting
    SQL> <copy>EXIT</copy>
    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0

    $
    ```


You may now [proceed to the next lab](#next).


## Learn More

- [Resource Manager Video](hhttps://youtu.be/udJdVCz5HYs)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, May 5 2021
