# Introduction

## Data Science Service and NVIDIA RAPIDS

[Oracle Cloud Infrastructure (OCI) Data Science](https://docs.oracle.com/en-us/iaas/data-science/using/data-science.htm) is a fully managed service for data science teams to build, train, manage, and deploy machine learning models on Oracle Cloud Infrastructure.

The Data Science Service:
* Provides data scientists with a collaborative, project-driven workspace.
* Enables self-service access to infrastructure for data science workloads.
* Includes Python-centric tools, libraries, and packages developed by the open source community and the [Oracle Accelerated Data Science Library](https://docs.cloud.oracle.com/iaas/tools/ads-sdk/latest/index.html), which support the end-to-end life cycle of predictive models:
* Integrates with the rest of the Oracle Cloud Infrastructure stack, including Functions, Data Flow, Autonomous Data Warehouse, and Object Storage.
* Helps data scientists concentrate on methodology and domain expertise to deliver more models to production.

In this workshop you create a project and a notebook session in the Data Science service. The notebook session runs on a VM that hosts an NVIDIA GPU. In the notebook session
you install the [NVIDIA RAPIDS](https://rapids.ai/) 0.16 conda environment and run two notebooks introducing you to the `cuDF` and `cuML` libraries. The `cuDF` library provide powerful functionalities to
speed up data frame manipulations on a GPU while `cuML` provides a comprehensive series of machine learning algorithms that can be trained on a GPU.

Estimated Workshop Time: 2 hours

### Objectives
In this lab, you:
* Become familiar with the main features offered as part of the OCI Data Science service, including projects, notebook sessions, and conda environments.
* Execute notebooks that showcase some of the key features of the NVIDIA RAPIDS cuDF and cuML libraries.

### Prerequisites

* None.

## Data Science Service Concepts

Review the following concepts and terms to help you get started with the Data Science service.

* **Project**: Projects are collaborative workspaces for organizing and documenting Data Science assets, such as notebook sessions and models.
* **Notebook Session**: Data Science notebook sessions are interactive coding environments for building and training models. Notebook sessions come with many pre-installed open source and Oracle developed machine learning and data science packages.
* **Accelerated Data Science SDK**: The Oracle Accelerated Data Science (ADS) SDK is a Python library that is included as part of the Oracle Cloud Infrastructure Data Science service. ADS has many functions and objects that automate or simplify many of the steps in the Data Science workflow, including connecting to data, exploring and visualizing data, training a model with AutoML, evaluating models, and explaining models. In addition, ADS provides a simple interface to access the Data Science service model catalog and other Oracle Cloud Infrastructure services including Object Storage. To familiarize yourself with ADS, see the [Oracle Accelerated Data Science Library documentation](https://docs.cloud.oracle.com/iaas/tools/ads-sdk/latest/index.html).
* **Model**: Models define a mathematical representation of your data and business processes. The model catalog is a place to store, track, share, and manage models.

You can *proceed to the next lab*.

## Acknowledgements

* **Author**: [Jean-Rene Gauthier](https://www.linkedin.com/in/jr-gauthier/), Sr. Principal Product Data Scientist
* **Last Updated By/Date**:
    * [Jean-Rene Gauthier](https://www.linkedin.com/in/jr-gauthier/), Sr. Principal Product Data Scientist, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/data-science). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
