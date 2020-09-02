![](./media/labs.jpg)

## Who Should Complete This Lab: All Participants

# Connecting to Autonomous Database

## Table of Contents

- [Module 1: Download Client Credentials](#module-1--download-the-client-credentials-wallet)
- [Module 2: Explore credentials wallet file information](#module-2--examining-the-wallet-file)
- [Module 3: Connect to your ATP instance with SQL Developer](#module-3--connecting-to-the-database-using-sql-developer)
- [Module 4: Connect to your ATP instance with Oracle ML Notebooks](#module-4--connecting-to-the-database-using-oracle-machine-learning-oml)

***** 

## Module 1:  Download the Client Credentials (wallet)

The Client Credentials, also known as the wallet, provides the only authentication information that
can be used to connect to your ATP database. This wallet must be
downloaded to the client that will be connecting to the database. The
wallet can be downloaded from two locations, the Database Details page
or the Service Console

1. The wallet is downloaded from the **Administration** page in the ATP
service console. Continuing from where we left off in the previous lab,
select **Download Client Credentials:**

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.23.10%20PM.png](./media/image2.png)
<p align="center">Figure 1-1</p>

2. Specify a password of your choice for the wallet. Note that this
password is separate from the **Admin** password created during the database provisioning lab (but the same actual password can be used again). Make sure you know where the file
gets downloaded to so you can find it on your system.

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.23.30%20PM.png](./media/wallet1.jpg)
<p align="center">Figure 1-2</p>

3. If you completed the previous step successfully you can proceed to Module 2. **Alternatively** you can download the wallet using the DB Connection button in the main Database
Details page to download the credentials:

![](./media/wallet2.jpg)
<p align="center">Figure 1-3</p>

4. This step opens up a screen where the wallet can be downloaded as well as
connection strings be copied from (more on this in other modules)

![](./media/wallet3.jpg
)

[Back to Top](#table-of-contents) 
***** 

## Module 2:  Examining the Wallet File

1. Navigate to the location in your system where the file was downloaded
(typically your DOWNLOADS directory). 
2. In this example the file will be called *wallet\_ATPXWEEK.zip*, the format of the file is always
“wallet\_$dbname.zip”. 
3. Extract the contents of the wallet into a
directory (using a zip utility, usually by right clicking on the file),
you will find the following files:

![](./media/image6.png)
<p align="center">Figure 2-1</p>

4. There are 4 files you will be working with during the different labs.
Some tools use the wallet file (.zip) and some use specific files
contained in the wallet. The files used in the labs are:

1.  **wallet\_ATPXWEEK.zip** – the wallet itself

2.  **sqlnet.ora** – points to the location of the wallet for sqlnet
    connections

3.  **tnsnames.ora** – connection description for the database service
    (please note this file contains connection description for all the
    databases that exist in that cloud account)

4.  **ojdbc.properties** – points to the location of the wallet for jdbc
    connections
    
[Back to Top](#table-of-contents)   

***** 

## Module 3:  Connecting to the Database using SQL Developer 

**PLEASE NOTE: SQL DEVELOPER CONNECTONS DO NOT WORK IF YOU ARE BEHIND THE VPN OR ON ORACLE OFFICE PRIVATE NETWORKS. IF YOU ARE USING THE VPN CLIENT YOU MUST DISCONNECT FROM VPN, AND FROM AN ORACLE OFFICE CONNECT TO AN OPEN/PUBLIC ACCESS NETWORK**

*(Make sure you are running the latest version of SQL Developer. Some older versions will not work with ADB, see lab introductions on how to install)*

1. Start SQL Developer (by clicking the icon on your desktop or selecting
from the Windows Start menu) and create a connection for your database
using the ADB Database account that was created for you in the previous lab by following these steps.

2. Click the **Create Connection** icon in the Connections toolbox on the
top left of the SQL Developer homepage.

![](./media/image7.png)
<p align="center">Figure 3-1</p>

3. The new Database Connection screen will appear:

![](./media/5e7ce7da8b1304d89cfad7c628942219.png)
<p align="center">Figure 3-2</p>

4. Fill in the connection details as below:

**Name:** pick a connection name

**Database Type:** Oracle

**Authentication Type** Default

**Username:** the database user name that was created for you

**Password:** the database user password created for your account

**Role** Default

**Connection Type:**  Cloud Wallet

**Configuration File:** Enter the full path for the wallet file you downloaded before, or click the Browse button to point to the location of the file.


![../Desktop/Screen%20Shot%202019-04-22%20at%2012.24.09%20PM.png](./media/image9.png)
<p align="center">Figure 3-3</p>

**Service:** Many services may be listed but make sure you pick the one for with the database name you created. In this example its **atpxweek\_TP. For this lab pick any of the services that contain your database name.

5. Test your connection by clicking the **Test** button, if it succeeds proceed to step 6. If your test failed to successfully connect to your database, the most likely reasons are:
-   you are connected to VPN or in an Oracle office not on the public network
-   that you used an incorrect password (or username and password)
-   you are behind the Oracle VPN - you need to be in a public network
-   you selected the wrong Service for your database

Verify that all this information is correct and try your test again. Save your connection once the test succeeds.

6. Click on **Save Password** so you don't have to re-type your password every time you connect to the database.

7. Save your connection information by clicking **Save**

8. Connect to your database by clicking the **Connect** button.

9. See below for completed input and test. Notice also that after you save
your connection it will appear on the list of connections on the top
left corner of the main dashboard, under connections.

![](./media/77e7f1ed47bd7ef10eee546c361aac8a.png)
<p align="center">Figure 3-4</p>

10. Now that you are connected run test a query. The ATP (or ADW) database
you created contains the sample Oracle Sales History (SH) schema, we
will use this schema to run a test query to make sure everything is
working correctly. 

12. Copy the SQL below and paste it on the query builder
screen in SQL Developer (with standard Windows copy and paste), then
click F5 or the “Run Script” button as indicated below. Make sure you
are connected to your database, per the last step on the previous
process.

```
    SELECT channel_desc, TO_CHAR(SUM(amount_sold),'9,999,999,999')
    SALES$,  
    RANK() OVER (ORDER BY SUM(amount_sold)) AS default_rank,  
    RANK() OVER (ORDER BY SUM(amount_sold) DESC NULLS LAST) AS
    custom_rank  
    FROM sh.sales, sh.products, sh.customers, sh.times, sh.channels,
    sh.countries  
    WHERE sales.prod_id=products.prod_id AND
    sales.cust_id=customers.cust_id  
    AND customers.country_id = countries.country_id AND
    sales.time_id=times.time_id  
    AND sales.channel_id=channels.channel_id  
    AND times.calendar_month_desc IN ('2000-09', '2000-10')  
    AND country_iso_code='US'  
    GROUP BY channel_desc;
```

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.28.36%20PM.png](./media/image11.png)
<p align="center">Figure 3-4</p>

13. And you will see the result of your query on the bottom **Script Output** section

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.28.45%20PM.png](./media/image12.png)
<p align="center">Figure 3-5</p>

**You have successfully connected and run an operation against ATP with SQL Developer. We will use SQL Developer throughout other labs.**

[Back to Top](#table-of-contents) 
***** 

## Module 4:  Connecting to the Database using Oracle Machine Learning (OML)

Another tool that can be used to connect and develop in ATP is the
included Oracle Machine Learning OML Notebook based environment. Because
OML is easy to access from anywhere and included with the ATP service it
provides an easy and fast environment to work with ATP. This
browser-based application provides a web interface to run SQL queries
and scripts, which can be grouped together within a notebook. Notebooks
can be used to build single reports, collections of reports and
dashboards. OML provides a simple way to share workbooks with other OML
users.

## OML Key Features

  - Collaborative SQL notebook UI for data scientists  

  - Packaged with Oracle Autonomous Transaction Processing Cloud Service

  - Easy access to shared notebooks, templates, permissions, scheduler,
    etc.

  - Access to 30+ parallel, scalable in-database implementations of
    [machine learning
    algorithms](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/dmcon/algorithms.html#GUID-B901A29B-218C-4F37-91E0-AA94631364E3)

  - SQL and PL/SQL scripting language support

  - Enables and Supports Deployments of Enterprise Machine Learning
    Methodologies.

In this section you will connect to OML with the **OML** user that was created for you in the earlier lab and you will run the same query in OML you just ran above in SQL Developer to test your connection. In a later lab you will explore more about OML.

1. If you are not already logged into the ATP Service Console, in the main
ATP service page select Service Console:

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.28.53%20PM.png](./media/image13.png)
<p align="center">Figure 4-1</p>

2. On the next **if prompted**,  page log in with your ADMIN ATP user name/password  (this is the password you created when you provisioned the Autonomous Database in Lab 2) and click **Sign in:**

3. Select Administration from the left and once on the Administration
page select **Manage Oracle ML Users**:

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.29.00%20PM.png](./media/image14.png)
<p align="center">Figure 4-2</p>

4. This will place you in the OML Login Page. To connect to OML as your user,
click on the Home Icon on the top right, pointed at by the arrow (or the
link you received by email). This will open up a new tab with the OML
home page. In this page log in with the OML username and password that was created for you in an earlier lab. Please note the OML username and password are different than your Oracle Cloud, and Autonomous Database username and password. 

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.29.27%20PM.png](./media/image18.png)
<p align="center">Figure 4-3</p>

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.29.36%20PM.png](./media/image19.png)
<p align="center">Figure 4-4</p>


5. You are connected as an OML Notebook user. Run the same query we ran in
SQL Developer now in OML. Select **Run SQL Scripts** from Quick Actions:

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.29.44%20PM.png](./media/image20.png)
<p align="center">Figure 4-5</p>

6. Copy the same SQL statement you ran in SQL Developer above and paste it
right under the **%script** statement then select the **Run all
Paragraphs** icon, as shown below:

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.29.49%20PM.png](./media/image21.png)
<p align="center">Figure 4-6</p>

7. The results are shown below (and same as on SQL Developer):

![../Desktop/Screen%20Shot%202019-04-22%20at%2012.29.55%20PM.png](./media/image22.png)
<p align="center">Figure 4-7</p>

**You have successfully connected and run an operation against ATP with Oracle OML. We will use OML in other labs.**

***END OF LAB***

[Back to Top](#table-of-contents)   
