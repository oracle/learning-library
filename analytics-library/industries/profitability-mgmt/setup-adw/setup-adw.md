# Setup Autonomous Data Warehouse

## Introduction

This lab walks you through the steps to get started using the Oracle Autonomous Database (Autonomous Data Warehouse [ADW] on Oracle Cloud. You will provision a new ADW instance and connect to the database using Oracle SQL Developer Web. Create tables and Load data from excel.

*Note: While this lab uses ADW, the steps are identical for creating and connecting to an ATP database.*

Estimated Lab Time: 15 minutes

### About Product/Technology
Provisioning Oracle Autonomous Database, Oracle SQL Developer web.

### Objectives

* Learn how to provision a new Autonomous Database. Create tables and load data from excel.

In this lab, you will:
* Provisioning Oracle Autonomous Database
* Connect to Autonomous Database using SQL Developer
* Import Data Files into the Autonomous Database

### Prerequisites

* The following lab requires an Oracle Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, a Free Tier account, a LiveLabs account or a training account whose details were given to you by an Oracle instructor. 

* Creation of Tables. Download the sql file and execute it using the Oracle SQL Developer web. Download the [Create file](files/starter-file.sql) SQL code.
  
* Upload the Data in Tables using the Oracle SQL Developer web.  Download the [Data file](files/starter-file.sql) SQL code.

## **STEP 1**: Provisioning Oracle Autonomous Database

1. On the Dashboard Home page, click either the Create a data warehouse instance area:
![Image alt text](images/ADW1.JPG "Image title")

2. or click the hamburger menu from the upper left part of the screen and select Autonomous Data Warehouse.
![Image alt text](images/ADW2.JPG "Image title")

3. Click Create Autonomous Database blue button to create a new service instance.
![Image alt text](images/ADW3.JPG "Image title")

4. In the next window you will be prompted to choose a Compartment, Display name, Database name, Workload type. 
The OCI Console launches and it will bring you to the Autonomous Data Warehouse page. 
Autonomous Data Warehouse, as Autonomous Transaction Processing are both deployed on OCI datacentres and can be created from within the OCI interface depending on your needs.

5. Next, you are prompted to choose a compartment if you already have one created in this regard or use the default root compartment. In our case we are going to choose the DEMO compartment where the ADWC instance will be created.
![Image alt text](images/ADW4.JPG "Image title")

6. Next, enter: 
Display name – Choose a unique display name. In our case we will use OACDEMO3 
Database Name – Choose a unique database name. In our case is OACDEMO3

7. Choose a workload type: 
![Image alt text](images/ADW5.JPG "Image title")

8. Next, configure the database: 
CPU Count: 1 
Storage Capacity (TB): 1 
Auto scaling - Allows system to use up to three times the provisioned number of cores as the workload increases. We will leave the Auto scaling feature unticked for now.
![Image alt text](images/ADW6.JPG "Image title")

9. In the Create administrator credentials section enter the Administrator (ADMIN) Password and confirm the password: 
Administrator Password: 12 Characters password like Welcome12345 
Also tick the License Included Subscribe to new Oracle Database software licenses and the Database service button.
![Image alt text](images/ADW7.JPG "Image title")

10. Scroll down and click Create Autonomous Database blue button to confirm. 
![Image alt text](images/ADW8.JPG "Image title")

11. Notice that the instance is on provisioning state.
![Image alt text](images/ADW9.JPG "Image title")

12. Once the service is provisioned click on its name to open the Service Overview page 
![Image alt text](images/ADW10.JPG "Image title")

13. Check the Service Overview page regarding more details on your ADW instance.
![Image alt text](images/ADW11.JPG "Image title")
![Image alt text](images/ADW12.JPG "Image title")

## **STEP 2:** Connect to Autonomous Database using SQL Developer

1. The first step in accessing the credentials is to log in to the Service Console associated to your ADW instance. To do that, click on the Service Console button in the OACDEMO3 overview.
![Image alt text](images/ADW13.JPG "Image title")

2. Next, when prompted, login to the Service Console with the following credentials: 
Username: ADMIN 
Password: Welcome12345 
Note: this is the password you have set during the provisioning of the service. 

3. On the home page, click the Administration menu on the left side of the page. 
![Image alt text](images/ADW14.JPG "Image title")
![Image alt text](images/ADW15.JPG "Image title")

4. Click Download Client Credentials. 

5. Enter a password before downloading the wallet .zip file containing the credentials. This password will protect the sensitive data residing in the file. You may also use Welcome12345 as the password and then re-type it for confirmation. 
Click Download and save the file on your local computer.
![Image alt text](images/ADW16.JPG "Image title")

A zip archive with the wallet was downloaded:
![Image alt text](images/ADW17.JPG "Image title")
Next, we will open Oracle SQL Developer and create a connection to our ADW instance there. 

6. Open Oracle SQL Developer and click to create a new connection. 
![Image alt text](images/ADW18.JPG "Image title")

7. Fill in the details in order to connect to the database: 
Connection Name: OACDEMO3RET 
Username: ADMIN 
Password: Welcome12345 
Connection Type: Cloud Wallet 
Role: default 
Configuration File: Browse to the location of the zipped (.zip) wallet file and select it. 
Keystore Password: Welcome12345 
Note: The Keystore Password is the one you selected for your wallet before downloading it. The Service that you need to choose is the name you previously gave to your service when provisioning it. 
Service: oacdemo3_high - it is the service of the OACDEMO3 instance created which leads to the consumer „high” group.
![Image alt text](images/ADW19.JPG "Image title")

Click Test to check the connection. 
Note: If you are behind a Proxy, please also fill in the details within the Proxy tab. 

8. If the test is successful Save the connection and afterwards click Connect to access the database. 
We have now connected to our database. The next step will be to load data into the ADWC instance by also using the Oracle SQL Developer tool.

## **STEP 3:** Import Data Files into the Autonomous Database

1. Import the Data Files in Tables using the Oracle SQL Developer. Download the Data Files
   [Financial Data file](files/Financial.xlsx),
   [HRLeavers Data file](files/HR_Leavers.xlsx),
   [keyrevenuekpis Data file](files/key_revenue_kpis.xlsx),
   [MLForecast Data file](files/ML_Forecast.xlsx),
   [Payroll Data file](files/Payroll.xlsx),
   [TaxExpenses Data file](files/Tax_Expenses.xlsx),
   [TopDeal Data file](files/Top_Deal.xlsx).

You may proceed to the next lab.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Adapted for Cloud by** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
