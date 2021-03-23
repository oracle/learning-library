# Build a Machine Learning Model

## Introduction

This is the lab where you’re going to do the work of building and training a machine learning model that will help identify fraudulent auto claims.

### Before You Begin

Remember that we are trying to help predict when an auto claim is fraudulent. We use Oracle Machine Learning's 1-Class Support Vector Machine to train on "normal" records and apply the 1-Class SVM model to our insurance claims to flag those claims that are most dissimilar from the training population.

[](youtube:IkOz2rrB7hU)

In this lab, you will use Apache Zeppelin notebooks to do this work.

Estimated time: 20 - 30 minutes

### Objectives

- Import an Apache Zeppelin notebook.
- Become familiar with Oracle Machine Learning Algorithms.
- Create a machine learning model to determine factors that predict fraud.

### Prerequisites

This lab assumes you have completed the following labs:
<if type="freetier">
- Sign Up for Free Tier Account/Login to Oracle Cloud
- Provision and Setup ADB
</if>
<if type="livelabs">
- Launch the workshop (in the Introduction)
</if>

## **Step 1:** Import ML Notebooks

We have built the steps that are normally followed when exploring data and building a machine learning model. This has been saved to the file you can download. We will import this notebook and review it. It is important to note that you *must execute all the steps in this notebook*. Executing the steps takes only a few minutes.

1. From the tab on your browser with your ADW instance, in the Tools tab, select **Open Oracle ML Administration** and (if required) login with the admin credentials. <if type="livelabs">Your admin password is the password you copied from the Launch page.</if>

    ![](images/adw-open-ml-user-admin.png)

    ![](images/oml-signin-admin.png)

2. Click the home button to login in with the OMLUSER.

    ![](images/oml-user-homebutton.png)

3. Sign in with the omluser using the password <if type="freetier">you created</if><if type="livelabs">`AAbbcc123456`</if>.

    ![](images/signin-to-oml.png)

4. Click on Notebooks from the Quick Actions menu.

    ![](images/open-notebooks.png)

5. Download the [Auto Insurance Claims Fraud - Unsupervised Learning.json](files/Auto-Insurance-Claims-Fraud-Unsupervised-Learning.json?download=1) file.

6. Download the [Auto Insurance Claims Fraud - Supervised Learning.json](files/Auto-Insurance-Claims-Fraud-Supervised-Learning.json?download=1) file.

7. Click on **Import**.

    ![](images/import-notebook.png)

6. Go to the directory where you downloaded the files and import the **Auto-Insurance-Claims-Fraud-Unsupervised-Learning.json** notebook.

    ![](images/import-unsuper-notebook.png)

7. Repeat and import the **Auto-Insurance-Claims-Fraud-Unsupervised-Learning.json** notebook.

    ![](images/import-super-notebook.png)

## **Step 2:** - Working Unsupervised Auto Claims

1.  Select the **Auto Insurance Claims Fraud - Unsupervised Learning** notebook to open it.

    ![](./images/unsuper-learning-notebook.png  " ")

2.  Before you start working the **Auto Insurance Claims Fraud - Unsupervised Learning** you need to set the interpreter binging. Click on the gear icon.

    ![](./images/unsuper-learning-notebook-binding-1.png  " ")

3.  Click the low and medium bindings to disable them and click **Save**.

    ![](./images/unsuper-learning-notebook-binding-2.png  " ")

4.  Click on the **Run All Paragraphs** icon to run all paragraphs in the notebook, then click **OK**.

    ![](./images/run-all.png  " ")

    ![](images/run-all-ok.png)

5.  Click on the **Show/Hide the Output** icon to show the output and ensure that all the paragraphs are in **Finished** state.

    ![](./images/show-hide-output-2.png  " ")

    Click the **Show/Hide the Output** icon again to return to the paragraphs.

## **Step 3:** About this Notebook

This step discusses the result of each portion of the notebook.

1. In the first table, the claims data illustrates the model input attributes.

    ![](images/unsuper-1.png)

2. The next section illustrates how we can graph our understanding of the data.

    ![](images/unsuper-2.png)

3. Next, we'll build the model to train on.

    ![](images/unsuper-3.png)

4. Using the model, we can display the most suspicious claims in descending order.

    ![](images/unsuper-4.png)

5. Then explore those suspicious claims.

    ![](images/unsuper-5.png)

6. Finally, build the table of suspicious claims.

    ![](images/unsuper-6.png)

You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Charlie Berger, Senior Director of Product Management, Machine Learning, Cognitive Analytics and AI
- **Last Updated By/Date** - Tom McGinn, Product Manager, DB Product Management, March 2021

