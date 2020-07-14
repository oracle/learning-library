# Visualizing results of Validation and Prediction in Oracle Analytics Cloud (OAC)


## Introduction
This lab walks you through the steps to visualize results of validation and prediction in Oracle Analytics Cloud (OAC).  

### Objectives
Learn how to visualize the results in Oracle Analytics Cloud

### Required Artifacts
The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.



## Part 1. Visualize Results of Validation in OAC. 

### **STEP 1**: Load the Validation Result Table onto OAC

1.   In the Oracle Analytics Cloud Homepage, click on the **Create** button on the top-right and then click on **Data Set** in the popped menu.

![](./images/picture500-1.png)

2.   Select the connection (**FlightDelayPrediction**) that you have created in previous lab.

![](./images/picture500-2.png)

3.   Select the OML user created in **Lab 100**, then pick the validation result table (**OT_Valid_Res**).

![](./images/picture500-3.png)

4.   Click **Add All** to add all columns and click **Add** to save the dataset.  

![](./images/picture500-4.png)

### **STEP 2**: Visualize Results of Validation using Combo chart
1.   Once you have uploaded the validation result table onto OAC successfully, click **Visualize** tap.  
![](./images/picture500-5.png)

2.   Make visualization by following below steps to visualize the validation result. 
![](./images/picture500-6.png)
- Change Aggregation of DELAY, PREDICTEDDELAY columns as **Average**.
- Create a Combo chart
- Values (Y-Axis): DELAY (Bar) and PREDICTEDDELAY (Line) 
- Category (X-Axis): DEST
- Save the visualization (e.g. Visualization_Validation) 

3. Click the tap of **Narrate** and click **Present**. Now, you can see the graph as presentation mode. 
![](./images/picture500-7.png)

**Notes:** In this graph, x-axis is each airport and y-axis is averaged flight’s delay time. Here, bars show the actual flight delay time and lines show the predicted delay time. This graph shows actual flight delay and predicted delay time at each destination. You can see that the line (predicted value) closely follows the pattern exhibited by the bar graphs (actual value). Hence, you can say the machine learning model is very reliable.


## Part 2. Visualize Results of Prediction in OAC. 

### **STEP 1**: Load the Prediction Result Table onto OAC

1. Repeat **Part 1.STEP 1** to load the prediction result table (**OT_Pred_Res**) onto OAC. 

### **STEP 2**: Make a new CARRIER column on tap of Prepare
1. Click **Option** button on the column of **UNIQUECARRIER** and select **Duplicate**. 
![](./images/picture500-8.png)

2. Rename the duplicated column as **CARRIER** and click **Add Step**. 
![](./images/picture500-9.png)

3. Click **Option** button on the column of **CARRIER** and select **Replace**. Then, replace the actual carrier names to some character (e.g. AS -> A, UA -> B, WN -> C) and click **Add Step**. 

![](./images/picture500-10.png)

4. Click **Apply Script** button to make all changes happen on the dataset. 

![](./images/picture500-11.png)

### **STEP 3**: Visualize Results of Prediction using Bar graph
1.   Once you have uploaded the prediction result table onto OAC successfully, click **Visualize** tap.  

2.   Make visualization by following below steps to visualize the prediction result. 
![](./images/picture500-12.png)
- Change **Aggregation** of PREDICTEDDELAY columns as **Average**.
- Change SCHEDULEDEEPTTIME, DAYOFWEEK as **Attribute**. 
- Create a **Bar** graph
- **Values (Y-Axis)**: PREDICTEDDELAY
- **Category (X-Axis)**: SCHEDULEDEEPTTIME
- **Color**: CARRIER
- Add ORIGIN (**LAX**), DEST(**SFO**), DAYOFWEEK(**4**, Thursday) and CARRIER(**A,B,C**) as filter. 
- Save the visualization (e.g. Visualization_Prediction) 

3. Click the tap of **Narrate** and click **Present**. Now, you can see the graph as presentation mode. 
![](./images/picture500-13.png)

**Notes:** This graph shows predicted delay time for flights from LAX to SFO on a Thursday. Each color represents three major airlines, a, b, and c. This graph predicts that on a Thursday, airline “B” from LAX to SFO leaving at 4:50 p.m. will arrive about 17 minutes late. On the other hand, airline “C” from leaving at 4:45 p.m. will arrive only about 5 minutes late.


## Acknowledgements

- **Author** - NATD Solution Engineering - Austin Hub (Joowon Cho)
- **Last Updated By/Date** - Joowon Cho, Solutions Engineer, May 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.    Please include the workshop name and lab in your request. 