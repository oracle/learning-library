# Speed up data science with the Accelerated Data Science SDK

## Table of Contents

[Overview](#overview)

[Pre Requisites](#pre-requisites)

[Getting Started](#getting-started)

[Data Science Service](#data-science-service)

[Sign in to the OCI Console](#sign-in-to-the-oci-console)

[Selecting the Compartment](#selecting-the-compartment)

[Opening the Notebook](#opening-the-notebook)

[Working with JupyterLab](#working-with-jupyterlab)

[Binary Classification Model](#binary-classification-model)

[Next Steps](#next-steps)

## Overview

The Oracle Data Science Service is a fully managed, self-service platform for data science teams to build, train, and manage machine learning (ML) models in Oracle Cloud Infrastructure.

The Accelerated Data Science (ADS) SDK will help you build better machine learning models faster. It can significantly speed up your workflow by automating common tasks like exploratory data analysis (EDA), feature engineering, algorithm selection and tuning, machine learning explanation (MLX) and much more. This lab will introduce the Accelerated Data Science SDK, showing you how it can speed up your workflow and make you more productive.

In this module, we will build a binary classification model in an effort to predict employee attrition. Using the Accelerated Data Science (ADS) SDK we will do an exploratory data analysis (EDA) to understand the nature and distribution of the data. We will visualize the data and assess the correlation between predictors. The Oracle AutoML tools will be used to perform and automatically tune Light Gradient Boosting Machine (GBM), XG Boost, Random Forest and Logistic Regression classifiers. These models will be evaluated and compared using ADS' model evaluation tools. Once the best model is selected, we will use the machine learning explainability (MLX) tools to explain the global and local behavior of the model. That is, we will see what features are important in the model using feature permutation importance, partial dependence plots (PDP), individual conditional expectation (ICE) and several other methods used to determine why the model made the prediction that it did. 

**We recommend using Chrome or Edge as the browser. Also set your browser zoom to 80%**

## Pre-Requisites

**Chrome or Edge are the browsers. You can switch during your session.**

**Set your browser zoom to 80%**

**Follow the guided instructions to login and access the course.**

This module uses the Oracle Cloud Infrastructure (OCI) Data Science service. While we will guide through the menu items, it would be helpful to have a basic familiarity with the OCI Console. The module uses JupyterLab notebooks. It has an intuitive interface but it would also be helpful if you have used it before. The code is written in python. You will not have to write any code in the lab but it would be best if you had a basic understanding of the syntax. If you know other languages you will generally be alright in following what is happening with the code. Below are some links to resources that will be helpful in getting the most out of this module.

1. OCI Training : https://cloud.oracle.com/en_US/iaas/training

2. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

3. Familiarity with Oracle Accelerated Data Science SDX (ADS): https://docs.cloud.oracle.com/en-us/iaas/tools/ads-sdk/latest/index.html

4. Familiarity with JupyterLab: https://jupyterlab.readthedocs.io/

5. Familiarity with python: https://www.python.org/

## Getting Started

**Chrome or Edge are the browsers. You can switch during your session.**

**Set your browser zoom to 80%**

**Follow the guided instructions to login and access the course.**

Welcome to the module on using the OCI Data Science service to build a binary classification module. In the instructions there are a few screen shots. The service is always changing and while we try to keep up with the changes, please note that they are there for your reference only and things may look a little different.

You will need to log in to use this module. The instructions that tell you how to do this will have the information that you need.

**A note for Mac OS users. Use Ctrl+C / Ctrl+V to copy and paste.**

Have fun and enjoy learning about binary classification, exploratory data analysis (EDA), AutoML, model validation and selection, and machine learning explainability (MLX).

## Data Science Service

* Provides infrastructure and data science tools, such as open source technologies, libraries, and packages for machine learning and artificial intelligence. It also offers Oracle ML products, such as Oracle Labs AutoML and model explanation tools.

* Provides data scientists with a collaborative and project-driven workspace that includes an end-to-end cohesive user experience and supports the life cycle of predictive models.

* Helps data scientists concentrate on methodology and domain expertise to deliver more models to production in the Oracle Cloud Infrastructure.

**Data Science Service Concepts**

Review the following concepts and terms to help you get started with Data Science.

* Project: Projects are collaborative workspaces for organizing and documenting Data Science assets such as notebook sessions and models.

* Notebook Session: Data Science notebook sessions are interactive coding environments for building and training models. Notebook sessions come with many pre-installed open source and Oracle developed machine learning and data science packages.

* Accelerated Data Science SDK: The Oracle Accelerated Data Science (ADS) SDK is a Python library that is included as part of the Oracle Cloud Infrastructure Data Science service. ADS has many functions and objects that automate or simplify many of the steps in the Data Science workflow, including connecting to data, exploring and visualizing data, training a model with AutoML, evaluating models, and explaining models. In addition, ADS provides a simple interface to access the Data Science service model catalog and other Oracle Cloud Infrastructure services including Object Storage. To familiarize yourself with ADS, see the Accelerated Data Science Library.

* Model: Models define a mathematical representation of your data and business processes. The model catalog is a place to store, track, share, and manage models.

## Sign in to the OCI Console

* **Cloud Tenant:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}

**Note: Credentials can be accessed at any time by clicking on the icon at the top of the screen with the key on it.**

1. Enter your cloud tenant name and click continue.

2. Enter the user name and password that was provided to you. Use the login option under **Oracle Cloud Infrastructure**. Click Sign In.
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="image-alt-text">

3. Once you have successfully logged in, you will see the console home page.

## Selecting the Compartment

**Compartment:** {{Compartment}}

Your account has a root compartment and some compartments that are part of it. To access the notebook, you will need to select the compartment that has been assigned to you. The following instructions will help you do this.

1. Click on the OCI Services menu. This is the hamburger menu (3 horizontal lines) in the top left corner.

2. Scroll down the menu to Data Science. The menu will expand.

3. Click on Projects. The Projects screen will open.

4. Note, you will not see any projects listed on the Projects page until you select your compartment.

5. On the left-hand side you will see a compartment drop-down. Click on this.

6. In the compartment drop-down you will see the root compartment with a + sign. Click on the + sign and the list of choices will expand.

7. Select your compartment. If you have done this correctly, you will see a project listed under the Projects page.


<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Data_Science_Service/img/compartment.png" alt="image-alt-text">

## Opening the Notebook

JupyterLab notebooks are grouped into projects. Now that the correct compartment is selected, the notebook can be accessed using the following steps.

1. From the Projects page, click on the project "initial-datascience-project-XXXX". This will take you to the Notebook Sessions page for that project.

2. Under the list of notebooks, you will see a notebook with a name like "initial-datascience-session-XXXX". Click on that link and Notebook Session Information page will open

3. Click on the button "Open" to launch the notebook. A new tab in the browser will open.

4. You may have to login again.

* **User Name:** {{User Name}}
* **Password:** {{Password}}

## Working with JupyterLab

Now that JupyterLab is open, it can be seen that the screen is split into two sections. By default, the left side has the file browser open but it can change based on what navigation icons are selected on the far left side of the screen. The right side of the screen contains the workspace. It will have a notebook, terminal, console, launcher, Notebook Examples, etc..

Click on the file folder icon just below the JupyterLab logo on the left most section to close and open the file browser section. It can be closed as it is not needed for this lab.

There is a menu across the top of the screen. For this lab, the most interesting menu item is *Run*. It will allow you to execute the different code cells in the document. It is recommended that you manually execute the cells one at a time as you get to them. It is, generally important, that you execute them in order. To do this from the keyboard, press shift+enter in a cell and it will execute it and advance to the next cell. Alternatively, you can run all of the cells at once. To do this, click on Run then "Run Selected Cells".

## Binary Classification Model

To open the notebook, that will be used in this lab, have the launcher open. It will be open by default but if it got closed it can be accessed with *File*->*New Launcher*. 

1. Click on the *Notebook Examples*. A drop down will appear.

2. Select for *binary-classification-attrition.ipynb*. 

3. Click on the *Load Example*. It will open in a new tab.

4. Read through the document. When you encounter a chunk of code, click in the cell and press shift+Enter to execute it. When the cell is running a [*] will appear in the top left of the cell. When it is finished, a number will appear in [ ], for example [1].

5. Execute the cells in order. If you run into problems and want to start over again, click on *Kernel* then *Restart Kernel and Clear All Outputs...*

6. Step through the lab and look at the tools that are provided by Oracle Accelerated Data Science (ADS) SDK. This automates a number of time-consuming and repetitive processes by analyzing the data and creating appropriate outputs.

## Next Steps

**Congratulations! You have successfully completed the lab**

If you have time, there are some other notebooks that you may find interesting. They can be accessed by selecting *File*->*New Launcher* and then clicking on the *Notebook Examples*.

* **data_visualizations.ipynb**: It provides a comprehensive overview of the data visualization tools in ADS. This includes smart data visualization for columns based on data types and values.
* **transforming_data.ipynb**: Learn about the ADSDatasetFactory and how it can clean and transform data.
* **model_from_other_library.ipynb**: See the capabilities of the ADSModel class. See how ADSModel makes the ADS pipeline completely modular and adaptable to 3rd party models.

When you are done, you can close the lab by clicking on the "Finish Lab" button.
