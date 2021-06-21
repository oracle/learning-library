# Lab 4: (Advanced Session) Access Anomaly Detection Service with REST API

## Introduction

Our anomaly detection services also support to use CLI tool `oci` or REST API calls to perform model and data operations.

In this lab session, we will show several code snippets to integrate with our service endpoints.

You do not need to execute those codes, but review them to understand what information and steps are needed to implement your own integration.

*Estimated Lab Time*: 45 minutes

### Objectives:

* Learn how to use REST API to communicate with our anomaly detection service endpoints.

### Prerequisites:
* Familiar with Python programming is required
* Have a Python environment ready in local or use our [Data Science Platform](https://www.oracle.com/data-science/)
* Familiar with local editing tools, vi and nano
* Installed with Python libraries: `oci` and `requests`

## REST API Endpoints

Our service supports CRUD (Create, Read, Update, Delete) actions on the four different resource types involved, including Project, Data Asset, Model, and Deployment.

The following are a few examples of accessing those API endpoints using Python. The complete code file can be [downloaded here](../files/anomaly_detection_rest_api_example.py).


### **STEP 1:** Authentication

This code snippet showed you how to perform authentication before other operations.

```Python
import oci
import json
import requests

# replace with the location of your oci config file
CONFIG_FILENAME = "~/.oci/config"
config = oci.config.from_file(CONFIG_FILENAME, profile_name="DEFAULT")

auth = oci.signer.Signer(
  tenancy=config['tenancy'],
  user=config['user'],
  fingerprint=config['fingerprint'],
  private_key_file_location=config['key_file'],
  pass_phrase=config['pass_phrase'])

# Initialize some constants
CLOUD_ENV_URL = "https://aiservice.us-ashburn-1.oci.oraclecloud.com" # Change this accordingly based on your region
# https://aiservice.us-ashburn-1.oci.oraclecloud.com
# https://aiservice.eu-frankfurt-1.oci.oraclecloud.com
# https://aiservice.ap-mumbai-1.oci.oraclecloud.com
COMPARTMENT_ID = "YOUR_COMPARYMENY_ID"

```

### **STEP 2:** Creating a Project

```Python
PROJECT_URL = f"{CLOUD_ENV_URL}/20210101/projects"

project_name = "Sample Project"
project_desc = "SAMPLE PROJECT FOR ANOMALY DETECTION"
payload = { "displayName": project_name,
                 "compartmentId": COMPARTMENT_ID,
                 "description" :  project_desc}
headers = { 'Content-Type': 'application/json', 'User-Agent': 'any-user' }

session = requests.Session()
create_project_res = session.request("POST", PROJECT_URL, headers=headers, data=json.dumps(payload),
                                             allow_redirects=True, auth=auth)
create_project_json = json.loads(create_project_res.text)
print(create_project_res.text)
project_id = create_project_json["id"]

# This loop waits for project to be created (upto 10 mins)
timeout = time.time() + 60 * 10
while True:
    view_project_res = session.request("GET", f"{PROJECT_URL}/{project_id}", headers=headers,
                                       allow_redirects=True, auth=auth)
    view_project_json = json.loads(view_project_res.text)
    if time.time() > timeout:
        print("TIMEOUT")
        break
    elif view_project_json["lifecycleState"] == "ACTIVE":
        print("SUCCESS")
        break
    elif view_project_json["lifecycleState"] == "CREATING":
        print("Still creating...")
    elif view_project_json["lifecycleState"] == "FAILED":
        print("FAILED...")
        break
    time.sleep(10)
```

### **STEP 3:** Creating the DataAsset

```Python
DATA_ASSET_URL = f"{CLOUD_ENV_URL}/20210101/dataAssets"
BUCKET_NAME = "Your bucket name of the object"
NAME_SPACE = "Your namespace of the object"
OBJECT_FILE_NAME = "Your object file name in Oracle OCI Object Storage"

asset_name = "Sample dataAsset"
asset_desc = "Oracle object storage data asset"
dataasset_payload = {
  "displayName": asset_name,
  "compartmentId": COMPARTMENT_ID,
  "projectId": project_id,
  "description": asset_desc,
  "dataSourceDetails": {
    "dataSourceType": "ORACLE_OBJECT_STORAGE",
    "bucketName": BUCKET_NAME,
    "namespace": NAME_SPACE,
    "objectName": OBJECT_FILE_NAME
  }
}

session = requests.Session()
create_dataasset_res = session.request("POST", DATA_ASSET_URL, headers=headers, data=json.dumps(dataasset_payload),
                                             allow_redirects=True, auth=auth)
create_dataasset_json = json.loads(create_dataasset_res.text)
print(create_dataasset_res.text)
dataasset_id = create_dataasset_json["id"]

# This loop waits for dataasset to be created (upto 10 mins)
timeout = time.time() + 60 * 10
while True:
    view_dataasset_res = session.request("GET", f"{DATA_ASSET_URL}/{dataasset_id}", headers=headers,
                                       allow_redirects=True, auth=auth)
    view_dataasset_json = json.loads(view_dataasset_res.text)
    if time.time() > timeout:
        print("TIMEOUT")
        break
    elif view_dataasset_json["lifecycleState"] == "ACTIVE":
        print("SUCCESS")
        break
    elif view_dataasset_json["lifecycleState"] == "CREATING":
        print("Still creating...")
    elif view_dataasset_json["lifecycleState"] == "FAILED":
        print("FAILED...")
        break
    time.sleep(10)
```

### **STEP 4:** Creating the Train Model
```Python
TRAIN_URL = f"{CLOUD_ENV_URL}/20210101/models"

param_fap = 0.01 # Model parameter: False Acceptance Percentage, have to be in range [0.01, 0.05]
param_trainingFac = 0.7 # Model parameter: Training Fraction, a percentage to split data into training and test, value range [0.7, 0.9]

model_name = "Test model"
model_desc = "Creating a model test"
train_payload = {
  "compartmentId": COMPARTMENT_ID,
  "displayName": model_name,
  "description": model_desc,
  "projectId": project_id,
  "modelCreationDetails": {
    "modelType": "ANOMALY_MULTIVARIATE",
    "fap": param_fap,
    "trainingFraction": param_trainingFac,
    "dataAssets": [ dataasset_id ]
  }
}

session = requests.Session()
create_train_res = session.request("POST", TRAIN_URL, headers=headers, data=json.dumps(train_payload),
                                             allow_redirects=True, auth=auth)
create_train_json = json.loads(create_train_res.text)
print(create_train_res.text)
model_id = create_train_json["id"]

# This loop waits for train to be created (upto 15 mins) depending on your training data size u might want to wait longer
timeout = time.time() + 60 * 15
while True:
    view_train_res = session.request("GET", f"{TRAIN_URL}/{model_id}", headers=headers,
                                       allow_redirects=True, auth=auth)
    view_train_json = json.loads(view_train_res.text)
    if time.time() > timeout:
        print("TIMEOUT")
        break
    elif view_train_json["lifecycleState"] == "ACTIVE":
        print("SUCCESS")
        break
    elif view_train_json["lifecycleState"] == "CREATING":
        print("Still creating...")
    elif view_train_json["lifecycleState"] == "FAILED":
        print("FAILED")
        break
    time.sleep(10)
```

### **STEP 5:** Deploying the Model
```Python
DEPLOY_URL = f"{CLOUD_ENV_URL}/20210101/modelDeployments"

deploy_name = "Anomaly Multivariate Model Shared Deployment"
deploy_desc = "E2E Testing MSET Model Shared Deployment"
deploy_payload = {
  "compartmentId": COMPARTMENT_ID,
  "displayName": deploy_name,
  "description": deploy_desc,
  "modelId": model_id,
  "config": { "sku": "SHARED", "coreCount": "1" }
}

session = requests.Session()
create_deploy_res = session.request("POST", DEPLOY_URL, headers=headers, data=json.dumps(deploy_payload),
                                             allow_redirects=True, auth=auth)
create_deploy_json = json.loads(create_deploy_res.text)
print(create_deploy_res.text)
deploy_id = create_deploy_json["id"]

# This loop waits for deploy to be created (upto 15 mins)
timeout = time.time() + 60 * 15
while True:
    view_deploy_res = session.request("GET", f"{DEPLOY_URL}/{deploy_id}", headers=headers,
                                       allow_redirects=True, auth=auth)
    view_deploy_json = json.loads(view_deploy_res.text)
    if time.time() > timeout:
        print("TIMEOUT")
        break
    elif view_deploy_json["lifecycleState"] == "ACTIVE":
        print("SUCCESS")
        break
    elif view_deploy_json["lifecycleState"] == "CREATING":
        print("Still creating...")
    elif view_deploy_json["lifecycleState"] == "FAILED":
        print("FAILED")
        break
    time.sleep(10)
```

### **STEP 6:** Detection with the Model
```Python
DETECT_URL = f"{CLOUD_ENV_URL}/20210101/modelDeployments/{deploy_id}/actions/detectAnomalies"

data_payload = {
  "requestType": "INLINE",
  "columnLabels": [ "sensor1", "sensor2", "sensor3", "sensor4", "sensor5", "sensor6", "sensor7", "sensor8", "sensor9", "sensor10" ],
  "data": [
    {
      "timestamp": "2020-10-01T09:22:59.000Z",
      "value": [ 0.8885, 0.975, 1.25, 0.01, 0, 0.8885, 0.975, 1.25, 0.01, -2165 ]
    }
  ]
}

session = requests.Session()
detect_res = session.request("POST", DETECT_URL, headers=headers, data=json.dumps(data_payload),
                              allow_redirects=True, auth=auth)
print(detect_res.json())
print(detect_res.headers)
```

Congratulations on completing this lab!

[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Jason Ding - Principal Data Scientist - Oracle AI Services
    * Haad Khan - Senior Data Scientist - Oracle AI Services
* **Last Updated By/Date**
    * Jason Ding - Principal Data Scientist, May 2021
