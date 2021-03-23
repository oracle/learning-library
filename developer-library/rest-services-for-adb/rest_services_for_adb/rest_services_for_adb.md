# RESTful Services for your Autonomous Database

## Introduction

In this lab you will use the SQL Developer Web browser-based tool, connect to your Autonomous Database and REST enable tables and views and/or develop custom RESTful Services based on your SQL and PL/SQL code.

Estimated Lab Time: 30-45 minutes

### Objectives

- Enable a user for REST access
- Publish a RESTful service for a database table
- Secure the REST service

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.

## **STEP 1**: Create a user for Application Development

1. First, we want to create a database schema for our tables and data. We do this by creating a database user. To create a database user, we start by clicking the Database Actions Menu in the upper left of the page, then clicking Database Users in the Administration List. It is not good practice to use a SYS or SYSTEM user to create an application's tables, and neither is it good practice to use the ADMIN account to create applications.

    ![Database Actions Menu, Administration then Users](./images/sdw-1.png)

2. Now, click the Create User button on the left side of the page. This will slide out the Create User panel.

    ![Create User button on the left side of the page](./images/sdw-2.png)

3. Start by entering a user name. Let's use GARY as the username. Next we need to enter a password. The password must be complex enough to pass the password profile set by the database. The rules are as follows:

    Password must be 12 to 30 characters and contain at least one uppercase letter, one lowercase letter, and one number. The password cannot contain the double quote (") character or the username "admin".


    Once we enter the password twice, ensure the REST Enable button is on. This will allow us to use REST services with this database schema from the start. Your panel should look similar to the following image:

    ![Create User Slide Out Panel](./images/sdw-3.png)

4. Once you are ready, click the Create User button on the bottom of the panel to create the database user.

5. We next need to give this new user some space to create objects and data. For this, we need to go back to the SQL worksheet and run a simple statement. To get back to the SQL Worksheet, again click the Database Actions menu in the upper left and select SQL in the Development List.

    ![Database Actions Menu, Development then SQL](./images/sdw-4.png)

6. On the SQL Canvas, copy and paste the following statement:
    ````
    <copy>alter user gary quota unlimited on data;</copy>
    ````
    Once copied on the canvas, click the run button on the worksheet toolbar.

    ![Click RUN on the SQL Worksheet Toolbar](./images/sdw-5.png)

7. On the bottom of the worksheet, in the Script Output, you should see that the user Gary has been altered and the quota granted.

    ![SQL Output indicates User Altered](./images/sdw-6.png)


## **STEP 2**: Load data into the Database

We need to load some data into the database so that we can create some REST services upon those tables and data. To do this, we need to login as our newly created user. We have two ways to switch users.

**User Changing Method 1:**

1. The first method requires us to sign out and back in. Start by clicking the Admin user dropdown menu in the upper right, then selecting Sign Out.

    ![Sign Out is at the Admin user dropdown menu in the upper right](./images/sdw-7.png)

2. On the page the follows, click Sign In

    ![Click Sign In Button](./images/sdw-8.png)

3. On the next page, enter gary as the username and click Next

    ![Enter User Name, the click NEXT](./images/sdw-9.png)

4. And on the final page, enter the password you used when you created the user and click Sign In.

    ![Enter PASSWORD, then click Sign in](./images/sdw-10.png)

    This will bring you back to Database Actions but as the user we created.

    ![Database Actions Home Page](./images/sdw-11.png)

**User Changing Method 2:**

1. As the Admin user, in the upper left of the page, click the Database Actions Menu. In the Administration List, select Database Users; just as we did previously when creating Gary.

    ![Database Actions Menu, Administration then Users](./images/sdw-12.png)

2. Find Gary's user title and click the open-in-new-tab icon ![open-in-new-tab icon](./images/open-in-new-tab.png) on the lower right to open a new browser tab/window with a login box.

    ![GARY the user's Details Tile, click the open-in-new-tab icon](./images/sdw-13.png)

3. Enter Gary as the Username and then his password in the password field. Then click Sign in.

    ![Sign In Page, enter Username and Password](./images/sdw-14.png)

**Loading Data**

1. In either login method, we end up on the overview page. Now click the SQL tile.

    ![Database Actions Home Page, Click SQL tile](./images/sdw-15.png)

**If this is your first time accessing the SQL Worksheet, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

2. We are now ready to load data into the database. For this task, we will use the Data Loading tab in the SQL Worksheet.

    ![Click Data Loading Tab on SQL Worksheet](./images/sdw-16.png)

3. Start by clicking the Data Loading area; the center of the gray dotted-line box.

    ![Click the Center of the Data Loading Tab Area](./images/sdw-17.png)

4. The Upload Data into New Table model will appear.

    ![To upload a file, Drag into the File Load Modal or Click Select File and use the OS File Browser](./images/sdw-18.png)

5. We are going to use some sample data to load data into the database and create a table at the same time. Start by downloading this file

    **(right-click and download the file with the following link)**

    [May 2018 Earthquakes](https://objectstorage.us-ashburn-1.oraclecloud.com/p/tKIZjBqerdxe-PkpUv5cELZaMRcUIYu1LVe2EqPez8A5of0XTih2eLdVGGV0t1on/n/c4u03/b/developer-library/o/may2018.csv)

6. Once on your desktop, drag the file into the Upload Data into New Table model. You can also click the Select Files button and find where you downloaded it via your operating system's file browser.

    ![Click the Next Button](./images/sdw-19.png)

7. The modal will then give you a preview of what the data will look like in an Oracle table. Go ahead and click the Next button on the bottom right of the modal.

    ![View Data Preview and then Click Next Button](./images/sdw-20.png)

    On the following step of the data loading modal, we can see the name of the table we are going to create as well as the column and data types for the table.

    ![Data Column Layout from uploaded file](./images/sdw-21.png)

8. Let's edit a few of these columns. We need a Primary Key for our table. Here, we can use the ID column. Just click the PK checkbox for the ID row.

    ![Click the PK checkbox for the ID Column](./images/sdw-22.png)

9. Next, we want to take the TIME column and make it a TIMESTAMP type. Do this by selecting TIMESTAMP from the Column Type dropdown.

    ![Change the TIME column to a TIMESTAMP using the Column Type dropdown](./images/sdw-23.png)

10. Next, we need to set the timestamp format so that we can load it into the database. Just to the right of the Column Type you will find a Format Mask column. (You may need to use the horizontal scroll bar to see the column to the right)

    Enter the following into that column:

    **YYYY-MM-DD"T"HH24:MI:SS.FF3"Z"**

    You can check the image below for guidance.

    ![Change the Format Mask of the column](./images/sdw-24.png)

11. Next, we are going to change the LATITUDE, LONGITUDE, DEPTH and MAG columns to NUMBER column Types. Again, use the Column Type dropdown select list to choose NUMBER for each of them. We also need to set the SCALE of each of these columns so that we retain the values to the right of the decimal point.

    Set the scale to 7 for LATITUDE, 7 for LONGITUDE, 3 for DEPTH, and 3 for MAG.

    ![Change the Column Type of the 4 columns to Number and set the Scale](./images/sdw-25.png)

12. Click Next on the bottom right of the modal when done.

    On the last step of the modal, we can see the DDL (Data Definition Language) for creating the table, table name and if you scroll down, the column mappings.

    ![The Data Definition Language preview for the table and data](./images/sdw-26.png)

13. When you are done taking a look, click the Finish button in the lower right of the modal.

    ![Click Finish in the Data Loading Modal](./images/sdw-27.png)

    The Data Loader will now process the file by creating a table and loading the CSV file data into that table. 

    ![Data Will Load Into the Database indicated by the Uploading Data Modal](./images/sdw-28.png)

    Once its done, you will see a row in the Data Loading tab that indicates how many rows were uploaded, if any failed and the table name.

    ![Row indicating data load is finished in the Data Loading Tab of the SQL Worksheet](./images/sdw-29.png)

14. We can take a look at our newly created table and the data in it by using the navigator on the left of the SQL Worksheet. Just right click the table name and select Open from the pop up menu.

    ![Using the navigator on the left of the SQL Worksheet, we can see out new table](./images/sdw-30.png)

    In the slider that has come out from the right of the page, we can look at the data definition, triggers, constraints and even the data itself.

    ![Click the Data option to view the table data](./images/sdw-31.png)

## **STEP 3:** Auto-REST Enable a Table

1. REST enabling a table couldn't be easier. To do this, find the table we just created named MAY2018 in the navigator on the left of the SQL Worksheet.

    ![Using the navigator on the left of the SQL Worksheet, find the MAY2018 Table](./images/sdw-32.png)

2. Right click on the table name and select REST in the pop up menu then Enable.

    ![Right click on the table name and select REST in the pop up menu then Enable](./images/sdw-33.png)

    The REST Enable Object slider will appear from the right side of the page. We are going to use the defaults for this page but take note and copy the Preview URL. This is the URL we will use to access the REST enabled table. When ready, click the Enable button in the lower right of the slider.

    ![The REST Enable Object Slider, view the Preview URL](./images/sdw-34.png)

3. Thats it! Your table is REST enabled. Open a new browser window or tab and enter that URL we copied in the previous step. We will see our table data in JSON format via a REST service.

    ![Open a new browser window or tab and enter that URL we copied in the previous step](./images/sdw-35.png)

    You can also see a plug icon ![plug icon](./images/plug-icon.png) next to the table to indicate it is REST enabled.

    ![Plug Icon Next to table in navigator](./images/sdw-36.png)

4. We can work with the REST endpoints by using cURL commands that the SQL Worksheet can provide to us. To get to these endpoints, again right click the table name as we did in the previous step, select REST, then cURL Command.

    ![right click the table name in the navigator, select REST, then cURL Command](./images/sdw-37.png)

    On the right of the page, we see the cURL for the table MAY2018 side out panel.

    ![the cURL for the table MAY2018 side out panel](./images/sdw-38.png)

5. Here we can work with the various REST endpoints. GET ALL is the URL we tried out in the browser previously. Let's take a look at getting a single row. Click on GET Single and you will see a form field for the ID column. Enter **hv70116556** and click the Next button on the lower right of the slide out.

    ![Click the GET Single item, then enter the value. Now Click Next on the bottom right](./images/sdw-39.png)

    We now have the REST endpoint for getting a single record.

    ![REST endpoint for getting a single record](./images/sdw-40.png)

6. You can grab the URL and put it into a browser window,

    ![REST endpoint for getting a single record in a browser](./images/sdw-41.png)

    or you can copy the curl command and run it where curl is available. If you are unsure if you have curl installed locally or do not want to install it, we can use the OCI cloud shell. While logged into the OCI console, you can click the Cloud Shell icon in the upper right of the page.

    ![In the OCI Web Console, click the Cloud Shell icon in the upper right of the page](./images/sdw-42.png)

    This will open a console where you can run the curl command.

    ![Cloud Shell on bottom of the OCI Console web page](./images/sdw-43.png)

    The cURL for the table MAY2018 side out also will help you construct REST endpoints for update, delete and insert actions.

## **STEP 4**: Securing the REST Endpoint

**If this is your first time accessing the REST Workshop, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

1. So, we have a REST enabled table ready to be used by our applications but we need to ensure not just anyone can use it; we need to secure access to the table. To do this, let's use the Database Actions menu in the upper left of the page and choose REST.

    ![Database Actions Menu, Development then REST](./images/sdw-44.png)

2. The REST pages let you create REST endpoints just as we did with the auto REST option. Here, we want to select the Security Tab on the top of the page and then select OAuth Clients.

    ![On the Top Menu Bar, click Security Tab then select OAuth Clients](./images/sdw-45.png)

3. To create our OAuth client, we will secure our REST endpoints with, click the Create OAuth Client button in the upper right of the page.

    ![Click the Create OAuth Client button](./images/sdw-46.png)

4. The Create OAuth Client slider will come out on the right of the page. In this form we first need to name our OAuth Client. We can name it **garysec**. Next we can give it a description; anything will do here. The follow field, support URI, is where a client will be taken upon an authorization error or failure. Finally, we need an support email for contacting someone. Once your form looks similar to the image below:

    ![The OAuth Client Slide Out Panel](./images/sdw-47.png)

5. Click the Roles tab on the top of the Create OAuth Client slider

    ![Click the Roles tab on the top of the Create OAuth Client slider](./images/sdw-48.png)

6. Now, use the shuttle to move the Role **oracle.dbtools.role.autorest.GARY.MAY2018** over to the right side, then click the Create button on the lower right. Moving the Role says that we want all REST services with this role to be secure and by using the auto REST feature, the service has created a role for us and all the endpoints we have used in this lab.

    ![use the shuttle to move the Role over to the right side, then click the Create button](./images/sdw-49.png)

    We now have an OAuth Client we can secure our REST service with.

    ![Created OAuth Client Details Tile](./images/sdw-50.png)

7. Before we secure the REST endpoint, we need to get a token to pass to the secured REST service once its enabled. To get this token, we can click the pop out menu icon ![pop out menu icon](./images/three-dot-pop.png) on our OAuth tile and select **Get Bearer Token**.

    ![click the pop out menu icon on our OAuth tile and select Get Bearer Token](./images/sdw-51.png)

8. The OAuth Token modal will provide the token text in **Current Token** field. You can use the copy icon ![copy icon](./images/copy-copy.png) to copy this text. Save it because we will need it when calling the secured REST service. The modal also gives us a curl command to get a token if we need to include this in our applications.

    ![Click the copy icon to save the Token Text](./images/sdw-52.png)

9. Time to secure the REST service. Using the tab bar on the top of the page, select AutoREST.

    ![Use the tab bar on the top of the page, select AutoREST](./images/sdw-53.png)

10. Here we can see the table we autoREST enabled previously. Click the pop out menu icon ![pop out menu icon](./images/three-dot-pop.png) on the MAY2018 title and select Edit.

    ![Click the pop out menu icon on the MAY2018 title and select Edit](./images/sdw-54.png)

11. In the REST Enable Object slider, click the Require Authentication toggle button, then click Save in the lower right of the slider. That's it, the service it now secure.

    ![click the Require Authentication toggle button then click Save in the lower right of the slider](./images/sdw-55.png)

12. We can try out this security using curl and the OCI Cloud Shell. We can immediately see that we have a new green lock icon on out autoREST table tile. To see the new curl commands, use the pop out menu icon ![pop out menu icon](./images/three-dot-pop.png) and select Get Curl.

    ![Use the pop out menu icon and select Get Curl](./images/sdw-56.png)

13. We are going to use the GET Single curl command just as we did before. Start by clicking on Get Single, enter **hv70116556** in the ID field and click the Next button on the lower right of the slide out.

    ![clicking on Get Single, enter the above value in the ID field and click the Next button on the lower right of the slide out](./images/sdw-39.png)

14. On the following page of the slider, we can see the curl command now contains some header information:

    **--header 'Authorization: Bearer VALUE'**

    ![curl command now contains some header information](./images/sdw-57.png)

    and if we run the original curl command using the OCI Cloud Shell without this information, we get Unauthorized:

    ````
    > curl --location \
    'https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/hv70116556'

    {
        "code": "Unauthorized",
        "message": "Unauthorized",
        "type": "tag:oracle.com,2020:error/Unauthorized",
        "instance": "tag:oracle.com,2020:ecid/c755a84b26f02aba9ce630f831ee721c"
    }
    ````

15. Take the token text we previously copied and replace <VALUE> in the curl command with that text. Then run the curl command using the OCI Cloud Shell:

    ````
    > curl --location '\
    https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/hv70116556' \
    --header 'Authorization: Bearer yuNINeg1uqHIivqDDgJnfQ' 
    ````

16. We can see that we have been authenticated and are able to use the REST endpoint to retrieve the record.

    ````
    {"id":"hv70116556","time":"2018-05-04T22:32:54.650Z","latitude":19.3181667,"longitude":-154.9996667,"depth":5.81,
    "mag":6.9,"magtype":"mw","nst":"63","gap":"210","dmin":"0.11","rms":"0.11","net":"hv","updated":"2020-08-15T02:55:22.135Z",
    "place":"19km SSW of Leilani Estates, Hawaii","type":"earthquake","horizontalerror":"0.52","deptherror":"0.31",
    "magerror":null,"magnst":"10","status":"reviewed","locationsource":"hv","magsource":"hv","links":[{"rel":"self",
    "href":"https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/hv70116556"},{"rel":"edit",
    "href":"https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/hv70116556"},
    {"rel":"describedby","href":"https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/metadata-catalog/may2018/item"},
    {"rel":"collection","href":"https://myrestenabledtable-dcc.adb.us-ashburn-1.oraclecloudapps.com/ords/gary/may2018/"}]}
    ````

## Conclusion

In this lab, you had an opportunity to get an introduction to REST services using an easy to follow User Interface. REST enable your tables and database objects in minutes with zero code.

## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - February 2021
- **Workshop Expiry Date** - February 2022
