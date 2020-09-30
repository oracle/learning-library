# Building Machine Learning Models in Oracle Machine Learning Tool (OML)

![](images/500/Picture500-lab.png)  
Updated: January 4, 2019

## Introduction

This lab walks you through the steps to create a linear regression model in the Oracle Machine Learning tool and apply it to the dataset in the Autonomous Datawarehouse. Also, we will show you how you can use the Oracle Analytics Cloud to visualize the results of the model created in OML.


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives
-   Learn how to create machine learning models in Oracle Machine Learning Tool
-   Learn how to visualize the results in Oracle Analytics Cloud


## Required Artifacts
-    The following lab requires an Oracle  Cloud account. You may use your own cloud account, a cloud account that you obtained through signing up for the free tier, or a training account whose details were given to you by an Oracle instructor.



# Learn to Build Machine Learning Modules in Oracle Machine Learning (OML) and Visualize in Oracle Analytics Cloud (OAC)

## Part 1. Create a Linear Regression Model in OML

### **STEP 1: Import the Notebook to OML**

-   Go back to the Cloud Console and open the Instances screen. Find your database, click the action menu and select **Service Console**.


-   Log in to the service with your admin password.

![](./images/500/Picture700-2.png)

-   Go to the **Administration** tab and click **Manage Oracle ML Users** to go to the OML user management page - this page will allow you to manage OML users.

![](./images/500/Picture700-3.png)

-   Click on the Home icon to go the OML login page.

![](./images/500/Picture700-11.png)

-   Use the OML account that you created in **Lab 100** to sign in.

![](./images/500/Picture700-12.png)

-   Once you have successfully signed in to OML the application home page will be displayed. Go to the **Notebook** section.

![](./images/500/Picture500-16.png)

-   In the **Notebooks** section, click on **Import** and import the [**Bike Share Availability Prediction.json**](./files/scripts/Bike Share Availability Prediction.json) file.

-   If you are on Orale/learning library, click on <a href="https://raw.githubusercontent.com/oracle/learning-library/master/workshops/bike-share-prediction/files/scripts/Bike%20Share%20Availability%20Prediction.json" target="_blank">here</a> to download the file (right click then save page as .json file). 

![](./images/500/Picture500-17.png)

The entire code for creating the model in OML is now accessible in the **Bike Share Availability Prediction** notebook.



### **STEP 2: Run the Code in the OML Notebook**
Run the code in the **Bike Share Availability Prediction** notebook to train and validate a linear regression model and apply it to a weather forecast to predict the bike availability for a future day. Go over paragraphs one-by-one and run each at a time. Make sure each paragraph is completed without error. As the result of running the code in this notebook, several tables will be created. We will load a few of those tables in OAC in the next sections in order to generate our desired graphs. Note that running the entire notebook may take about 45 minutes.


## Part 2. Visualize results in OAC

### **STEP 3: Load Results of the OML Model to OAC**

-   In the Oracle Analytics Cloud Homepage, click on the **Create** button on the top-right and then click on **Data Set** in the popped menu.

![](./images/500/Picture500-31.png)

-   Select the connection that you have created in  **Lab 300**.

![](./images/500/Picture500-32.png)

-   Select the OML user created in **Lab 100** from the list of users to import the tables that contain the results of the model created and ran in OML.

![](./images/500/Picture500-33.png)


-  You should import tables **SSW_V_RES** and **SSW_P_RES** to the OAC instance. Import those tables as descirbed in **Step 4** in **Lab 300**. After completing these process, you should see four datasets in the data section.

![](./images/500/Picture500-34.png)



### **STEP 4: Add Datasets to the Project**

-  Open the **BikeSharePrediction** project that you imported to the OAC instance in **Lab 400**. Under the **Visualize** tab, click on the **+** icon next to the **Data Elements** and select **Add Data Set**.

![](./images/500/Picture500-41.png)

-   Select **SSW_P_RES**, **SSW_V_RES**, and **STATION_INFO** and click on **Add to Project**.

![](./images/500/Picture500-42.png)

-   Next, go to the Prepare tab and in the **Data Diagram** section, click on the **0** in the middle of the line between **SSW_P_RES** and **STATION_INFO** datasets (it appears when you move your mouse between the two datasets).

![](./images/500/Picture500-43.png)

-   In the popped window, click on Add Another Match and select **STATION_ID** and **STATIONID** in **STATION_INFO** and **SSW_P_RES**. Finally, click **OK**.

![](./images/500/Picture500-44.png)

-   Repeat **Step 4** to create a connection between **SSW_V_RES** and **STATION_INFO** datasets. Finally the Data Diagram should look like this:

![](./images/500/Picture500-45.png)



### **STEP 5: Create Desired Graphs**

-   Go back to the **Visualize** tab in the project, add a new Canvas by clicking on the **+** icon.

![](./images/500/Picture500-51.png)

-   Click on the triangle next to the Canvas name, select Rename and enter the desired name for the Canvas, e.g. **Validation (OML Model)**.

![](./images/500/Picture500-52.png)

-   In the newly created Canvas, create a **Combo** chart. Use the following values to set up the chart:

![](./images/500/Picture500-53.png)

-   **Values (Y-Axis):**  SSW_V_RES->Actual_Available_Bikes (bar)   and   SSW_V_RES->Predicted_Available_Bikes (line)

-   **Category (X-Axis):** SSW_V_RES->Last_Reported->Hour of Day

-    **Filters:** SSW_V_RES->Last_Reported (start: 8/28/17 – end: 8/29/17)   and   Station_Info->Station_Name (Avenue D & E 8 St)


-   Repeat the first two instructions in this step to create another Canvas- e.g. **Prediction (OML Model)**- to visualize the prediction results. Create a **Bar** chart in this canvas as below:

![](./images/500/Picture500-54.png)

-   **Values (Y-Axis):**  SSW_P_RES->Predicted_Available_Bikes (bar)

-   **Category (X-Axis):** SSW_P_RES->Last_Reported->Hour of Day

-   **Filters:** SSW_P_RES->Last_Reported (start: 8/31/17 – end: 9/1/17)   and   Station_Info->Station_Name (Avenue D & E 8 St)




## Great Work - All Done with Lab500!
**Congrats! You are all done. You may now close this tab.**
