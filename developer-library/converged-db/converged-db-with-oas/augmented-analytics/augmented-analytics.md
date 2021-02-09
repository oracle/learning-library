# Augmented Analytics

## Introduction ##

Oracle powers deeper insights by embedding machine learning and AI into every aspect of the analytics process, making your job easier than ever.  Oracle employ smart data preparation and discovery to enhance your overall experience. Natural language processing (NLP) powers modern, conversational-style analytics.

*Estimated Lab Time:* 30 Minutes.

  ![](./images/augmentedanalytics.png " ")


### Objectives ###

In this lab you will learn on two key features in OAS Augmented Analytics:  “Explain” and “Forecast”.

Explain: Explain analyzes the selected column within the context of its data set and generates text descriptions about the insights it finds.  Explain creates corresponding visualizations that you can add to your project's canvas.

Forecast: Oracle Analytics Server offers a user-friendly method to leverage advanced analytics functions on a chart with a single mouse click. Having advanced analytical functions like, Trendline, Cluster, Outlier and forecast. These functions provide a strong capability to business users who want to have better insights into their data.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup (Free Tier and Paid Tenants Only)
    - Lab: Environment Setup
    - Lab: Initialize Environment
    - Lab : Data Visualization  

The below pre-loaded data object is available in Converged Database.  

| Object Name  | Object Type  | Data Type  | Description  |
| ------------- | ------------- | ------------- |
| FINANCIALS\_REL | Table | Relational  | Data used Explain and Forecast features. |

## **STEP 1**: Create A Data Set From Database

1. In the home screen, click the hamburger to select **Data** and then **Connections** tab. Select the  created connection and browse schema **OASLABS** as shown below.
    ![](./images/aa4.png " ")
    ![](./images/aa5.png " ")

2. Select the **FINANCIALS\_REL** table and click “Add All” to select all the columns of the table and by providing a dataset name click “Add” button to create the dataset.
    ![](./images/aa6.png " ")

3. Now in Data tab, you can see the added table as a data set.
    ![](./images/aa7.png " ")

## **STEP 2**: Project Creation From Data Set

1. In the **Data** tab, click on the added data set.  This will open screen for project creation.
    ![](./images/aa7.png " ")

## **STEP 3**: Explain Feature

Let us now learn the Augmented Analytics of OAS using the  **Explain** feature.

1. Select the Revenue column and right-click to select “Explain REVENUE”
    ![](./images/aa8.png " ")

The result is a profile of the data element you have selected with both visualizations and narrative text to explain the insights for the element that is being analyze.  To choose the generated visualization, click "Add Selected" and easily one can begin to use Data Visualizations project editor to drill further.
    ![](./images/aa9.png " ")
2.  Now, In Basic Facts about REVENUE, select Revenue by Cost Center graph, Revenue by Region Graph, and Revenue by Month graph. Click on "Add Selected".
    ![](./images/aa10.png " ")

3. After Adding the selected Visualizations, we can change the type of graph as per our choice. Now, let us change bar to pie chart as shown below:
    ![](./images/aa11.png " ")
4. Rearrange the columns to get the pie chart as shown below.
    ![](./images/aa12.png " ")

5. Similarly, try another column **OPERATINGEXP** using **Explain** feature and the final canvas should look as shown below.

    ![](./images/aa14.png " ")

6. Click on **Save** to save the project by providing a name to the project file.

## **STEP 4**: Forecast Feature

Using Forecast you can predict values for the next _n_ future periods.  Number of _n_ next periods can be set as required.

Let us use forecast feature on the sample financial data.

1. Select REVENUE, OPERATINGEXP, NETINCOME and MONTH columns.  Pick Line Graph by right click.
    ![](./images/aa15.png " ")

    Verify the result as below.

    ![](./images/aa16.png " ")

2. Similarly, build a line graph for payables and receivables monthly trend.
    ![](./images/aa17.png " ")

3. Now in the first chart, right-click and select "Add Statistics" and then click on "Forecast".
    ![](./images/aa18.png " ")
4. The highlighted area will show future predictions for next two month.
    ![](./images/aa19.png " ")

5. Similarly, use forecast for payables and receivables trend.
    ![](./images/aa20.png " ")

Great! Now, you have completed augmented analytics lab and hope you have learnt to use Explain and Forecast features of the tool to generate and present insights.

You may now *proceed to the next lab*.

## Want To Learn More

- [What Is Augmented Analytics?](https://blogs.oracle.com/analytics/what-is-augmented-analytics-v2)

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Sudip Bandyopadhyay, Vishwanath Venkatachalaiah
- **Contributors** - Jyotsana Rawat, Satya Pranavi Manthena, Kowshik Nittala, Rene Fontcha
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/converged-database). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
