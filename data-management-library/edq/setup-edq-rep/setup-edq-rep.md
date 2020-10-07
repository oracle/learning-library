# Access and Configure EDQ Instance

## Introduction
This lab will show you how to access an EDQ instance using Apache Guacamole and create a new project in EDQ.

### Objectives
* Access an EDQ Instance through Apache Guacamole
* Start EDQ Director
* Create New Project
* Create a Data Store and a Snapshot

## **Step 1:** Access an EDQ instance through Apache Guacamole

1. Obtain the Apache Guacamole URL, credentials from the instructor and login into it using any browser.

    ![](./images/guacamole.png " ")
2. Select "edqvnc" option after you login into the Guacamole.
   
    ![](./images/edq_config_1.png " ")

3. Go to Applications -> Favorites -> Firefox.

    ![](./images/browser_1.png " ")    

4. Go to weblogic console and provide the login crendentials (weblogic/oraedq123).
   
   **URL:** http://localhost:7001/console

    ![](images/weblogic_1.png)

    **Note:** If weblogic console is not working, run edq\_start\_up.sh script. This script will take 5 minutes to execute.

5.	In the login page, click on servers.

    ![](images/weblogic_2.png)

6.  If you see EDQ server and Admin server are running, you are good to proceed further.

    ![](images/weblogic_3.png)


## **Optional:** EDQ Start Script

1. Right click on Home screen and select "Open Terminal".

    ![](images/open_terminal.png)

2. Sudo to oracle user and run the edq\_start\_up.sh script to start the EDQ application.
   
    ````
   <copy>
    sudo su - oracle
    sh /home/oracle/scripts/edq_start_up.sh
   </copy>
    ````
     
This script will approximately take 5-10 minutes to start the Node Manager, Weblogic and EDQ Services.

Please login into weblogic console and check if all the EDQ services are up and running after 5 minutes.


## **Step 2:** Start EDQ Director and Create new project in EDQ

1.	Open a web browser, go to EDQ Launchpad and click on “Director”.

    **URL:** http://localhost:8001/edq 

    ![](./images/image1200_5.png)

2.	Click “OK” to accept opening the program

    ![](./images/image1200_6.png)

3.	Wait a few minutes, you will receive a new message, click on “Run”

    ![](./images/image1200_7.png)

4.	EDQ director will appear on your screen. Provide the Director login credentials (weblogic/oraedq123).

    ![](./images/image1200_4.png)

5. Take a moment to familiarize yourself with the Terminology of each of the four different areas of the Director application

    ![](./images/image1200_8.png)

## **Step 3:** Create a New Project
1.	In the "Project Browser", right-click "Projects" and select "New Project…" to start the wizard 

    ![](./images/image1200_9.png)

2.	Provide the following information:
    - Name: Exploring Customer Data
    - Description: Data Quality Project to Profile, Standardize, Match and Merge customer data
3.	Click on “Next >” button located at the bottom right corner

    ![](./images/image1200_10.png)

4.	Ensure the “All Groups” checkbox is selected in “Project Permissions”; then click “Finish” button located at the bottom right

    ![](./images/image1200_11.png)

The “Exploring Customer Data” project now appears in the Projects list!

## **Step 4:** Create a Data Store and a Snapshot
Now that we have created a project, the next step is creating a Data Store. A Data Store is a connection to a source of data, whether the data is stored in a database or in one or more files.
1.	Expand the newly created project “Exploring Customer Data”, right click “Data Stores”, and select “New Data Store” to launch the wizard

    ![](./images/image1200_12.png)

2.	Select "Server" on “Data is accessed from” field.
3.	Leave “Database” on “Category” field
4.	Select “Oracle” on the “Type” list and click “Next >” to continue

    ![](./images/image1200_13.png)

5.	Provide the following data:
    - Database host: **localhost**
    - Port: **1521**
    - Database name: **orcl.us.oracle.com**
    - Name type: **Service**
    - User name: **EDQ\_SRC**
    - Password: **oraedq**
    - Schema: 

6.	Click on “Test…” button located on the bottom right corner

    ![](./images/image1200_14.png)

7.	When all information is correct, you will receive a message about connection success, click “OK”

    ![](./images/image1200_15.png)

8.	Click on “Next > ” button located on the bottom right corner
9.	Provide the following information
    - **Name**: Connection to Oracle Database
    - **Description**: Connection to US Custom Data
10.	Click on “Finish” button located on the bottom right corner

    ![](./images/image1200_16.png)

11.	Now we will use this new connection and select a table for profiling and cleansing; the goal is to stage some of the data so we can begin to understand it. Right click “Staged Data” under your project and select “New Snapshot…”

    ![](./images/image1200_17.png)

12.	Select the newly created database connection, then click “Next >” to continue

    ![](./images/image1200_18.png)

13.	In “Table Selection”, select "US_Customers" from the list.  Click “Next >” to continue

    ![](./images/image1200_19.png)

14.	In “Column Selection”, ensure all columns are selected, then click “Next >” to continue

    ![](./images/image1200_20.png)

15.	In “Filter Options”, leave the default value of Simple and click “Next >” to continue

    ![](./images/image1200_21.png)

16.	Sampling Options allows to specify the amount of data brought to the snapshot. If needed, it is possible to specify a certain “Count” or “Percentage” of data to be read for the snapshot. Leave the default and click “Next >“

    ![](./images/image1200_22.png)

17.	Leave the default empty value for the ‘No Data’ Reference Data field, click on “Next >“

    ![](./images/image1200_23.png)

18.	Provide the following data:
    - **Name**: US Customer Data
    - **Description**: Connection to Oracle Database.US_CUSTOMERS

19.	Verify that checkbox “Run Now?” is checked and click on “Finish”

    ![](./images/image1200_24.png)

After a short delay, the Results Browser panel is populated. Taking the Snapshot causes EDQ to stage the data from the database into the EDQ data repository. From now on we will be working with the data residing in the "US_Customer" Data Snapshot and we will not be modifying or in any way accessing the source data.


Congratulations!  Now you have the environment to run the EDQ labs.   

## Acknowledgements

 - **Author** - Ravi Lingam, September 2020
 - **Contributors** - Narayanan Ramakrishnan, Sri Vishnu Gullapalli
 - **Reviewer** - Sudip Bandyopadhyay, Winston Shirley
 - **Last Updated By/Date** - Sri Vishnu Gullapalli, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
