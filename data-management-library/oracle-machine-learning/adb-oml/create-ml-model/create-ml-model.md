# Build a Machine Learning Model

## Introduction

This is the lab where you’re going to do the work of building and training a machine learning model that will help Alpha Office.

### Before You Begin

Remember that we are trying to help Alpha Office predict the credit and payment suitability of their customers. We can use machine learning to help us here because we already have a set of customers with known credit and payment status. This is what we are going to use to train a model that will predict for new customers if their credit is suitable.

This lab uses a decision tree algorithm which is a classification technique. If these are new to you, here’s a [presentation](https://objectstorage.us-ashburn-1.oraclecloud.com/n/natdcshjumpstartprod/b/adbml/o/Machine_Learning_Introduction.pdf) and a short video below that explains machine learning, classification, and decision trees at a high level.

[](youtube:IkOz2rrB7hU)

In this lab, you will use Apache Zeppelin notebooks to do this work. The lab will help you create a new notebook, and also import an existing one with all the code, descriptions, and examples that you need. You will then step through that notebook, examining the code, data, and visualizations and, most importantly, executing each step to populate the database.

Estimated time: 20 - 30 minutes

### Objectives

- Import an Apache Zepplin notebook.
- Become familiar with Oracle Machine Learning Algorithms.
- Create a machine learning model to determine factors that predict good credit.

### Prerequisites

This lab assumes you have completed the following labs:
- Login to Oracle Cloud/Sign Up for Free Tier Account
- Connect and Provision ADB

## **Step 1:** Create ML User

1.  Login to Oracle Cloud, select Autonomous Data Warehouse and navigate to your ADW instance.

    ![](./images/005.png  " ")

    ![](./images/step1.1-005-1.png  " ")

2.  Select **Service Console**.

    ![](./images/006.png  " ")

3.  Select **Administration**.

    ![](./images/007.png  " ")

4.  Select **Manage Oracle ML Users**.

    ![](./images/008.png  " ")

5.  Login with your ADW admin userid. Enter **Username - admin** and **Password** that you assigned when you created the ADW instance.

    ![](./images/009.png  " ")

6.  Click **Create** to create a new ML user. Enter **Username - ml\_user**, provide your account **Email Address** and create a **Password** and click **Create**.

    ![](./images/010.png  " ")

    ![](./images/011.png  " ")

## **Step 2:** Create ML Notebook

1.  Select the **home icon** upper right.

    ![](./images/012.png  " ")

2.  Log in as **ml\_user** and provide the password you just created in step 1. Before you log in, you may wish to bookmark this page.

    ![](./images/013.png  " ")

3.  Navigate around to get familiar with the ML pages. Click on **Examples**.

    ![](./images/014.png  " ")

4.  Note the various ML notebook examples. Feel free to review some of these. We will be creating a new ML notebook in this lab.

    ![](./images/015.png  " ")

5.  Click on the upper-left hamburger menu and select **Notebooks**.

    ![](./images/016.png  " ")

    ![](./images/017.png  " ")

6.  We will create a notebook from the beginning, select **Create**.

    ![](./images/018.png  " ")

7.  Enter **adwc_notebook** as the name, then click **OK**.

    ![](./images/019.png  " ")

## **Step 3:** Add Content to Your ADW Notebook

It is simple to create content in Zeppelin Notebooks, and the following exercise will give you experience in doing so.

1.  Select **Notebooks** in the upper left.

    ![](./images/046.png  " ")

    ![](./images/047.png  " ")

2.  Select the **notebook** you just created.

    ![](./images/048.png  " ")

3.  Click on the **gear** icon in the upper right. We must set the interpreter binding if we're going to connect to the ADW database and run queries. Be sure to select at least one of the **services** (High, Medium, or Low (or all)).

    ![](./images/049.png  " ")

    Zepplin notebooks are composed of paragraphs that can contain formatted text, sql, and script (pl/sql). Notebooks can support a broad range of scripting languages (python, R, etc.), but we'll just be using these three. We create different paragraphs with different interpreters based on what we want to put in the paragraphs. The interpreter is set at the top of the paragraph:
    - %md - markdown language which is used for formatted text.
    - %sql - used to run sql statements.  Note you can only run one statement per paragraph, otherwise use a script.
    - %script - used to run multiple sql statements and pl/sql blocks.

4.  Paste the following into the first paragraph. Then click on the **arrow** to run the code (format the text in this case.). Note that it displays the formatted text, and adds a new paragraph. Notebooks save automatically. There is no need to click a save button.

    ````
    <copy>
    %md
    ### Targeting Likely Good Credit Customers using Oracle Machine Learning's (OML) Classification Models

    Heather has spent most of her time over the past couple of years extracting and preparing data for analysis.  The large volumes of data need extracting and processing mean she spends most of her time waiting for jobs to finish and very little of her time analyzing the data.  Demands from marketing are forcing a new approach whereby the data remains in the data warehouse and is processed there.  The alternative cloud solution is more complex, and has no direct out of the box processes to analyze the data in place.  She started taking a look at Oracle, and found the simple SQL commands in ADW are familiar, and execute extremely fast, leveraging all the performance features of the platform.  Further once she is done can can apply the learning models to incoming data on the fly, and allow end user analysts to immediately see mining results.  This drastically reduces the cycle of data preparation, analysis, and publishing.  It also means there is no change to analysis/reporting Data Visualization toolset that users are familiar with.
    </copy>
    ````

    ![](./images/050.png  " ")

    ![](./images/051.png  " ")

5.  Sometimes we just want the result (formatted text in this case), and not the code. Click on the **show editor** icon to hide the code.

    ![](./images/052.png  " ")

    ![](./images/053.png  " ")

6.  In the next paragraph enter the following, overwrite the %md that has defaulted in. Then hit **execute**.

    ````
    <copy>
    %sql

    /* This shows the credit scoring data we will use historical data to predict the likelihood of a customer having good credit. */

    Select * from admin.credit_scoring_100k where rownum &lt; 100
    </copy>
    ````

    ![](./images/054.png  " ")

    ![](./images/055.png  " ")

7.  To add a title, click on the **gear** icon and select **Show title**.

    ![](./images/056.png  " ")

8.  Enter the following into the title.

    ````
    <copy>
    Review Credit Scoring Data
    </copy>
    ````

    ![](./images/057.png  " ")

9.  In this last example, enter the following in the next paragraph and then execute the script. Review Data by Mode of Job Contacts and Income.

    ````
    <copy>
    %sql

    /* This is a basic example of a chart visualization in Zepplin.  This particular one is a column graph.  Click on the 'settings' link below.  That will show you the fields in the query that were used to create the chart.  After you review the settings you can click on the link again to hide the settings. */

    select customer_id, age, income, tenure, loan_type, loan_amount, occupation, number_of_current_accounts, max_cc_spent_amount, mode_job_of_contacts from admin.credit_scoring_100k where rownum &lt; 1000
    </copy>
    ````

    ![](./images/058.png  " ")

    ![](./images/059.png  " ")

10. Change the presentation style by selecting **bar chart**.

    ![](./images/060.png  " ")

    ![](./images/step3.10-060-1.png  " ")

11. Select **settings** and drag and drop the fields into a position to review the results.

    ![](./images/061.png  " ")

    ![](./images/062.png  " ")

12. Hide the settings by clicking on the **settings** label again.

    ![](./images/063.png  " ")

    So how does all this help us build ml models, collaborate with others, and review and share the results/findings?

    Zeppelin provides:
    - A collaborative shared workspace for model development.
    - A direct connection to all the data in your Autonomous Database that can scale to petabytes.
    - A platform for preparing data for model ingestion.
    - A visual pallet to display data and ml results.
    - A shared platform where discussion, documentation, execution, and results are presented together.

13. Finally, let's review some examples. Navigate to the **Home** dashboard.

    ![](./images/064.png  " ")

    ![](./images/065.png  " ")

14. Navigate to **Examples**.

    ![](./images/066.png  " ")

15. Select a model of interest. In this example, we will open **Anomaly Detection**.

    ![](./images/067.png  " ")

    ![](./images/068.png  " ")

## **Step 4:** Import ML Notebook

As you have seen adding content to a notebook is simple and fast. However, we have already built out all the steps that are normally followed when exploring data and building a machine learning model. This has been saved to the Credit Score Predictions.json file. We will import this notebook and review it. It is important to note that you *must execute all the steps in this notebook if you wish to continue with lab 3 and 4*. Executing the steps takes only a few minutes.

1.  Navigate back to the Notebook page.

    ![](./images/020.png  " ")

2.  We will be importing a pre-built notebook, and using this for the remainder of the lab. Select **Import**.

    ![](./images/021.png  " ")

3.  Go to the install directory in your git repository and import **Targeting Customers That Complete All Payments.json** notebook.

4.  Select the **Targeting Customers That Complete All Payments** notebook.

    ![](./images/step4.4-023.png  " ")

5.  Before you start working the **Targeting Customers That Complete All Payments** you need to set the interpreter binging. Click on the gear icon.

    ![](./images/step4.5-024.png  " ")

6.  Select the **orcl_high** interpreter, drag and drop it to reorder and then **Save**.

    ![](./images/025.png  " ")

7.  Click on the **arrow** icon to run all paragraphs in the notebook.

    ![](./images/step4.7-026.png  " ")

8.  Click on the **output** icon to show the output and ensure that all the paragraphs are in **Finished** state.

    ![](./images/step4.8-027.png  " ")

    ![](./images/step4.8-028.png  " ")

9.  To view the code and the formatted text, click on **show editor** icon and then on **output** icon.

    ![](./images/step4.9-029.png  " ")

    ![](./images/step4.9-030.png  " ")

    ![](./images/step4.9-031.png  " ")

The rest of this lab will be done interactively in the notebook. The following area just screenshots for your convenience.

## Screen Shots of ML Notebook

![](./images/026.png  " ")

![](./images/027.png  " ")

![](./images/028.png  " ")

![](./images/029.png  " ")

![](./images/030.png  " ")

![](./images/031.png  " ")

![](./images/032.png  " ")

![](./images/033.png  " ")

![](./images/034.png  " ")

![](./images/035.png  " ")

![](./images/036.png  " ")

![](./images/037.png  " ")

![](./images/038.png  " ")

Please proceed to the next lab.

## Acknowledgements

- **Author** - Derrick Cameron
- **Last Updated By/Date** - Anoosha Pilli, Product Manager, DB Product Management, May 2020
- **Contributors** - Peter Jeffcock, Arabella Yao, Ayden Smith, Jeffrey Malcolm Jr, June 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
