# Appendix B: Perform Pre-installation Tasks for Oracle Database 19c

## Overview
This lab shows you what you need to do to your compute instance before you can install Oracle Database 19c on it.

Estimated Lab Time: 15 minutes

## Objectives
Learn how to do the following:

- Run oracle-database-preinstall-19c
- Make the `oracle` user a sudoer
- Create the **Oracle base** and **Oracle inventory** directories and assign permissions
- Increase the swap space on your compute instance to 16GB
- Create a `stage` directory to store the Oracle Database 19c (19.3) installer file, OPatch, and the 19.11 release update
- Download and stage the Oracle Database 19c installer files in the Oracle home directory
- Install OPatch to the required version
- Download the Database Release Update 19.11.0.0 and extract it into the Oracle home directory
- Download the lab files to your compute instance
- Configure the /etc/hosts file on your compute instance

### Prerequisites

The following need to be completed before you start:

- You created a compute instance.
- You have your My Oracle Support username and password. These are required to download OPatch and a release update.


## **STEP 1**: Run oracle-database-preinstall-19c

The preinstaller for Oracle Database 19c performs many pre-installation and pre-configuration tasks for you. It also creates a `dba` and `oinstall` group, creates an `oracle` user, and adds the `oracle` user to the `dba` and `oinstall` groups. If you've already created the `oracle` user and groups, that is fine. This installation will not affect them.

1. Change to the `root` user.

    ```nohighlighting
    $ <copy>sudo su -</copy>
    ```


2. Execute the following command to run the preinstaller.

    ```nohighlighting
    # <copy>yum install oracle-database-preinstall-19c</copy>
    ```

2. Set the password for the `oracle` user as `Ora4U_1234`. You are prompted to enter and confirm the password.

    ```nohighlighting
    # <copy>passwd oracle</copy>
    ```


## **STEP 2**: Make the `oracle` user a sudoer

Allow the `oracle` user to perform any operation as `root`. This step gives the `oracle` user root permission without the need for them to know the `root` password. Sudoers must be edited by running `visudo`. You need to do this step so that later when you install Oracle Database 19c in another lab, you can specify the `oracle` user as the sudo user to run configuration scripts.

1. Run `visudo`.

    ```nohighlighting
    # <copy>sudo visudo</copy>
    ```

2. Insert the following line after the `root    ALL=(ALL)       ALL` line:

    ```nohighlighting
    <copy>oracle  ALL=(root)      ALL</copy>
    ```

    Tip: Press **i** to insert text.

3. Save the changes.

    Tip: To save, press **Esc**, enter **:wq**, and then press **Enter.



## **STEP 3**: Create the `Oracle base` and `Oracle inventory` directories and assign permissions.

1. Create the **Oracle base** and **Oracle inventory** directories.

    ```nohighlighting
    # <copy>mkdir -p /u01/app/oracle</copy>
    # <copy>mkdir -p /u01/app/oraInventory</copy>
    ```

2. Specify `oracle` as the owner and `oinstall` as the group for the Oracle base and Oracle inventory directories.

    ```nohighlighting
    # <copy>chown -R oracle:oinstall /u01/app/oracle</copy>
    # <copy>chown -R oracle:oinstall /u01/app/oraInventory</copy>
    ```
3. Set the permissions on the `/u01/app` directory and all if its subdirectories (which includes the Oracle base and Oracle inventory directories) so that the owner and group can read, write, and execute on the directories.

    ```nohighlighting
    # <copy>chmod -R 775 /u01/app</copy>
    ```


## **STEP 4**: Increase the swap space on your compute instance to 16GB.

Currently, a VM.Standard.E2.4 compute instance has 8GB of free swap space. The Oracle Database 19c installer requires at least 16GB, so you need to increase the amount.

1. Allocate 8GB of swap space.

    ```nohighlighting
    # <copy>fallocate -l 8G /swapfile</copy>
    ```

2. Allow only the `root` user to read/write to swap.

    ```nohighlighting
    # <copy>chmod 600 /swapfile</copy>
    ```

3. Format the file to make it a swap file.

    ```nohighlighting
    # <copy>mkswap /swapfile</copy>

    Setting up swapspace version 1, size = 8388604 KiB
    no label, UUID=322b862d-083d-429c-b5b8-a71fff68fa5d
    ```

4. Enable the swap file.

    ```nohighlighting
    # <copy>swapon /swapfile</copy>
    ```

5. Check that the compute instance now has enough free swap space (16GB).

    ```nohighlighting
    # <copy>free -m</copy>

                  total        used        free      shared  buff/cache   available
    Mem:          31824        1158       19572           8       11093       30201
    Swap:         16383           0       16383
    ```

    The output indicates that the compute instance now has 16GB of free swap space.

6. Using the `vi` editor, open `/etc/fstab`.

    ```nohighlighting
    # <copy>vi /etc/fstab</copy>
    ```

7. Scroll to the bottom, add the following as the last line, and save the file. This step makes the changes permanent.

    ```nohighlighting
    <copy>/swapfile swap swap defaults 0 2</copy>
    ```
## **STEP 5**: Create a `stage` directory to store the Oracle Database 19c (19.3) installer file, OPatch, and the 19.11 release update

1. Create a `/stage` directory.

    ```nohighlighting
    # <copy>mkdir -p /stage</copy>
    ```

2. Grant the `oracle` user read, write, and execute permissions on the directory.

     ```nohighlighting
    # <copy>chown -R oracle:oinstall /stage</copy>
     ```


## **STEP 5**: Download and stage the Oracle Database 19c installer files in the Oracle home directory on your compute instance

1. In a browser on your local computer, access the following URL:

    ```nohighlighting
    <copy>https://www.oracle.com/database/technologies/oracle19c-linux-downloads.html</copy>
    ```

2. Click `LINUX.X64_193000_db_home.zip` and save the ZIP file to a directory on your local computer.

3. Sign in to Oracle Cloud Infrastructure. From the navigation menu, select **Object Storage** and then **Object Storage**.

4. Select a compartment, and then click **Create Bucket**.

5. Enter a bucket name or leave the default name as is.

6. Click **Create**.

7. Click the bucket name.

8. Under **Objects**, click **Upload**.

9. Enter **19-3** for the object name.

10. Click **select files**, browse to and select the `LINUX.X64_193000_db_home.zip` file, and then click **Open**.

11. Click **Upload**, and wait for the upload to finish.

12. Click **Close**.

13. To the far right of your object name, click the three dots, and then select **Create Pre-Authenticated Request**.

14. Set the expiration date, and then click **Create Authenticated Request**.

15. Copy the url to the clipboard and save it somewhere. This is the only time you see this url.

16. Click **Close**.

17. Return to the terminal window and change the current user to `oracle`.

    ```nohighlighting
    # <copy>su - oracle</copy>
    ```

18. Download the Oracle Database 19c installation ZIP file from object storage (in the LiveLabs tenancy) to the `stage` directory. In the following command, replace `pre-authenticated-request-url` with the URL that you copied in a previous step.

    ```nohighlighting
    $ <copy>wget pre-authenticated-request-url -P /stage</copy>
    ```

19. Change to the `stage` directory and verify that the Oracle Database 19c installation ZIP file is there.

    ```nohighlighting
    $ <copy>cd /stage </copy>
    $ <copy>ls</copy>
    ```

20. Create an **Oracle home** directory and change to that directory. It's important that the Oracle home directory is in compliance with the Oracle Optimal Flexible Architecture recommendations. Make sure that the current user is still `oracle`.

    ```nohighlighting
    $ <copy>mkdir -p /u01/app/oracle/product/19.11.0/dbhome_1</copy>
    $ <copy>cd /u01/app/oracle/product/19.11.0/dbhome_1</copy>
    ```

21. Extract the Oracle Database 19c installation ZIP file from the `stage` directory into the Oracle home directory.

    ```nohighlighting
    $ <copy>unzip -q /stage/LINUX.X64_193000_db_home.zip</copy>
    ```

22. List the files. You should have several directories and files.

    ```nohighlighting
    $ <copy>ls</copy>
    ```



## **STEP 6**: Install OPatch to the required version

1. Download the OPatch ZIP file from My Oracle Support. Select release **12.2.0.1.0**. Upload the ZIP to your object storage and get the pre-authenticated request URL.

2. Change to the `OPatch` directory and check the version of OPatch.

    ```nohighlighting
    $ <copy>cd /u01/app/oracle/product/19.11.0/dbhome_1/OPatch/</copy>
    $ <copy>./opatch version</copy>

    OPatch Version: 12.2.0.1.17

    OPatch succeeded.
    ```

3. Back up the old OPatch utility.

    ```nohighlighting
    $ <copy>cd /u01/app/oracle/product/19.11.0/dbhome_1/</copy>
    $ <copy>mv OPatch/ OPatch_backup</copy>
    ```

4. Make sure that the `OPatch` directory doesn't exists now. Instead, you now have `OPatch_backup`.

    ```nohighlighting
    $ <copy>ls</copy>
    ```

5. Use the wget command to upload OPatch to your `/stage` directory. Replace `pre-authenticated-request-url` with the one you obtained in object storage.

    ```nohighlighting
    $ <copy>wget pre-authenticated-request-url -P /stage</copy>
    ```
6. *Important!* Change to the Oracle home directory.

    ```nohighlighting
    $ <copy>cd /u01/app/oracle/product/19.11.0/dbhome_1/</copy>
    ```

7.  Unzip the OPatch ZIP file into the Oracle home directory.

    ```nohighlighting
    $ <copy>unzip -q /stage/p6880880_190000_Linux-x86-64.zip</copy>
    ```

8. List the files and folders in the Oracle home directory and verify that you now have an `OPatch` directory.

    ```nohighlighting
    $ <copy>ls</copy>
    ```
9. View the version of the OPatch utility and verify that it is version 12.2.0.1.23 or later.

    ```nohighlighting
    $ <copy>OPatch/opatch version</copy>
    OPatch Version: 12.2.0.1.24

    OPatch succeeded.
    ```



## **STEP 7**: Download the Database Release Update 19.11.0.0 and extract it into the Oracle home directory


1. Use the `wget` command to download the release update ZIP file from My Oracle Support into the `stage` directory. In the following command, replace `MOSusername` and `MOSpassword` with your My Oracle Support username and password.

    ```nohighlighting
    $ <copy>wget --http-user=MOSusername --http-password=MOSpassword --no-check-certificate --output-document=p32545013_190000_Linux-x86-64.zip "https://updates.oracle.com/Orion/Services/download/p32545013_190000_Linux-x86-64.zip?aru=24175065&patch_file=p32545013_190000_Linux-x86-64.zip" -P /stage</copy>
    ```
2. Make sure that you are in the Oracle home directory.

    ```nohighlighting
    $ <copy>cd /u01/app/oracle/product/19.11.0/dbhome_1/</copy>
    ```
3. Extract `p32545013_190000_Linux-x86-64.zip` into the Oracle home directory.

    ```nohighlighting
    $ <copy>unzip -q /stage/p32545013_190000_Linux-x86-64.zip</copy>
    ```

4. Verify that the `32545013` directory exists.


## **STEP 8**: Download the lab files to your compute instance

In the Oracle Database 19c New Features workshop, you run many prebuilt scripts. You can download these scripts from LiveLab's object storage.

1. As the `oracle` user, create a `lab` directory, set permissions, and change to it.

    ```nohighlighting
    $ <copy>mkdir -p ~/labs/</copy>
    $ <copy>chown -R oracle:oinstall ~/labs</copy>
    $ <copy>cd ~/labs
    ```

2. Use the `wget` command to download a ZIP file containing the lab files to the `labs` directory.

    ```nohighlighting
    $ <copy>wget "https://objectstorage.us-phoenix-1.oraclecloud.com/p/83Tmlx4J_v8iicr-u5G8PYlzpiFmXxxB9qKGBgEVScgZXHjmyb5xSLUOdolnPO0F/n/c4u03/b/ll-19c/o/19cNewFeaturesLabFiles19cNewFeatures.zip"</copy>
        ```


3. Extract `19cNewFeatures.zip`.

    ```nohighlighting
    $ <copy>unzip -q 19cNewFeatures.zip</copy>
    ```

4. Remove `19cNewFeatures.zip`.

    ```nohighlighting
    $ <copy>rm 19cNewFeatures.zip</copy>
    ```

5. Verify that you have the following in the `labs` directory:
    ```nohighlighting
    $ <copy>ls</copy>

    admin  DB  db.rsp  DIAG  DW HA  OBEs PERF SEC  Videos
    ```


## **STEP 9**: Configure the `/etc/hosts` file on your compute instance

Using the vi editor, open the `/etc/hosts` file and add the following line to the end of the file. Replace private-ip-address and host-name with your own values.

    ```nohighlighting
    <copy>private-ip-address   host-name-livelabs.oraclevcn.com   host-name</copy>
    ```
