# Provision Kubernetes Using the OCI Console

![](images/200/header.png)

## Introduction

This is the second of several labs that are part of the **Oracle Public Cloud Container Native Development workshop.** 

During this lab, you will take on the **DevOps Engineer Persona**. You will provision a Kubernetes cluster and all of the infrastructure that it requires using the OCI console. OCI will provision the Virtual Cloud Network, Load Balancers, Kubernetes Master and Worker instances, and etcd instance required to support your cluster.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
### Objectives

**Automate Deployment to Kubernetes**

- Create and Deploy to a Kubernetes Cluster
  - Set Up Oracle Cloud infrastructure
  - Provision Kubernetes Using the OCI Console
  - Configure and Run Wercker Deployment Pipelines
  - Deploy and Test the Product Catalog Application

### Required Artifacts

- The following lab requires:
  - an Oracle Cloud Trial Account

# Provision Kubernetes Using the OCI Console

## Set Up Oracle Cloud Infrastructure

### **STEP 1**: Log in to your OCI dashboard

- If you are using a Trial Account, **you must wait until you receive this email** indicating that your Cloud Account has been provisioned. _Please note that this email may arrive in your spam or promotions folder pending your email settings._

  ![](images/200/Step1/Lab200-Step1-1.png)

- Once you receive the **Your Oracle Cloud Account is Fully Provisioned** Email, make note of your **Username, Password and Cloud Account Name**.

- From any browser go to and click on **View Accounts** and then click on **Sign in to Cloud**:

    [https://cloud.oracle.com/en_US/sign-in](https://cloud.oracle.com/en_US/sign-in)

    ![](images/200/Step1/Lab200-Step1-2.png)

- Enter your **Cloud Account Name** in the input field and click the **Next** button. If you have a trial account, this can be found in your welcome email. Otherwise, this will be supplied by your workshop instructor.

  ![](images/200/Step1/Lab200-Step1-3.png)

- Enter your **Username** and **Password** in the input fields and click **Sign In**. If you have a trial account, these can be found in your welcome email. Otherwise, these will be supplied by your workshop instructor.

  ![](images/200/Step1/Lab200-Step1-4.png)

**NOTE**: If you have used your trial account already, you may have been prompted to change the temporary password listed in the welcome email. In that case, enter the new password in the password field.


### **STEP 2**: Create a Compartment for your Kubernetes nodes

Compartments are used to isolate resources within your OCI tenant. Role-based access policies can be applied to manage access to compute instances and other resources within a Compartment.

- Click the **hamburger icon** in the upper left corner to open the navigation menu. Under the **Identity** section of the menu, click **Compartments**

  ![](images/200/LabGuide200-c32a35b9.png)

  - If you have a **Demo** compartment already, _**SKIP THIS STEP**_. Otherwise, Click **Create Compartment**

    ![](images/200/7.png)

  - In the **Name** field, enter `Demo`. Enter a description of your choice. In the **Parent Compartment** field, ensure that the `root` compartment is selected (it will have the same name as your Oracle Cloud Account). Click **Create Compartment**.

    ![](images/LabGuide200-2b3b6b30.png)

### **STEP 3**: Add a Policy Statement for OKE

  - Before the Oracle managed Kubernetes service can create compute instances in your OCI tenancy, we must explicitly give it permission to do so using a policy statement. From the OCI Console navigation menu, choose **Identity->Policies**.

    ![](images/200/LabGuide200-13c980fa.png)

  - In the Compartment drop down menu on the left side, choose the **root compartment**. It will have the same name as your OCI tenancy (Cloud Account Name).

    ![](images/200/LabGuide200-a321171a.png)

  - Click **PSM-root-policy**

    ![](images/200/LabGuide200-e67b7705.png)

  - Click the **Edit Policy Statement** button

    ![](images/200/LabGuide200-3d4a7471.png)

  - Click **Another Statement** and in the Statement box, enter: `allow service OKE to manage all-resources in tenancy`  

    ![](images/200/LabGuide200-bd5bcbd1.png)

### **STEP 4**: Provision Kubernetes Using the OCI Console

  - Now we're ready to create our Kubernetes cluster. From the OCI Console navigation menu, select **Developer Services->Container Clusters (OKE)**.

    ![](images/200/LabGuide200-5c0a2b4c.png)

  - In the Compartments drop down, select the **Demo** compartment.

    ![](images/200/LabGuide200-4071818d.png)

  - Click **Create Cluster**

    ![](images/200/LabGuide200-2e2ab7ca.png)

  - We don't need to make any changes to the default values on this form, but let's look at what will be created when we submit it.

    ![](images/LabGuide200-6ff14524.png)
    ![](images/200/LabGuide200-k8s-2.png)
    
    - Starting at the top you will notice that the cluster will be created in our **Demo** compartment.
    - We can customize the name of this cluster if we want
    - Multiple versions of Kubernetes are available, with the newest version selected by default
    - The default cluster creation mode will automatically create a Virtual Cloud Network for our cluster, including 2 load balancer subnets and 3 subnets for our worker VMs
    - We can customize the size and quantity of worker VMs in the node pool; by default we will get 3x 1 OCPU VMs, one in each Availability Domain.
    - We can also add more node pools to the cluster after creation.
    - The dashboard and Tiller will be installed by default.

  - Click **Create**. You will be brought to the cluster detail page. Your cluster will take a while to provision, so let's use this time to create a cloud VM that we can use to manage our cluster using the command line.


### **STEP 5**: Prepare Token using Cloud Shell

  - From the OCI Console navigation menu, select **Developer Services->Container Clusters (OKE)**, then click the name of your cluster, **cluster1**

    ![](images/200/LabGuide200-5c0a2b4c.png)

    ![](images/LabGuide200-931bae7f.png)

  - Click **Access Cluster**.

    ![](images/LabGuide200-2adad8f0.png)

  - Click on **Cloud Shell** and then click **Launch Cloud Shell**

    ![](images/200/cloud_shell.png)

  - Once the Cloud Shell is launched copy the command shown in the screen and paste it in the cloud shell terminal. New config will be created and the output should be similar as below

    ![](images/200/Lab200-step7-2.png)

    **NOTE**: Copy and paste the commands from the OCI Console window -- the command below is personalized with your cluster OCID. They are listed here for reference only.

    >oci ce cluster create-kubeconfig --cluster-id <your-kubernetes-cluster-ocid\> --file $HOME/.kube/config

- In your _Cloud Shell session_, run the following commands to verify that kubectl is able to communicate with your cluster. You should see cluster-info print out the URL of the Kubernetes Master node and get nodes print out the IP address and status of each of the worker nodes.
  
    ![](images/200/step8/Lab200-step8-1.png)

- In your _Cloud Shell session_, create a file (for example, called **oke-admin-service-account.yaml**) with the following command:

```
<copy>vi oke-admin-service-account.yaml</copy>
```

- press **i** and **copy and paste** the following content: Once done press esc key from keyboard, type **:wq** and press enter to exit.

    ```bash
    <copy>
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: oke-admin
      namespace: kube-system
    ---
    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRoleBinding
    metadata:
      name: oke-admin
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: cluster-admin
    subjects:
    - kind: ServiceAccount
      name: oke-admin
      namespace: kube-system
      </copy>
    ```

- Create the service account and the clusterrolebinding in the cluster by entering the following command where <filename> is the name of the file you created earlier:

    ```bash
    <copy>
    kubectl apply -f oke-admin-service-account.yaml
    </copy>
    ```

- The **output** from the above command confirms the creation of the service account and the clusterrolebinding:

    ```bash
    serviceaccount "oke-admin" created
    clusterrolebinding.rbac.authorization.k8s.io "oke-admin" created
    ```

- Obtain an authentication token for the oke-admin service account by entering:

    ```
    <copy>
    kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep oke-admin | awk '{print $1}')
    </copy>
    ```

    ![](images/200/step8/Lab200-step8-2.png)

- **Copy and note the token, we will use that to login in kube dashboard.**

- Now that we have verified that `kubectl` is connected to our cluster, let's increase the default auto-logout time so that we don't have to keep re-authenticating during the workshop. Note that the default logout time of 15 minutes is set for security reasons. The `--token-ttl=43200"` argument in the following command is the only change that we are making to the dashboard.

  **NOTE**: The following commands are **optional**.

    ```bash
    <copy>
    kubectl patch deployment kubernetes-dashboard -n kube-system -p '{"spec": {"template": {"spec": {"containers": [{"name": "kubernetes-dashboard", "args": ["--token-ttl=43200", "--auto-generate-certificates"]}]}}}}'
    </copy>
    ```

  ![](images/LabGuide200-a5c59f02.png)

  - In order to interact with your cluster and view the dashboard, you will need to install the Kubernetes command line interface, `kubectl`. We will do that next.

### **STEP 6**: Install and Test kubectl on Your Local Machine

- The method you choose to install `kubectl` will depend on your operating system and any package managers that you may already use. The generic method of installation, downloading the binary file using `curl`, is given below (**run the appropriate command in a terminal or command prompt**). If you prefer to use a package manager such as apt-get, yum, homebrew, chocolatey, etc, please find the specific command in the [Kubernetes Documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

    **NOTE**: There are several files that will be downloaded or created on your local machine during this workshop. We recommend creating a directory to store them in for ease of locating and cleaning up. In this step, you will create a directory inside your home/user directory called `container-workshop`. You are free to change the location and name of this directory, but the lab guide will assume it is located at `~/container-workshop/`. **You will need to modify the given terminal commands throughout this lab** if you change the location or name of the directory.

    ```bash
    <copy>
    cd ~
    mkdir container-workshop
    </copy>
    ```

  **Windows**
    ```bash
    <copy>
    cd %USERPROFILE%\container-workshop
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/windows/amd64/kubectl.exe
    </copy>
    ```

  **Mac**
    ```bash
    <copy>
    cd ~/container-workshop
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl
    chmod +x ./kubectl
    </copy>
    ```
    - To install with brew
    ```bash
    <copy>
    brew install kubectl 
    </copy>
    ```

  **Linux**
    ```bash
    <copy>
    cd ~/container-workshop
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    </copy>
    ```

- To access the dashboard we need to create kubeconfig file.
- In _Cloud Shell Session_, run the following command and copy the output

    ```bash
    <copy>
    cat ~/.kube/config
    </copy>
    ```

- In your _local machine_, open the terminal and create kubeconfig file and paste the copied content, press **i** and paste: 
- If possible create file in container-workshop directory
  
    ```bash
    <copy>
    vi kubeconfig
    </copy>
    ```

**Note**: Remember the path where you are creating this file

   

- We need to modify the file, remove all the content after user and it should look as follow:

    ![](images/200/Step7/Lab200-step7-2.png)

- Now paste the token which we copied in **Step 5** in the file as follow
- Once the changes are made to **save and exit** press escape key in keyboard and type **:wq** and press enter.

    ![](images/200/Step7/Lab200-step7-3.png)

**Note**: Make sure the intendation is correct for token. It should be 4 spaces from the beginning of line and space between token and value.

- Export the path of KUBECONFIG to the file.
  
    **Windows**
    ```bash
    <copy>
    set KUBECONFIG=PATH_OF_KUBECONFIG_FILE
    </copy>
    ```
  **Note**: Make sure to replace the path in above command
  - Example, if path is ~/container-workshop

    ```bash
    <copy>
   set KUBECONFIG=%USERPROFILE%\container-workshop\kubeconfig
    </copy>
    ```
   - To confirm the config is correct, try the following commands:
   
    ```bash
    <copy>
    kubectl.exe cluster-info
    kubectl.exe get nodes
    </copy>
    ```
    

  **Mac/Linux**
    ```bash
    <copy>
    export KUBECONFIG=PATH_OF_KUBECONFIG_FILE
    </copy>
    ```
  
   **Note**: Make sure to replace the path in above command
  - Example, if path is ~/container-workshop

    ```bash
    <copy>
   export KUBECONFIG=~/container-workshop/kubeconfig
    </copy>
    ```
- To confirm the config is correct, try the following commands:

    ```bash
    <copy>
    ./kubectl cluster-info
    ./kubectl get nodes
    </copy>
    ```

- We can use `kubectl` to start a proxy that will give us access to the Kubernetes Dashboard through a web browser at a localhost URL. Run the following command in the same terminal window:

  **Windows**
    ```bash
    <copy>
    kubectl.exe proxy
    </copy>
    ```

  **Mac/Linux**
    ```bash
    <copy>
    ./kubectl proxy
    </copy>
    ```

  ![](images/LabGuide200-73acec26.png)

  **NOTE**: If you receive an error stating `bind: address already in use`, you may have another application running on port 8001. You can specify a different port for the proxy by passing the `--port=` parameter, for example `kubectl proxy --port=8002`. Note that you  will have to modify the URL for the dashboard in the next step to match this port.

- Leave the proxy server running and navigate to the [Kubernetes Dashboard by Clicking on this link](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/), and choosing **open in a new browser tab**.

- In the [Kubernetes Dashboard](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/), select **Kubeconfig** and click three dots to choose the kubeconfig file, then click **Sign In**.

  ![](images/200/Step7/Lab200-step7-4.png)

- After authenticating, you are presented with the Kubernetes dashboard.

  ![](images/200/LabGuide200-eed32915.png)

- Great! We've got Kubernetes installed and accessible -- now we're ready to get our microservice deployed to the cluster. The next step is to tell Wercker how and where we would like to deploy our application. In your **terminal window**, press **Control-C** to terminate `kubectl proxy`. We will need the terminal window to gather some cluster info in another step. We'll start the proxy again later.

## Configure and Run Wercker Deployment Pipelines

### **STEP 7**: Define Kubernetes Deployment Specification

- From a browser, navigate to your forked twitter-feed repository on GitHub. If you've closed the tab, you can get back by going to [GitHub](https://github.com/), clicking the **Repositories** tab at the top of the page, and clicking the **twitter-feed-oke** link.

  ![](images/200/LabGuide200-b51c7f37.png)

- Click **Create new file**

  ![](images/200/27.png)

- In the **Name your file** input field, enter **kubernetes.yml.template**

  ![](images/200/28.png)

- **Copy** the YAML below and **paste** it into the file editor.

    ```yaml
    <copy>
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: twitter-feed-v1
      labels:
        commit: ${WERCKER_GIT_COMMIT}
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: twitter-feed
      template:
        metadata:
          labels:
            app: twitter-feed
            commit: ${WERCKER_GIT_COMMIT}
        spec:
          containers:
          - name: twitter-feed
            image: ${DOCKER_REGISTRY}/${DOCKER_REPO}:${WERCKER_GIT_BRANCH}-${WERCKER_GIT_COMMIT}
            imagePullPolicy: Always
            ports:
            - name: twitter-feed
              containerPort: 8080
              protocol: TCP
          imagePullSecrets:
            - name: wercker
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: twitter-feed
      labels:
        app: twitter-feed
        commit: ${WERCKER_GIT_COMMIT}
    spec:
      ports:
      - port: 30000
        targetPort: 8080
      selector:
        app: twitter-feed
      type: ClusterIP
    ---
    </copy>
    ```
  >This configuration consists of two parts. The first section (up to line 28) defines a **Deployment**, which tells Kubernetes about the application we want to deploy. In this Deployment we instruct Kubernetes to create two Pods (`replicas: 2`) that will run our application. Within those pods, we specify that we want one Docker container to be run, and compose the link to the image for that container using environment variables specific to this workflow execution (`image: ${DOCKER_REPO}:${WERCKER_GIT_BRANCH}-${WERCKER_GIT_COMMIT}`).

  >The second part of the file defines a **Service**. A Service defines how Kubernetes should expose our application to traffic from outside the cluster. In this case, we are asking for a cluster-internal IP address to be assigned (`type: ClusterIP`). This means that our twitter feed will only be accessible from inside the cluster. This is ok, because the twitter feed will be consumed by the product catalog application that we will deploy later. We can still verify that our twitter feed is deployed properly -- we'll see how in a later step.

  >A `.yml` file is a common format for storing Kubernetes configuration data. The `.template` suffix in this file, however, is not a Kubernetes concept. We will use a Wercker step called **bash-template** to process any `.template` files in our project by substituting environment variables into the template wherever `${variables}` appear. You'll add that command to a new pipeline in the next step.

  - At the bottom of the page, click **Commit new file**

    ![](images/200/29.png)

  - Since you've committed to the repository, Wercker will trigger another execution of your workflow. We haven't defined the deployment pipelines yet, so this will just result in a new entry in Wercker's Runs tab and a new image pushed to the container registry. You don't need to do anything with those; you can move on to the next step.

### **STEP 8**: Define Wercker Deployment Pipelines

  - Click the file **wercker.yml** and then click the **pencil** button to begin editing the file.

    ![](images/200/26.png)

  - **Copy** the YAML below and **paste** it below the pipelines we defined earlier.

    ```yaml
    <copy>
    #Deploy our container from the Oracle Container Registry to the Oracle Container Engine (Kubernetes)
    deploy-to-cluster:
      box:
          id: alpine
          cmd: /bin/sh

      steps:

      - bash-template

      - kubectl:
          name: delete secret
          server: $KUBERNETES_MASTER
          token: $KUBERNETES_AUTH_TOKEN
          insecure-skip-tls-verify: true
          command: delete secret wercker; echo delete registry secret

      - kubectl:
          name: create secret
          server: $KUBERNETES_MASTER
          token: $KUBERNETES_AUTH_TOKEN
          insecure-skip-tls-verify: true
          command: create secret docker-registry wercker --docker-server=$DOCKER_REGISTRY --docker-email=nobody@oracle.com --docker-username=$DOCKER_USERNAME --docker-password='$OCI_AUTH_TOKEN'; echo create registry secret

      - script:
          name: "Visualise Kubernetes config"
          code: cat kubernetes.yml

      - kubectl:
          name: deploy to kubernetes
          server: $KUBERNETES_MASTER
          token: $KUBERNETES_AUTH_TOKEN
          insecure-skip-tls-verify: true
          command: apply -f kubernetes.yml
          </copy>
    ```

    >This will define a new **Pipeline** called deploy-to-cluster. The pipeline will make use of a new type of step: **kubectl**. If you have used Kubernetes before, you will be familiar with kubectl, the standard command line interface for managing Kubernetes. The kubectl Wercker step can be used to execute Kubernetes commands from within a Pipeline.

    >The **deploy-to-cluster** Pipeline will prepare our kubernetes.yml file by filling in some environment variables. It will then use kubectl to tell Kubernetes to apply that configuration to our cluster.

- At the bottom of the page, click **Commit new file**

  ![](images/200/29.png)

- Since you've committed to the repository again, Wercker will once again trigger an execution of your workflow. We still haven't configured the deployment pipelines in Wercker yet, so we'll still end up with a new Run and a new image, but not a deployment to Kubernetes.

### **STEP 9**: Set up deployment pipelines in Wercker

- Open **[Wercker](https://app.wercker.com)** in a new tab or browser window, or switch to it if you already have it open. In the top navigation bar, click **Pipelines**, then click on your **twitter-feed-oke** application.

  ![](images/200/30.png)

- On the **Runs** tab you can see that Wercker has triggered another execution of our build and publish workflow, but it has not executed our new deploy-to-cluster pipeline. This is because we have not added the new pipeline to the workflow definition yet. Let's do that now -- click on the **Workflows** tab, then click the **Add new pipeline** button.

  ![](images/200/31.png)

- Enter **deploy-to-cluster** into both the Name and YML Pipleine name fields. Click **Create**.

  ![](images/200/32.png)

- Click the **Workflows** tab again to get back to the editor.

- Click the **plus** button to the right of the **push-release** pipeline to add to the workflow. In the **Execute Pipeline** drop down list, select **deploy-to-cluster** and click **Add**

  ![](images/200/33.png)

- Your overall Workflow should now have three Pipelines:

  ![](images/200/34.png)

- Now we've got our workflow updated with our deployment pipelines, but there's one more thing we need to do before we can actually deploy. We need to set a few environment variables that tell Wercker the address of our Kubernetes master and provide authentication tokens for Wercker to issue commands to Kubernetes and to OCI.

### **STEP 10**: Set up environment variables in Wercker


- Back in your Wercker browser tab, click the **Environment** tab. In the key field of the empty row below the last environment variable,   enter the key **`KUBERNETES_AUTH_TOKEN`**.
-  In the value field, **paste** the token we copied in **Step 5**. Check the **Protected** box and click **Add**.

  ![](images/200/LabGuide200-7a3d011b.png)

- The next environment variable we need to add is the address of the Kubernetes master we want to deploy to. We can get the URL from `kubectl`. Run the following command in your _Cloud Shell Terminal_ to output the URL, then **select it and copy it** to your clipboard:


    ```bash
    <copy>
    echo $(kubectl config view | grep server | cut -f 2- -d ":" | tr -d " ")
    </copy>
    ```

- In your Wercker browser tab, add a new environment variable with the key **`KUBERNETES_MASTER`**. In the value field, **paste** the value you copied from `kubectl`. The value **must start with https://** for Wercker to communicate with the cluster. When finished, click **Add**.

  ![](images/200/55.png)

  **NOTE**: You can also find this address in the OCI Console OKE page, by clicking on your cluster name to view the detail page:

    ![](images/200/LabGuide200-9d5e858e.png)

- The last environment variable we need to create in Wercker is a token for Wercker to authenticate to OCI so that it can push our Docker image to the OCI Repository (OCIR). We will generate this authentication token in the OCI Console and then paste it into a Wercker environment variable. Add a new environment variable with the key **`OCI_AUTH_TOKEN`**.

  ![](images/200/LabGuide200-ad86d83b.png)

- Switch to your **OCI Console** browser tab. Use the navigation menu to go to Identity->Users and select **View User Details** from the three-dots menu for your user. If you've closed the tab, [log in again](https://console.us-ashburn-1.oraclecloud.com).

  ![](images/LabGuide200-f1749ef3.png)

  **NOTE**: You may see two users in the list, one that is named with just your email address, and another that is named `oracleidentitycloudservice`/your-email-address. **Choose the one that is named just your-email-address.**

- In the Resources menu of the user settings page, click **Auth Tokens**. Then click **Generate Token**.

  ![](images/200/LabGuide200-8b775cc2.png)

  ![](images/200/LabGuide200-ae59e875.png)

- In the Description field, enter **Wercker Pipeline Token** and click **Generate Token**.

  ![](images/200/LabGuide200-a04556fa.png)

- Click the **Copy** link under the generated token, then click **Close**. Save the token in notes we will use the same token in Lab 500
  
- Switch back to your Wercker browser tab and **Paste** this token into the Value field of the **`OCI_AUTH_TOKEN`** environment variable you started creating earlier. Check the **Protected** box and click **Save**.

  ![](images/200/LabGuide200-8313bb92.png)

  ![](images/200/LabGuide200-bb187bd2.png)

- Lastly, let's go back and look at the `DOCKER_REGISTRY` variable to ensure that we have specified the correct region. In the **OCI Console**, look in the top right corner for the currently selected region:

  ![](images/LabGuide200-fd1aa1f3.png)

  - If the region is `ashburn`, then you do not need to change anything. The URL `iad.ocir.io` is correct.

  - If the region is not `ashburn`, replace the `iad` part of the `DOCKER_REGISTRY` environment variable to match your region:

  ```
  London = lhr
  Frankfurt = fra
  Phoenix = phx
  Ashburn = iad
  ```

  - For example, if your region is `eu-frankfurt-1`, change the URL to `fra.ocir.io` and click the **save** button

    ![](images/LabGuide200-cc8b640d.png)

- Before moving to next step make sure that all the env variables are set
    ![](images/200/Step12/Lab200-step12-1.png)

- Now we're ready to try out our workflow from start to finish. We could do that by making another commit on GitHub, since Wercker is monitoring our source code. We can also trigger a workflow execution right from Wercker. We'll see how in the next step.

### **STEP 11**: Trigger a retry of the pipeline

- On your Wercker application page in your browser, click the **Runs** tab. Your most recent run should have a successful build pipeline and a failed push-release pipeline. Click the **push-release** pipeline.

  ![](images/200/LabGuide200-8591cf15.png)

- Click the **Retry** button.

  ![](images/200/LabGuide200-77bb35a3.png)

- Click the **Runs** tab so you can monitor the execution of the pipeline. Within a minute or so, the deployment pipeline should complete successfully. Now we can use the Kubernetes dashboard to inspect and validate our deployment.

  ![](images/200/42.png)

### **STEP 12**: Validate deployment

- First we will validate that our Docker image is visible in the OCI Registry. In your **OCI Console** browser tab, select **Registry (OCIR)** from the navigation menu, under the Developer Services category.

  ![](images/200/LabGuide200-f5114d8a.png)

- Click on **twitter-feed** to expand the list of images, then click **master-xxxx** to view the details. This confirms that our image was pushed to the right place. The git branch and commit hash help us connect this image with the specific code version on GitHub.

  ![](images/200/LabGuide200-2de08741.png)

- If you prefer to use the command line as opposed to the web browser method of testing the service, run the following command to verify that our microservice is returning JSON data:

  **Mac/Linux/Git Bash**
  ```bash
  export KUBECONFIG=~/container-workshop/kubeconfig
  ./kubectl exec -it $(./kubectl get pod -l "app=twitter-feed" -o jsonpath='{.items[0].metadata.name}') -- /bin/sh -c '/usr/bin/curl -s http://$HOSTNAME:8080/statictweets | head -c 1000; echo'
  ```

  **Windows**
  ```bash
  set KUBECONFIG=%USERPROFILE%\container-workshop\kubeconfig
  kubectl.exe get pod -l "app=twitter-feed" -o jsonpath="{.items[0].metadata.name}" > podname.txt && FOR /F usebackq %A IN (`more podname.txt`) DO kubectl.exe exec -it %~A -- /bin/sh -c "/usr/bin/curl -s http://$HOSTNAME:8080/statictweets | head -c 1000; echo"
  ```

  - If you see JSON data returned, **skip to Step 14** where we will deploy the other components of our product catalog application. Otherwise, if the commands didn't work, you don't have PowerShell, or you prefer a browser-based interface, continue on:

- In a terminal window, start the **kubectl proxy** using the following command. Your `KUBECONFIG` environment variable should still be set from a previous step. If not, reset it.

  **Windows**
  ```bash
  kubectl.exe proxy
  ```

  **Mac/Linux**
  ```bash
  ./kubectl proxy
  ```

- In a browser tab, navigate to the [**Kubernetes dashboard**](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)

- You should see the overview page. In the pods section, you should see two twitter-feed pods running. Click the **name of one of the pods** to go to the detail page.

  ![](images/200/44.png)

- On the pod detail page, in the top menu bar, click **Exec**. This will give us a remote shell on the pod where we can verify that our application is up and running.

  ![](images/200/45.png)

- In the shell that is displayed, **paste** the following command and press **Enter**.

  **NOTE:** You may need to use ctrl-shift-v to paste. Alternatively, you can use the mouse-driven browser menu to paste the command.

  `curl -s http://$HOSTNAME:8080/statictweets | head -c 100`

- You should see some JSON data being returned by our twitter feed service. Our microservice has been deployed successfully! But the twitter feed service is just one part of our product catalog application. Let's deploy the rest of the application so we can validate that everything works together as expected. Leave this browser tab open, as we will use it in a later step.

  ![](images/200/46.png)

**NOTE**: You may be wondering why we had to use the Kubernetes remote terminal to test our application. Remember the kubernetes.yml file that we created earlier -- we specified a cluster-internal IP address for our twitter-feed service. This means that only other processes inside the cluster can reach our service. If we wanted to access our service from the internet, we could have used a load balancer instead.

## Deploy and Test the Product Catalog Application

### **STEP 13**: Download the Product Catalog Kubernetes YAML file

- From a browser, navigate to your forked twitter-feed repository on GitHub. If you've closed the tab, you can get back by going to [GitHub](https://github.com/), clicking the **Repositories** tab at the top of the page, and clicking the **twitter-feed-oke** link.

  ![](images/200/LabGuide200-b51c7f37.png)

- Click on the **alpha-office-product-catalog.kubernetes.yml** file.

  ![](images/200/47.png)

- Right click on the **Raw** button and choose **Save Link As** or **Save As**. In the save file dialog box that appears, note the location of the file and click **Save**

  ![](images/200/48.png)

**NOTE**: This YAML file contains the configuration for a Kubernetes deployment and service, much like the configuration for our twitter feed microservice. In a normal development environment, the product catalog application would be managed by Wercker as well, so that builds and deploys would be automated. In this workshop, however, you will perform a one-off deployment of a pre-built Docker image containing the product catalog application from within the Kubernetes dashboard.

### **STEP 14**: Deploy and test the Product Catalog using the Kubernetes dashboard

- Switch back to your **Kubernetes dashboard** browser tab. If you have closed it, navigate to the Kubernetes dashboard at [**Kubernetes dashboard**](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)

- In the upper right corner of the dashboard, click **Create**.

  ![](images/200/49.png)

- Click the **Create From File** tab, then click the **three dots** button to browse for your file. In the dialog, select the YAML file you just downloaded from GitHub and click **Open**, then click **UPLOAD**.

  ![](images/200/LabGuide200-5765b03c.png)

- In the left side navigation menu, click **Overview**. You should see two new product-catalog-app pods being created and soon change state to Running.

  ![](images/200/51.png)

- Instead of a cluster-internal IP address, the product-catalog-service will be exposed to the internet via a load balancer. The load balancer will take a few minutes to be instantiated and configured. Let's check on its status--click **Services** from the left side menu, then click on the **product-catalog-service**.

  ![](images/200/52.png)

- On the service detail page, you will see a field called **External endpoints**. Once the load balancer has finished provisioning, the External endpoints field will be populated with a link to the product catalog application. If the link is not shown yet, wait a few minutes, refresh your browser, and check again. Once the link is displayed, **click it** to launch the site in a new tab.

  ![](images/200/53.png)

- You should see the product catalog site load successfully, validating that our new Kubernetes deployment and service were created correctly. Let's test the twitter feed functionality of the catalog. Click the first product, **Crayola New Markers**. The product's twitter feed should be displayed.

  ![](images/200/54.png)

  **NOTE**: You may have noticed that we did not need to alter the pre-built product catalog container with the URLs of the twitter feed pods or service. The product catalog app makes use of Kubernetes DNS to resolve the service name (twitter-feed) into its IP address. Kubernetes DNS assigns a DNS name to every service defined in your cluster, so any service can be looked up by doing a DNS query for the name of the service (prefixed by _`namespace.`_ if the service is in a different namespace from the requester). The product catalog server uses the following JavaScript code to make an HTTP request to the twitter feed microservice:

  `request('http://twitter-feed:30000/statictweets/color', function (error, response, body) { ... });`

- Some tweets are indeed displayed, but they aren't relevant to this product. It looks like there is a bug in our twitter feed microservice! Continue on to the next lab to explore how to make bug fixes and updates to our microservice.

**You are now ready to move to the next lab: Lab 300**
