# OAS Environment Setup #

## Introduction ##
In this lab you will setup both Database and OAS environments by running the script files. 

### Pre-requisites ###

This lab assumes you have completed the following labs:  
- Lab 1: Login to Oracle Cloud  
- Lab 2: Generate SSH Key  
- Lab 3: Create Compute Instance  

## Step 1: Starting Database and OAS services

1. Login to putty and change user to oracle.
`````
<copy>
sudo su - oracle
</copy>
````` 
![](./images/oas-environment1.png " ")

2. To set the environment for Database and access the binaries, Enter “ . oraenv “ on command prompt.
   
![](./images/oas-environment2.png " ")

Enter **convergedcdb** for ORACLE\_SID.
So that the Oracle_Base will be set.
![](./images/oas-environment3.png " ")

3. Go to folder /u01/script

````
<copy>
cd /u01/script
</copy>
````
4. Run the script file to start the services
````
<copy>
./env_setup_script.sh
</copy>
````
![](./images/oas-environment4.png " ")

This script will ensure to start Database, Admin Server and all the services of OAS in 5-6 minutes. Here you can get all the service names and their status in the end of the script.

![](./images/oas-environment5.png " ")

Check for the success status before moving to OAS login screen.

## Step 2: Login to Oracle Analytics Server

1. Open web browser (preferabily Chrome) and access the OAS Data Visualization service by the below URL structure.  

      Lab 3 - Create Compute Instance will provide you the instance IP address. ?? (public / private)
````
<copy>
http://Your-Machine-IP:9502/dv/ui
</copy>
````
![](./images/oas-environment6.png " ")

2. Login with the below credentials;

      Username	: Weblogic

      Password 	: Oracle_4U

## Step 3: Create a connection to database

1. From Home screen, click on **Create** button and select **Connection**.

![](./images/oas-environment7.png " ")

2. Select **Oracle Database** for connecting to database and provide required connection details.  

![](./images/oas-environment8.png " ")
![](./images/oas-environment9.png " ")

**Connection Details:**	

| Argument  | Description   |
| ------------- | ------------- |
| Connection Name | ConvergedDB_Retail |
| Connection Type | Basic  |
| Host | localhost  |
| Port | 1521  |
| Service Name | apppdb  |
| Username | oaslabs  |
| Password | Oracle_4U  |

3. Once connection details are provided click **Save** to save the connection.

Now, you are ready to move to further labs.

## Acknowledgements

- **Authors** - Sudip Bandyopadhyay, Vishwanath Venkatachalaiah
- **Contributors** - Jyotsana Rawat, Satya Pranavi Manthena, Kowshik Nittala
- **Team** - North America Analytics Specialists
- **Last Updated By** - Vishwanath Venkatachalaiah

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.