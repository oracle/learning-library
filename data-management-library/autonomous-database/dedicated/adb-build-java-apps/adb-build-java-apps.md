# Building and deploying Java application stacks on dedicated autonomous infrastructure

## Introduction
The Oracle Cloud Infrastructure marketplace provides a pre-built image with necessary client tools and drivers to build applications on autonomous databases. As an application developer you can now provision a developer image within minutes and connect it to your dedicated or serverless database deployment. 

The image is pre-configured with tools and language drivers to help you build applications written in node.js, python, java and golang.
For a complete list of features, login to your OCI account, select 'Marketplace' from the top left menu and browse details on the 'Oracle Developer Cloud Image'.

In this lab we will configure and deploy a java application in a developer client VM and connect it to an autonomous database.

### Objectives

As an application developer,
1. Learn how to deploy a java application and connect it to your dedicated autonomous database instance.


### Required Artifacts

- An Oracle Cloud Infrastructure account.
- A pre-provisioned instance of Oracle Developer Client image in an application subnet. Refer to [Lab 5](?lab=lab-5-configuring-development-system).
- A pre-provisioned dedicated autonomous database instance. Refer to [Lab 4](?lab=lab-4-provisioning-databases).
- A network that provides connectivity between the application and database subnets. Refer to [Lab 1](?lab=lab-1-prepare-private-network).

## STEP 1: Download sample java application

- Login to your Oracle Cloud Infrastructure account and select *Compute* and *Instances* from the hamburger menu top left.
    ![](./images/Compute1.png " ")

- Select the right Oracle Developer Cloud image you created in earlier labs. 

- Copy the public IP address of the instance on to a note pad. 
    ![](./images/Compute2.png " ")


**Mac users**

- Open Terminal and SSH into linux host machine.

    ```
    <copy>
    sudo ssh -i /path_to/sshkeys/id_rsa opc@publicIP
    </copy>
    ```

    ![](./images/SSH1.png " ")

**Windows users**

- You can connect to and manage linux host mahine using SSH client. Recent versions of Windows 10 provide OpenSSH client commands to create and manage SSH keys and make SSH connections from a command prompt.

- Other common Windows SSH clients you can install locally is PuTTY. Click [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows) to follow the steps to connect to linux host machine from you windows using PuTTY.


- Download a sample java application for the purpose of this lab as follows,

```
<copy>
cd /home/opc/


wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/v3Wdc2lzrxStw775qXuXEtQY-oV3uKKOpPuAjMCtgEA/n/atpdpreview11/b/adb-build-java-apps/o/ATPDjava.zip
</copy>
```


Unzip the application in /home/opc


```
<copy>
unzip /home/opc/ATPDjava.zip
</copy>
```

*Note: The package unzips to a folder /home/opc/atpjava*

Next,  download ojdbc8 drivers needed for connectivity,

```
<copy>
cd /home/opc/atpjava/

mkdir ojdbc

cd ojdbc/

wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/iv-ms2lpLm5NuFkTVm_PErpN0HeI_clDBUM7c7s1l9A/n/atpdpreview11/b/adb-build-java-apps/o/ojdbc8-full.tar.gz


tar xzfv ojdbc8-full.tar.gz
</copy>
```


## STEP 2: Transfer database wallet to developer client

- Login to Oracle Cloud Infrastructure account and click on *Autonomous Transaction Processing* from top left menu.
    ![](./images/atpd1.png " ")

- Click on Autonomous Database and select your previously created database.
    ![](./images/atpd2.png " ")

- Click on DB Connection and under Download Client Credential(Wallet) click *Download*.
    ![](./images/atpd3.png " ")

- Database connections to you Autonomous Database use a secure connection. You will be asked to create a password for your wallet. 

- Enter *Password* and *Confirm password* and click on *Download*.
    ![](./images/atpd4.png " ")

- The credentials zip file contains the encryption wallet, Java keystore and other relevant files to make a secure TLS 1.2 connection to your database from client applications. Store this file in a secure location on your local machine.

- Let us now scp the downloaded wallet to our developer client machine.

**Mac Users** 
- Open a terminal window on your laptop and type in the following commands,

    *Note: Please change the path and file name for your ssh keyfile and the encryption wallet. Also provide the IP address of your developer client machine.*

    ```
    <copy>
    sudo scp -i /Path/to/your/private_ssh_key /Path/to/your/downloaded_wallet opc@publicIP:/home/opc/ATPDjava
    </copy>
    ```
    ![](./images/atpd5.png " ")

**Windows Users** 

- Use a scp client such as winSCP to move your wallet to the client machine.

## STEP 3: Run your java application

Now that you have successfully SCP'd the encryption to your client machine, let's connect to our linux host, unzip the wallet and update sqlnet.ora file to point to the wallet folder.

- Open terminal in your laptop and SSH into linux host machine.

    ```
    <copy>
    ssh -i /path/to/your/private_ssh_key opc@PublicIP
    </copy>
    ```
    Once logged in ,

    ```
    <copy>
    cd /home/opc/atpjava/

    mkdir wallet

    unzip Wallet_ATPDedicatedDB.zip -d /home/opc/atpjava/wallet/
    </copy>
    ```

- Edit sqlnet.ora to update the directory path.

    ```
    <copy>
    cd /home/opc/atpjava/wallet/

    vi sqlnet.ora
    </copy>
    ```

- Change *DIRECTORY* path to /home/opc/ATPDjava/wallet/ and save the file.
    ![](./images/atpd6.png " ")

- Next, configure your java applications DB config file.

    ```
    <copy>
    cd /home/opc/atpjava/atpjava/src

    vi dbconfig.properties
    </copy>
    ```

- Change *dbinstance*, *dbcredpath*, *dbuser*, *dbpassword* as per the autonomous database you created earlier.
    ![](./images/db_parameters.png " ")

    ![](./images/atpd7.png " ")


- Next, let's set the TNS_ADMIN environment variable to point to the wallet and set the java classpath.

    ```
    <copy>
    export TNS_ADMIN=/home/opc/atpjava/wallet/
    </copy>
    ```

- Verify TNS_ADMIN path.

    ```
    <copy>
    echo $TNS_ADMIN
    </copy>
    ```
    ![](./images/atpd8.png " ")


- Set java class path.

    ```
    <copy>
    javac -cp .:/home/opc/atpjava/ojdbc/ojdbc8-full/ojdbc8.jar com/oracle/autonomous/GetAutonomousConnection.java
    </copy>
    ```

- Run application.

    ```
    <copy>
    java -cp .:/home/opc/atpjava/ojdbc/ojdbc8-full/ojdbc8.jar com/oracle/autonomous/GetAutonomousConnection
    </copy>
    ```

    ![](./images/atpd9.png " ")


## Acknowledgements

*Congratulations! You successfully deployed and connected a java app to your autonomous database.*

- **Author** - Tejus S. & Kris Bhanushali
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Kris Bhanushali, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 