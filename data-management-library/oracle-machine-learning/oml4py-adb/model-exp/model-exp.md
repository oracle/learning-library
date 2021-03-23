# Rank attribute importance using Model Explainability feature

## Introduction

This lab walks you through the steps to the steps to use the Model Explainability feature. You will learn how to use this feature, run the **GlobalFeatureImportance** to explain and interpret machine learning models.


Estimated Lab Time: 30 minutes

### About Model Explainability
Machine Learning Explainability (MLX) is the process of explaining and interpreting machine learning models. The oml.mlx Python module supports the ability to help better understand a model's behavior and how it ranks predictors when making predictions. MLX currently provides model-agnostic explanations for classification and regression tasks where explanations treat the ML model as a black-box, instead of using properties from the model to guide the explanation.

The **GlobalFeatureImportance** explainer object is the interface to the MLX permutation importance explainer. The global feature importance explainer identifies the most important features for a given model and data set. The explainer is model-agnostic and currently supports tabular classification and regression data set with both numerical and categorical features.

### Objectives

In this lab, you will:
* Import the **GlobalFeatureImportance** explainer
* Load the data set into the database
* Split the data set into train and test variables
* Train an SVM model
* Create the MLX Global Feature Importance explainer `gfi`
* Run the explainer `gfi.explain` to generate the global feature importance for the test data


### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## **STEP 1**: Import and run the GlobalFeatureImportance explainer

To use the GlobalFeatureImportance explainer to explain and interpret machine learning models:

1. Run the following script to import the oml module, Pandas, Numpy packages, GlobalFeatureImportance explainer and load the data set into the database. The script also adds a unique Case ID column.

  ```
  import oml
  from oml.mlx import GlobalFeatureImportance
  import pandas as pd
  import numpy as np
  from sklearn import datasets

  iris_ds = datasets.load_iris()
  iris_data = iris_ds.data.astype(float)
  X = pd.DataFrame(iris_data, columns=iris_ds.feature_names)
  y = pd.DataFrame(iris_ds.target, columns=['TARGET'])
  row_id = pd.DataFrame(np.arange(iris_data.shape[0]),
  columns=['CASE_ID'])
  df = oml.create(pd.concat([X, y, row_id], axis=1), table='Iris')
  ```
2. Split the data set into train and test variables.

  ```
  train, test = df.split(ratio=(0.8, 0.2), hash_cols='CASE_ID', seed=32)
  X, y = train.drop('SPECIES'), train['SPECIES']
  X_test, y_test = test.drop('SPECIES'), test['SPECIES']
  ```

3. Train an SVM model.

    ```
    model = oml.algo.svm(ODMS_RANDOM_SEED=32).fit(X, y, case_id='CASE_ID')
    "SVM accuracy score = {:.2f}".format(model.score(X_test, y_test))
    ```

4. Create the MLX Global Feature Importance explainer gfi, using the `f1_weighted` metric.
    ```
    gfi = GlobalFeatureImportance(mining_function='classification',
                              score_metric='f1_weighted',
                              random_state=32, parallel=4)
    ```

5. Run the explainer gfi.explain to generate the global feature importance for the test data:
    ```
    explanation = gfi.explain(model, X_test, y_test,
      case_id='CASE_ID', n_iter=10)
      explanation
    ```  
   The explainer returns the following explanation:

   ```
   Global Feature Importance:
   [0] petal length (cm): Value: 0.3462, Error: 0.0824
   [1] petal width (cm): Value: 0.2417, Error: 0.0687
   [2] sepal width (cm): Value: 0.0926, Error: 0.0452
   [3] sepal length (cm): Value: 0.0253, Error: 0.0152
   ```


## **Try it yourself:** Build a model and compare
Build an in-db RandomForest model and compare the RF model's attribute importance ranking with that from MLX.

## Learn More



* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
