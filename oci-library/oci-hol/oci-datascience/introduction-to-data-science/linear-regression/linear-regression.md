# Lab: Linear Regression (using OCI Data Science service)

## Introduction

This lab will guide you through a practical example of how to train and apply a regression model. You have access to a dataset with house sale data. The dataset includes the Sale Price and many attributes that describe some aspect of the house, including size, area, features, et cetera. You will use this dataset to build a regression model that can be used to estimate what a house with certain characteristics might sell for.

There are many applications of regression in business. The main use cases are around forecasting and optimization. For example, predicting future demand for products, estimating the optimal price for a product and fine-tuning manufacturing and delivery processes. In other words, the principles that you learn with this exercise are applicable to those business scenarios as well.

This video will cover additional theory that you require to be able to do the exercise.

[](youtube:y_GpyF-y1xw)

Estimated lab time: 90 minutes (video 8 minutes, exercise +/- 80 minutes)

### Objectives

In this lab you will:
* Become familiar with Data Exploration, Data Preparation, Model training and Evaluation techniques.
* Become familiar with Python and its popular ML libraries, in particular Scikit Learn.
* Become familiar with the OCI Data Science service.

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account (see prerequisites in workshop menu)

## **STEP 1:** Provision OCI Data Science

This guide shows how to use the Resource Manager to provision the service using Resource Manager. This process is mostly automated. However, if you prefer a step-by-step manual approach to control every aspect of the provisioning, please follow the following instructions instead: [manual provisioning steps](https://docs.cloud.oracle.com/en-us/iaas/data-science/data-science-tutorial/tutorial/get-started.htm#concept_tpd_33q_zkb).

1. In your Oracle Cloud console, open the menu.
   ![](./images/openmenu.png)

2. Select Resource Manager -> Stacks.

   ![](./images/resourcemanager.png)

3. Click the "Create Stack" button.

   ![](./images/createstackbutton.png)

4. Choose "Sample Solution" and click the button "Select Solution".

   ![](./images/newimage1.png)

5. Check the "Data Science" solution and click "Select Solution".

   ![](./images/newimage2.png)

6. Choose a compartment that you've created or use Root.

   ![](./images/newimage3.png)

7. Click "Next".

   ![](./images/newimage4.png)

8. Configure the Project and Notebook Session

   Select "Create a Project and Notebook Session".

   We recommend you choose VM.Standard2.8 (*not* VM.Standard.*E*2.8) as the shape. This is a high performance shape, which will be especially useful when we run AutoML later on.

   ![](./images/newimage5b.png)

9. Disable the option "Enable Vault Support".

   ![](./images/newimage6.png)

10. Disable the option "Provision Functions and API Gateway".

   ![](./images/disablefunctions.png)

11. Click "Next".

   ![](./images/newimage7.png)

12. Click "Create".

   ![](./images/create.png)

13. Run the job

   Go to "Terraform Actions" and choose "Apply".

   ![](./images/applytf.png)

14. Click Apply once more to confirm the submission of the job.

   Provisioning should take about 20 minutes after which the status of the Job should become "Succeeded".

## **STEP 2:** Open the OCI Data Science notebook

1. Open OCI Data Science projects console

   ![](./images/open-projects.png)

2. Open the project that was provisioned

   The name of the project may be different than shown here in the screenshot.

   ![](./images/open-project.png)

3. Open the notebook that was provisioned

   The name of the notebook may be different than shown here in the screenshot.

   ![](./images/open-notebook.png)

## **STEP 3:** Upload House Sales Data

1. Download the dataset with the house prices and characteristics.

   Download [The training dataset](files/housesales.csv) (the dataset is public)

   Click on the link, then use the `"Raw"` button and then right click `"Save As"`. Make sure to save these with extension `CSV`. Some browsers try to convert this to Excel format, which is incorrect.

2. Review the datasets.

   The column names are explained [here](files/data-description.txt). This document also explains the possible list-of-values for categorical attributes.

## **STEP 4:** Prepare your notebook

1. Open the notebook (in OCI) that you created in the prerequisites

   ![Open Notebook](images/opennotebook2.png)

2. Upload the dataset by dragging it to the left panel

   ![Upload Dataset](images/uploaddataset.png)

3. Create a new notebook

   Jupyter is a notebook environment that allows on-the-fly Python execution. It allows you to mix Python code with text for documentation. Create a new Jupyter notebook by clicking on the button that shows `"Python 3"`.

   ![Create Notebook](images/createjupyternotebook.png)

## **STEP 5:** Data Exploration

1. Understanding Data Exploration

   The goals of this are to identify what data you have and what is usable, identify issues such as missing values and outliers, and Forf ideas of new features that could be calculated (Feature Engineering). Later on we'll use the knowledge that we gain during Data Exploration to decide which data transformations to perform.

2. Copy the code for loading the required Python libraries

   `Pandas` is a library that's used for working with data, e.g. displaying it and doing data transformations.

   - `Numpy` is a library to work with arrays and for calculations.
   - `Sklearn` is the standard Python library for machine learning. It provides many unsupervised and supervised learning algorithms.
   - `Seaborn` is a Python data visualization library based on matplotlib.

   Press the copy button on the fragment below.

    ```python
    <copy>
    import pandas as pd
    import matplotlib.pyplot as plot
    import seaborn as sns
    import numpy as np
    from scipy.stats import norm
    from sklearn.preprocessing import StandardScaler
    from sklearn.model_selection import train_test_split
    from sklearn import linear_model
    from sklearn.metrics import mean_squared_error
    from scipy import stats
    import warnings
    warnings.filterwarnings('ignore')
    %matplotlib inline
    </copy>
    ```

3. Paste the code into the Notebook and run it

   ![Run Script](images/runscript.png)

   Follow the copy-paste approach every time you see a piece of code like this.

4. Load the training data

   We'll split this into train and test later. All these type of data operations are handled by the Pandas library (named `"pd"` here)

    ```python
    <copy>
    alldata = pd.read_csv('./housesales.csv')
    </copy>
    ```

5. Check how much data we have

   Is the dataset large enough to train a model?

   The following code shows that there are 1460 rows, which at first sight looks like a good enough to train an initial model. The data is not extensive enough for production use but would help establish a good baseline. We also see that there are 80 input features that we can potentially use to predict our target variable.

    ```python
    <copy>
    alldata.shape
    </copy>
    ```

6. Review the target attribute: `SalePrice`

   Before we look at the input features, let's have a close look at our Target attribute: `SalePrice`.

   First, let's display some values. The `[:10]` selects only the first 10 rows.

    ```python
    <copy>
    alldata['SalePrice'][:10]
    </copy>
    ```

7. Let's check if there are any empty values

    ```python
    <copy>
    alldata['SalePrice'].isnull().sum()
    </copy>
    ```

8. Let's check the price range:

    ```python
    <copy>
    minPrice = alldata['SalePrice'].min()
    maxPrice = alldata['SalePrice'].max()

    print('Min Sales Price (%d) - Max Sales Price (%d)' % (minPrice,maxPrice))
    </copy>
    ```

9. What can we conclude from the above?

   *SalePrice* is an integer and has numbers in the range that we would expect from house prices. There are no empty values. We could see however that the price range is very wide from a 34900 up to 755000. This would require to scale the price to allow the algorithm to learn better.

10. Which columns will we select as input features for our model?

   Let's start by listing all the columns.

    ```python
    <copy>
    alldata.columns
    </copy>
    ```

11. Separate the columns into numerical and categorical

   As we can see there are too many, maybe more useful will be to separate them and see only the numerical and the categorical ones.

   Let's get a list of all numeric features first.

    ```python
    <copy>
    alldata.select_dtypes(include=np.number).columns.tolist()
    </copy>
    ```

12. Show a sample of numerical columns

   Now that we see the numeric columns we could also show a sample to get some impression about the data.

    ```python
    <copy>
    alldata.select_dtypes(include=[np.number])
    </copy>
    ```

13. Show a list of categorical columns

   We could do the same for all categorical variables, notice this time we use the property `exclude` in the `select_dtypes` function...

    ```python
    <copy>
    alldata.select_dtypes(exclude=np.number).columns.tolist()
    </copy>
    ```

14. Show a sample of categorical variables

    ```python
    <copy>
    alldata.select_dtypes(exclude=[np.number])
    </copy>
    ```

15. What can we conclude about the columns?
   There are many input features that we could potentially use. Some of these columns are self explanatory, others not so much. To understand what each column mean, have a look at [data_scription.txt](./data/data-description.txt) for background.

16. Which columns would we select intuitively?

   To start with, let's first take an intuitive approach. Ask yourself:

   `"Which of these columns is likely of value to predict Sale Price?"`
   `"Which factors of a house would I look at yourself when making a buying decision?"`
   `"Is enough information available in these columns, are there any empty values?"`

   Imagine that we've decide that we believe the following features are relevant:

   `GrLivArea`: size of living area
   `TotalBsmtSF`: size of basement
   `OverallQual`: overall quality category
   `YearBuilt`: year house was built
   `MSZoning`: A=Agriculture, C=Commercial, RH=Residential High Density, etc.

17. Are the columns we selected intuitively also correlated with the Sale Price?

   Let's test our theories that these input features are correlated with Sale Price. We'll start with the numerical variables first: `GrLivArea`, `TotalBsmtSF`, `OverallQual` and `YearBuilt`.
   Because all of these are numerical continuous attributes, we can use scatter plots here.

    ```python
    <copy>
    plot.scatter(alldata.GrLivArea, alldata.SalePrice)
    plot.xlabel("GrLivArea")
    plot.ylabel("SalePrice")
    plot.show()
    plot.scatter(alldata.TotalBsmtSF, alldata.SalePrice)
    plot.xlabel("TotalBsmtSF")
    plot.ylabel("SalePrice")
    plot.show()
    plot.scatter(alldata.OverallQual, alldata.SalePrice)
    plot.xlabel("OverallQual")
    plot.ylabel("SalePrice")
    plot.show()
    plot.scatter(alldata.YearBuilt, alldata.SalePrice)
    plot.xlabel("YearBuilt")
    plot.ylabel("SalePrice")
    plot.show()
    <copy>
    ```

18. What can we conclude from this plot?

   `GrLivArea`: There is a linear correlation with `SalePrice`; We can draw a straight line from the bottom-left to the top-right.
   `TotalBsmtSF`: It appears to be an relationship between `TotalBsmtSF` and `SalePrice` too but not that obvious. It seems a higher basement sizes lead to higher prices but we could notice that there are some outliers.
   `OveralQual`: As expected, there is a higher sales price when overal quality perception is higher. But that is not nessary for the entire price range. Probably the quality of the house is not enough and the price would depend on the location or the zoning as well.
   `YearBuilt`: This relationship is a little less obvious, but there's a trend for higher prices for more recent construction.

   These attributes appear to be of predictive value and we want to keep them in our training set.

   On another note, we see several `outliers`. In particular, the attribute `GrLivArea` shows that there are some houses with exceptionally large living areas given their price. We could notice this also for the `TotalBsmtSF`. Generally it is recommended to build the initial model with all the available values first and then start removing outliers to see if this would improve the prediction and make the model generalize better.

19. Is the categorical attribute `MSZoning` also correlated with `SalePrice`?

   This attribute contains the type of property (`A=Agriculture`, `C=Commercial`, `RH=Residential High Density`, et cetera). Correlation between a categorical and a continuous attribute (SalePrice) can be visualized as a boxplot.

    ```python
    <copy>
    var = 'MSZoning'
    data = pd.concat([alldata['SalePrice'], alldata[var]], axis=1)
    f, ax = plot.subplots(figsize=(10, 7))
    fig = sns.boxplot(x=var, y="SalePrice", data=data)
    fig.axis(ymin=0, ymax=800000)
    </copy>
    ```

20. What can we conclude from the MSZoning plot?

   The boxplots for the various types of properties look very different. From the plot we could see that the residential areas seems to be more expensive as expected than commercial but the price range is high.

21. What is the relationship between Neighborhood and SalePrice?

   Let's explore also the relationship of the Neighborhood to the price. We can plot the data using the same technique.

    ```python
    <copy>
    var = 'Neighborhood'
    data = pd.concat([alldata['SalePrice'], alldata[var]], axis=1)
    f, ax = plot.subplots(figsize=(30, 10))
    fig = sns.boxplot(x=var, y="SalePrice", data=data)
    fig.axis(ymin=0, ymax=800000)
    </copy>
    ```

22. What can we conclude from the Neighborhood plot?

   The plot is not nesserary conclusive but it appears that as expected some areas are more expensive than others. As such we should keep this columns and use it in the model. Notice that some areas shown very large range of prices and spikes like `NridgHt` or `StoneBr` or very large outliers like in `NoRidge` with prices more than double as the usual range for that neighborhood. After the initial model build you could try to remove these outliers and test if the model would have better performance.

23. A different approach: Systematically checking for correlation between input features and our target

   It becomes clear that manually investigating all of the attributes this way is very time consuming. Therefore, let's take a more systematic approach. Ideally, we would like to see the correlation between all input attributes and the target `SalePrice`.

    ```python
    <copy>
    corr = alldata.corr(method='spearman')
    corr.sort_values(["SalePrice"], ascending = False, inplace = True)
    corr.SalePrice
    </copy>
    ```

24. What conclusion can we draw from the correlation plot?

   Our initial intuition of thinking that `TotalBsmtSF`, `OverallQual`, `GrLivArea` and `YearBuilt` are of importance, was correct. However, there are other features listed as high correlation, such as `GarageCars`, `GarageArea` and `Fullbath`.

   Here's an explanation of the features that are most correlated with our target:

   `OverallQual`: Rates the overall material and finish of the house (1 = Very Poor, 10 = Very Excellent)
   `GrLivArea`: Above grade (ground) living area square feet
   `GarageCars`: Size of garage in car capacity
   `GarageArea`: Size of garage in square feet
   `TotalBsmtSF`: Total square feet of basement area
   `1stFlrSF`: First Floor square feet
   `FullBath`: Full bathrooms above grade
   `TotRmsAbvGrd`: Total rooms above grade (does not include bathrooms)
   `YearBuilt`: Original construction date

25. What is the relationship between GarageCars and GarageArea?

   Of the top correlated attributes, two are related to the garage(s) of the house. It appears that GarageArea and GarageCars are very similar types of information. This phenomenon is called `colinearity`. Let's test if GarageArea and GarageCars are correlated.

    ```python
    <copy>
    var = 'GarageCars'
    data = pd.concat([alldata['GarageArea'], alldata[var]], axis=1)
    f, ax = plot.subplots(figsize=(8, 6))
    fig = sns.boxplot(x=var, y="GarageArea", data=data)
    fig.axis(ymin=0, ymax=1500);
    </copy>
    ```

26. What conclusion can we draw from the colinearity plot?

   Indeed, there's a pattern here. It's logical that a bigger size of garage (GarageArea) will allow for more cars to park (GarageCars) and maybe even suggest bigger house too. However we could notice also a lot of outliers where houses with single or two cars garage are as expensive as the houses with three or four cars garage. This could mean that other features have stronger relationship to the price or we have outliers that we should try to remove later.

27. How can we deal with Colinearity in a systematic way?

   To do this, we would have the check the correlation between all attributes (!) There's a visualization that can help us do this: `The Correlation Matrix Heatmap`

    ```python
    <copy>
    corrmat = alldata.corr()
    f, ax = plot.subplots(figsize=(15, 15))
    sns.heatmap(corrmat, vmax=.8, square=True);
    </copy>
    ```

28. How do we interpret this chart?

   We see that all attributes are listed on the vertical and the horizontal axis. Bright colors (white) mean high correlation. The diagonal line shows the correlation of each attribute with itself, and hence is correlated. If you check the very bottom "line", you see the correlation of all input features with `SalePrice`. The other bright spots indicate attributes that might contain similar information. For example, we see the correlation between `GarageArea` and `GarageCars`.

   **Which other correlations do you see? Can you explain them?**

29. Do we have Missing Data?

   Many machine learning models are unable to handle missing data. We have to find out how much data is missing. At the moment of replacing missing data, we should first find out whether that would cause some kind of distortion in the data and have a negative effect on model quality.

   Therefore, we have to see if the missing data follows certain patterns.

   Check how many Empty values each column has, and compute the percentage of the total number of rows.

    ```python
    <copy>
    total = alldata.isnull().sum().sort_values(ascending=False)
    percent = (alldata.isnull().sum()/alldata.isnull().count()).sort_values(ascending=False)
    missing_data = pd.concat([total, percent], axis=1, keys=['Total', 'Percent'])
    missing_data.head(20)
    </copy>
    ```

30. Conclusions on missing data

   There are a lot of attributes with missing values. This is especially the case for attributes `PoolQC`, `MiscFeature`, `Alley`, `Fence` and `FireplaceQu`.

31. Let's investigate the attributes with most missing values in detail

   The description of the attribute `PoolQC` (pool quality) is as follows:

   `Ex - Excellent`
   `Gd - Good`
   `TA - Average/Typical`
   `Fa - Fair`
   `NA - No Pool`

   It seems sensible to assume that most houses don't have pools and therefore missing values simply mean `"No Pool"`. Therefore we make a note to replace those missing values with `"NA"`.
   Similarly, we make a note to replace the missing values for `MiscFeature`, `Alley`, `Fence` and `FireplaceQu` with `"NA"`.

   The next attribute with many hidden values is `LotFrontage`, which means `"Linear feet of street connected to property"`. This is a continuous measure, and we choose that we will replace missing values by with the mean of the existing values.

32. Check the distribution of the Target variable

   It's important that the target variable follows Normal Probability distribution. If it does not, this will negatively impact the model's performance. We can check for this using a histogram, and including a normal probability plot. The Seaborn library does this for us.

    ```python
    <copy>
    sns.distplot(alldata['SalePrice'], fit=norm);
    fig = plot.figure()
    </copy>
    ```

33. What conclusion can we draw from the Target variable plot?

   This deviates from the Normal Distribution. You see that it is left skewed. The regression algorithms that we will use later on has problems with such a distribution. We will have to address this problem.

## **STEP 6:** Data Preparation

During Data Exploration, we have realized that several changes must be made to the dataset. Data Preparation is a logical result of Data Exploration; we will now take action based on the insights that we gained earlier.

1. Update missing values

   In the previous topic (identifying Missing Values) we made the decision that:

   We want to replace the missing values of `PoolQC`, `MiscFeature`, `Alley`, `Fence` and `FireplaceQu` with `"NA"`.
   We will replace missing values of `LotFrontage` with the mean of the existing values. Let's do this:

    ```python
    <copy>
    alldata = alldata.fillna({"PoolQC": "NA"})
    alldata = alldata.fillna({"MiscFeature": "NA"})
    alldata = alldata.fillna({"Alley": "NA"})
    alldata = alldata.fillna({"Fence": "NA"})
    alldata = alldata.fillna({"FireplaceQu": "NA"})
    meanlot = alldata['LotFrontage'].mean()
    alldata = alldata.fillna({"LotFrontage": meanlot})
    alldata = alldata.dropna()
    </copy>
    ```

2. Handling Outliers

   Do you remember that the scatter chart for `GrLivArea` showed several outliers? Let's remove these two outliers, by identifying the houses with the highest `GrLivArea`.

   Show the IDs of the houses with the highest GrLivArea.

    ```python
    <copy>
    alldata.sort_values(by = 'GrLivArea', ascending = False)[:2]
    </copy>
    ```

3. Remove the Outliers

  Also plot the chart again to check that the outliers have disappeared.

    ```python
    <copy>
    alldata = alldata.drop(alldata[alldata['Id'] == 1299].index)
    alldata = alldata.drop(alldata[alldata['Id'] == 524].index)
    plot.scatter(alldata.GrLivArea, alldata.SalePrice)
    plot.xlabel("GrLivArea")
    plot.ylabel("SalePrice")
    plot.show()
    </copy>
    ```

4. Handling the skewed distribution of the Target variable

   Do you remember that the histogram of `SalePrice` showed a positive skew? We can solve this problem by converting the target variable. We use a `-log-` transformation to make the variable fit normal distribution. Let's make the log transformation and show the histogram again to check the result.

   After this the sales price will follow a normal distribution. We will use the newly created `y` variable later to fit our model.

    ```python
    <copy>
    y = np.log(alldata['SalePrice'])
    sns.distplot(y, fit=norm)
    fig = plot.figure()
    </copy>
    ```

5. Removing irrelevant features

   In any case we will remove the ID column, which does not carry any predictive value. We will also remove the attributes that showed very low correlation with `SalePrice` during Data Exploration. Note that this is a fairly brute approach, but it is again sufficient for our exercise. After the first model build, you could start addining back some of the features and observe if the model will generalize better.

    ```python
    <copy>
    alldata.drop("Id", axis = 1, inplace = True)
    alldata.drop("BsmtFullBath", axis = 1, inplace = True)
    alldata.drop("BsmtUnfSF", axis = 1, inplace = True)
    alldata.drop("ScreenPorch", axis = 1, inplace = True)
    alldata.drop("MoSold", axis = 1, inplace = True)
    alldata.drop("3SsnPorch", axis = 1, inplace = True)
    alldata.drop("PoolArea", axis = 1, inplace = True)
    alldata.drop("MSSubClass", axis = 1, inplace = True)
    alldata.drop("YrSold", axis = 1, inplace = True)
    alldata.drop("BsmtFinSF2", axis = 1, inplace = True)
    alldata.drop("MiscVal", axis = 1, inplace = True)
    alldata.drop("LowQualFinSF", axis = 1, inplace = True)
    alldata.drop("OverallCond", axis = 1, inplace = True)
    alldata.drop("KitchenAbvGr", axis = 1, inplace = True)
    alldata.drop("EnclosedPorch", axis = 1, inplace = True)
    </copy>
    ```

6. Separating Target and Input Features

   Scikit Learn expects that we deliver the data for training in two parts:

   * A dataset with a single column, the target, in this case `SalePrice`. We did this already earlier by taking the `log` of the `SalePrice` and storing it in `"y"` variable.
   * A dataset with all the input columns, in this case all columns apart from `SalePrice`. We will place this in variable "X".

   Get all the data with the exception of the `SalePrice`:

    ```python
    <copy>
    X = alldata.drop(['SalePrice'], axis=1)
    </copy>
    ```

7. Convert categorical values to numbers

   Most ML algorithms can only work with numbers. Therefore we should convert categories to numbers first.

   For all attributes we will assume that they are Nominal (as opposed to Ordinal), meaning that there's no order/sequence in the values that it can take. The go-to method to encode Nominal categorical values is Onehot Encoding. This will convert each separate value of a category into its own column that can take a value of 1 or 0. The Pandas `get_dummies` function does OneHot encoding.

   You will see that after this the `SaleType` column has been converted into `SaleType_ConLw`, `SaleType_New`, et cetera. The dataset now only has numerical values.

    ```python
    <copy>
    X = pd.get_dummies(X)
    X.head()
    </copy>
    ```

## **STEP 7:** Building the model

   We will build a simple Linear Regression model. We will use the Scikit-Learn library for this.

1. Split Train and Test data so we can validate the model later

   After building the model, we will want to test its performance against new data. It's important that this data has not been seen before during the model training. To achieve this we have to reserve part of our dataset for testing, which will be removed from the training phase.

   We'll reserve 20% of the total dataset for testing. The random_state variable is for initializng the randomizer. By hardcoding it here we make sure that we select the same records everytime that we run the script.

   After this we will have 4 variables:
   `X_train`: The input features of the training dataset.
   `X_test`: The input features of the test dataset.
   `y_train`: The target of the training dataset.
   `y_train`: The target of the test dataset.

    ```python
    <copy>
    X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=63, test_size=.20)
    </copy>
    ```

2. Build the model

   Now we're ready to build the model (on the training data only). Building the model is also called "fitting".

    ```python
    <copy>
    lr = linear_model.LinearRegression()
    model = lr.fit(X_train, y_train)
    </copy>
    ```

## **STEP 8:** Verifying the performance of the model

   How accurate is our model? We will use the Test dataset for this.

1. Apply the predictions on the Test dataset

    ```python
    <copy>
    y_predicted = model.predict(X_test)
    </copy>
    ```

2. An intuitive, visual approach to verification

   To verify the quality of the predictions, let's first use an intuitive visual approach, which works well for linear regression models. For this we will display in one plot:

   The actual `SalePrice` (according to the original data in the Test dataset)
   The predicted `SalePrice` (the value according to our model)

   We're plotting this as a scatter.

   In ideal circumstances we'd like to see the predictions falling on the line of actual values. This would mean that Predicted and Actual Sale Prices are the same.

    ```python
    <copy>
    plot.scatter(y_predicted, y_test)
    plot.xlabel('Predicted Sale Price')
    plot.ylabel('Actual Sale Price')
    plot.title('Comparing Predicted and Actual Sale Prices')
    plot.plot(range(11, 15), range(11, 15), color="red")
    plot.show()
    </copy>
    ```

3. A measurable approach to verification

   How can we express the accuracy of the model in a more mathematical way? For that we use a quality metric, in this case we could use [RMSE](https://en.wikipedia.org/wiki/Root-mean-square_deviation).

   In essence `RMSE` measures the distance between the predictions and the actual values. A lower value for RMSE means a higher accuracy.

   RMSE by itself is not easy to interpret, but it can be used to compare different versions of a model, to see whether a change you've made has resulted in an improvement. Scikit-Learn has a function to calculate RMSE.

    ```python
    <copy>
    print('RMSE: ', mean_squared_error(y_test, y_predicted))
    </copy>
    ```

## **STEP 9:** Single house SalesPrice prediction

   Let's use now the model and try to predict the SalesPrice for a house. From the given test set we would get the data from one house, to see how this works and to have this as reference example later if you want to deploy the model and use it as REST Services for example.

1. Select one record of house data from the test set and see how it looks in JSON format:

    ```python
    <copy>
    r = X_test.iloc[2]
    r.to_json()
    </copy>
    ```

2. Verify the record

   This is the information from the test set for a single house, however we only need the data and not the names of each of the columns/features to pass to the model for prediction.

   ![single house data](images/singlehousedata.png)

3. Convert data into an array

   Let's get the data into a form that would allow us to store it as array. If you execute following in your notebook:

    ```python
    <copy>
    r.to_csv(index=False, line_terminator=',')
    </copy>
    ```

4. Check the resulting array

    <p>
    '67.0,10656.0,8.0,2006.0,2007.0,274.0,0.0,1638.0,1646.0,0.0,1646.0,0.0,2.0,0.0,3.0,6.0,1.0,2007.0,3.0,870.0,192.0,80.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,1.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,'
    </p>

5. Create a new variable with that data

  Notice that we are removing the last comma `(,)` from the array.

    ```python
    <copy>
    input = [[67.0,10656.0,8.0,2006.0,2007.0,274.0,0.0,1638.0,1646.0,0.0,1646.0,0.0,2.0,0.0,3.0,6.0,1.0,2007.0,3.0,870.0,192.0,80.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,1.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0]]
    </copy>
    ```

6. Make prediction on single house

    ```python
    <copy>
    s_predicted = model.predict(input)
    s_predicted
    </copy>
    ```

7. Check the resulting prediction

  The result should be

```console
array([12.42384482])
```

8. Convert house price back to normal range

  You would notice that the price is strange, it shows a number that doesn't seem to be a normal house Sales Price. If you remember we scaled the SalePrice by using `np.log(SalePrice)` to get the prices in smaller range and help the algorithm generalize and learn better. To get the real price now we need to revert back this scale. To do so we have to use `np.exp(PredictedSalePrice)`, example:

    ```python
    <copy>
    np.exp(12.42384482)
    </copy>
    ```

9. Check the result of the conversion

    ```console
    248660.7558014956
    ```

10. Predict directly from test set array

   In case you want to save yourself all this steps and execute the model directly against a house data in the test set, you could also access it directly from the test set array. Notice we used the third house data from the test set:

    ```python
    <copy>
    single_predicted = model.predict(X_test[2:3])
    single_predicted
    </copy>
    ```

## Bonus: Train the model using AutoML

   OCI Data Science comes with a Python library SDK called ADS (Accelerated Data Science) that allows you to streamline the entire lifecycle of machine learning models, from data acquisition to model evaluation and interpretation. It also comes with the Oracle AutoML engine, which automates Feature Selection, Algorithm Selection, Feature Encoding and Hyperparameter Tuning.

   We will use it to train a model for the same problem as above (House Price Prediction), but this time automating the process using the various AutoML features. Once we've done that we will evaluate it using the ADS evaluation features and compare it with our "manually" built model that we created earlier.

   In this case, we've already prepared the notebook that you will run.

1. Download the notebook

  Download the [AutoML and Model Evaluation notebook](files/lab100-bonus-1.ipynb). Click on the link, then use the `"Raw"` button and then right click `"Save As"`. Make sure to save these with extension `ipynb`. Some browsers try to convert this to Txt format, which is incorrect.

2. Upload the notebook to OCI Data Science by dragging it to the left panel.

   ![Upload Notebook](images/uploadnotebook.png)

3. Open the Notebook that you've just uploaded

   Now go through each of the cells and run them one by one.

[Proceed to the next section](#next).

## Acknowledgements
* **Authors** - Jeroen Kloosterman - Product Strategy Manager - Oracle Digital, Lyudmil Pelov - Consulting Solution Architect - A-Team Cloud Solution Architects, Fredrick Bergstrand - Sales Engineer Analytics - Oracle Digital, Hans Viehmann - Group Manager - Spatial and Graph Product Management
* **Last Updated By/Date** - Jeroen Kloosterman, Oracle Digital, Jan 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
