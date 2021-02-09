# Provision an Autonomous Transaction Processing database with Kubernetes

## Introduction

In this lab we will use the OCI Service Broker to manage the lifecyle of an Autonomous Transaction Processing (ATP) database, using kubernetes.

Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:

- Configure an ATP instance and binding to deploy on kubernetes
- Use kubectl to deploy the instance and provision the DB
- learn how to tear down the ATP database instance when you are done

Note: This provisions an ATP database with a public endpoint. It is currently not possible to provision the database in a private subnet via OCI Service Broker.

## **STEP 1:** Get the template manifests for ATP

1. Download the example templates

    ```bash
    <copy>
    mkdir -p atp
    pushd atp
    curl -o atp-binding.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-binding.yaml
    curl -o atp-instance.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-instance.yaml
    curl -o atp-secret.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-secret.yaml
    curl -o atp-demo-secret.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-demo-secret.yaml
    curl -o atp-demo.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-demo.yaml
    popd
    </copy>
    ```

2. How it works:

    - The `atp-demo-secret.yaml` defines a secret with the admin password and wallet password as-is. Secrets are base64 encoded. 

    - The `atp-secret.yaml` defines a secret with the same information as the atp-demo-secret but the variables are defined as JSON objects. The admin password is used to provision the instance, while the wallet password is used for the binding.

    - The `atp-instance.yaml` define an instance of the ATP service to deploy. It defines the specifications for this instance, including OCPUs, autoscaling mode and storage parameters.

    - The `atp-binding.yaml` creates a binding and will generate the wallet secret to use by the app.

    - The `atp-demo.yaml` contains the deployment of a demo app, showing how to load the wallet in the app using the init container.

        Note that the init container is currently needed to decode the credentials that are base64 encoded twice (see the github repo for OCI Service Broker for more details about this topic)

    - A secret called `atp-demo-binding` is created by the OCI Service Broker when deploying, which provides the wallet credentials for the ATP database.

        This secret contains the content of the wallet to access the ATP database

## **STEP 2:** Edit the manifests

1. Edit the file called `atp-instance.yaml` and replace the mention `CHANGE_COMPARTMENT_OCID_HERE` with the **compartment OCID** of the compartment where you deployed the OKE cluster.


2. Edit the file called `atp-demo.yaml` and replace the `<USER_APPLICATION_IMAGE>` with `nginx` and replace the `apiVersion` to be `apps/v1`

## **STEP 3:** Deploy

1. To deploy the mainfest use:

    ```bash
    <copy>
    kubectl apply -f ./atp
    </copy>
    ```

    This will deploy all the manifests in the `atp` folder.

## **STEP 4:** Check the deployment

1. Verify the database instance is being provisioned

    ```bash
    <copy>
    kubectl get all
    </copy>
    ```

    Should list:

    ```
    NAME                            READY   STATUS     RESTARTS   AGE
    pod/atp-demo-56d678995f-fbcvj   0/1     Init:0/1   0          12s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/atp-demo   0/1     1            0           12s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/atp-demo-56d678995f   1         1         0       12s   

    NAME                                                    SERVICE-INSTANCE   SECRET-NAME        STATUS   AGE
    servicebinding.servicecatalog.k8s.io/atp-demo-binding   osb-atp-demo-1     atp-demo-binding   Ready    9m44s
    NAME                                                   CLASS                             PLAN       STATUS   AGE
    serviceinstance.servicecatalog.k8s.io/osb-atp-demo-1   ClusterServiceClass/atp-service   standard   Ready    9m43s
    ```

3. You can check the ATP database is being provisioned

    In the OCI console under **Oracle Databases -> Autonmous Transaction Processing** in the compartment where you provisioned, you should see the ATP database named `osbdemo`

    Wait until it is provisioned and **Available**, which is when the OCI Service Broker is able to create the `atp-demo-binding` secret containing the access wallet.

3. Verify that the `atp-demo-binding` secret was created

    ```bash
    <copy>
    kubectl get secrets
    </copy>
    ```

    Should list `atp-demo-binding`

    If it does not show, it is likely that the database is not finished provisioned. Check in the console and be patient.


## **STEP 5:** Check the wallet content in the demo app

The demo application doesn't do anything: it uses a generic nginx container that has not interaction with the database. It is solely to demonstrate how to get the wallet credentials inside the container.

You can verify the wallet is now accessible inside the demo app container by looking up the pod ID, and getting a shell into it:

1. Get the demo app pod ID with:

    ```bash
    <copy>
    kubectl get pods 
    </copy>
    ```

    You should find a pod called `atp-demo-XXXXXXXXXX`

    Make sure the status is READY 1/1 or wait until it becomes ready; since the secret was not available for some time (until the database was available) the demo app would be unable to load the secret to decode the wallet. Once the secret is available, the pod will initialize.

    Once the pod is ready, copy the name of the pod and execute:

    ```bash
    <copy>
    kubectl exec -it <pod_name> -- /bin/sh
    </copy>
    ```

    You'll be prompted with a shell prompt inside the container.

    You can check the wallet files are available in the folder `/db-demo/creds` with:

    ```bash
    <copy>
    cd /db-demo/creds
    ls -lah
    </copy>
    ```

    Now you know how to get the credentials for a dynamically provisioned ATP database, you can build your own app connecting to the DB.

## **STEP 5:** Clean up

1. To undeploy, and terminate the ATP instance, delete the kubernetes instances with:

    ```bash
    <copy>
    kubectl delete -f ./atp
    </copy>
    ```

    Clean up is done asynchronously, and the ATP DB will be de-provisioned after a few minutes.

    
You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabs). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
