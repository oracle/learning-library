# Scaling the Application
## Introduction

This lab will show how the application can be scaled at the application and database tiers to maintain optimal performance.

![](images/architecture.png " ")

### Objectives
-   Install the k6 load testing tool
-   Start the external load balancer for the order-helidon microservice
-   Test the performance of the existing deployment and identify the point at which performance begins to degrade
-   Scale the application tier to improve performance and identify the point at which further application tier scaling does not help
-   Scale the database tier and demonstrate how performance is improved

### What Do You Need?

This lab assumes that you have already completed labs 1 through 4.

## **STEP 1**:  Install the k6 load testing tool and start an external load balancer for the Order service

1. Install the k6 tool (takes less than a second).

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; wget https://github.com/loadimpact/k6/releases/download/v0.27.0/k6-v0.27.0-linux64.tar.gz; tar -xzf k6-v0.27.0-linux64.tar.gz; ln k6-v0.27.0-linux64/k6 k6</copy>
    ```

   ![](images/install-k6.png " ")

2. Start an external load balancer for the order service.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/order-helidon; kubectl create -f ext_order_service.yaml -n msdataworkshop</copy>
    ```

    Repeatedly view the ext-order LoadBalancer service.  Make note of the external IP address.

    ```
    <copy>services</copy>
    ```

    ![](images/ext-order-address.png " ")

    Set the LB environment variable to the external IP address of the ext-order service. Replace 123.123.123.123 in the following command with the external IP address.

    ```
    <copy>export LB='123.123.123.123'</copy>
    ```

## **STEP 2**: Load test and scale the application tier

1.  Execute a load test by executing the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh</copy>
    ```

    Note the request rate.

    ![](images/perf1replica.png " ")

2. Scale to 2 service replicas.

    ```
    <copy>kubectl scale deployment.apps/order-helidon --replicas=2 -n msdataworkshop</copy>
    ```

   List the running pods.

    ```
    <copy>pods</copy>
    ```

   Note there are now two order-helidon replicas.  Keep polling until both replicas are ready.

   ![](images/2replicas.png " ")

3. Execute the load test again by executing the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh</copy>
    ```

   Note the average response time for the requests.  Throughput has increased and response time has returned to normal.

   ![](images/perf2replica.png " ")

4. Scale to 3 Replicas.

    ```
    <copy>kubectl scale deployment.apps/order-helidon --replicas=3 -n msdataworkshop</copy>
    ```

   List the running pods.

    ```
    <copy>pods</copy>
    ```

   Note there are now three order-helidon replicas.  Keep polling until all replicas are ready.

    ![](images/3replicas.png " ")

5. Execute the load test again by executing the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh</copy>
    ```

  Note the median response time for the requests and the request rate.  Note how the response time is still degraded and the request rate has not improved significantly.

   ![](images/perf3replica.png " ")

## **STEP 3**: Load test and scale the database tier

1. To scale the Order DB ATP database to 2 OCPUs, click the hamburger icon in the top-left corner of the Console and go to Autonomous Transaction Processing.

   ![](images/35-open-atp-menu.png " ")

2. Click **Scale Up/Down** and enter 2 in the OCPU field. Click **Update**.

   ![](images/ScaleTo2dbocpuScreen1.png " ")

   ![](images/ScaleTo2dbocpuScreen2.png " ")

3. Wait until the scaling has completed (Lifecycle State: Available).

   ![](images/ScaleTo2dbocpuScreen3.png " ")

4. Execute the load test by executing the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/k6; ./test.sh</copy>
    ```

   Note the request rate.  Throughput has increased.

   ![](images/perf3replica2dbocpu.png " ")

## **STEP 4**: Scale down the application and database tiers

1. To scale the Order DB ATP database down to 1 OCPUs, click the hamburger icon in the top-left corner of the Console and go to Autonomous Transaction Processing.

   ![](images/35-open-atp-menu.png " ")

2. Click **Scale Up/Down** and enter 1 in the OCPU field. Click **Update**.

   ![](images/ScaleTo1dbocpuScreen1.png " ")

   ![](images/ScaleTo1dbocpuScreen2.png " ")

3. Scale the order-helidon service back to 1 replica.

    ```
    <copy>kubectl scale deployment.apps/order-helidon --replicas=1 -n msdataworkshop</copy>
    ```

## Acknowledgements
* **Authors** - Richard Exley, Maximum Avaiability Architecture; Curtis Dinkel, Maximum Avaiability Architecture; Rena Granat, Maximum Avaiability Architecture;
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

## Need Help?
Please submit feedback or ask for help using this [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/building-microservices-with-oracle-converged-database). Please login using your Oracle Sign On and click the **Ask A Question** button to the left.  You can include screenshots and attach files.  Communicate directly with the authors and support contacts.  Include the *lab* and *step* in your request. 
