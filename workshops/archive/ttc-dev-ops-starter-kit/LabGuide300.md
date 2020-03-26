<img class="float-right" src="https://oracle.github.io/learning-library/workshops/common-content/images/touch-the-cloud/ttc-logo.png" width="200">
# Lab 300

## Introduction

In Lab 300 we will be adding a MySQL database to our microservice from lab 200. We will be using an automated build process to load our baseline schema onto the database after we have provisioned it.

**To log issues**, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Objectives
- Provision a MySQL Database
- Create the baseline schema
- Bind the database to your microservice from lab 200

## Required Artifacts
- We will be leveraging scripts found within the MySQL Microservice from lab 200 that was pulled from [GitHub: https://github.com/CloudAccelerate/TTC-MySQLMicroservice.git](https://github.com/CloudAccelerate/TTC-MySQLMicroservice.git)
- We will require an ssh key: [labkey](labkey.pub)

## Prerequisites

- Expected that labs 100 and 200 have been completed already
- Expected that your storage policy has been set as described in the **prerequisite guide**

## Technologies Involved
- Oracle Cloud Services:
    - Developer Cloud Service
    - MySQL Cloud Service

## Architecture
You will be building out the first component of your Microservices Application

![](images/300/targeted-architecture.png)

# Provision and Setup a MySQL Cloud Service Instance

## Provision your Database

### **STEP 1**: Login to the MySQL Cloud Service

MySQL Cloud service provides a complete MySQL instance easily provisioned in the cloud.

- Return to the main Cloud UI Dashboard

![](images/300/step01.png)
 
 - From the Cloud UI dashboard click on the **MySQL Cloud Service Menu** select **Open Service Console**.   

![](images/300/step02.png)

### **STEP 2**: Create a new MySQL Database

- Click **create service**. Give your service a name.

```
Name: CatalogDB
```

![](images/300/step03.png)

- On the details form fill out as follows and click **Next**.


```

Compute Shape: OC3
SSH Key: <use labkey.pub found in required artifacts>
Usable DB Storage: 25
Administration Username: root
Password: Oracle123!
Database Schema Name: catalog
Backup Destination: none

```
> Note: we have chosen no DB backup for our Demo Environement. If setting up a backup, you would simply set a container name (this container can be created on the fly or provisioned previously from your Storage Service) and set your account username and password.

![](images/300/step04.png)

- Confirm your setup and **Create**

![](images/300/step05.png)

- Your Database is now being provisioned and will be ready shortly

![](images/300/step06.png)

- Verify that your database is provisioned

![](images/300/step07.png)

- Click on the instance to view details. Record the public IP of the database

![](images/300/step08.png)

### **STEP 3**: Add a build for the baseline schema setup

- Return to the main project dashboard for your Touch the Cloud Demo in Developer Cloud Service

![](images/300/step09.png)

- Click **Build** on the left menu

![](images/300/step10.png)

- Create a **New Job**. Fill out the form and click **Save**

> Name: MySQLDBSetup

![](images/300/step11.png)

- You will now be able to configure your build.

![](images/300/step12.png)

- Select the Build Parameters Tab and check parameterized build.

![](images/300/step13.png)

- Add a String Parameter


```

Name: MYSQL_IP
Default Value: <Public IP of MySQL DB>
```

![](images/300/step14.png)

- Select the **Source Control** tab and select **Git**, followed by the **MySQLMicroservice** repository. Add the **Master branch**.

![](images/300/step16.png)

- Select the **Build Step** and add a Shell Build step

```shell

cd src/main/resources/db/setup
scp -i mysqlkey -o StrictHostKeyChecking=no mysql_setup.sql opc@${MYSQL_IP}:/tmp/mysql_setup.sql
ssh -i mysqlkey -o StrictHostKeyChecking=no opc@${MYSQL_IP} sudo su - oracle -c 'mysql "catalog" < "/tmp/mysql_setup.sql"'
```

![](images/300/step17.png)

- Save and Execute the Build. Note you will get a pop-up from your parameterized build to confirm the MYSQL_IP. Leave the default value in place.

![](images/300/step19.png)

- Your build should execute successfully

![](images/300/step18.png)

### **STEP 4**: Bind the database to your microservice
- Open your main Dashboard Console. Select Application Container and open the service console

![](images/100/step27.png)

- You should see both of your Applications

![](images/300/step20.png)

- Select the MySQLMicroserviceDeploy Application

![](images/300/step21.png)

- Select the Deployments tab

![](images/300/step22.png)

- Select Add under Service Bindings

```

Service Type: MySQL CS Service
Service name: Catalog DB
Username: root
Password: Oracle123!
```

![](images/300/step23.png)

- Apply and Edit the changes to the MySQLMicroserviceDeploy application

![](images/300/step28.png)

- Once redeployment has finished you will see the service binding in the deployment details

> Note: Selecting the show all variables under environment variables will display all variables added that are associated with the binding

![](images/300/step24-1.png)

### **STEP 5**: Verify the Catalog Data

- Return to the main screen for Application Container Cloud Service

![](images/300/step25.png)

- Open the URL for the MySQLMicroserviceDeploy Application and append "/catalog/v1" to see the JSON data now available

```

ex: https://mysqlmicroservicedeploy-a458023.apaas.us6.oraclecloud.com/catalog/v1
```

![](images/300/step26.png)

- Return to the main screen for Application Container Cloud Service

![](images/300/step25.png)

- Select the URL for the CatalogDeployUI to see the catalog on screen and achievement 3 unlocked.

![](images/300/step27.png)

**You have now completed lab 300**
