# Low Code Development with APEX and DevCS CI/CD

## Before You Begin

### Introduction

In this lab you will create a new APEX workspace and appliction using a file upload, and then reference the Product Catalog REST Endpoint in your APEX application.  When finished, you will leverage DevCS to clone the APEX application.

Estimated time: 30 minutes

### Objectives
- Log into OCI tenancy.
- Develop an APEX Application leveraging microservice REST Endpoint.
- Use DevCS CI/CD to push APEX changes from Development to Production.

### Prerequisites
- Successful completion of Lab 3 and creation of a REST service for products.

*In addition to the workshop*, feel free to watch the walkthrough companion video by clicking on the following image:
[](youtube:RWjzYN3PpdM)

## **STEP 1:** Log into your OCI Tenancy

   Log in to your OCI dashboard and retrieve information required to create resources.

1. From any browser go to oracle.com to access the Oracle Cloud.

    [https://www.oracle.com/](https://www.oracle.com/)

  ![](../images/common/login-screen.png " ")

2. Click the icon in the upper right corner.  Click on **Sign in to Cloud** at the bottom of the drop down.   

  ![](../images/common/signup.png " ")   

3. Enter your **Cloud Account Name** in the input field and click the **Next** button.  *NOTE: this is NOT your email. This is the name of your tenancy noted in the email you received during signup. Do NOT click the Sign-In button, this will take you to Single Sign-On, not the Oracle Cloud.*

  ![](../images/common/cloud-login-tenant.png " ")   

4. Enter your username (this may be your email address) and password and click on **Sign In**. 
    
  ![](../images/common/username.png " ")  

## **STEP 2:** Create an API Gateway to Access the REST Service

1. Due to ATP restrictions regarding access to web services we will use the **API Gateway** to address this.  Navigate to the **API Gateway** through the console menu - **Developer Services**.

  ![](images/071.png " ")

2. Select the **AppDev** Compartment then click **Create Gateway**.

  ![](images/072.png " ")

3. Enter the following details to create the gateway.

  ![](images/073.png " ")

4. Select the **Subnet** assigned to the API Gateway to add an **Ingress Rule** for port **443** so the API Gateway can communicate.  

  ![](images/102.png " ")
  
  ![](images/103.png " ")

  ![](images/104.png " ")

  ![](images/105.png " ")

5. Return to the API Gateway **productServices** and select **Deployments** on the left, then **Create Deployment**.  Follow these steps.

  ![](images/074.png " ")

  ![](images/075.png " ")

  ![](images/076.png " ")

  ![](images/077.png " ")

6. The service will take a few seconds to create.

  ![](images/078.png " ")

7. Prior to leaving this page copy the API endpoint URL and save in a notepad for use in the following steps.

  ![](images/079.png " ")

8. Open a new browser window.  Paste this URL into the browser and append /products to test it.

  ![](images/080.png " ")

## **STEP 3:** Create a New APEX Workspace

1. Navigate to your ATP instance.

  ![](images/001.png " ")

2. Select the **ProductCatalog** database.

  ![](images/002.png " ")

3. Got to the **Service Console**, and then **Development**.

  ![](images/003.png " ")

  ![](images/004.png " ")

4. Select **Oracle APEX**.

  ![](images/005.png " ")

5. Click on **Workspace Sign-In** below the **Sign In to Administration** button, enter workspace name **internal**, and your **admin** userid and password.

  ![](images/006.png " ")

6. Select **Create Workspace**.

  ![](images/007.png " ")

7. Enter the **alpha** userid

  ![](images/008.png " ")

8. Sign out and then back in.

  ![](images/009.png " ")

  ![](images/010.png " ")

9. Sign in with your **alpha** workspace, userid and password'

  ![](images/011.png " ")

10. Select **Set APEX Account Password**.

  ![](images/012.png " ")

11. Enter a valid email address and then reset your password.  NOTE: this **alpha** user is and APEX user, not a database user (even though it is the same name).

  ![](images/013.png " ")

## **STEP 4:** Create a New APEX Application from a csv File

Steve has been using spreadsheets to create product forecasts.  He will take one of the existing spreadsheets and use that to build out a new APEX application.

1. Download the spreadsheet using [this link](https://objectstorage.us-ashburn-1.oraclecloud.com/n/natdcshjumpstartprod/b/spw-appDev-DevOps-files/o/product_forecast.csv).

2. It is always easier to learn when you have examples.  Review the **App Gallery**.

  ![](images/014.png " ")

3. There are many great example apps that can be used as examples.  Click on the **Sample Charts** application.

  ![](images/015.png " ")

  ![](images/016.png " ")

4. Install the application.

  ![](images/017.png " ")

  ![](images/018.png " ")

5. Run the app.

  ![](images/019.png " ")

  ![](images/020.png " ")

6. Select some charts for review (not shown here).  There are many rich visuals to choose from.  We'll be using some of these later.

7. Click on the **Home** link at the bottom of the page.

  ![](images/021.png " ")

8. Return to the App Gallery.  Note the Sample REST Services App.  We will not install or review this in this lab, but it's worth looking at this and others for great how to information.

  ![](images/022.png " ")

  ![](images/023.png " ")

9. Return to App

  ![](images/024.png " ")

10. Select create new application.

  ![](images/025.png " ")

11. Create from file.

  ![](images/026.png " ")

12. Select the **product_forecast.csv** file you downloaded previously.

  ![](images/027.png " ")

  ![](images/028.png " ")

13. Enter table name **FORECAST** and leave other values default and select **load data**.

  ![](images/029.png " ")

14. Then select **Create Application**.

  ![](images/030.png " ")

15. Select the highlighted features and select **Create Application** button.

  ![](images/031.png " ")

  ![](images/032.png " ")

16. First make a note of the **Application ID** Select **Run Application**.  Enter your **alpha** userid and password.

  ![](images/033.png " ")

  ![](images/034.png " ")

17. Click through the different pages.

  ![](images/035.png " ")

  ![](images/036.png " ")

  ![](images/037.png " ")

18. Return to the Dashboard page and select **Edit Page 2** at the bottom.

  ![](images/038.png " ")

19. Ensure you are on the **Layout** tab, select **Forecast** region, right click to delete.

  ![](images/039.png " ")

20. Drag the Year Month region below **Region** region.

  ![](images/040.png " ")

21. Click on the **Region** attributes and change the chart from pie to bar.

  ![](images/041.png " ")

22. Click on the **Region** Series1 element and change the SOURCE sql to the following:
  ```
  <copy>select REGION, sum(forecast) value
  from FORECAST
  group by REGION
  order by 2 desc</copy>
  ```

  ![](images/042.png " ")

23. Edit the **Year Month** attributes and change chart type, title, and appearance.

  ![](images/043.png " ")

24. Scroll down and select Show Legend.

  ![](images/044.png " ")

25. Update the **Source** SQL, select **REGION** for the **Series Name** under **Columnn Mapping** and then **Save** and **Run** the report. 
  ```
  <copy>select REGION, YEAR_MONTH, sum(forecast) value
  from FORECAST
  group by REGION, YEAR_MONTH
  order by 2  </copy>
  ```

  ![](images/046.png " ")

  ![](images/045.png " ")


## **STEP 5:** Configure a New Web Server and Application and Create a New Page to Access the Data using the API Gateway you created in Step 2

1. Select Application tab on the bottom.

  ![](images/047.png " ")

2. Select **Shared Components**.

  ![](images/048.png " ")

3. Select **Web Source Modules**.

  ![](images/049.png " ")

4. Create new module using the **API Gateway URL** from Step 2.8.

  ![](images/050.png " ")

  ![](images/051.png " ")

  ![](images/052.png " ")

  ![](images/053.png " ")

  ![](images/054.png " ")

  ![](images/055.png " ")

  ![](images/056.png " ")

5. Return to the application.

  ![](images/057.png " ")

6. Create a new Page.

  ![](images/058.png " ")

  ![](images/059.png " ")

  ![](images/060.png " ")

  ![](images/061.png " ")

  ![](images/062.png " ")

  ![](images/063.png " ")

7. Update **Local Post Processing**, select SQL Query and enter the following (overriding what is currently in the region).
  ```
  <copy>SELECT R.PRODUCT_ID,
  R.CATEGORY_ID,
  R.TWITTER_TAG,
  R.PRODUCT_NAME,
  R.PRODUCT_STATUS,
  L.REGION,
  L.YEAR_MONTH,
  L.FORECAST
  FROM #APEX$SOURCE_DATA# R, FORECAST L
  WHERE L.PRODUCT_ID=R.PRODUCT_ID</copy>
  ```

  ![](images/064.png " ")

8. Note the report contains both REST data and relational forecast data, joined by product_id.

  ![](images/065.png " ")

9. Change to a pivot view using actions drop down.

  ![](images/066.png " ")

  ![](images/067.png " ")

10. Add a Region filter.

  ![](images/068.png " ")

  ![](images/069.png " ")

  ![](images/070.png " ")

## **STEP 6:** Push APEX Application to Production using DevCS CI/CD

1. Navigate to Visual Builder Studio.

  ![](images/081.png " ")

  ![](images/082.png " ")

2. Select the **ProductCatalogServices** Project.

  ![](images/083.png " ")

3. Select **Builds** and then **Create Job**.

  ![](images/084.png " ")

4. Select the **Docker-kubernetes-template** VM.

  ![](images/085.png " ")

5. Add the **product-catalog** git.

  ![](images/086.png " ")

  ![](images/087.png " ")

6. Select **Configure**.

  ![](images/089.png " ")

7. Select **Steps**.

  ![](images/088.png " ")

8. Add **SQLcl** step.

  ![](images/090.png " ")

9. Enter the following details.  Note this assumes your APEX application is 101.  In previous steps this lab highlighted where the application ID is.  You can go back to your APEX and it will show beside the name.  This is the code you can pasted into the SQL window (change the application ID 101 if need be)

    ```
    <copy>begin
      apex_application_install.set_workspace('ALPHA');
    end;
    /
    spool /tmp/f101.sql
    apex export 101
    spool off</copy>
    ```

  ![](images/091.png " ")

10. Add a second **SQLcl** step and enter the following.  Note you will increment the application ID (in this case from 101 to 102).  ENSURE IT DOES NOT CLASH WITH AN EXISTING ID IN THE CASE WHERE YOU HAVE CREATED OTHER APPLIATIONS OUTSIDE THIS WORKSHOP.  Note this is importing the application into the same database as the export (we're just using a single db), but could create four steps, each importing into a different database (for our fictitious Alpha company this could be for US, EMEA, APAC, and Japan).

    ```
    <copy>begin
      apex_application_install.set_workspace('ALPHA');
      apex_application_install.set_application_id(102);
      apex_application_install.set_application_alias('102');
      apex_application_install.set_application_name('Forecast US');
      apex_application_install.generate_offset;
    end;
    /
    @/tmp/f101.sql</copy>
    ```

  ![](images/092.png " ")

11. Scroll back to the top of the page to save.

  ![](images/093.png " ")

12. Select **Build Now** to run the job.  It will initially enter **Waiting for Executor** status, and then run and take several seconds.

  ![](images/094.png " ")

  ![](images/095.png " ")

  ![](images/096.png " ")

  ![](images/097.png " ")

13. Navigate back to APEX to confirm a new copy of the Application called **Forecast US** was created.

  ![](images/098.png " ")

  ![](images/099.png " ")

  ![](images/100.png " ")

  ![](images/101.png " ")


**This completes Lab 500 and the Worshop!**

## Acknowledgements

- **Authors/Contributors** - Derrick Cameron
- **Last Updated By/Date** - 
- **Workshop Expiration Date** - May 31, 2021

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 