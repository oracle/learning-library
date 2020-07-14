# Building Machine Learning Models in Oracle Analytics Cloud (OAC)  

## Introduction

This lab walks you through the steps to provision an Oracle Analytics Cloud (OAC) instance and connect it to the instance of ADW you created. In addition, we will demonstrate how to build machine learning models and how to find out which model fits flight delay prediction the best in OAC which is "no-code" development platform. 


### Objectives
-   Learn how to provision a new Oracle Analytics Cloud (OAC) Instance
-   Learn how to connect the OAC instance to the instance of ADW you created 
-   Learn how to build machine learning models in OAC
-   Learn how to find out which ML model fits the flight delay prediction the best in OAC 

### Required Artifacts
-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.



## Part 1. Create an OAC Instance
In this section, you will create an OAC instance.

1.   Go to your **Dashboard** page by clicking **My Services Dashboard** from the OCI Console navigation menu.

![](./images/labguide300-029b17f5.png)

2. Click on **Create Instance**.

![](./images/picture300-21.png)

3.   Under **All Services**, find **Analytics** and click on **Create**.

![](./images/analyticsDash.png)

4.   On the **Analytics** page, click on **Create Instance**.

![](./images/analyticsInstance.png)

5.   Enter the following information and then click on **Next**.

- Instance Name: Enter a name for your service instance (e.g. OAC_FlightDelay)
- Notification Email: Enter the email address of the person you want to notify when this service is ready to use and receive other status updates about this service in the future
- Region: Select the region where you want to deploy Oracle Analytics Cloud (e.g. us-Phoenix-1)
- License Type: Select whether you want to use your on-premises license with Oracle Analytics Cloud and to be charged the Bring Your Own License (BYOL) rate or subscribe to a new license for Oracle Analytics Cloud
- Edition: Select the edition that you want to use (e.g. Enterprise Edition) 
- Feature Set: Select the features that you want to deply. The options available to you depend on the deition you are subscribed to. (e.g. Business Intelligence) 
    
![](./images/picture300-24.png)

6.   After validating your configuration, click on **Create**.

![](./images/picture300-25.png)

7.   It will take 20 minutes to create the instance. If you enter the notification email, Oracle sends an email to the email address when your servie is ready.

![](./images/oacprovision.png)

8.   Now your OAC instance is ready. In order to access your instance, click **Manage this instance** button on the right side of your instance.

![](./images/expand.png)

9.   Then, click **Oracle Analytics Cloud URL**. It will open a new tab within your browser. 

![](./images/oacurl.png)

10.  This is main page of **Oracle Analytics Cloud (OAC)** which is "no-code" development platform. 

![](./images/picture300-29.png)



## Part 2. Connect OAC to ADW

1.   In the Oracle Analytics Cloud main page, click on the **Create** button on the top-right and then click on **Connection** in the popped menu.

![](./images/picture300-31.png)

2.   Select the **Oracle Autonomous Data Warehouse Cloud** from the existing connection types.

![](./images/picture300-32.png)

3.   Complete all the required fields in the wizard and Save the connection. Note that you need the ADW instance **Wallet** in order to be able to complete these fields. Please refer to the instruction in **Lab100** for accessing the **Wallet**.

4.   You should fill the following connection fields, then click **Save**:

- Connection Name: Type a name for this connection (e.g. FlightDelayPrediction)
- Client Credentials: Click on **‘Select’** and select the zipped **Wallet** file (The **cwallet.sso** file will be automatically extracted from the **Wallet** file)
- Username: Admin (the username you created during the ADW provisioning)
- Password: The password you specified during provision of your ADW instance
- Service Name: Select your database name and desired service level (low, medium, high) from the drop down list. (e.g.  ADW_FlightDelay_HIGH)

![](images/picture300-33-updated.png)


## Part 3. Upload Dataset from ADW to OAC

1.   In the Oracle Analytics Cloud Homepage, click on the **Create** button on the top-right and then click on **Data Set** in the popped menu.

![](./images/picture300-41.png)

2.   Select the connection that you have created in previous step.

![](./images/picture300-42.png)

3.   Select the **ADMIN** schema from the list of users, then pick the dataset (**OAC_DATASET**) that you want to use to train the model.  

![](./images/picture300-44.png)

4.   Click **Add All** to add all columns. 

![](./images/picture300-45.png)

5.   Then, type a name for the dataset (**OAC_DATASET**) and click **Add**.

![](./images/picture300-46.png)


## Part 4. Build Machine Learning Models in OAC 

Once you have created connection and uploaded dataset from ADW to OAC successfully, let's create **Data Flow** to build machine learning model. 

1.   On the main page of OAC, click **Data Flow** to create the machine learning model. 

![](./images/picture300-47.png)

2.   Pick the dataset (**OAC_DATASET**) which you uploaded on previous step. 

![](./images/picture300-48.png)

3.   Using “+” button, you can add next steps to build machine learning model. You need to select some columns, so click **select columns**. Then, since you need all columns, select all of them. 

![](./images/picture300-49.png)

4. Then, select proper statistical algorithm for flight delay prediction project. Here, OAC provides four different classes of machine learning. In this case, you want to predict numerical variable of flight delay. So, let’s click **train numeric prediction model**. 

![](./images/picture300-50.png)

5. Here, for training numeric prediciton model, we have four different statistical algorithms built in OAC. Let’s suppose we are not someone who are familiar with machine learning. So, we will just pick one of them. (e.g. pick **linear regression algorithm**) 

![](./images/picture300-51.png)

6. Once you pick the algorithm, all of the parameters are set by default except for the target value. Here, you want to predict flight delay time, so set **ARRDELAY** column as target. 

![](./images/picture300-52.png)

7. Then, we just need to **save** both our model and the Data Flow.

![](./images/picture300-53.png)

![](./images/picture300-54.png)

8. Once the Data Flow and model are saved, you can run the model that you had trained using the data you selected in the first step. It will take only about 2-3 mins.

![](./images/picture300-55.png)

9. Once you have ran the model successfully, you will see the following message. 

![](./images/picture300-56.png)



## Part 5. Find Out Which ML Model Fits Flight Delay Prediction the Best 

### **STEP 1**: Import the ML_ModelQuality.dva Project File
You can repeat the same process and create four different ML models for predicting flight delay time, then compare them and find out which model fits our problem the best using statistical methods. However, to simplify the process, we have already created all those models in OAC. And then, we have saved statistical results from each model in the project of  **ML_ModelQuality.dva**. From follwing steps, you will import the project of **ML_ModelQuality.dva**  and find out which model fits our problem the best. 

1. Click [ML_ModelQuality.dva](./files/mlmodel.dva) to download the project file to a directory on your local computer.

2. Click **Menu Page** button on the top of right side and select **Import Project**. Then, click **Select File** and **import** the downloaded ML_ModelQuality.dva file. 

![](./images/picture300-57.png)

3. You can find the imported project under the section **Projects**. 

![](./images/picture300-59.png)

4. Let's open the project. 

![](./images/picture300-60.png)

5. Then, click the tap of **Narrate** and click **Present**. 
![](./images/picture300-61.png)

6. Now, you can see the graph as presentation mode as below: 

![](./images/picture300-63.png)

### **STEP 2**: Find Out Which ML Model Fits Flight Delay Prediction the Best

We have created four different ml models in OAC. And then, to find out which model fits our problem the best, we have calculated Mean Absolute Error (MAE) of each model. MAE is commonly used statistics for evaluating the overall quality of model. MAE value ranges from zero to infinity, and smaller MAE value means better model quality. 

Here, we can see that the Linear Regression has the lowest MAE of 13. Generally speaking, 13 is a small value for MAE that represents good model quality. Also, you can see that the Linear Regression has the lowest MAE of our four models, meaning it is the best one here. Then, we can decide to use linear regression model to predict flight delay. 

But, what if you want to operationalize ML and build ML model on the entire dataset with more parameter options? You can use oracle Machine Learning Notebook (OML). In the next lab, you will follow steps for building ML model in OML. 


## Acknowledgements

- **Author** - NATD Solution Engineering - Austin Hub (Joowon Cho)
- **Last Updated By/Date** - Joowon Cho, Solutions Engineer, May 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.    Please include the workshop name and lab in your request. 