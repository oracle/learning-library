# Deploy an OKE cluster with OCI Service Broker (OSB)

## Introduction

In this lab we will deploy the OKE cluster with the OCI Service Broker, using the quickstart repository at [https://github.com/oracle-quickstart/oke-with-service-broker](https://github.com/oracle-quickstart/oke-with-service-broker)

Estimated Lab Time: 30 minutes

### Objectives

In this lab you will:

- Clone the repository
- Populate parameter files
- Run the terraform script to deploy the OKE cluster with OSB
- Verify the deployment

### Prerequisites

For this lab you will need to have installed the required software:

- kubectl
- helm
- oci cli

## **STEP 1:** Clone the repository

1. Clone the repository with the following command:

    ```bash
    <copy>
    git clone https://github.com/oracle-quickstart/oke-with-service-broker
    cd oke-with-service-broker
    </copy>
    ```

    or download the code from github at [https://github.com/oracle-quickstart/oke-with-service-broker](https://github.com/oracle-quickstart/oke-with-service-broker)


## **STEP 2:** Create a `TF_VARS.sh` file

1. Create an emtpy file called `TF_VARS.sh` that contains the following environment variables:

    ```bash
    <copy>
    export TF_VAR_user_ocid=
    export TF_VAR_fingerprint=
    export TF_VAR_private_key_path=
    export TF_VAR_tenancy_ocid=
    export TF_VAR_region=
    </copy>
    ```

    This information can be obtained from:
    - `TF_VAR_user_ocid`: On the OCI web console, click your user icon on the top right and then `User Settings`. The user OCID is displayed in the user details

    - `TF_VAR_fingerprint`: As you uploaded your public key when installing the OCI CLI, you should have gathered the key fingerprint. You can find it under **API Keys**.

    - `TF_VAR_private_key_path`: is the path to the private key which corresponded public key was uploaded to your user API Keys. The path is typically `~/.oci/oci_api_key.pem`

    - `TF_VAR_tenancy_ocid`: under your user icon, click **Tenancy** to get to your tenancy details and retrieve the tenancy OCID

    - `TF_VAR_region`: is the region code where to deploy, it is part of the console URL, for example `us-ashburn-1`

2. Source the `TF_VARS.sh` file

    Source the file with the command:

    ```bash
    <copy>
    source ./TF_VARS.sh
    </copy>
    ```

    This will add the defined environment variables to your shell environment.

    On Windows, in PowerShell, use:

    ```
    <copy>
    .\TF_VARS.sh
    </copy>
    ```

## **STEP 3:** Create a `terraform.tfvars` file

1. Create a `terraform.tfvars` file from the template `terraform.tfvars.template` (make a copy and rename it `terraform.tfvars)

    ```bash
    <copy>
    cp terraform.tfvars.template terraform.tfvars
    </copy>
    ```

2. Edit the required variables with the values for your environment

    The following variables are required:

    ```
    tenancy_ocid = ""
    compartment_ocid = ""
    region           = "us-ashburn-1"
    ssh_authorized_key = ""
    secrets_encryption_key_ocid = null
    ```

    - `region` and `tenancy_ocid` should match the values set in `TF_VARS.sh`

    - `compartment_ocid` is the OCID of the compartment where the stack will be deployed. If you have not created a compartment, create one, and/or get the OCID by going to **Identity -> Compartments** and select the compartment to use to see its details and retrieve the OCID.

    - `ssh_authorized_key` is the content of your ***public key*** used for ssh. This will give you access to the worker nodes of the Kubernetes cluster if need be.

        You can use the `oci_api_key_public` you created when installing the OCI CLI or your default ssh key usually located at `~/.ssh/id_rsa.pub` on Mac or Linux machines.

        To output the content of the key use:
        
        ```bash
        <copy>
        cat ~/.ssh/id_rsa.pub
        </copy>
        ```

        and copy the full output and then paste it into the `terraform.tfvars` file within the `""`

    - If you wish to encrypt kubernetes secrets at rest, you can provide an encryption key OCID for `secrets_encryption_key_ocid`

        You need to have created a **Vault** and an **Encryption Key** to use this feature, otherwise keep the value `null`
    
## **STEP 4:** Initialize the terraform repository

1. Initialize the terraform project with:

    ```bash
    <copy>
    terraform init
    </copy>
    ```

## **STEP 5:** Deploy the stack

1. If you wish to see the plan for the deployment, use:

    ```bash
    <copy>
    terraform plan
    </copy>
    ```

2. Deploy the stack with:

    ```bash
    <copy>
    terraform apply
    </copy>
    ```

    Type **yes** at the prompt to confirm.

    This will take between 20 and 40min

## **STEP 6:** Verify the deployment

If the deployment went smoothly, you should not see errors in the terraform log, and it should be done within 45min.

1. Check the presence of the pods in the `oci-service-broker` namespace

    ```bash
    <copy>
    kubectl get pods -n oci-service-broker
    </copy>
    ```

    You should see an output like:

    ```
    NAME                                                     READY   STATUS    RESTARTS   AGE
    catalog-catalog-controller-manager-dc65bcd87-zs5vj       1/1     Running   0          2m
    catalog-catalog-webhook-d6694bdf8-tmtbv                  1/1     Running   0          2m
    etcd-0                                                   1/1     Running   0          2m
    etcd-1                                                   1/1     Running   0          2m
    etcd-2                                                   1/1     Running   0          2m
    oci-service-broker-oci-service-broker-67ddfbf76b-rbsvt   1/1     Running   0          2m
    ```

2. Check the presence of the OCI Service Broker classes and plans

    ```bash
    <copy>
    kubectl get all
    </copy>
    ```

    You should see an output containing:

    ```
    NAME                                                         READY   STATUS    RESTARTS   AGE
    pod/catalog-catalog-controller-manager-dc65bcd87-nngbw       1/1     Running   0          11m
    pod/catalog-catalog-webhook-d6694bdf8-jq2kb                  1/1     Running   0          11m
    pod/etcd-0                                                   1/1     Running   0          4m16s
    pod/etcd-1                                                   1/1     Running   0          4m15s
    pod/etcd-2                                                   1/1     Running   0          4m15s
    pod/oci-service-broker-oci-service-broker-6f8bf64b87-8wcxb   1/1     Running   0          96s

    NAME                                         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
    service/catalog-catalog-controller-manager   ClusterIP   10.2.144.176   <none>        443/TCP             11m
    service/catalog-catalog-webhook              NodePort    10.2.222.92    <none>        443:31443/TCP       11m
    service/etcd                                 ClusterIP   10.2.81.192    <none>        2379/TCP,2380/TCP   4m17s
    service/etcd-headless                        ClusterIP   None           <none>        2379/TCP,2380/TCP   4m17s
    service/oci-service-broker                   ClusterIP   10.2.95.171    <none>        8080/TCP            97s

    NAME                                                    READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/catalog-catalog-controller-manager      1/1     1            1           11m
    deployment.apps/catalog-catalog-webhook                 1/1     1            1           11m
    deployment.apps/oci-service-broker-oci-service-broker   1/1     1            1           97s

    NAME                                                               DESIRED   CURRENT   READY   AGE
    replicaset.apps/catalog-catalog-controller-manager-dc65bcd87       1         1         1       11m
    replicaset.apps/catalog-catalog-webhook-d6694bdf8                  1         1         1       11m
    replicaset.apps/oci-service-broker-oci-service-broker-6f8bf64b87   1         1         1       97s

    NAME                    READY   AGE
    statefulset.apps/etcd   3/3     4m17s

    NAME                                                                             EXTERNAL-NAME          BROKER               AGE
    clusterserviceclass.servicecatalog.k8s.io/3cc45fe6-gqee-321f-c143-w3d1d278912c   atp-service            oci-service-broker   43s
    clusterserviceclass.servicecatalog.k8s.io/4a39466b-211d-48e2-a86b-db022c10fe59   object-store-service   oci-service-broker   43s
    clusterserviceclass.servicecatalog.k8s.io/adw45fe6-fqxe-261g-k172-a7d1x277112d   adw-service            oci-service-broker   43s
    clusterserviceclass.servicecatalog.k8s.io/f28894d0-cf40-4cff-a19a-a6893f88dd67   oss-service            oci-service-broker   43s

    NAME                                                                             EXTERNAL-NAME   BROKER               CLASS                                  AGE
    clusterserviceplan.servicecatalog.k8s.io/35678215-23xq-n373-fsls-cbf782ams8kp    standard        oci-service-broker   adw45fe6-fqxe-261g-k172-a7d1x277112d   42s
    clusterserviceplan.servicecatalog.k8s.io/78904215-13ea-a123-cd16-cbm890d6689a    standard        oci-service-broker   3cc45fe6-gqee-321f-c143-w3d1d278912c   42s
    clusterserviceplan.servicecatalog.k8s.io/831ab2a8-97e4-4f34-a26b-2bfd61617b61    standard        oci-service-broker   f28894d0-cf40-4cff-a19a-a6893f88dd67   42s
    clusterserviceplan.servicecatalog.k8s.io/ffd4b96d-4910-4427-bfd4-7899f7f6097a    archive         oci-service-broker   4a39466b-211d-48e2-a86b-db022c10fe59   43s
    clusterserviceplan.servicecatalog.k8s.io/k1d643051-c407-4f3f-8527-82cee9ab45f6   standard        oci-service-broker   4a39466b-211d-48e2-a86b-db022c10fe59   43s

    NAME                                                            URL                                                                    STATUS   AGE
    clusterservicebroker.servicecatalog.k8s.io/oci-service-broker   https://oci-service-broker.oci-service-broker.svc.cluster.local:8080   Ready    46s
    ```

## **Step 7:** Access the Kubernetes dashboard

    To access the Kubernetes dashboard, run the helper script:

    ```bash
    <copy>
    ./access_k8s_dashboard.sh
    </copy>
    ```

    The script will display a token, setup kubeproxy and open the browser to the Kubernetes dashboard page.

    Copy the token from the script output and paste it at the login prompt, and you can then navigate to the various resources.

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabs). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
