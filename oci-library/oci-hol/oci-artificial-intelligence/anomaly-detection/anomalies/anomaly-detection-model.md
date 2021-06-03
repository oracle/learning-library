#Lab 3: Train Anomaly Detection Model And Detect

## Introduction

In this session, we will show you how to train an anomaly detection model, deploy the model, and make predictions with new data.

***Estimated Lab Time***: 30 minutes

### Objectives

In this lab, you will:
- Learn to train an anomaly detection model with created data asset
- Learn to verify the trained model performance
- Learn to deploy the model to be ready
- Upload testing data to check detection result

### Prerequisites
- A Free tier or paid tenancy account in OCI (Oracle Cloud Infrastructure)
- Understand basic model terminology FAP - False Alarm Probability
- Tenancy is whitelisted to be able to use Anomaly Detection service


## **STEP 1:** Create a Model
* Select the proper data asset
* Set training parameters
* Train a model
Once the project livelabs_demo is selected, it will navigate the User to Created Anomaly Detection Project. Select Create and Train Model
![](../images/5_create_a_new_model.png " ")

Select Next
![](../images/create_a_new_data_asset.png " ")

Now that we have a data asset to train a model, let train an anomaly detection model. Since we have a Data Asset now, navigate back to the Create and Train a model screen
![](../images/5_create_a_new_model.png " ")

This time, the data asset previously created should show up on the default panel. Select Next
![](../images/choose_an_existing_dataset.png " ")


This takes us to train a model menu. Among options like naming the model and providing description which are option since they relate to housekeeping we also have an option to specify FAP(false alarm probability) and Train Fraction Ratio. The default values for these are 0.01 and 0.7 (implying 70%) respectively.

###FAP(False Alarm Probability)
FAP stands for False Alarm Probability. In other words, this basically specifies how much accurate the model needs to be. A high FAP model means the likelihood of an anomaly flagged by AD service to be a false alarm is high. If this is not desired, depending on the sensitivity requirements of a user, they can specify it to be low. One thing to keep in mind is by specifying a lower FAP, the model needs more time to train.

### How to calculate FAP
![](../images/fap.png " ")
As can be inferred from the formula, the more the number of false alarms higher the FAP will be.

###Train Fraction Ratio
Train Fraction Ratio specifies to the model on how much of the data to use for training. So the default value 0.7 or 70% specifies the model to use 70% of the data for training.

The default value 0.01 is very less so in order to save on the training time, we will dial up the FAP to 0.05. The training fraction ratio can be left as it is.
![](../images/create_and_train_model.png " ")

Select Submit. If the steps till now are done right, we should see the following screen.
![](../images/model_creation.png " ")

## **STEP 2:** Deploy a Model
* Once we have verified that our model is successfully created now it is time to deploy our model. To initiate the process, click on the model you desire to deploy. It will direct you to the model deployment form
![](../images/add_deployment.png " ")

* Click on Add Deployment.
![](../images/add_deployment_form.png " ")

* Press Submit button. Once the deployment is successful, the model is ready to be used for detecting anomalies.
![](../images/detect_anomalies.png " ")

## **STEP 3:** Detect Anomaly with new Data

* Upload to UI
To start the  process of anomaly detection select detect anomalies.
![](../images/upload_data.png " ")

Select a file from local filesystem or drag and drop the desired file.
![](../images/detect_anomalies_result.png " ")

Now press detect.

* See result in graph
Once the test file is submitted, you have the option to select the column to see anomalies for.
![](../images/select_column.png " ")

Use the drop wizard to select column. The columns for which the model has detected anomalies will be labelled as such.
![](../images/select_column_drop.png " ")

 Lets select sensor 8 to see where the model has detected an anomaly.
 ![](../images/graph.png " ")

The part of the signal where the model has determined to be an anomaly is highlighted. There is also an option to download the anomaly detection result.

* Download anomaly file
 ![](../images/graph_highlighted.png " ")

This will download a file named anomalies.json Lets peek at the contents
 ```json
 {
    "anomalies": {
      "pressure_1": [
        {
          "timestamp": "2020-07-02T13:12:00.000Z",
          "estimatedValue": 85.66492698482568,
          "actualValue": 81.7651725
        },
        {
          "timestamp": "2020-07-02T13:12:01.000Z",
          "estimatedValue": 87.28059796474808,
          "actualValue": 76.87014
        },
        {
          "timestamp": "2020-07-02T13:13:00.000Z",
          "estimatedValue": 88.59603352625678,
          "actualValue": 71.97510750000001
        },
        {
          "timestamp": "2020-07-02T13:14:00.000Z",
          "estimatedValue": 89.468983523406,
          "actualValue": 67.080075
        },
        {
          "timestamp": "2020-07-02T13:14:01.000Z",
          "estimatedValue": 90.20400941495645,
          "actualValue": 62.1850425
        },
        {
          "timestamp": "2020-07-02T13:15:00.000Z",
          "estimatedValue": 90.657841920921,
          "actualValue": 57.29001
        }
      ],
      "temperature_4": [
        {
          "timestamp": "2020-07-02T13:20:01.000Z",
          "estimatedValue": 16.224764289227032,
          "actualValue": 20
        },
        {
          "timestamp": "2020-07-02T13:21:00.000Z",
          "estimatedValue": 16.207771473365277,
          "actualValue": 20.1
        },
        {
          "timestamp": "2020-07-02T13:22:00.000Z",
          "estimatedValue": 16.253040231702492,
          "actualValue": 20.15
        },
        {
          "timestamp": "2020-07-02T13:22:01.000Z",
          "estimatedValue": 16.25493106991135,
          "actualValue": 20.1
        }
      ]
    }
  }

 ```

We see that the results for all the anomalies are within their own key. And each value is a further a tuple that contains the timestamp, actual value and what the model expects the value to be.

In the results pay attention to the  difference between the estimatedValue and actualValue. Generally some error is expected but in this particular values are what the AD service deemed to be anomalous.

Congratulations on completing this lab!

You now have completed the full cycle of using the training data to create a model and deploy, and also making predictions with testing data.

The next 2 sessions are optional for advanced users, which cover the topic on using REST API to integrate our services and how to prepare the training and testing data from raw data in different scenarios.

[Proceed to the next section](#next).

## Acknowledgements

* **Authors**
    * Jason Ding - Principal Data Scientist - Oracle AI Services
    * Haad Khan - Senior Data Scientist - Oracle AI Services
* **Last Updated By/Date**
    * Haad Khan - Senior Data Scientist, May 2021
