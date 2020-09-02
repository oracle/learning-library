# Scaling Application Platform

## Introduction

This lab will show you how Helidon works with OKE health probes for liveness and
readiness. You will also monitor the microservices performance, perform
horizontal pod scaling and configure tracing with Jaeger.

### Objectives

- Measure health and readiness of microservices
- Monitor Microservices performance
- Implement horizontal scaling of OKE pod

### Prerequisite
This lab assumes you have already completed the following labs:
- Register for Free Tier
- Set up OCI, OKE, ATP and Cloud shell
- Set up Service broker and Messaging

## **STEP 1**: Measure health and readiness of microservices

1. Oracle Cloud Infrastructure Container Engine for Kubernetes (OKE) provides
    health probes which check a given container for its liveness (checking if
    the pod is up or down) and readiness (checking if the pod is ready to take
    requests or not). In this STEP you will see how the probes pick up the
    health that the Helidon microservice advertises. Open the frontend
    microservices home page. Click on “health” , “health/live” and
    “health/ready” buttons to see the information that is being captured by the
    health checks.

   ![](images/c4e1969d489a58cf0965607054b21778.png " ")

   The “health/live” result should show that the service is up.

   ![](images/79a6ebc5796e4ae0c5b303617be21c59.png " ")

   The “health/ready” result should show that the service is ready to receive
    requests, since all required connections have been created.

   ![](images/fe32a9b20badb35e10dc21148f021b62.png " ")

2. In order to observe how OKE will manage the pods, the microservice has been
    created with the possibility to set up the liveliness to “false”. Click
    **lastContainerStartTime** to check the age of the container.

   ![](images/7aa75ac4256999f7915e563ac2049af5.png " ")

3. Click the **ordersetlivenesstofalse** button, which will trigger the
    container to advertise that the service is not alive.

   ![](images/10023aaaf4468944fbd9b88041166abc.png " ")

4. The OKE health probes check the advertised health metrics and if they are
    not healthy for a certain period, the infrastructure will reboot the pod.
    While the service is being restarted, lets see how the  mechanism works. The Order Helidon pom file is located in
    `$MSDATAWORKSHOP_LOCATION/order-helidon/pom.xml`. Observe the Helidon health
    dependencies.

   ![](images/2e4d0c6b95330e009c5ee6e6bc143918.png " ")

5. The Kubernetes deployment yaml file also has liveness information. Open the
    yaml file located in
    `$MSDATAWORKSHOP_LOCATION/order-helidon/order-helidon-deployment.yaml`.
    Observe the parameter `livenessProbe`.

   ![](images/c85dc4495ee6d2fc2d5a8b94d1e18df6.png " ")

   The `livenessProbe` can be set up with different criteria, such as reading from a
file or an HTTP GET request. In this example the OKE health probe will use HTTP
GET to check the /health/live and /health/ready addresses every 3 seconds, to
see the liveness and readiness of the service.

6. The Java source code file shows how the liveness method is being calculated.
    Open the source code file located in
    `$MSDATAWORKSHOP_LOCATION/order-helidon/src/main/java/io/helidon/data/examples/OrderServiceLivenessHealthCheck.java`

   ![](images/c6b4bf43b0ed4b9b4e67618b31560041.png " ")

   The method returns the down metric for health.

7. Go back to the frontend microservice front page and check the age of the
    container by clicking the **lastContainerStartTime** button. The time
    had now changed, reflecting that the pod was restarted.

   ![](images/bb361bd61e7817c61fb5356637bb7bfa.png " ")

## **STEP 2**: Implement horizontal scaling of OKE pod
Horizontal scaling is an important aspect for microservices architecture
    when it comes to providing application availability as the amount of
    workload or number of connections increases. In this example you will
    configure the OKE horizontal pod autoscaler. Horizontal pod autoscaler can
    be configured to check a certain advertised customer or standard metric.

1. Install the metric server first.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION ; ./installMetricsServer.sh</copy>
    ```

2. Open the Cloud Shell and run the following command to deploy a simple Linux
    pod.

    ```
    <copy>kubectl run oraclelinux77-hpa-demo --image=phx.ocir.io/oraclegilsonmel/oraclelinux77-demo:latest --requests=cpu=200m --limits=cpu=500m tailf /dev/null -n msdataworkshop</copy>
    ```

   ![](images/d78a32841d84b794a322c2cb90114704.png " ")

   *Notice that the pod has request and limit CPU resource attributes.*

3. Check that the pod is running using the below command.

    ```
    <copy>pods | grep linux</copy>
    ```

   ![](images/e97786d4e8475b430c6cd66949c8a5a3.png " ")

4. Create a horizontal pod autoscaler for this container. Notice that this HPA
    will get triggered once CPU threshold exceeds 50%. Also the minimum number
    of pods is set to 1, while the maximum is 10.

    ```
    <copy>kubectl autoscale deployment oraclelinux77-hpa-demo --cpu-percent=50 --min=1 --max=10 -n msdataworkshop</copy>
    ```

   ![](images/fe370c12f8de0f64e8425ff0a9b0d5c5.png " ")

5. Run the below command to get additional information about the HPA deployment
    and CPU utilization of the pod.

    ```
    <copy>hpa ; toppod linux ; k get deployment oraclelinux77-hpa-demo -n msdataworkshop ; pods | grep linux ;echo ----------------</copy>
    ```

   ![](images/31c3a877bc6cc5ee6e28337a3e88ce6e.png " ")

6. Enter the pod, execute a command to stress the CPU.

    ```
    <copy>podshell linux</copy>
    ```

   ![](images/b499162a01a1acb247321d92bdb488ed.png " ")

    ```
    <copy>stress --cpu 4 &</copy>
    ```

   ![](images/22b8ac3195bac2f9f61bc91a9f4a7c47.png " ")

7. Use the `exit` command to leave the linux pod.

    ```
    <copy>exit</copy>
    ```

   ![](images/e4d252c59984f38a7ef73ec7b1b46804.png " ")

8. Execute the commands below to get additional information about the HPA and linux pods.

    ```
    <copy>hpa ; toppod linux ; k get deployment oraclelinux77-hpa-demo -n msdataworkshop ; pods | grep linux ;echo ----------------</copy>
    ```

    Notice that we currently have 5 pods deployed due to the stress test.

   ![](images/96f267ff0337bc4f2a14b368d0d23a4e.png " ")

9. You can now delete the linux pods and HPA using the commands:

    ```
    <copy>k delete deployment oraclelinux77-hpa-demo -n msdataworkshop</copy>
    ```

   ![](images/6131d4e7ab4fcbd3b034ecdb3a583489.png " ")

    ```
    <copy>k delete hpa oraclelinux77-hpa-demo -n msdataworkshop</copy>
    ```

   ![](images/436789441a591de3901e293e1538f204.png " ")

   This was a basic demonstration of horizontal autoscaling with microservices. It’s important to note that with the implementation of horizontal scaling the design of the application changes, as it needs to be able to handle the addition of replicas.

## Acknowledgements
* **Author** - Paul Parkinson, Dev Lead for Data and Transaction Processing, Oracle Microservices Platform, Helidon
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
