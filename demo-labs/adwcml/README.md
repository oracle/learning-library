  ![](images/001.png)

# Oracle Autonomous Data Warehouse Machine Learning Demo Lab

## Introduction
_Time to Complete: 30 minutes_

in this lab you will assume the persona of Heather, the data scientist/ML expert for Alphaoffice. Heather has spent most of her time over the past couple of years extracting and preparing data for analysis. The large volumes of data need extracting and processing mean she spends most of her time waiting for jobs to finish and very little of her time analyzing the data. Demands from marketing are forcing a new approach whereby the data remains in the data warehouse and is processed there. The alternative cloud solution is more complex, and has no direct out of the box processes to analyze the data in place. She started taking a look at Oracle, and found the simple SQL commands in ADWC are familiar, and execute extremely fast, leveraging all the performance features of the platform. Further once she is done can can apply the learning models to incoming data on the fly, and allow end user analysts to immediately see mining results. This drastically reduces the cycle of data preparation, analysis, and publishing. It also means there is no change to analysis/reporting Data Visualization toolset that users are familiar with.

An added benefit is the ability to use a new open source Apache Zeppelin based collaboration environment where she can work with others on the team in real time, annotating ML steps and combining the processing and documentation in one place. Since we are going to use Oracle ML interface, much of the lab will be done in that interface. For more information on which Machine Learning Algorithms are supported see Oracle Advanced Analytics documentation.

You will begin your machine learning development journey by importing an Apache Zeppelin Notebook into Oracle Machine Learning and then use ADWC's Machine Learning to predict customer good credit given detailed demographic information.

## Objectives

- Get hands-on with Oracle's Autonomous Data Warehouse Machine Learning
- Explore the Apache Zeppelin notebook interface
- Create an Attribute Importance Model using the DBMS_Predictive_Analytics.Expain procedure
- Identify customer attributes that are the best predictors of good credit
- Predict credit worthiness of new customers

## Instructions

### Download your Apache Zeppelin Notebook.

**Click to download, then unzip**

[Credit_Score_Predictions.zip](https://dgcameron.github.io/adwcjs/demo-labs/adwcml/Credit_Score_Predictions.zip)

### Log into Oracle Machine Learning.

- Use the [Machine Learning Login](https://adwc.uscom-east-1.oraclecloud.com/oml/tenants/OCID1.TENANCY.OC1..AAAAAAAA3FF5N7TZN3BUPBW7D5NHFCNUAGNCA5KN7KW4ODBMZMP5FHH6FWLA/databases/ORCL/index.html) to sign into Machine Learning.  Use your assigned userid, with password `Alpha2018___` (three underscores):  

  ![](images/002.png)

- You must change your password before executing any of the notebook paragraphs that follow later on.  Select your useid in the upper right (each username will be different for each section):

  ![](images/002.1.png)

- The original password is `Alpha2018___` (three underscores).  Enter a new password of your choice.

  ![](images/002.2.png)

- Select `Examples` to review sample content.

  ![](images/003.png)

- Select `Attribute Importance` and review the notebook content.  We will not do anything with this notebook, but will be using the `Attribute Importance` model later on.

  ![](images/004.png)

  ![](images/005.png)

- Select the menu in the upper left and select `Notebooks`.

  ![](images/006.png)

  ![](images/007.png)

- We will be importing a pre-built notebook, and using this for the remainder of the lab.  Select `Import`.

  ![](images/008.png)

- Go to where you downloaded the `Credit Score Predictions.json` file and import the notebook.

  ![](images/009.png)

- Select the `Credit Score Predictions` notebook.

  ![](images/010.png)

- Before you start working with the `Credit Score Predictions` you need to set the interpreter binding.  Click on the gear icon.

  ![](images/011.png)

- Select the `orcl_high` interpreter and then Save.

  ![](images/012.png)

The rest of this lab will be done interactively in the notebook.  The following area just screen shots for your convenience.

![](images/013.png)

![](images/014.png)

![](images/015.png)

![](images/016.png)

![](images/017.png)

![](images/018.png)

![](images/019.png)

![](images/020.png)

![](images/021.png)

![](images/022.png)

![](images/023.png)

![](images/024.png)

![](images/025.png)

![](images/026.png)