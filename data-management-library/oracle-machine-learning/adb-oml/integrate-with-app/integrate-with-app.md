# Using Prediction in an Application

## Introduction

In Lab 2, you built a model and in Lab 3, you imported that model into a new database, representing a production system. Now we just need to integrate that model with existing applications and processes. It’s worth repeating that this is a critical step. Machine learning models aren’t delivering value until they are being actively used by the company in existing applications and processes.

### Before You Begin

We will start this lab with some more setup, loading both data and an APEX application, the Alpha Office Customer Service application. Once those are ready we will show you three ways that you could deploy this model.

First, we will integrate it into the Customer Service application. This is something that customer-facing employees would use when interacting with customers. In this case, the customer walks into the office, asks about making a purchase, and the rep can get an immediate answer. By integrating this model with that workflow, we can shorten the process of applying for the new service and improve customer experience. This is a common situation, where a model can help guide a response to an event as it happens. This would include situations like any customer interaction, recommending products on a web site, processing a financial transaction, or responding to a new sensor reading on a piece of equipment.

In the second scenario, we are going to process a large number of customers in batch. Alpha Office has completed an acquisition and inherited some new customers. The marketing department would like to process all those customers at once, perhaps creating a campaign to target those who are suitable. In this lab, we do that using the Customer Service application. It would also be possible to address a use case like this by loading bulk data into the database, running scripts to process them, and making results available through a suitable analytics tool like Oracle Analytics Cloud.

Finally, while APEX applications work well with Oracle Database, many organizations use a distributed development approach. If this is the case, then making a model available via a REST API endpoint is the way to go. We’ll show you how to do that as well.

And when you’ve completed this lab, you are all done. You have set up two autonomous databases, built, trained, and deployed a machine learning model. We hope that you can take your new-found skills back to your organization. Are there some business problems that you might be able to help with? Are there existing data sets that colleagues are analyzing where machine learning might help? If you set up a free trial account to do this lab, then you can continue to use the free tier or your $300 of cloud credits to experiment further. And you can find more information at Oracle.com/machine-learning

Estimated time: 20 - 30 minutes

### Objectives

In this lab, you will:
- Import data to set up the lab.
- Import an APEX application.
- Review the application to see how you can make predictions on the fly.
- Expose your ml model as a REST endpoint so any application can use it.

### Lab Prerequisites

This lab assumes you have completed the following labs:
- Login to Oracle Cloud/Sign Up for Free Tier Account
- Connect and Provision ADB
- Create a Machine Learning Model
- Migrate ML Model to ATP

## Step 1: Prepare data for the lab in ATP

1.  If you are already logged in as **ml_user** in SQL Developer Web, proceed to load the data.

    Else, log into Oracle Cloud Console, navigate to Autonomous Transaction Processing from the menu, select your ATP instance and then click on **Service Console**.

    ![](./images/step1.1-1.png  " ")

    ![](./images/step1.1-2.png  " ")

    ![](./images/008.png  " ")

    In the ATP Console, select **Developement** and then select **SQL Developer Web**.

    ![](./images/step1.1-3.png  " ")

    Log in as ml_user, enter **Username - ml\_user** and **Password** you created for the ATP instance.

    ![](./images/step1.1-4.png  " ")

2.  To show how an application would use ml predictions we will add some customer names to the original credit\_scoring\_100k data set. Click on the more options icon, select **Data Loading** and then select **Upload Data Into New Table**.

    ![](./images/001.png  " ")

3.  Click on **Select files**, upload **customer\_names.csv** file from the install.zip you downloaded in the install directory and click **Next**.

    ![](./images/002.png  " ")

    ![](./images/step1.3-002-1.png  " ")

    ![](./images/003.png  " ")

4.  Change the data type of **CUSTOMER\_ID - Number**. Change the lengths of **CUSTOMER\_ID - 6**, **FIRST\_NAME - 100** and **LAST\_NAME to 100** and click **Next** .

    ![](./images/004.png  " ")

5.  Once the DDL Code is generated, click **Finish**. Uploading the data may take time, click **OK** to close the popup.

    ![](./images/005.png  " ")

    ![](./images/step1.5-005-1.png " ")

6.  Create a view that combines the names with the credit\_scoring\_100k data set.

    ````
    <copy>
    create or replace view ml_user.credit_scoring_100k_v as select a.first_name, 
    a.last_name, b.*
    from ml_user.customer_names a, credit_scoring_100k b
    where a.customer_id(+)= b.customer_id;
    </copy>
    ````

    ![](./images/006.png  " ")

7.  Create a new *upload_customers* table. This will be used in the application to show how newly loaded records can be scored on the fly.

    ````
    <copy>
    create table upload_customers (
    customer_id number
    , first_name varchar2(100)
    , last_name varchar2(100)
    , wealth varchar2(4000)
    , income number
    , customer_dmg_segment varchar2(26)
    , customer_value_segment varchar2(26)
    , occupation varchar2(26)
    , highest_credit_card_limit number
    , delinquency_status varchar2(26)
    , max_cc_spent_amount number
    , max_cc_spent_amount_prev number
    , residental_status varchar2(26)
    , likely_good_credit_pcnt AS (round((100*(prediction_probability(n1_class_model, 'Good Credit' USING 
        wealth
    , customer_dmg_segment
    , income
    , highest_credit_card_limit
    , residental_status
    , max_cc_spent_amount_prev
    , max_cc_spent_amount
    , occupation
    , delinquency_status
    , customer_value_segment
    , residental_status))),1))
    , credit_prediction AS (prediction(n1_class_model USING   
    wealth
    , customer_dmg_segment
    , income
    , highest_credit_card_limit
    , residental_status
    , max_cc_spent_amount_prev
    , max_cc_spent_amount
    , occupation
    , delinquency_status
    , customer_value_segment
    , residental_status))
    );
    </copy>
    ````

    ![](./images/007.png  " ")

## Step 2: Import the APEX Application

1.  To navigate to the ATP APEX application, switch to the ATP service console in browser. Select **Development** and then select **Oracle APEX**.

    ![](./images/009.png  " ")

2.  Enter your admin **Password**.

    ![](./images/010.png  " ")

3.  You will be prompted to create a workspace, Click **Create Workspace**.

    ![](./images/011.png  " ")

4.  Select **Database User - ML\_USER** from the drop down, enter **Workspace Name - ML\_APPLICATION** and click on **Create Workspace**.

    ![](./images/012.png  " ")

    ![](./images/013.png  " ")

5.  Sign out of user admin. When the popup appears, click **Return to Sign In Page** and log in to the ML\_APPLICATION as ML\_USER. Enter **Workspace - ML\_APPLICATION**, **Username - ML\_USER** and **Password** you created for ATP instance and then click on **Sign In**.

    ![](./images/014.png  " ")

    ![](./images/015.png  " ")

    ![](./images/016.png  " ")

6.  You will be prompted to set the new application password for ml\_user. Enter a proper **Email Address** (not necessarily valid) and click **Apply Changes**.

    ![](./images/017.png  " ")

    ![](./images/018.png  " ")

7.  Select **App Builder**.

    ![](./images/019.png  " ")

8.  Select **Import**

    ![](./images/020.png  " ")

9.  To import file, select **Choose File**, select **f100.sql** file from your install zip file in downloads folder and click **Next**.

    ![](./images/021.png  " ")

    ![](./images/022.png  " ")

    ![](./images/023.png  " ")

10. To confirm file import, click **Next**.

    ![](./images/024.png  " ")

11. To install database application, accept the defaults and click on **Install Application**.

    ![](./images/025.png  " ")

12. Click **Next** to confirm the installation and click **Install**.

    ![](./images/026.png  " ")

    ![](./images/027.png  " ")

13. Once the installation is complete, click on **Run Application** to run the application.

    ![](./images/028.png  " ")

14. Log in as ml_user, enter **Username - ml\_user** and **Password** you created for the ATP instance and then click on **Sign In**.

    ![](./images/029.png  " ")

    ![](./images/030.png  " ")

## Step 3: Run the application and review on-the-fly prediction/scoring

1.  Select Customer Walk-in from the menu. Select **Lastname**, and then **Customer Id**. Note that the credit score prediction and the probability of that estimate calculations are done as data is queried.

    ![](./images/031.png  " ")

2.  Next, we will upload new customers and score those as a batch.  Select **Home** item from the menu at the bottom of the page. (Note: If you do not see the menu bar at the bottom of the page, switch to Oracle APEX tab which was opened earlier in the browser.)

    ![](./images/032.png  " ")

3.  Select **SQL Workshop**.

    ![](./images/033.png  " ")

4.  Select **Utilities**.

    ![](./images/034.png  " ")

5.  Select **Data Workshop**.

    ![](./images/035.png  " ")

6.  Select **Load Data** and then select **Choose File**.

    ![](./images/036.png  " ")

    ![](./images/step3.6-036-1.png  " ")

7.  Select the **upload\_customers.xlsx** file from your install zip file in downloads folder.

    ![](./images/037.png  " ")

8.  Select **Load To - Existing Table** and choose **Table - UPLOAD\_CUSTOMERS** from the drop down menu and select **Load Data**. Once the data is appended to the table, close the popup.

    ![](./images/038.png  " ")

    ![](./images/039.png  " ")

9.  In Oracle APEX, select **App Builder** and then select **Alpha Office**.

    ![](./images/040.png  " ")

    ![](./images/041.png  " ")

10. Click **Run Application** to run the application.

    ![](./images/042.png  " ")

11. In Alpha Office, click on **Review Uploaded Customers** from the menu to review the uploaded customers and note the predictions.

    ![](./images/043.png  " ")

12. Select **Customer Upload Summary** from the menu. This provides a summary measure of the uploaded customer number of new good credit versus other credit customers. *This shows there were 40 customers with 100 percent probability of good credit, 83 customers with a 50.7 percent probability of good credit, and 277 customers with a 1.2 percent probability of good credit.* (Note: your values may differ slightly.)

    ![](./images/044.png  " ")

13. Select **Overall Credit Profile**. This provides an overall measure of the credit across the entire 100k credit database. This scoring of 100k customers with 10 variables takes less than a second. *This shows Alpha Office has 12k customers with a 100 percent probability of good credit, 22k customers with a 50.7 probability of good credit, and 66k customers with a 1.2 percent probability of good credit*. (Note: your values may differ slightly.)

    ![](./images/045.png  " ")

## Step 4: Expose the ml model as a REST end point so any application can call it

1.  Select the **Home** button from the menu at the bottom of the screen. (Note: If you do not see the menu bar at the bottom of the page, switch to Oracle APEX tab which was opened earlier in the browser.)

    ![](./images/046.png  " ")

2.  Select **SQL Workshop**.

    ![](./images/047.png  " ")

3.  Select **RESTFul Services**.

    ![](./images/048.png  " ")

4.  Select **Modules** on the left, and then click on **Create Module**.

    ![](./images/049.png  " ")

5.  Enter the following and select **Create Module**.
    - Module Name - *Predict Credit*
    - Base Path - */credit/*

    ![](./images/050.png  " ")

6.  Select **Create Template** to create a template.

    ![](./images/051.png  " ")

7.  Enter the following and select **Create Template**.
    - URI Template: *credit_scoring_100k\_v/:wealth/:income*

    ![](./images/052.png  " ")

8.  Next, click on **Create Handler**. Be sure to select **Method - GET** and **Source Type - Query One Row**, and enter the following SQL query in the worksheet and select **Create Handler**.

    ````
    <copy>
    select prediction(n1_class_model using :wealth as wealth, :income as income) credit_prediction from dual
    </copy>
    ````

    ![](./images/053.png  " ")

    ![](./images/054.png  " ")

    ![](./images/055.png  " ")

9.  Copy **Full URL** and paste it in your browser. Replace the parameters **:wealth - Rich** and **:income - 20000** respectively and hit enter. We are passing the wealth and income variables to the prediction model. Note these are just two of the many variables we could pass to the model (just add additional ones).

    ![](./images/056.png  " ")

    ![](./images/057.png  " ")

This concludes this lab and this workshop.

## Acknowledgements

- **Author** - Derrick Cameron
- **Last Updated By/Date** - Anoosha Pilli, Product Manager, DB Product Management, May 2020
- **Contributors** - Peter Jeffcock, Arabella Yao, Ayden Smith, Jeffrey Malcolm Jr, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
