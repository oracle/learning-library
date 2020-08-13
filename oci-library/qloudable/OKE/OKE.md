# Deploying Oracle Kubernetes Engine.

## Table of Contents

[Overview](#overview)

[Prerequisites](#Prerequisites)

[Sign in to OCI Console and create Kubernetes Cluster](#sign-in-to-oci-console-and-create-kubernetes-cluster)

[Install OCI CLI in your enviornment](#install-oci-cli-in-your-enviornment)

[Install Kubectl](#install-kubectl)

[Download get-kubeconfig.sh file and Initialize your environment](#download-get-kubeconfig.sh-file-and-initialize-your-environment)

[Starting the Kubernetes Dashboard](#starting-the-kubernetes-dashboard)

[Deploying a Sample Nginx App on Cluster Using kubectl](#deploying-a-sample-nginx-app-on-cluster-using-kubectl)

[Delete the resources](#delete-the-resources)


## Overview

Oracle Cloud Infrastructure Container Engine for Kubernetes is a fully-managed, scalable, and highly available service that you can use to deploy your containerized applications to the cloud. Use Container Engine for Kubernetes (sometimes abbreviated to just OKE) when your development team wants to reliably build, deploy, and manage cloud-native applications. You specify the compute resources that your applications require, and Container Engine for Kubernetes provisions them on Oracle Cloud Infrastructure in an existing OCI tenancy.

**Some Key points;**

***Recommended Browsers: Chrome, Edge**

- We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

- Do NOT use compartment name and other data from screen shots.Only use  data(including compartment name) provided in the content section of the lab

- Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the OCI Console

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

**Cloud Tenant Name**
**User Name**
**Password**
**Compartment Name (Provided Later)**

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

## Prerequisites

1. OCI Training : https://cloud.oracle.com/en_US/iaas/training

2. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

3. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

4. Familiarity with Compartments: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

## Sign in to OCI Console and create Kubernetes Cluster

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="image-alt-text">

2. From OCI Services menu, Click **Container Clusters (OKE)** under Developer Services

**No need to create any policies for OKE, all the policies are pre-configured**

3. Click **Create Cluster**. Choose **Quick Create** and click **Launch Workflow**. 

4. Fill out the dialog box:

- NAME: Provide a name (oke-cluster in this example)
- COMPARTMENT: Choose your compartment
- CHOOSE VISIBILITY TYPE: Public
- SHAPE: Choose a VM shape 
- NUMBER OF NODES: 1
- KUBERNETES DASHBOARD ENABLED: Make sure flag is checked

5. Click **Next** and Click "**Create Cluster**

**We now have a OKE cluster with 1 node and Virtual Cloud Network with all the necessary resources and configuration needed**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_015.PNG" alt="image-alt-text">


## Install OCI CLI in your enviornment

1. Click the Apps icon in the toolbar and select Git-Bash to open a terminal window.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL006.PNG" alt="image-alt-text">


4. Enter command 
```
ssh-keygen
```
**HINT:** You can swap between OCI window, 
git-bash sessions and any other application (Notepad, etc.) by Clicking the Switch Window icon 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL007.PNG" alt="image-alt-text">

5. Press Enter When asked for 'Enter File in which to save the key', 'Created Directory, 'Enter passphrase', and 'Enter Passphrase again.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL008.PNG" alt="image-alt-text">

6. You should now have the Public and Private keys:

/C/Users/ PhotonUser/.ssh/id_rsa (Private Key)

/C/Users/PhotonUser/.ssh/id_rsa.pub (Public Key)

**NOTE:** id_rsa.pub will be used to create 
Compute instance and id_rsa to connect via SSH into compute instance.

**HINT:** Enter command 
```
cd /C/Users/PhotonUser/.ssh (No Spaces) 
```
and then 
```
ls 
```
to verify the two files exist. 

7. In git-bash Enter command  
```
cat /C/Users/PhotonUser/.ssh/id_rsa.pub
```
 , highlight the key and copy 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL009.PNG" alt="image-alt-text">

8. Click the apps icon, launch notepad and paste the key in Notepad

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0010.PNG" alt="image-alt-text">


9. Change directory to .oci, Enter command:
```
cd ~/.oci
```

10. Generate API keys, Enter commands:
```
openssl genrsa -out oci_api_key.pem 2048 
```

**NOTE:** Type the command and do not copy/paste

```
openssl rsa -pubout -in oci_api_key.pem -out oci_api_key_public.pem
```                
```
cat oci_api_key_public.pem
```
```
openssl rsa -in ~/.oci/oci_api_key.pem -pubout -outform DER 2>/dev/null | openssl md5 -c | awk '{print $2}' > ~/.oci/oci_api_key_fingerprint
```

11. We will now install OCI CLI.Switch to git-bash window, Enter Command:
```
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```

12. Accept the default (Press Enter) for Install directory Prompts

13. Enter Y when prompted for **Modify Path**

14. Once installation is completed, Enter command:
```
oci -v
```
to check OCI CLI version which should be 2.5.x or higher

15. In git bash window, Enter command:
```
oci setup config
```

16. Accept the default location. For user OCI switch to OCI Console window. Click Human Icon and then your user name. In the user details page Click **copy** to copy the OCID. **Also note down your region name as shown in OCI Console window**. Paste the OCID in git bash.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_004.PNG" alt="image-alt-text">

17. Repeat the step to find tenancy OCID (Human icon followed by Clicking Tenancy Name). Paste the Tenancy OCID in ssh session to compute instance followed by providing your region name (us-ashburn-1, us-phoneix-1 etc)

18. When asked for **Do you want to generate a new RSA key pair?** answer **N**.

19.  When prompted for ‘Enter a location for your private key file’, Type the full directory path Of oci_api_key.pem file location and press Enter (~/.oci/oci_api_key.pem. For rest of questions accept default by pressing Enter. 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_005.PNG" alt="image-alt-text">

20. Now we need to upload  API key into our OCI account for authentication of API calls. To display the conent of API key Enter command :

```
cat ~/.oci/oci_api_key_public.pem
```

21. Highligh and copy the content from ssh session. Switch to OCI Console, Click Human icon followed by your user name. In user details page Click **Add Public Key**. In the dialg box paste the public key content and Click **Add**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_006.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_007.PNG" alt="image-alt-text">


## Install Kubectl

In this section we will install kubectl. You can use the Kubernetes command line tool kubectl to perform operations on a cluster you've created with Container Engine for Kubernetes.

1. Switch to git-bash window, Enter commands:
```
mkdir -p $HOME/.kube 
```
```
cd $HOME/.kube
```

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/windows/amd64/kubectl.exe
```

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_004.PNG" alt="image-alt-text">

2.  Wait for download to complete. Enter command 
```
ls
```
 and verify kubectl.exe file exists.

## Download get-kubeconfig.sh file and Initialize your environment

1. Switch to OCI console window and navigate to your cluster. In Cluster detail window Click **Quick Start**, under **Resources**. 
Follow the steps under the **Quick Start** Section

2. The Commands listed will need to be executed in your local terminal.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_006.PNG" alt="image-alt-text">

3. Next follow the instruction under **Access Kubernetes Dashboard** to access the dash board.


## Deploying a Sample Nginx App on Cluster Using kubectl

1. In git bash window, change Directory to $HOME/.kube, Enter Command:
```
cd $HOME/.kube
```

2. Create nginx deployment with three replicas,  Enter Command:
``` 
./kubectl run nginx  --image=nginx --port=80 --replicas=3
```

3. Get Deployment data, Enter Command:
``` 
./kubectl get deployments
```

4. get PODs data, Enter command:
```
./kubectl get pods -o wide
```

**NOTE:** You can see thse deployment using Kubernetes Dashboard under Deployment

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_010.PNG" alt="image-alt-text">

5.  Create a service to expose the application. The cluster is integrated with the OCI Cloud Controller Manager (CCM). As a result, creating a service of type --type=LoadBalancer will expose the pods to the Internet using an OCI Load Balancer.In git-bash window Enter command:
```
./kubectl expose deployment nginx --port=80 --type=LoadBalancer
```

6. Switch to OCI console window. From OCI Services menu Click **Load Balancers** under Networking. A new OCI LB should be getting  provisioned (This is due to the command above). 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_011.PNG" alt="image-alt-text">

7. Once Load Balancer is Active, Click Load Balancer name and from Load Balancer details page note down its IP address.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_012.PNG" alt="image-alt-text">

8. open a new browser tab and enter URL  http://<Load-Balancer-Public-IP> (http://129.213.76.26 in this example). Nginx Welcome screen should be displayed

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_013.PNG" alt="image-alt-text">


##  Delete the resources

**Delete Kubernetes nodes**

1. In git-bash window Enter command 
```
kubectl delete service nginx
```
and then  
```
kubectl delete deployments nginx
```

**Delete OKE Cluster**

1. In OCI Console window navigate to your cluster and Click **Delete Cluster**, Click **Delete** in the confirmation window


**Delete VCN**

1. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

2. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">


**Delete API Key**

1. Navigate to user settings. Click on Action icon and Click **Delete** to delete the API key

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_014.PNG" alt="image-alt-text">


**Congratulations! You have successfully completed the lab**
