# Building a Machine Learning Model in Oracle Machine Learning (OML) Notebook

![](images/400/Picture400-lab.png)  
Updated: January 4, 2019

## Introduction

This lab walks you through the steps to build a linear regression model in Oracle Machine Learning (OML) Notebook since we learned that linear regression algorithm is one of the best models on previous lab. 

**_To log issues_**, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Objectives
-   Learn how to build and apply machine learning model in Oracle Machine Learning (OML)

## Required Artifacts
-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.



# Building a Machine Learning Model in Oracle Machine Learning (OML) Notebook

## Part 1. Import Notebook File to OML 

### **STEP 1: Sign into OML**

-   Go back to the Cloud Console and Click the **Service Console** button on your Autonomous Data Warehouse details page.

![](./images/100/Picture100-34.jpeg)

-   Click the **Administration** tab and click **Manage Oracle ML Users** to go to the OML user management page. This will open OML user Administration page as a new tab within your browser.

![](./images/100/Picture100-35.jpeg)


- Click the **Home icon** on the top right of Oracle Machine Learning User administration page to go to OML home page.

![](./images/400/Picture400-1.jpeg)


- Sign in using your new user account **omluser1**. 

![](./images/400/Picture400-2.jpeg)


### **STEP 2: Import Notebook File (Flight Delay Prediction.json) to OML**

- Once you have successfully signed in to OML the application home page will be displayed. Let's click **Notebooks**. 

![](./images/400/Picture400-3.jpeg)


- To download the .json notebook file, click [here](./files/scripts/FlightDelayPrediction.json). In the **Notebooks** section, click on **Import** to import the downloaded file. 

![](./images/400/Picture400-4.jpeg)


## Part 2. Run the imported OML Notebook

### **STEP 3: Run Each Paragraph in the OML Notebook**

- Let's open the imported OML Notebook (.json). Then, click **interpreter binding** and select **%md** and one of the **%sql and %script** interpreters. 

![](./images/400/Picture400-5.jpeg)

- Now, run each paragraph in the OML Notebook (**Flight Delay Prediction.json**) at a time and make sure each paragraph is completed without error. Since you learned that linear regression algorithm is one of the best models, you will build the machine learning model with linear regression algorithm on OML. You will also be using the DBMS pl/sql packages, which are included in ADW as well. These packages allow you to build machine learning models with minimal coding. It will take about 15 minutes to run the entire paragraph in the OML Notebook. 

- Refer to below explanations about each paragrph. 

  - Here, all data are from 2008. Let’s imagine today is 10/31/2008 and you want to predict future flight delays in November and December of 2008. 
  - Paragraphs 1 & 2: These are to segment the data into training, validation, and prediction parts. 
    ![](./images/400/Picture400-6.jpeg)

  - Paragraphs 3, 4 & 5: These are to clean up any previously existing model objects with the same name as new model. Then, create setting table and set parameters to build linear regression model. 
    ![](./images/400/Picture400-7.jpeg)

  - Paragraph 6: This is to train this model on the portion of data you created for training.
    ![](./images/400/Picture400-8.jpeg)

  - Paragraph 7,8 & 9: These are to show model setting information, attribute name on the model and statistics for each attribute.
  ![](./images/400/Picture400-9.jpeg)

  - Paragraph 10: To validate our model, you will apply the trained model to the validation portion of the data. Then, store the result in a table in our autonomous data warehouse. Then, you will load it onto OAC for visualization on the following lab.
  ![](./images/400/Picture400-10.jpeg)

  - Paragraph 11: You will use the model to predict flight delay at each airport and at any given time by applying the model to the future data.  This result is saved as table in ADW for visualization using OAC as well. You will load it onto OAC for visualtion on the following lab. 
  ![](./images/400/Picture400-11.jpeg)

  - Paragraph 12: This is **optional**. Thanks to the DBMS_Scheduler package included in ADW, you can define repeating schedules, such as "every Tuesday and Friday at 4:00 p.m." or "the second Wednesday of every month.” Using DBMS_ Scheduler, you can get your machine learning model refreshed as new live data comes in, and the model can provide new recommendations. To  run this paragraph, you should define the parameters depend on your choice first. 
  ![](./images/400/Picture400-12.jpeg)



## Great Work - All Done with Lab400!
**You are ready to move on to the next lab. You may now close this tab.**
