# Lab: ML for Busines Users (Oracle Analytics Cloud)

## Introduction

In this lab we will take the perspective of a **business user** (as opposed to the expert data scientist).

Oracle Analytics lets business users build and apply ML models in a visual and intuitive way. Oracle Analytics provides algorithms in all major ML categories, e.g. Regression, Classification, Clustering and Association Rule Mining.

In addition, there's a set of featured called "Augmented analytics" in this platform that uses ML "under the hood" to automate a lot of the common tasks in the analytics process, think about Data Preparation and Data Exploration.

In this lab you will use Oracle Analytics Cloud to build a ML model that assess Credit Risk. In this particular case, this task was performed by an employee before. Our aim is to automates the credit assessment using a ML model.

Estimated lab time: 80 minutes (video 10 minutes, provisioning 30 minutes, exercise 40 minutes)

This video will cover the theory behind Neural Networks.
[](youtube:ywstbYbIlPg)

### Objectives

In this lab you will:
- Become familiar with Oracle Analytics and self service analysis.
- Learn how Oracle Analytics can be used to do Data Preparation and Exploration in a way, as an alternative to coding.
- Learn about the potential impact that ML can have in the hands of business users!

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account (see prerequisites in workshop menu)

## **STEP 1:** Provision Oracle Analytics Cloud

You will provision Oracle Analytics Cloud.

1. Open the provisioning screen

   Click the "hamburger" menu on the top left.

   ![](images/oac1.png)

   Select Analytics from the menu.

   ![](images/oac2.png)

   Choose a compartment.

   ![](images/oac3.png)

2. Configure OAC

   Choose to create a new OAC instance.

   In the configuration screen, do the following:

   Instance name: Any name you choose,
   Feature Set: Enterprise Analytics,
   OCPU: 2,
   Network access: Public,
   License type: "Subscribe to a new Analytics Cloud...".

3. Start provisioning

   Click Next.

   Click "Create". The status changes to "Creating...". Provisioning can take up to 30min.

   ![](images/oac8.png)

## **STEP 2:** Data preparation

   First we have to upload the data that's required for our model. In this case, the dataset with historical credit assessments is mostly ready to go, without requiring any changes.

1. Download the training dataset

   Download the [training dataset](files/MLTD2-german-credit-applications.csv) with historical credit information.

   Click on the link, then use the "Raw" button and then right click "Save As". **Make sure to save these with extension CSV.** Some browsers try to convert this to Excel format, which is incorrect.

   The original dataset contains 1000 entries with 20 categorical and numerical attributes prepared by Professor Hofmann and each entry in the dataset represents a PERSON who took a credit and classified as good or bad credit risk.

   The dataset provided to you as part of the material was obtained from the following location: https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)

   We will try to capture the knowledge that this person applies to assessing credits in a ML model.

2. Upload the dataset into Oracle Analytics Cloud

   The first task to do is to upload the MLTD2-german-credit-applicants.csv dataset provided to you into Oracle Analytics Cloud. In OAC, on the top left corner click on the menu icon and Click on "Data".

   ![](images/img2.jpg)

   To import the dataset click on "Create", "Data Set", and select the file that you downloaded earlier.

   ![](images/img3.jpg)
   ![](images/img4.jpg)

   You see a preview of the dataset. Complete the process by clicking "Add"
![](images/img5.jpg)

3. Change column type of recid

   By default Oracle Analytics incorrectly treats the "recid" column as a measure. Change it to "Attribute" by clicking on "recid", then "treated as", then "attribute".
   ![](images/img6.jpg)

   Oracle Analytics records all changes you make in a script. This allows it to easily repeat the process in case data is reloaded. For now, apply the script that has been created by clicking "Apply Script". This makes the change to recid effective.
   ![](images/img7.jpg)

## **STEP 3:** Data exploration

   As you know, this phase in the Data Science process is for us to get to know our data, identify which columns are useful, detect any problems with the data, et cetera.

   First of all, let's imagine you want to know how many credit applications have been Accepted vs Denied in the past. We can use Oracle Analytics' visualization capabilities for this.

1. Create a project

   Create a project in order to investigate the dataset using visualizations by clicking on the burger menu associated with our dataset and "Select Project".
   ![](images/img10.jpg)

2. Add a calculation

   First we need a way to count the credit card applications. We do this as follows: Right-click on ‘My calculation’ folder of the dataset and select "Add Calculation".
   ![](images/img11.jpg)

   The name of the field can be anything, e.g. "# Count". Then add a counter by Double-clicking on ‘Count’ in the ‘Aggregation’ list of options.
   ![](images/img12.jpg)

   Define the counter by selecting the column "recid", then click "Save".
   ![](images/img13.jpg)

3. Create a new visualization

   Now we can find an answer to our questions. Select both the "class" and the "# Count" fields (use Control to select multiple fields). Then ‘Right-Click’ on the blue part and select "Pick Visualization".
   ![](images/img14.jpg)

   Select the ‘donut’ visualization
   ![](images/img15.jpg)

4. Review the visualization

   You see that 70% out of 1000 credit applications were good and 30% were bad for the target called ‘class’
   ![](images/img16.jpg)

5. Review colinearity

   Remember the colinearity issue from the previous labs? Colinearity is the effect of multiple attributes that supply similar information. When we train our model, we should try to only supply attributes that provide unique pieces of information. To investigate this issue, we will create a correlation diagram between the input features. Do this by selecting all the fields from "duration" until "num_dependants". Choose "Pick Visualization" and select "Correlation Matrix".
   ![](images/img20.jpg)

   Now you see the correlation matrix visualization. Although there is some correlation between the fields, the correlation does not appear to be too high in any place. Therefore there's no colinearity and no action to be taken.
   ![](images/img23.jpg)

   Save the results of the Data Exploration. Give it a logical name.
   ![](images/img25.jpg)

   At the is point you are doing with the investigation of the dataset and move on the next task

## **STEP 4:** Train the model

   Our goal is to build a model that can correctly assess the credit of an application for a loan with either "Good" or "Bad".
   In Oracle Analytics, this is done by creating a so-called "Data Flow". A "Data Flow" specifies the source of the data for the training, any data transformations, and a step for the actual model training.

1. Create Data Flow

   Create a new Data Flow by going to the "Data" menu, then select "Create" and "Data Flow".
   ![](images/img26.jpg)
   ![](images/img28.jpg)

2. Add dataset

   Every Data Flow starts with a dataset. Select the dataset that we uploaded earlier (‘MLTD2-german-credit-applicants’) and select "Add".
   ![](images/img29.jpg)

3. Remove recid column

   During Data Exploration we found that we want to keep all attributes for training. However, the identifier "recid" does not have any values, so let's remove it.  Use "remove selected" next to this column to remove it.
   ![](images/img30.jpg)
   ![](images/img31.jpg)

4. Add Binary Classifier

   In this case we need a Binary Classifier algorithm. The reason is that our output are two possible classes: "Good" and "Bad". Add a "Train Binary Classifier" step at the end of the process (see "+" symbol").
   ![](images/img32.jpg)

   There are different algorithms available to do binary classification. In this case we will select "Logistic Regression for model training".
   ![](images/img33.jpg)

   There are a few hyperparameters for this algorithm. Most importantly, we have to select what the target column is. In this case, select "class". "class" is the column that was set by the credit assessment expert historically. The other hyperparameters are "Positive Class in Target", set this to "bad" (all lowercase), this means that for us it's important to predict "bad" credit. Set the value for "Predict Value Threshold Value" to 30%. Set "Standardization" to True.
   ![](images/img46.jpg)
   ![](images/img47.jpg)

5. Configure the model name and save the Data Flow

   You see that a "Save Model" node was automatically created. Click it and set ""MLTD2-trained-german-credit-LR30" as the model name. Now, save the Data Flow. Click on ‘Save’ and choose "MLTD2-train-german-credit-DF".
   ![](images/img36.jpg)

6. Execute the Data Flow to train the model

   Next, we can finally execute the Data Flow. Effectively this will train the model. Click on "Run Data Flow" (top right). This could take up to 10 minutes, depending on the speed of your PC. A message will appear saying that the data flow was run successfully.
   ![](images/img38.jpg)

## **STEP 5:** Evaluate the model

   Now that you have built the model, you need to assess how good it is and decide if you are happy with it. Oracle Analytics Cloud machine learning provides quality metrics to allow you to evaluate how good the trained models are.

1. Open the model for inspection

   First, locate the trained machine model by going to the "Machine Learning" menu and selecting our model. Then select "Inspect".
   ![](images/img40.jpg)
   ![](images/img50.jpg)

2. Review model metrics

   Go to "Quality" tab to see the quality metrics associated with your model. You can see that the model doesn't predict all cases correctly. You can play with the hyperparameters to improve these results and find the best trade off for your case.
   ![](images/img51.jpg)

## **STEP 6:** Make predictions (apply the model)

   We have a file with new credit applications that we would like to assess. Instead of doing this the manual (HUMAN) way, we'll use our freshly trained model.

1. Download new dataset to score

   Download the new applications [here](files/MLTD2-german-credit-new-applications.csv). Click on the link, then use the "Raw" button and then right click "Save As". **Make sure to save these with extension CSV.** Some browsers try to convert this to Excel format, which is incorrect.

2. Create new dataset

   Again, create a new dataset, and set the "Treat As" for attribute "recid" to "attribute". The dataset should be named "MLTD2-german-credit-NEW-applications".
   ![](images/newupload.png)

3. Create new Data Flow to score the dataset

   You'll notice that this dataset does -not- have the class column yet. In fact, that is what we will predict now. Create a new Data Flow to score the new dataset.
   ![](images/createdataflow.png)

4. Configure the Data Flow - remove "recid"

   Select the new dataset. Deselect the "recid" column, as this does not have any predicted value.
   ![](images/selectdatasetnew.png)

5. Add Apply Model to perform the scoring

   Add a "Apply Model" step in the dataflow and select the model that we trained earlier.
   ![](images/addapplymodel.png)
   ![](images/selectmodel.png)

   Verify the next dialog. You see that the Apply Model step will create two new columns: PredictedValue and PredictionConfidence. You also see that the columns of our NEW dataset are automatically aligned with the input features of the model.
   ![](images/applymodelcolumns.png)

6. Add a final step to Save the Data

   Add a "Save Data" step. Name the new dataset "Scored New Applications"
   ![](images/savedatastep.png)

7. Save the Data Flow

   Save the Data Flow. Name it "Apply Credit Assessment DF".
   ![](images/saveapplyflow.png)

8. Run the Data Flow

   Run the new Data Flow. This typically takes a few minutes depending on the speed of your PC.
   ![](images/runapply.png)

## **STEP 7:** Verify the predictions

   Our goal is to visualize the results of the prediction. The prediction Data Flow will have created a new dataset called "Scored New Applications", as we specified.

1. Create a new project

   Let's create a new project on that dataset by going back to the "Data" menu, and selecting "Create Project" on this new dataset.
   ![](images/scoredcreateproject.png)

2. Create new visualization

   Imagine we want to see all applications that the model has assessed with a "bad" credit scoring. We want to simply display all the results in a table. Select all columns (use Shift), then right click "Pick Visualization", and choose the Table visualization.
   ![](images/selectallcolumns.png)

3. Show only bad credit rating using a filter

   Now apply a filter to only show the bad credit ratings, by dragging "Predicted Value" to the filter area and choosing "bad".
   ![](images/dragfilter1.png)
   ![](images/dragfilter2.png)

4. Evaluating the results

   We see that there are a handful of applications (of the 20+ that we provided) that have been assessed as "bad".
   ![](images/result.png)

Congratulations on completing this lab!

[Proceed to the next section](#next).

## Acknowledgements
* **Authors** - Jeroen Kloosterman - Product Strategy Manager - Oracle Digital, Lyudmil Pelov - Consulting Solution Architect - A-Team Cloud Solution Architects, Fredrick Bergstrand - Sales Engineer Analytics - Oracle Digital, Hans Viehmann - Group Manager - Spatial and Graph Product Management
* **Last Updated By/Date** - Jeroen Kloosterman, Oracle Digital, Jan 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
