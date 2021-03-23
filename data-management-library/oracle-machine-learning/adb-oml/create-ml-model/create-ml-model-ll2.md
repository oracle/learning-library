# Build a Machine Learning Model

## Introduction

This is the lab where you’re going to do the work of building and training a machine learning model that will help Alpha Office.

Estimated lab time: 20 - 30 minutes

Watch this short video to preview how to build a machine learning model.

[](youtube:XO9WI2bJN5s)

### About Oracle Machine Learning

Simplifying greatly, you can split machine learning into two parts: the process of building and training a model so it is ready to work; putting that model to work in production systems, applications, and processes. In general, training a machine learning model takes significant computing resources. You should not run that kind of work in an existing data warehouse or data mart, without clearing it ahead of time because it’s possible that model training could use too many resources and impact SLAs. You definitely don’t want to build and train a model in any kind of critical transactional system for the same reason.

For this Alpha Office scenario, we provision two different autonomous databases. The autonomous data warehouse is used to build and train your model. Think of it as a stand-in for your own data warehouse or data mart. Alternatively, given how easy it is to provision a data mart, think of this ADW as the best way for you to do machine learning without impacting anybody else in the organization. Setting up a dedicated data mart for machine learning may be the right thing for you to do outside of this lab.

But it’s not just about training the model - you also have to deploy it, and there are some options. You could deploy a model into a data warehouse where it’s available for analytics. Or maybe you want to deploy it into a production transaction processing system so that you can score each new transaction. Either way, you are going to need to know how to export and import a model. So we show you that in this workshop using two different databases.

What Alpha Office wants is to deploy this machine learning model in a production database that supports their Client Service application. When an existing customer comes into the branch, we can pull up their name and check their credit in real-time. The marketing department can also load batch data into this system and run a process to score a new set of customers in bulk. So, this setup of just two different services allows you to build, train, and deploy a machine learning model into an application so that customer-facing and marketing employees can work with it.

We are trying to help Alpha Office predict the credit and payment suitability of their customers. We can use machine learning to help us here because we already have a set of customers with known credit and payment status. This is what we are going to use to train a model that will predict for new customers if their credit is suitable.

This lab uses a decision tree algorithm which is a classification technique. If these are new to you, here’s a [presentation](https://objectstorage.us-ashburn-1.oraclecloud.com/n/natdcshjumpstartprod/b/adbml/o/Machine_Learning_Introduction.pdf) and a short video below that explains machine learning, classification, and decision trees at a high level.

[](youtube:IkOz2rrB7hU)

In this lab, you will use Apache Zeppelin notebooks to do this work. The lab will help you create a new notebook, and also import an existing one with all the code, descriptions, and examples that you need. You will then step through that notebook, examining the code, data, and visualizations and, most importantly, executing each step to populate the database.

### Objectives

- Import an Apache Zeppelin notebook.
- Become familiar with Oracle Machine Learning Algorithms.
- Create a machine learning model to determine factors that predict good credit.

### Prerequisites

This lab assumes you have completed the following labs:
- Login to Oracle Cloud/Sign Up for Free Tier Account
- Connect and Provision ADB

## **STEP 1:** Create ML User in ADW

1.  From the hamburger menu, select **Autonomous Data Warehouse**, choose your compartment and navigate to your ADW instance.

    ![](./images/ml-adw.png " ")

    ![](./images/adw-instance.png " ")

2.  Select **Tools** on the Autonomous Database Details page.

    ![](./images/tools.png " ")

3.  Select **Open Oracle ML User Administration** under the tools.

    ![](./images/open-ml-admin.png " ")

4. Sign in as ADMIN user. Provide the **Username - ADMIN** and **Password - WELcome__1234** assigned to you when the ADW instance was created.

    ![](./images/ml-login.png  " ")

6.  Click **Create** to create a new ML user.

    ![](./images/create.png  " ")

7. On the Create User form, enter **Username - ML\_USER**, an e-mail address (you can use admin@oracle.com), un-check **Generate password**, and enter a password you will remember. You can use the same password you used for the ADMIN account. Then click **Create**.

    ![](./images/ml-user.png  " ")

8. Notice that the **ML\_USER** is created.

    ![](./images/ml-user-created.png " ")

## **STEP 2:** Grant Privileges to ML_USER to access Database Actions

1.  From the hamburger menu, select **Autonomous Data Warehouse**, choose your compartment and navigate to your ADW instance.

    ![](./images/ml-adw.png " ")

    ![](./images/adw-instance.png " ")

2.  Select **Tools** on the Autonomous Database Details page.

    ![](./images/tools.png " ")

3. Select **Open Database Actions** under the tools.

    ![](./images/open-database-actions.png  " ")

4. On the Database Actions login page, log in with your ADW credentials, provide the **Username - ADMIN** and click **Next**. Then provide the **Password - WELcome__1234** created for the Autonomous instance and click **Sign in**.

    ![](./images/ml-admin.png " ")

    ![](./images/ml-admin-password.png " ")

5. From the Database Action menu, select **SQL**.

    ![](./images/sql.png " ")

6. Dismiss the Help by clicking on the **X** in the popup.

    ![](./images/click-x.png  " ")

7.  By default, only the ADMIN user can use the SQL Developer Web. To enable ML\_USER to use it, you need to enter the following and execute the procedure to grant SQL developer web access to ML\_USER.

    ````
    <copy>
    BEGIN
      ORDS_ADMIN.ENABLE_SCHEMA(
        p_enabled => TRUE,
        p_schema => 'ML_USER',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'ml_user',
        p_auto_rest_auth => TRUE
      );
      COMMIT;
    END;
    /
    </copy>
    ````

    ![](./images/grant-mluser-access.png " ")

    ![](./images/mluser-access-granted.png " ")

8.  Grant storage privileges to ML\_USER.

    ````
    <copy>
    alter user ml_user quota 100m on data;
    </copy>
    ````

    ![](./images/storage-privileges.png " ")

## **STEP 3:** Create ML Notebook

1.  If you are not logged into Machine Learning User Administration as ADMIN user, log in to your cloud account, click the hamburger menu, select **Autonomous Data Warehouse** and navigate to your instance.

    ![](./images/choose-adw.png  " ")

    ![](./images/adw-instance.png " ")

    On the **Tools** tab of your ADW instance, and click on **Open Oracle ML User Administration**.

    ![](./images/tools.png " ")

    ![](./images/open-ml-admin.png " ")

    Sign in as **Username - ADMIN** with the **Password - WELcome__1234** created for your Autonomous instance.

    ![](./images/ml-login.png  " ")

2.  In the Machine Learning User Administration, click on the **home icon** on the upper right.

    ![](./images/home-icon.png  " ")

3.  Log in as **ML\_USER** and provide the password you created  for the ML\_USER. Before you log in, you may wish to bookmark this page.

    ![](./images/mluser-sign-in.png  " ")

4.  Navigate around to get familiar with the ML pages. Click on **Examples**.

    ![](./images/examples.png  " ")

5.  Note the various ML notebook examples. Feel free to review some of these. We will be creating a new ML notebook in this lab. Click on the upper-left hamburger menu.

    ![](./images/notebooks-menu.png  " ")

6.  Click on the upper-left hamburger menu and select **Notebooks**.

    ![](./images/choose-notebooks.png  " ")

7.  We will create a notebook from the beginning, select **Create**.

    ![](./images/018.png  " ")

8.  Enter **adwc_notebook** as the name, then click **OK**.

    ![](./images/019.png  " ")

9. Now you can view the notebook created - **adwc_notebook**.

    ![](./images/new-notebook.png " ")

## **STEP 4:** Add Content to Your ADW Notebook

It is simple to create content in Zeppelin Notebooks, and the following exercise will give you experience in doing so.

1.  Click on the hamburger menu and select **Notebooks** in the upper left.

    ![](./images/046.png  " ")

    ![](./images/047.png  " ")

2.  Select the **notebook** you just created.

    ![](./images/adwc-notebook.png  " ")

3.  Click on the **gear** icon in the upper right. We must set the interpreter binding if we're going to connect to the ADW database and run queries. Be sure to select at least one of the **services** (High, Medium, or Low (or all)).

    ![](./images/gear.png  " ")

    Zeppelin notebooks are composed of paragraphs that can contain formatted text, sql, and script (pl/sql). Notebooks can support a broad range of scripting languages (python, R, etc.), but we'll just be using these three. We create different paragraphs with different interpreters based on what we want to put in the paragraphs. The interpreter is set at the top of the paragraph:
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

    ![](./images/select-table-run.png  " ")

    ![](./images/select-mluser-table.png  " ")

7.  To add a title, click on the **gear** icon and select **Show title**.

    ![](./images/show-title.png  " ")

8.  Enter the following into the title.

    ````
    <copy>
    Review Credit Scoring Data
    </copy>
    ````

    ![](./images/edit-title.png  " ")
    ![](./images/057.png  " ")

9.  In this last example, enter the following in the next paragraph and then execute the script. Review Data by Mode of Job Contacts and Income.

    ````
    <copy>
    %sql

    /* This is a basic example of a chart visualization in Zeppelin.  This particular one is a column graph.  Click on the 'settings' link below.  That will show you the fields in the query that were used to create the chart.  After you review the settings you can click on the link again to hide the settings. */

    select customer_id, age, income, tenure, loan_type, loan_amount, occupation, number_of_current_accounts, max_cc_spent_amount, mode_job_of_contacts from ml_user.credit_scoring_100k where rownum &lt; 1000
    </copy>
    ````

    ![](./images/enter-paragraph.png  " ")

    ![](./images/select-query-output.png  " ")

10. Change the presentation style by selecting **bar chart** and then click on **Setting**.

    ![](./images/bar-chart.png  " ")

    ![](./images/settings.png  " ")

11. Drag and drop the fields into a position to review the results.

    ![](./images/drag-and-drop.png  " ")

12. Hide the settings by clicking on the **settings** label again.

    ![](./images/hide-settings.png  " ")

    So how does all this help us build ml models, collaborate with others, and review and share the results/findings?

    Zeppelin provides:
    - A collaborative shared workspace for model development.
    - A direct connection to all the data in your Autonomous Database that can scale to petabytes.
    - A platform for preparing data for model ingestion.
    - A visual pallet to display data and ml results.
    - A shared platform where discussion, documentation, execution, and results are presented together.

13. Finally, let's review some examples. Click on hamburger and navigate to the **Home** dashboard.

    ![](./images/hamburger-menu.png  " ")

    ![](./images/home.png  " ")

14. Navigate to **Examples**.

    ![](./images/click-examples.png  " ")

15. Select a model of interest. In this example, we will open **Anomaly Detection**.

    ![](./images/click-anamoly-detection.png  " ")

    ![](./images/anamoly-detection.png  " ")

## **STEP 5:** Import ML Notebook

Adding content to a notebook is simple and fast. In this step, we have built the steps that are normally followed when exploring data and building a machine learning model. This has been saved to the file you can download. We will import this notebook and review it. It is important to note that you *must execute all the steps in this notebook if you wish to continue with lab 3 and 4*. Executing the steps takes only a few minutes.

1. Download the notebook [targeting\_customers\_that\_complete\_all\_payments\_v4_ll.json](files/targeting_customers_that_complete_all_payments_v4_ll.json?download=1).

2.  Navigate back to the Notebook page.

    ![](./images/020.png  " ")

3.  We will be importing a pre-built notebook, and using this for the remainder of the lab. Select **Import**.

    ![](./images/021.png  " ")

4.  Go to the directory where you downloaded the JSON file and import the **targeting\_customers\_that\_complete\_all\_payments\_v4.json** notebook.

    ![](./images/import.png  " ")

5.  Select the **Targeting Customers That Complete All Payments** notebook.

    ![](./images/step4.4-023.png  " ")

6.  Before you start working the **Targeting Customers That Complete All Payments** you need to set the interpreter binging. Click on the gear icon.

    ![](./images/step4.5-024.png  " ")

7.  Select the **orcl_high** interpreter, drag and drop it to reorder and then **Save**.

    ![](./images/gear2.png  " ")

8.  Click on the **arrow** icon to run all paragraphs in the notebook.

    ![](./images/step4.7-026.png  " ")

    ![](./images/click-ok.png  " ")

9.  Click on the **output** icon to show the output and to view the code and the formatted text, click on **show editor** icon. Ensure that all the paragraphs are in **Finished** state and then click on **output** icon.

    ![](./images/step4.8-027.png  " ")

    ![](./images/step4.9-029.png  " ")

    ![](./images/step4.9-030.png  " ")

    ![](./images/step4.9-031.png  " ")

## **STEP 6:** About this Notebook

The rest of this lab will be done interactively in the notebook. This step discusses the result of each portion of the notebook.

1. This graph illustrates Good\_Credit customers who complete all their payments are hard to find.

    ![](./images/nb3.png  " ")

2. This section illustrates how we can graph our understanding of the data.

    ![](./images/nb4.png  " ")

    ![](./images/nb5.png  " ")

3. Run the Attribute Importance to identify key variables that most influence the target attribute.

    ![](./images/nb6.png  " ")

4. Now, split the data into Train and Test data sets. Drop, then Build and Evaluate the Classification Model.

    ![](./images/nb7.png  " ")

5. Drop, build and evaluate multiple OML models for comparison.

    ![](./images/nb8.png  " ")

6. Join model outputs e.g. cumulative gains chart to view and assess model quality.

    ![](./images/nb9.png  " ")

7. Now, apply the model to make predictions.

    ![](./images/nb10.png  " ")

8. Apply the model to a single record to make a prediction.

    ![](./images/nb11.png  " ")

9. Verify the table or view.

    ![](./images/nb12.png  " ")

[Please proceed to the next lab](#next).

## Acknowledgements

- **Author** - Derrick Cameron
- **Contributors** - Anoosha Pilli, Peter Jeffcock, Arabella Yao, Ayden Smith, Jeffrey Malcolm Jr, June 2020
- **Last Updated By/Date** - Anoosha Pilli, Product Manager, DB Product Management, March 2021
