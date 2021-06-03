import oci
import time
import json
import requests

### version: 1.0 for Endpoint at LA phase. May 2021

### Changed it to Python Class. May 2021

# Replace with the location of your oci config file
CONFIG_FILENAME = "~/.oci/config"
config = oci.config.from_file(CONFIG_FILENAME, profile_name="DEFAULT") # Change to the proer profile name

auth = oci.signer.Signer(
  tenancy=config['tenancy'],
  user=config['user'],
  fingerprint=config['fingerprint'],
  private_key_file_location=config['key_file'],
  pass_phrase=config['pass_phrase'])

# Initialize some constants
CLOUD_ENV_URL = "https://aiservice.us-ashburn-1.oci.oraclecloud.com" # Change this accordingly
# https://aiservice.us-ashburn-1.oci.oraclecloud.com
# https://aiservice.eu-frankfurt-1.oci.oraclecloud.com
# https://aiservice.ap-mumbai-1.oci.oraclecloud.com

HEADER = { 'Content-Type': 'application/json', 'User-Agent': 'any-user' }

class OciAdService:

    def __init__(self):
        pass

    def create_project(self, compartmentId, projectName, description):
        """
        Step 1. Creating a Project, given compartment_id, projectName, and description
        """

        PROJECT_URL = f"{CLOUD_ENV_URL}/20210101/projects"
        payload = { "displayName": projectName,
                         "compartmentId": compartmentId,
                         "description" :  description}

        session = requests.Session()
        create_project_res = session.request("POST", PROJECT_URL, headers=HEADER, data=json.dumps(payload),
                                                     allow_redirects=True, auth=auth)
        create_project_json = json.loads(create_project_res.text)
        print(create_project_res.text)
        project_id = create_project_json["id"]

        # This loop waits for project to be created (upto 10 mins)
        timeout = time.time() + 60 * 10
        while True:
            view_project_res = session.request("GET", f"{PROJECT_URL}/{project_id}", headers=HEADER,
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

        return project_id


    def create_dataasset(self, compartmentId, projectId, displayName, description, namespace, bucketName, objectName):
        """
        Step 2. Creating data asset with compartment, project, and object storage information
        """

        DATA_ASSET_URL = f"{CLOUD_ENV_URL}/20210101/dataAssets"
        dataasset_payload = {
          "displayName": displayName,
          "compartmentId": compartmentId,
          "projectId": projectId,
          "description": description,
          "dataSourceDetails": {
            "dataSourceType": "ORACLE_OBJECT_STORAGE",
            "bucketName": bucketName,
            "namespace": namespace,
            "objectName": objectName
          }
        }

        session = requests.Session()
        create_dataasset_res = session.request("POST", DATA_ASSET_URL, headers=HEADER, data=json.dumps(dataasset_payload),
                                                     allow_redirects=True, auth=auth)
        create_dataasset_json = json.loads(create_dataasset_res.text)
        print(create_dataasset_res.text)
        dataasset_id = create_dataasset_json["id"]

        # This loop waits for dataasset to be created (upto 10 mins)
        timeout = time.time() + 60 * 10
        while True:
            view_dataasset_res = session.request("GET", f"{DATA_ASSET_URL}/{dataasset_id}", headers=HEADER,
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

        return dataasset_id

    def create_model(self, compartmentId, projectId, dataassetId, displayName, description, fap=0.01, trainingFraction=0.7):
        """
        Step 3. Creating a model with compartment, project, and dataaseet
        """
        # fap - Model parameter: False Acceptance Percentage, have to be in range [0.01, 0.05]
        # trainingFraction - Model parameter: Training Fraction, a percentage to split data into training and test, value range [0.7, 0.9]

        TRAIN_URL = f"{CLOUD_ENV_URL}/20210101/models"
        train_payload = {
          "compartmentId": compartmentId,
          "displayName": displayName,
          "description": description,
          "projectId": projectId,
          "modelCreationDetails": {
            "modelType": "ANOMALY_MULTIVARIATE",
            "fap": fap,
            "trainingFraction": trainingFraction,
            "dataAssets": [ dataassetId ]
          }
        }

        session = requests.Session()
        create_train_res = session.request("POST", TRAIN_URL, headers=HEADER, data=json.dumps(train_payload),
                                                     allow_redirects=True, auth=auth)
        create_train_json = json.loads(create_train_res.text)
        print(create_train_res.text)
        model_id = create_train_json["id"]

        # This loop waits for train to be created (upto 15 mins) depending on your training data size u might want to wait longer
        timeout = time.time() + 60 * 15
        while True:
            view_train_res = session.request("GET", f"{TRAIN_URL}/{model_id}", headers=HEADER,
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

        return model_id

    def deploy_model(self, compartmentId, displayName, description, modelId):
        """
        4. Deploying a model
        """

        DEPLOY_URL = f"{CLOUD_ENV_URL}/20210101/modelDeployments"

        deploy_payload = {
        "compartmentId": compartmentId,
        "displayName": displayName,
        "description": description,
        "modelId": modelId,
        "config": { "sku": "SHARED", "coreCount": "1" }
        }

        session = requests.Session()
        create_deploy_res = session.request("POST", DEPLOY_URL, headers=HEADER, data=json.dumps(deploy_payload),
                                                    allow_redirects=True, auth=AUTH)
        create_deploy_json = json.loads(create_deploy_res.text)
        print(create_deploy_res.text)
        deploy_id = create_deploy_json["id"]

        # This loop waits for deploy to be created (upto 15 mins)
        timeout = time.time() + 60 * 15
        while True:
            view_deploy_res = session.request("GET", f"{DEPLOY_URL}/{deploy_id}", headers=HEADER,
                                            allow_redirects=True, auth=AUTH)
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

    return deploy_id

    def detect(self, deploy_id, data_payload):
        """
        5. Detect with new data payload, example:
            data_payload = {
                "requestType": "INLINE",
                "columnLabels": [ "sensor1", "sensor2", "sensor3", "sensor4", "sensor5"],
                "data": [
                    {
                    "timestamp": "2020-10-01T09:22:59.000Z",
                    "value": [ 0.8885, 0.975, 1.25, 0.01, 0 ]
                    }
                ]
            }
        """
        DETECT_URL = f"{CLOUD_ENV_URL}/20210101/modelDeployments/{deploy_id}/actions/detectAnomalies"

        session = requests.Session()
        detect_res = session.request("POST", DETECT_URL, headers=HEADER, data=json.dumps(data_payload), allow_redirects=True, auth=AUTH)
        print(detect_res.json())
        print(detect_res.headers)
        return detect_res.json()
