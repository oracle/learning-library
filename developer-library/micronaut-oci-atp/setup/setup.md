# Setup for Local Development

## Introduction
In this lab you are going to get setup to develop a Micronaut application locally that communicates with an Autonomous Database instance.

Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:
* Create the Necessary Database schema
* Download the Wallet for Autonomous Database access

### Prerequisites
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account

## **STEP 1**: Create DB Schema

1. Click on the Cloud Shell button to start a Cloud Shell instance:

   ![Open Cloud Shell](images/cloudshell.png)

2. From Cloud Shell, download the script and run it:

    ```
    <copy>
    wget -O setup.sh https://objectstorage.us-phoenix-1.oraclecloud.com/n/toddrsharp/b/micronaut-lab-assets/o/setup.sh
    chmod +x setup.sh
    ./setup.sh
    </copy>
    ```
3. Enter the value of `script_input` that you copied from the Terraform output in the previous lab when prompted.

![Setup Script](images/setup_input.png)

The script will produce several snippets of output to be used to build, run and deploy.

## **STEP 2**: Download and Configure Wallet Locally

The Oracle Autonomous Database uses an extra level of security in the form of a wallet containing access keys for your new Database.

To connect locally you need to download and configure the ATP Wallet locally.

1. In the OCI Console, click on the burger menu and select 'Autonomous Transaction Processing' under 'Oracle Database'.

    ![ATP menu](images/atp-menu.png)

2. Make sure you are in the `mn-oci-hol` compartment:

   ![Choose compartment](images/choose-compartment.png)

**Note: if you do not see the `mn-oci-hol` compartment in the dropdown, please refresh the page and try again.**

3. Find the newly created instance and click on it.

    ![ATP instance](images/atp-instance-list.png)

4. In the instance details, click on 'DB Connection'.

    ![DB Connection](images/db-connection-btn.png)

5. In the 'Database Connection' dialog, select 'Instance Wallet' and click 'Download Wallet'.

    ![Wallet dialog](images/wallet-dialog.png)

6. Enter (and confirm) the `atp_wallet_password` from the Terraform output you obtained in the previous lab and click 'Download'.

    ![Wallet password](images/wallet-password.png)

7. After the wallet zip has been downloaded, unzip it and move it to `/tmp/wallet`. You can do this with a single command in a terminal window on a Unix system, however the file can be extracted to a location of your choosing:

    ```
    <copy>
    unzip /path/to/Wallet_mnociatp.zip -d /tmp/wallet
    </copy>
    ```

8. Once downloaded your wallet directory should contain the following files:

   ![Wallet dir](images/tmp-wallet-dir.png)


You may now *proceed to the next lab*.

## Acknowledgements
- **Owners** - Graeme Rocher, Architect, Oracle Labs - Databases and Optimization
- **Contributors** - Chris Bensen, Todd Sharp, Eric Sedlar
- **Last Updated By** - Kay Malcolm, DB Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
