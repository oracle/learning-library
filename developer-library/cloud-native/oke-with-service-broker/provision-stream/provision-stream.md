# Provision a Stream in Oracle Streaming Service with Kubernetes

## Introduction

In this lab we will use the OCI Service Broker to manage the lifecyle of a stream, using kubernetes.

Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:

- Configure a stream instance and binding to deploy on kubernetes
- Use kubectl to deploy the instance and provision the stream
- Tear down the stream instance

## **STEP 1:** Get the template manifests for Streams

1. Download the example templates

    ```bash
    <copy>
    mkdir -p streaming
    pushd streaming
    curl -o create-oss-instance.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/oss/create-oss-instance.yaml
    curl -o create-oss-binding.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/oss/create-oss-binding.yaml
    popd
    </copy>
    ```

2. How it works:

    - The `create-oss-instance.yaml` defines a stream instance to be created in a specific compartment and optionally in a specific pre-created streaming pool. 

    - The `create-oss-binding.yaml` creates a binding to retrieve credentials providing access to the stream.

    - OCI Service Broker will then create a secret named `test-stream-binding` containing the access to the stream


## **STEP 2:** Edit the manifests

1. Edit the file called `create-oss-instance.yaml` and replace the mention `CHANGE_COMPARTMENT_OCID_HERE` with the **compartment OCID** of the compartment where you deployed the OKE cluster, and the `CHANGE_PARTITION_COUNT_HERE` with the number of partitions you want (we'll use 1).

    If you want to use a specific stream pool, uncomment the streampoolId value and provide a stream pool OCID.

    ```bash
    <copy>
    nano ./streaming/create-oss-instance.yaml
    </copy>
    ```

    ***Note: the stream name needs to be unique across the OCI compartment, even if you deploy on different kubernetes namespaces.***

    If you're running this as part of a workshop with multiple users, make sure you modify the name of the bucket to make it unique by replacing the name `teststream` with your unique name both in the `create-oss-instance.yaml` and `create-oss-binding.yaml` files.


## **STEP 3:** Deploy

1. To deploy the mainfest use:

    ```bash
    <copy>
    kubectl apply -f ./streaming
    </copy>
    ```

    This will deploy all the manifests in the `streaming` folder.

## **STEP 4:** Check the deployment

1. Verify the database instance is being provisioned

    ```bash
    <copy>
    kubectl get all
    </copy>
    ```

    Should list:

    ```
    NAME                                               CLASS                             PLAN       STATUS   AGE
    serviceinstance.servicecatalog.k8s.io/teststream   ClusterServiceClass/oss-service   standard   Ready    4m25s

    NAME                                                       SERVICE-INSTANCE   SECRET-NAME           STATUS   AGE
    servicebinding.servicecatalog.k8s.io/test-stream-binding   teststream         test-stream-binding   Ready    4m25s
    ```


2. Verify that the `test-stream-binding` secret with

    ```bash
    <copy>
    kubectl get secrets
    </copy>
    ```

    Should list `test-stream-binding`

3. You can also check in the OCI console under **Solution and Platforms -> Analytics -> Streaming** in the compartment where you provisioned and you should see the stream named `teststream` (or the unique name you gave it)

## **STEP 5:** Look at the content of the secret

1. You can view the content of the secret by running:

    ```bash
    <copy>
    kubectl get secret test-stream-binding -o yaml
    </copy>
    ```

    which should return:

    ```yaml
    apiVersion: v1
    data:
    messageEndpoint: aHR0cHM6Ly9jZWxsLTEuc3RyZWFtaW5nLnVzLWFzaGJ1cm4tMS5vY2kub3JhY2xlY2xvdWQuY29t
    streamId: b2NpZDEuc3RyZWFtLm9jMS5pYWQuYW1hYWFhYWF4a2g1czZpYXVlZXdjMzcyczU3emJsc2UyeGJvbmxhaHczc28ycTU0YjdoNW50Y2hoempx
    kind: Secret
    metadata:
    creationTimestamp: "2021-01-09T01:06:22Z"
    managedFields:
    - apiVersion: v1
        fieldsType: FieldsV1
        fieldsV1:
        f:data:
            .: {}
            f:messageEndpoint: {}
            f:streamId: {}
        f:metadata:
            f:ownerReferences:
            .: {}
            k:{"uid":"b26883f5-d6d5-48ac-bb01-9c4994f194dc"}:
                .: {}
                f:apiVersion: {}
                f:blockOwnerDeletion: {}
                f:controller: {}
                f:kind: {}
                f:name: {}
                f:uid: {}
        f:type: {}
        manager: service-catalog
        operation: Update
        time: "2021-01-09T01:06:22Z"
    name: test-stream-binding
    namespace: oci-service-broker
    ownerReferences:
    - apiVersion: servicecatalog.k8s.io/v1beta1
        blockOwnerDeletion: true
        controller: true
        kind: ServiceBinding
        name: test-stream-binding
        uid: b26883f5-d6d5-48ac-bb01-9c4994f194dc
    resourceVersion: "87133"
    selfLink: /api/v1/namespaces/oci-service-broker/secrets/test-stream-binding
    uid: bac04231-91ee-4a02-bb51-849aa3609ed9
    type: Opaque
    ```

2. The content of the secret are the `messageEndpoint` and `streamId` fields which is base64 encoded.

    When mounting the secret as a variable in a pod, this value will be decoded for you.

    To decode the content of the field, you can do:

    ```bash
    echo <field content> | base64 -d
    ```

    for example:

    ```bash
    echo aHR0cHM6Ly9jZWxsLTEuc3RyZWFtaW5nLnVzLWFzaGJ1cm4tMS5vY2kub3JhY2xlY2xvdWQuY29t | base64 -d
    ```

    Which returns:

    ```bash
    https://cell-1.streaming.us-ashburn-1.oci.oraclecloud.com
    ```

## **STEP 6:** Usage

1. To mount the secret into a pod, use an environment variable like:

    ```yaml
    env:
    - name: STREAM_ID
      valueFrom:
        secretKeyRef:
            name: test-stream-binding
            key: streamId
    - name: STREAM_ENDPOINT
      valueFrom:
        secretKeyRef:
            name: test-stream-binding
            key: messageEndpoint
    ```

2. A full example deployment with the nginx image as base would be like:

    ```yaml
    <copy>
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: streaming-demo
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: streaming-demo
      template:
        metadata:
          labels:
            app: streaming-demo
        spec:
          containers:
          # User application that uses the PAR to access the bucket.
          - name: app
            image: nginx
            env:
            - name: STREAM_ID
              valueFrom:
                secretKeyRef:
                    name: test-stream-binding
                    key: streamId
            - name: STREAM_ENDPOINT
              valueFrom:
                secretKeyRef:
                    name: test-stream-binding
                    key: messageEndpoint
    </copy>
    ```

3. Create a new file `streaming-demo-app.yaml` and paste the content above

4. Deploy the manifest with:

    ```bash
    <copy>
    kubectl -apply -f streaming-demo-app.yaml
    </copy>
    ```

5. Verify the URI was properly defined by getting a shell into the pod

    ```bash
    <copy>
    kubectl get pods -n default
    </copy>
    ```

    Get the `streaming-demo` pod name then:

    ```bash
    kubectl exec -it <pod_name> -n default -- /bin/sh
    ```

    At the shell prompt inside the container, check the environment variables with:

    ```bash
    <copy>
    env | grep STREAM
    </copy>
    ```

    Which should return something like:

    ```bash
    STREAM_ID=ocid1.stream.oc1.iad.amaaaaaaxkh5s6iad7v7ornyhgb7gtowg4x6hd3ru2g6ejtbonls426hnltq
    STREAM_ENDPOINT=https://cell-1.streaming.us-ashburn-1.oci.oraclecloud.com
    ```

6. Working with stream is beyond the scope of this workshop, so we'll leave it as an exercise to the reader.

    A few pointers:

    - In order to use streaming with a private stream pool with this stack, you will need to add a security list to allow communication with port 9092
    - You can use the kafka SDK to use the stream directly, however you will need to know the stream pool OCID to create the username, and you will need a user with an Auth token and policy to use streams
    - You can use the OCI SDK to connect to streams, in which case you need a user in a group with proper policies, and you need the public/private key pair for this user, as well as fingerprint to comnfigure the OCI CLI in your container.

    Also: 
    - Before tearing down the stack, you will need to remove the security list from the subnet for the subnet to be deprovisioned properly.

## **STEP 7:** Clean up

1. To undeploy, and terminate the stream instance, delete the kubernetes instances

    ```bash
    <copy>
    kubectl delete -f ./streaming
    </copy>
    ```

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabs). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
