# Kubernetes REST Service Deployment

## Introduction

Thus far on our journey from a monolithic application to microservices, we have created our supporting infrastructure, populated our database, and packaged our Java application as a Docker container and deploy it to our Kubernetes Cluster using Visual Studio. Now we need to verify all REST services that it will be accessible to our customers, as well as be manageable, observable, and scalable -- a Kubernetes cluster.

During this lab, you will verify REST Services deployed via Kubernetes Dashboard.

Estimated time: 20 minutes

### Objectives
- Verify Kubernetes Cluster up and running.
- Find Deployed REST Services URLs.
- Verify REST Services deployed in Lab 300.
- Test REST services.
- Simulate Pod failure and REST service recovery.

### Prerequisites
- Successful completion of previous labs

*In addition to the workshop*, feel free to watch the walkthrough companion video by clicking on the following image:FPN_ggM1f3c
[](youtube:FPN_ggM1f3c)

- **Works better with the Chrome browser**.

## **STEP 1**: Add a Policy Statement for OKE

1. You should already have a browser tab logged in to the OCI Console. If you do not, log in again using the following URL.

    [https://cloud.oracle.com/en_US/sign-in](https://cloud.oracle.com/en_US/sign-in)

2.  Before the Oracle managed Kubernetes service can create compute instances in your OCI tenancy, we must explicitly give it permission to do so using a policy statement. From the OCI Console navigation menu, choose **Identity->Policies**.

  ![](images/LabGuide200-13c980fa.png)

3.  In the Compartment drop down menu on the left side, choose the **root compartment**. It will have the same name as your OCI tenancy (Cloud Account Name).

4.  Click **PSM-root-policy**

  ![](images/LabGuide200-e67b7705.png)

5.  Click the **Add Policy Statement** button

  ![](images/LabGuide200-3d4a7471.png)

6.  In the Statement box, enter the below statement and click **Add Statement**
    ```
    <copy>allow service OKE to manage all-resources in tenancy</copy>
    ```

  ![](images/LabGuide200-bd5bcbd1.png)

## **STEP 2**: Verify Kubernetes Cluster up and running.
1.  Navigate to **Developer Services** >   **Kubernetes Clusters**.
  ![](images/OKE1.png " ")
2.  Select the **AppDev** compartment and select **cluster1**.
  ![](images/300_2.png " ")
3.  Click **Access Cluster**.
  ![](images/300_3.png " ")
4.  Select **Lauch Cloud Shell** under Cloud Shell Access.
  ![](images/300_4.png " ")
5.  Wait for Attaching your Oracle Cloud Home Directory
  ![](images/300_5.png " ")
6.  You can see **Welcome to Oracle Cloud Shell**
  ![](images/300_6.png " ")
7.  To access the kubeconfig for your cluster, copy the following command to Cloud Shell
  ![](images/300_7.png " ")
8.  Paste it into Cloud Shell.
  ![](images/300_8.png " ")
9.  Check your new config file successfully created or merged.
  ![](images/300_9.png " ")
10.  Copy following command to see your cluster information

    ```
    <copy> kubectl cluster-info </copy>
    ```
  ![](images/300_10.png " ")
11.  Copy following command to see your worker nodes.
    ```
    <copy> kubectl get nodes </copy>
    ```
  ![](images/300_11.png " ")

12.  Copy following command and see your pods are successfully deployed in Lab 200.
    ```
    <copy> kubectl get pods </copy>
    ```
  ![](images/300_32.png " ")

  **Note**: If your pods are not in a **Running** state you must need go back to the lab 200 and fix your errors before proceeding to the next step.

  You can use following command to troubleshoot your errors in your pod.    
    ```
    <copy> kubectl describe pod [pod_name] </copy>
    ```

13.  Click **Close**.
  ![](images/300_12.png " ")
## **STEP 3**: Find Deployed REST Services URLs.

1.  Copy following command and paste it to Cloud Shell to view deployed REST web-services
    ```
    <copy> kubectl get svc </copy>
    ```

  ![](images/OKE_Services1.png " ")

## **STEP 4**: Test REST Services.
1.  Copy **product-svc** External IP. Append **:8080/product/list** to External IP and paste it in your browser.
  ![](images/OKE_Services4.png " ")
2.  You can see all products available for the REST endpoint GET method.
  ![](images/300_30.png " ")
3.  You can also test product REST endpoint for a specific product as follows.

    ```
    <copy>curl -iX GET http://EXTERNAL_IP:8080/product/1038 </copy>
    ```

  ![](images/300_31.png " ")

4. Copy **user-svc** External IP.  

  ![](images/OKE_Services2.png " ")

5. Copy and paste following command in Cloud Shell and replace **EXTERNAL_IP**  to test **user-svc**.
    ```
    <copy>curl -iX GET http://EXTERNAL_IP:8080/user </copy>
    ```

  ![](images/OKE_Services3.png " ")  

  **Note**: If you can't access your REST endpoints you can use following command to troubleshoot your errors in your pod. If you find any errors, you must need to go back lab 200, fix your errors, and re-run build before proceeding to the next steps.

    ```
    <copy> kubectl logs [pod_name] </copy>
    ```
## **STEP 5**: Simulate Pod Failure and REST Service Recovery.
1.  Copy following command to get pods

    ```
    <copy> kubectl get pods </copy>
    ```
  ![](images/300_32.png " ")
2.  Copy product-svc pod name and append it following command to delete pod.

    ```
    <copy>kubectl delete pod pod_name </copy>
    ```
  ![](images/300_33.png " ")
3.  Copy following command and paste to see status of your pod you deleted. It has been deleted and re-created automatically.

    ```
    <copy> kubectl get pods </copy>
    ```
  ![](images/300_34.png " ")



*You are ready to proceed to the next lab...*

## Acknowledgements

- **Author** - Sasanka Abeysinghe
- **Last Updated By/Date** - Kamryn Vinson, October 2020
