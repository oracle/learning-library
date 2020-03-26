# Deploying Oracle Kubernetes Engine.

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create a VCN](#sign-in-to-oci-console-and-create-a-vcn)

[Install OCI CLI in your enivornment](#install-oci-cli-in-your-enivornment)

[Create Kubernetes Cluster](#create-kubernetes-cluster)

[Install Kubectl, OCI CLI and configure OCI CLI](#install-kubectl,-oci-cli-and-configure-oci-cli)

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

## Pre-Requisites

1. OCI Training : https://cloud.oracle.com/en_US/iaas/training

2. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

3. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

4. Familiarity with Compartments: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

5. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm

## Sign in to OCI Console and create a VCN

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="image-alt-text">

2. From the OCI Services menu,Click **Virtual Cloud Network** under Networking and Click **Create Virtual Cloud Network**

3. Select the compartment assigned to you from drop down menu on left part of the screen

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL001.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL002.PNG" alt="image-alt-text">

4. Fill out the dialog box:


 **Name:** Enter easy to re¬member name

- **Create in Compartment:** Has the correct compartment

- **Create Virtual Cloud Network Only:** Select this option.

-**CIDR BLOCK**: 172.16.0.0/16

- Click **Create Virtual Cloud Network**

- Click **Close**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Advanced/img/OCI_Advanced_001.PNG" alt="image-alt-text">

5. Virtual Cloud Network will be created and VCN name will appear on OCI Console. Scroll down to find your VCN if multiple VCN exist, and Click your VCN name.

6. In VNC detials page,  Click **Internet Gateways** under Resources, and Click **Create Internet Gateway**. Fill out the dialog box. Click **Create Internet Gateway** (ensure correct compartment is selected).

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Advanced/img/OCI_Advanced_002.PNG" alt="image-alt-text">

7. Click **Route tables**, and Click **Create Route Table**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Advanced/img/OCI_Advanced_003.PNG" alt="image-alt-text">

8. **Click +Additional Route Rules**
- Target Type: Select **Internet Gateway** 
- Destination CIDR Block: 0.0.0.0/0 
- Compartment: Make sure the correct Compartment is selected
- Target Internet Gateway: Select the Internet Gateway for your VCN. 

9. Click **Add Route Rules**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_003.PNG" alt="image-alt-text">

10. Click your VCN name, then **Security Lists** and then **Create Security List** (You will be creating a new security list). Fill out the dialog box:

- Name: Provide a Name
- CREATE IN COMPARTMENT: Choose your compartment

11. Click **+Additional Ingress Rule** and enter the following ingress rule; Ensure to leave STATELESS flag un-checked


- Source Type: CIDR
- Source CIDR: 172.16.10.0/24
- IP Protocol: ALL
- Source Port Range: All
- Destination Port Range: All

12. Click **+Additional Ingress Rule**


- Source Type: CIDR
- Source CIDR: 172.16.11.0/24
- IP Protocol: ALL
- Source Port Range: All
- Destination Port Range: All

13. Click **+Additional Ingress Rule**


- Source Type: CIDR
- Source CIDR: 172.16.12.0/24
- IP Protocol: ALL
- Source Port Range: All
- Destination Port Range: All

14. Click **+Additional Ingress Rule**


- Source Type: CIDR
- Source CIDR: 0.0.0.0/0
- IP Protocol: ICMP
- Type: 3, 4
- Code: 3, 4

15. Click **+Additional Ingress Rule**


- Source Type: CIDR
- Source CIDR: 130.35.0.0/16
- IP Protocol: TCP
- Source Port Range: All
- Destination Port Range: 22

16. Click **+Additional Ingress Rule**


- Source Type: CIDR
- Source CIDR: 138.1.0.0/17
- IP Protocol: TCP
- Source Port Range: All
- Destination Port Range: 22

17. Click **+Additional Ingress Rule**


- Source Type: CIDR
- Source CIDR: 0.0.0.0/0
- IP Protocol: TCP
- Source Port Range: All
- Destination Port Range: 22

18. Click **+Additional Egress Rule** and enter the following Egress rule; Ensure to leave STATELESS flag un-checked


- Destination Type: CIDR
- Destination CIDR: 0.0.0.0/0
- IP Protocol: All
- Source Port Range: All
- Destination Port Range: All

19. Click **Create Security List**.

20. Next we will create another Security Lists for Load Balancer (to be created later). Click **Security Lists** and then **Create Security List** (You will be creating a new security list). Fill out the dialog box:


- Name: Provide a Name
- CREATE IN COMPARTMENT: Choose your compartment

21. Click **+Additional Ingress Rule** and enter the following ingress rule; Ensure to leave STATELESS flag un-checked


- Source Type: CIDR
- Source CIDR: 0.0.0.0/0
- IP Protocol: ALL
- Source Port Range: All
- Destination Port Range: ALL

22. Click **Create Security List**.

23. Next we will create three worker subnets and two load balancer subnets for Oracle Kubernetes Engine (OKE) implementation. In your VCN details page Click **Subnets**.

24. Click **Create Subnet**. Fill out the dialog box:


**Worker  Subnet # 1**
- Name: Enter a name 
- Subnet Type: Regional
- CIDR Block: 172.16.10.0/24
- Route Table: Select the Route Table you created earlier.
- Subnet access: Public Subnet
- DHCP Options: Select the default.
- Security Lists: Select the First Security List created earlier.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_004.PNG" alt="image-alt-text">

25. Leave all other options as default, Click **Create Subnet**.

26. Click **Create Subnet**. Fill out the dialog box:


**Worker  Subnet # 2**
- Name: Enter a name 
- Subnet Type: Regional
- CIDR Block: 172.16.11.0/24
- Route Table: Select the Route Table you created earlier.
- Subnet access: Public Subnet
- DHCP Options: Select the default.
- Security Lists: Select the First Security List created earlier.

27. Leave all other options as default, Click **Create Subnet**.

28. Click **Create Subnet**. Fill out the dialog box:


**Worker  Subnet # 3**
- Name: Enter a name 
- Subnet Type: Regional
- CIDR Block: 172.16.12.0/24
- Route Table: Select the Route Table you created earlier.
- Subnet access: Public Subnet
- DHCP Options: Select the default.
- Security Lists: Select the First Security List created earlier.

29. Leave all other options as default, Click **Create Subnet**.

30. Next we will create three load balancer. Click **Create Subnet**. Fill out the dialog box:


**Load Balancer Subnet # 1**
- Name: Enter a name 
- Subnet Type: Regional
- CIDR Block: 172.16.20.0/24
- Route Table: Select the Route Table you created earlier.
- Subnet access: Public Subnet
- DHCP Options: Select the default.
- Security Lists: Select the Second Security List created earlier.

31. Click **Create Subnet**

32. Click **Create Subnet**. Fill out the dialog box:


**Load Balancer Subnet # 2**
- Name: Enter a name 
- Subnet Type: Regional
- CIDR Block: 172.16.21.0/24
- Route Table: Select the Route Table you created earlier.
- Subnet access: Public Subnet
- DHCP Options: Select the default.
- Security Lists: Select the Second Security List created earlier.

33. Click **Create Subnet**

**We now have a Virtual Cloud Network with all the necessary resources and configuration needed for Oracle Kubernetes Engine (OKE) deployment. Next we will create Kubernetes Cluster**


## Install OCI CLI in your enivornment

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

## Create  Kubernetes Cluster

1. From OCI Services menu, Click **Container Clusters (OKE)** under Developer Services

2. Click **Create Cluster**. Fill out the dialog box

3. There is Quick Create option which will create all  neccessay resources including VCN. Since we created VCN seperately in this lab we  will choose Custom Create options as it shows different options available. Choose **Custom Create**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_002.PNG" alt="image-alt-text">

4. Fill out the dialog box:


- NAME: Provide a name (oke-cluster in this example)
- KUBERNETES VERSION: Choose the latest

**Under Network Selection**


- NETWORK COMPARTMENT: Choose your compartment
- VCN: Select the VCN created earlier (oke-vcn)
- KUBERNETES SERVICE LB SUBNETS: Select the two load balancer subnets (loadbalancer-1 and loadbalancer-2)
- KUBERNETES SERVICE CIDR BLOCK: 10.96.0.0/16
- PODS CIDR BLOCK: 10.244.0.0/16

**Under Additional Add ons**


- KUBERNETES DASHBOARD ENABLED: Make sure flag is checked
- TILLER (HELM) ENABLED: Make sure flag is checked

5. Click **Continue**

**Under Node Pool**


- NAME: Provide a name (oke-pool in this example)
- VERSION: Choose the latest
- IMAGE: Choose the latest
- SHAPE: Choose a VM shape
- SUBNETS: Select the three workers subnets created earlier (worker-1, worker-2 and worker-3) 
- QUANTITY PER SUBNET: 1
- PUBLIC SSH KEY: Copy the content of your SSH Public Key saved earlier (You can retrieve this again by **cat /C/Users/PhotonUser/.ssh/id_rsa.pub** in git bash window)


**Under Kubernetes Labels**


- Leave the fields as is

6. Click **Review** . Review the configuration and Click **Create**

7. Wait for Cluster status to change from **Creating** to **Active**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_003.PNG" alt="image-alt-text">

## Install Kubectl, OCI CLI and configure OCI CLI

In this section we will install kubectl. You can use the Kubernetes command line tool kubectl to perform operations on a cluster you've created with Container Engine for Kubernetes.

1. Switch to git-bash window, Enter commands:
```
mkdir -p $HOME/.kube 
```
```
cd $HOME/.kube
```
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_004.PNG" alt="image-alt-text">

2.  Wait for download to complete. Enter command 
```
ls
```
 and verify kubectl.exe file exists.

## Download get-kubeconfig.sh file and Initialize your environment

1. Switch to OCI console window and navigate to your cluster. In Cluster detail window Click **Access Kubeconfig**. Copy the 2nd command and enviornement variable command to notepad (using Built in Application)
            
**NOTE:** Since we already created .kube directory we dont need toexecute the first command 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_005.PNG" alt="image-alt-text">

2. Switch to git bash window and Enter the commands copied. Ensure the command is entered on a single line Ignore any errors related to Power shell.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_006.PNG" alt="image-alt-text">

3. Enter command ls and verify a file named **config** exists.

We have initialized the enviornment.

## Starting the Kubernetes Dashboard

In this section we will start Kubernetes Dashboard which is
a web-based user interface that you can use as an alternative
to the Kubernetes kubectl command line tool

1. Switch to OCI Console window. From services menu, Click **Container Clusters(OKE)** under **Developer services**.

2. Click your cluster name and verify Compute Node State shows active for all compute nodes

3. Click **Getting Started** and Copy the URL under Getting Started

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_007.PNG" alt="image-alt-text">

4. Switch to Git bash window, Enter Command:
```
./kubectl proxy and verify the service started.
```

5. Open a new browser tab and paste the URL copied earlier.

6. This will open Kubernetes dash board. 

7. Ensure Kubeconfig is selected, Click Action icon and browse to the location where config file is stored loclaly (/C/Users/Photonuser/.kube). This is being done for Authentication purposes.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_008.PNG" alt="image-alt-text">

8. Kubernetes dash board should be displayed. Click **Overview** to see the applications deployed on the cluster

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OKE/img/OKE_009.PNG" alt="image-alt-text">

**We now have successfully accessed the Kubernetes Dash board**

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
