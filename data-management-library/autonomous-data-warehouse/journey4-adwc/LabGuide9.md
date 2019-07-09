<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

September 21, 2018
</td>
<td class="td-banner">
# Bonus Lab 9: Simple Introduction to Machine Learning Algorithms (DBMS_PREDICTIVE_ANALYTICS)
</td></tr><table>


## Introduction

During this lab you will be using the Oracle Machine Learning (OML) notebook application provided with ADWC to explore some samples of the DBMS_PREDICTIVE_ANALYTICS functionality. DBMS_PREDICTIVE_ANALYTICS provides a set of easy-to-use machine learning procedures to simplify the machine learning process.

## Objectives

-   Learn how to import notebooks into Oracle ML Notebook
-   Learn how to use DBMS_PREDICTIVE_ANALYTICS routines
-   Learn how to use Oracle ML Gallery

## Required Artifacts

-   The following lab requires a user with access to the Oracle Machine Learning Notebook application (note: you created such a user in the previous lab).

# Downloading and Importing the sample notebook

The first step is to download the sample notebook and then import it into the Oracle ML notebook application.



#### STEP 1: Download the sample notebook for this lab

-   Download the sample notebook for this lab to a folder on your local computer from <a href="./files/Basic%20Machine%20Learning.zip" target="_blank">here</a>.

-   Note: the download is zipped and you will want to unzip it and copy the file in the zip to a known location on your computer.  After unzipping, you should have a file called "Basic Machine Learning.json".  Remember the location of where you have saved this file.

#### STEP 2: Login to the Oracle ML Notebook as one of your ML notebook users

-   In the previous lab, you created 2 users for the Oracle ML Notebook (omluser1 and omluser2).  Login to Oracle ML Notebook as one of those users.  Hint: the link to sign in to Oracle ML Notebook was sent to the email address you provided when you created the new users.

    ![](./images/700/Picture700-8.png)

    ![](./images/700/Picture700-12.png)

#### STEP 3: Click on the Go to Notebooks link

   ![](./images/800/snap0014521.jpg)

#### STEP 4: Click the Import button

   ![](./images/800/snap0014522.jpg)

#### STEP 5: Select the unzip lab notebook .json file you downloaded earlier

   ![](./images/800/snap0014523.jpg)

#### STEP 6: Click on the Basic Machine Learning link to open it

   ![](./images/800/snap0014524.jpg)

#### STEP 7: Read and Run the Basic Machine Learning notebook, paragraph by paragraph, to learn about using DBMS_PREDICTIVE_ANALYTICS
The notebook will provide some live examples of DBMS_PREDICTIVE_ANALYTICS in action against the sample SALES HISTORY tables.  There are additional instructions and steps in the notebook itself.

   ![](./images/800/snap0014525.jpg)

## Create machine learning notebook using OML Gallery template

#### STEP 8: Create a machine learning notebook

- Go back to OML dashboard and click on **Go to Gallery**. The Gallery page lists pre-populated Oracle Machine Learning notebook templates which you can view, like, and use it to create new templates.

    ![](./images/800/25.png)

- In the Gallery page, select the template based on which you want to create a notebook.

    ![](./images/800/26.png)

- Click **New Notebook**, and in the Create Notebook window, the name of the selected template appears. Enter information for notebook name and description and click on **OK**. For Association Rules example, it performs analysis based on SH schema. The results of the paragraphs have been shown. You can rerun each paragraph if you would like. You can go through this notebook at your own pace.

    ![](./images/800/27.png)

- One of the interesting things from this notebook is that it uses ``DBMS_DATA_MINING`` PL/SQL package which is an analytical technology that derives actionable information from data in an Oracle Database or Oracle Data Warehouse. This is a out-of-box function in ADWC that you can utilize to perform machine learning just using SQL scripts. Please refer to this for more information: `https://docs.oracle.com/cd/E18283_01/appdev.112/e16760/d_datmin.htm`

# Next Steps

- Experiment with DBMS_PREDICTIVE_ANALYTICS with your data
- Review the Oracle Database Data Mining documentation: https://docs.oracle.com/en/database/oracle/oracle-database/18/dmapi/introduction-to-oracle-data-mining.html
- Look at the DBMS_DATA_MINING sample notebooks in the Oracle ML Notebook Gallery

<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
## Great Work - All Done!
**You are ready to move on to the next lab. You may now close this tab.**
</td>
</tr>
<table>
