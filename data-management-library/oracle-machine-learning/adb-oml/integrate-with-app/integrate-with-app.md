# Using Prediction in an Application

In Lab 2 you built a model and in Lab 3 you imported that model into a new database, representing a production system. Now we just need to integrate that model with existing applications and processes. It’s worth repeating that this is a critical step. Machine learning models aren’t delivering value until they are being actively used by the company in existing applications and processes.

We will start this lab with some more setup, loading both data and an APEX application, the Alpha Office Customer Service application. Once those are ready we will show you three ways that you could deploy this model.

First, we will integrate it into the Customer Service application. This is something that customer-facing employees would use when interacting with customers. In this case, the customer walks into the office, asks about making a purchase, and the rep can get an immediate answer. By integrating this model with that workflow, we can shorten the process of applying for the new service and improve the customer experience. This is a common situation, where a model can help guide a response to an event as it happens. This would include situations like any customer interaction, recommending products on a web site, processing a financial transaction or responding to a new sensor reading on a piece of equipment.

In the second scenario, we are going to process a large number of customers in batch. Alpha Office has completed an acquisition and inherited some new customers. The marketing department would like to process all those customers at once, perhaps creating a campaign to target those who are suitable. In this lab, we do that using the Customer Service application. It would also be possible to address a use case like this by loading bulk data into the database, running scripts to process them, and making results available through a suitable analytics tool like Oracle Analytics Cloud.

Finally, while APEX applications work well with Oracle Database, many organizations use a distributed development approach. If this is the case, then making a model available via a REST API endpoint is the way to go. We’ll show you how to do that as well.

And when you’ve completed this lab, you are all done. You have setup two autonomous databases, built, trained and deployed a machine learning model. We hope that you can take your new-found skills back to your organization. Are there some business problems that you might be able to help with? Are there existing data sets that colleagues are analyzing where machine learning might help? If you setup a free trial account to do this lab, then you can continue to use the free tier, or your $300 of cloud credits to experiment further. And you can find more information at Oracle.com/machine-learning

## Objectives

In this lab, you will:

- Import data to set up the lab.
- Import an APEX application.
- Review the application to see how you can make predictions on the fly.
- Expose your ml model as a REST end point so any application can use it.

### Lab Prerequisites

This lab assumes you have completed the following labs:
- Register for Free Tier Account
- Connect and Provision ADB
- Create Machine Learning Model
- Migrate ML Model to ATP

## Step 1: Prepare data for the lab in ***ATP***.

1. To show how an application would use ml predictions we'll add some customer names to the original credit_scoring_100k data set.  Navigate to the ***ATP*** SQL Developer Web and log in with ml_user (if you are not already logged in from the previous lab).  Then select file upload on the left.

  ![](./images/001.png  " ")

2. Select the files button, and then the customer_names.csv file in the install directory.

  ![](./images/002.png  " ")

3. Accept the defaults and hit next.

  ![](./images/003.png  " ")

4. Change the customer\_id data type to number and change the lengths.

  ![](./images/004.png  " ")

5. Accept the remaining defaults.

  ![](./images/005.png  " ")

6. Create a view that combines the names with the credit\_scoring\_100k data set.
   ````
   <copy>create or replace view ml_user.credit_scoring_100k_v as select a.first_name, a.last_name, b.*
   from ml_user.customer_names a, credit_scoring_100k b
   where a.customer_id(+)= b.customer_id;</copy>
   ````

  ![](./images/006.png  " ")

7. Create a new upload\_customers table.  This will be used in the application to show how newly loaded records can be scored on the fly.
   ````
   <copy>create table upload_customers (
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
   );</copy>
   ````

  ![](./images/007.png  " ")

## Step 2: Import the APEX Application

1. Navigate to the ATP APEX application through the ATP Service Console.

  ![](./images/008.png  " ")

2. Select Development, then APEX.

  ![](./images/009.png  " ")

3. Enter your admin password.

  ![](./images/010.png  " ")

4. You will be prompted to create a workspace. 

  ![](./images/011.png  " ")

5. Select ML\_USER for the workspace user and enter ML\_APPLICATION for the workspace name.

  ![](./images/012.png  " ")

  ![](./images/013.png  " ")

6. Sign out of user admin and log in with workspace ML\_APPLICATION and user ML\_USER.

  ![](./images/014.png  " ")

  ![](./images/015.png  " ")

   ![](./images/016.png  " ")

7. You will be prompted to set the new application password for ml\_user.  Make the email proper (not necessarily valid) and accept defaults.

   ![](./images/017.png  " ")

   ![](./images/018.png  " ")

8. Select App Builder.

   ![](./images/019.png  " ")

9. Select Import

   ![](./images/020.png  " ")

10. Select choose file, and then select the ***f100.sql*** file in the git repo and then accept the defaults.

   ![](./images/021.png  " ")

   ![](./images/022.png  " ")

   ![](./images/023.png  " ")

   ![](./images/024.png  " ")

   ![](./images/025.png  " ")

   ![](./images/026.png  " ")

   ![](./images/027.png  " ")

   ![](./images/028.png  " ")

11. Log in as ml_user.

   ![](./images/029.png  " ")

   ![](./images/030.png  " ")

## Step 3: Run the application and review on-the-fly prediction/scoring.

1. Select Customer Walk-in from the menu.  Select last name, and then first name.  Note the credit score prediction and the probability of that estimate.  These calculations are done as the data is queried.

   ![](./images/031.png  " ")

2.  Next we will upload new customers and score those as a batch.  Select the Home menu item at the bottom of the page.

   ![](./images/032.png  " ")

3. Select SQL Workshop.

   ![](./images/033.png  " ")

4. Select Utilities.

   ![](./images/034.png  " ")

5. Select Data Workshop.

   ![](./images/035.png  " ")

6. Select Load Data.

   ![](./images/036.png  " ")

7. Select the upload_customers.xlsx file.

   ![](./images/037.png  " ")

8. Load to existing table upload_customers.

   ![](./images/038.png  " ")

   ![](./images/039.png  " ")

9.  Return to the Alpha Office application.

   ![](./images/040.png  " ")

   ![](./images/041.png  " ")

10. Run the application

   ![](./images/042.png  " ")

11. Now review the uploaded customers and note the predictions.

   ![](./images/043.png  " ")

12.Select Customer Upload Summary.  This provides a summary measure of the uploaded customer number of new good credit versus other credit customers.  This shows there were 40 customers with 100 percent probability of good credit, 83 customers with a 50.7 percent probability of good credit, and 277 customers with a 1.2 percent probability of good credit.

   ![](./images/044.png  " ")

13. Select Overall Credit Profile.  This provides an overall measure of the credit across the entire 100k credit database.  This scoring of 100k customers with 10 variables takes less than a second.  This shows Alpha Office has 12k customers with a 100 percent probability of good credit, 22k customers with a 50.7 probability of good credit, and 66k customers with a 1.2 percent probability of good credit.

   ![](./images/045.png  " ")

## Step 4: Expose the ml model as a REST end point so any application can call it.

1. Select the Home button at the bottom of the screen.

   ![](./images/046.png  " ")

2. Select SQL Workshop.

   ![](./images/047.png  " ")

3. Select RESTFul Services.

   ![](./images/048.png  " ")

4. Select Module on the left, then Create Module.

   ![](./images/049.png  " ")

5. Enter the following
    - Module Name - `Predict Credit`
    - Base Path - `/credit/`

  ![](./images/050.png  " ")

6. Next create a Template.

   ![](./images/051.png  " ")

7. Enter the following:
    - URI Template: `credit_scoring_100k_v/:wealth/:income`

   ![](./images/052.png  " ")

8. Next create a handler.  Be sure to select Query one row, and enter the following sql query and select Create Handler.
    - `select prediction(n1_class_model using :wealth as wealth, :income as income) credit_prediction from dual`

   ![](./images/053.png  " ")

   ![](./images/054.png  " ")

   ![](./images/055.png  " ")

10. Copy the URL and paste into your browser, and then replace the parameters :wealth and :income with Rich and 20000 respectively.  We are passing the wealth and income variables to the prediction model.  Note these are just two of the many variables we could pass to the model (just add additional ones).  After changing the URL just hit enter.

   ![](./images/056.png  " ")

   ![](./images/057.png  " ")

This concludes this lab and this workshop.

## Acknowledgements

- **Author** - Derrick Cameron
- **Last Updated By/Date** - Leah Bracken, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
