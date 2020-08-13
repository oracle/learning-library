# Provision Kubernetes Using the OCI Console

## Before You Begin
### Objectives
- Sign in to Oracle Cloud Infrastructure
- Create a Compartment for your Kubernetes nodes
- Add a Policy Statement for OKE
- Provision Kubernetes Using the OCI Console
- Launch a Cloud Compute Instance for Cluster Management
- Prepare OCI CLI for Cluster Access and Download kubeconfig
- Install and Test kubectl on Your Local Machine

### Requirements
To complete this lab, you need to have the following:
- Login credentials and a tenancy name for the Oracle Cloud Infrastructure Console


## **STEP 1**: Sign in to Oracle Cloud Infrastructure

- From any browser go to:

    [https://cloud.oracle.com/en_US/sign-in](https://cloud.oracle.com/en_US/sign-in)

- Enter your **Cloud Account Name** in the input field and click the **My Services** button. If you have a trial account, this can be found in your welcome email. Otherwise, this will be supplied by your workshop instructor.

  ![](images/200/1.png)

- Enter your **Username** and **Password** in the input fields and click **Sign In**. If you have a trial account, these can be found in your welcome email. Otherwise, these will be supplied by your workshop instructor.

  ![](images/200/2.png)

- You are presented with the Oracle Cloud Infrastructure (OCI) Dashboard/Portal

  ![](images/200/image4a.png)

## **STEP 2**: Create a Compartment for your Kubernetes nodes

Compartments are used to isolate resources within your OCI tenant. Role-based access policies can be applied to manage access to compute instances and other resources within a Compartment.

- Click the **hamburger icon** in the upper left corner to open the navigation menu. Under the **Identity** section of the menu, click **Compartments**

  ![](images/200/LabGuide200-c32a35b9.png)

  - If you have a **Demo** compartment already, _**SKIP THIS STEP**_. Otherwise, Click **Create Compartment**

    ![](images/200/7.png)

  - In the **Name** field, enter `Demo`. Enter a description of your choice. In the **Parent Compartment** field, ensure that the `root` compartment is selected (it will have the same name as your Oracle Cloud Account). Click **Create Compartment**.

    ![](images/LabGuide200-2b3b6b30.png)

## **STEP 3**: Add a Policy Statement for OKE

  - Before the Oracle managed Kubernetes service can create compute instances in your OCI tenancy, we must explicitly give it permission to do so using a policy statement. From the OCI Console navigation menu, choose **Identity->Policies**.

    ![](images/200/LabGuide200-13c980fa.png)

  - In the Compartment drop down menu on the left side, choose the **root compartment**. It will have the same name as your OCI tenancy (Cloud Account Name).

    ![](images/200/LabGuide200-a321171a.png)

  - Click **PSM-root-policy**

    ![](images/200/LabGuide200-e67b7705.png)

  - Click the **Add Policy Statement** button

    ![](images/200/LabGuide200-3d4a7471.png)

  - In the Statement box, enter: `allow service OKE to manage all-resources in tenancy` and click **Add Statement**

    ![](images/200/LabGuide200-bd5bcbd1.png)

## **STEP 4**: Provision Kubernetes Using the OCI Console

  - Now we're ready to create our Kubernetes cluster. From the OCI Console navigation menu, select **Developer Services->Container Clusters (OKE)**.

    ![](images/200/LabGuide200-5c0a2b4c.png)

  - In the Compartments drop down, select the **Demo** compartment.

    ![](images/200/LabGuide200-4071818d.png)

  - Select Quick Create and Click Launch Workflow.

     ![](images/launch-workflow-oke.png " ")

  - Choose visibility type as Public, enable all Add Ons including Kubernetes Dashboard Enabled and Tiler (Helm) enabled, and Click **Next**.
   
    ![](images/cluster-creating-oke-1.png " ")

  - Review Cluster Creation and Click **Create Cluster**.
  
    ![](images/cluster-creating-oke-2.png " ")
  
  - Wait for creating cluster and associated network resources and Click **Close**.
  
    ![](images/cluster-creating-oke-3.png " ")

  **Note:**
    - Starting at the top you will notice that the cluster will be created in our **Demo** compartment.
    - We can customize the name of this cluster if we want
    - Multiple versions of Kubernetes are available, with the newest version selected by default
    - The default cluster creation mode will automatically create a Virtual Cloud Network for our cluster, including 2 load balancer subnets and 3 subnets for our worker VMs
    - We can customize the size and quantity of worker VMs in the node pool; by default we will get 3x 1 OCPU VMs, one in each Availability Domain.
    - We can also add more node pools to the cluster after creation.
    - The dashboard and Tiller will be installed by default.


## **STEP 5**: Launch a Cloud Compute Instance for Cluster Management

  - Before we can launch a compute instance, we need two things: a Virtual Cloud Network to connect it to, and an SSH key pair to use for authentication. We could create a new VCN, but since the cluster wizard is already going to create one, we will just make use of that. So let's work on creating an SSH key pair for our instance. The method of generating an SSH key pair will depend on your operating system.

    **NOTE**: There are several files that will be downloaded or created on your local machine during this workshop. We recommend creating a directory to store them in for ease of locating and cleaning up. In this step, you will create a directory inside your home/user directory called `container-workshop`. You are free to change the location and name of this directory, but the lab guide will assume it is located at `~/container-workshop/`. **You will need to modify the given terminal commands throughout this lab** if you change the location or name of the directory.

    **Mac/Linux**:

      - Open a terminal or shell window and run the following commands:

        ```bash
        cd ~
        mkdir container-workshop && cd container-workshop && mkdir ssh-keys && cd ssh-keys
        ssh-keygen -f ./ssh-key -N ""
        ```
        ![](images/200/LabGuide200-a5328c9e.png)

    **Windows**:

      - If you don't already have them, download PuTTY and PuTTYgen from [http://www.putty.org/](http://www.putty.org/)

        ![](images/200/LabGuide200-395eff32.png)
        ![](images/200/LabGuide200-e2207b4c.png)

      - Locate and run **puttygen.exe** in the PuTTY install folder.

      - Ensure that **RSA** or **SSH-2 RSA** is selected in the `Type of key to generate` field (which one you see is dependent on your version of PuTTY)

      ![](images/LabGuide200-614f9c26.png)

      ![](images/LabGuide200-f0a8b7ba.png)

      - Click **Generate**

        ![](images/200/LabGuide200-4c048053.png)

      - **Move your mouse around the blank area** as instructed to genereate random data.

        ![](images/200/LabGuide200-eb2e6690.png)

      - Click **Save private key** and then click **Yes** to continue saving without a passphrase.

        ![](images/200/LabGuide200-2f7bb25a.png)

        - In the save dialog box:
          - Navigate to your home directory/user folder (usually **C:\Users\\<username\>**).
          - Click **New Folder** and name the folder `container-workshop`.

            ![](images/200/LabGuide200-b203da00.png)
          - **Double-click** the `container-workshop` folder to enter it.
          - Click **New Folder** again. This time name the folder `ssh-keys`.

            ![](images/200/LabGuide200-af71f041.png)
          - **Double click** on `ssh-keys` to enter that folder.
          - Finally, name the key **ssh-key.ppk** and click **Save**.

            ![](images/200/LabGuide200-0f4dd743.png)

      - Select and copy the **public key** using Control-C, which is displayed in the `Public key for pasting into OpenSSH authorized_keys file` region. Paste it into a **new text file** using **notepad** and save the file in the `C:\Users\username\container-workshop\ssh-keys` folder.

        **NOTE**: Do not use the Save public key button, as it uses an incompatible key format.

        ![](images/200/LabGuide200-dfe10559.png)
        ![](images/200/LabGuide200-81767c01.png)

      - When you SSH to your instance in a later step, use PuTTY to connect instead of a command-line ssh session.

  - With the keys generated, we are ready to launch an instance. From the OCI Console navigation menu, select **Compute->Instances**. Ensure you are still working in the **Demo** compartment using the drop down list in the left pane.

    ![](images/200/LabGuide200-bdda7d5d.png)

  - Click the **Create Instance** button.

    ![](images/200/LabGuide200-071f038f.png)

  - Click **Show Shape, Network and Storage Options**

  - Choose the Availability Domain as AD1, Change Image Source as Oracle Developer Image, and Instance Type settings at the defaults.

    ![](images/LabGuide200-026d5a7f.png)

    ![](images/select-oracle-cloud-image.png " ")

  - In the Instance Shape field, click **Change Shape**. 

    ![](images/change-shapes-select.png " ")

  - In the Browse All Shapes pane, check the box next to **VM.Standard2.1** and click **Select Shape**.

    ![](images/change-shapes.png " ")

  - In the Add SSH Key area, click **Choose Files** and select the **ssh public key** you generated at the beginning of this step (e.g. `~/container-workshop/ssh-keys/ssh-key.pub`).

    ![](images/LabGuide200-4b3f9759.png)

  - Make the following selections in the **Configure Networking** form:
    - In the VCN Compartment field, ensure **Demo** is selected.
    - In the VCN field, ensure **oke-vcn-quick-cluster1** is selected (if you changed the name of your cluster, the `cluster1` portion of these name will differ).
    - In the Subnet Compartment field, ensure **Demo** is selected.
    - In the Subnet field, select the subnet that begins with **oke-subnet-quick-cluster1**. Take care __not__ to select the subnet that begins with oke-svclbsubnet, as this one has a wide open security list (it is meant only for load balancers).  

    ![](images/LabGuide200-e67f88fa.png)

  - Click **Create**

    ![](images/LabGuide200-68185e86.png)

  - You will be brought to the instance details page. Wait for your instance to transition from the Provisioning state to the **Running** state before proceeding.

    ![](images/instance-running.png " ")

## **STEP 6**: Prepare OCI CLI for Cluster Access and Download kubeconfig

  - Your instance should now be in the **Running** state. Let's SSH into the instance and install the command line utility that will let us interact with our cluster. Still on the instance details page, find the **Public IP Address** and copy it to the clipboard.
  
    ![](images/200/LabGuide200-3986ce91.png " ")

  - Open an SSH connection to the instance using the following OS-specific method:

    **Mac/Linux**
      - Open a terminal or shell window
      - Run the following commands, pasting in the **Public IP Address** from your clipboard in place of <Public IP Address>

        ```
        cd ~/container-workshop/ssh-keys/
        ssh -i ssh-key opc@<Public IP Address>
        ```
      - Type **yes** and **press enter** when asked if you want to continue connecting

        ![](images/200/LabGuide200-edc8f079.png)

    **Windows**
      - Open PuTTY
      - In the Category pane, select Session and enter the following:
        - Host Name (or IP address): **opc@[Public IP Address you copied to the clipboard]**
        - Connection type: SSH
        - Port: 22
      - In the Category pane, expand Connection, expand SSH, and then click **Auth**. Click **Browse** and select your private key (for example, **C:\Users\\<username\>\container-workshop\ssh-keys\ssh-key.ppk**).
      - Click **Open** to start the session.

  - From _inside the SSH session_, run the following command to install the OCI CLI, which will allow you to interact with your cluster:

    `bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"`

    ![](images/200/LabGuide200-41638e46.png)

  - For each of the prompts, accept the default by **pressing enter**

    ![](images/200/LabGuide200-dd2c64cd.png)

  - When the install is finished, configure the OCI CLI by running `oci setup config` in your SSH session. In a web browser on your local machine, open your **User Settings** page: use the navigation menu to go to Identity->Users and select **View User Details** from the three-dots menu for your user. You will need some details from this page to complete the setup.

    ![](images/LabGuide200-f1749ef3.png)

  - After initiating `oci setup config`, respond to the prompts as follows:
    - Enter a location for your config: **accept default by pressing enter**
    - Enter a user OCID: copy your OCID by clicking **Copy** in the **User Information** box in OCI Console
    - Enter a tenancy OCID: copy the **Tenancy OCID** from the tenancy details page (found under the administration section of the OCI navigation menu)

      ![](images/tenancy-detail.png " ")

    - Enter a region: type the **region shown in the upper right** corner of OCI Console
    - Do you want to generate a new RSA key pair?: **Y**
    - Enter a directory for your keys to be created: **accept default by pressing enter**
    - Enter a name for your key: **accept default by pressing enter**
    - Enter a passphrase for your private key: **accept default by pressing enter**

    ![](images/200/LabGuide200-315d446f.png)

  - You've just generated an RSA key pair that we will use to authenticate you to the OCI API. Click **back** to get back to the User Settings page in your browser, click **Add Public Key**

    ![](images/200/LabGuide200-70626501.png)

  - We need to copy and paste the public key into this box. In your _SSH session_, run the following command to output the public key:

    `cat /home/opc/.oci/oci_api_key_public.pem`

    ![](images/200/LabGuide200-6cead97f.png)

  - Select the entire key, beginning with: `-----BEGIN PUBLIC KEY-----` and ending with `-----END PUBLIC KEY-----`. **Copy it** and **paste it** into the Public Key text area in the OCI Console Add Public Key dialog. Then click **Add**.

    ![](images/200/LabGuide200-cc48303b.png)

  - You are now ready to download the `kubeconfig` file using the OCI CLI that you just installed. From the OCI Console navigation menu, select **Developer Services->Container Clusters (OKE)**, then click the name of your cluster, **cluster1**

    ![](images/200/LabGuide200-5c0a2b4c.png)

    ![](images/LabGuide200-931bae7f.png)

  - Click **Access Kubeconfig**.

    ![](images/LabGuide200-2adad8f0.png)

  - Two commands are displayed in the dialog box. **Copy and paste** each command (one at a time) into your _SSH session_ and run them. The first creates a directory to store the `kubeconfig` file, and the second invokes the OCI CLI to download and store the `kubeconfig` file on your client virtual machine. Then click **Close**.

    ![](images/200/LabGuide200-0c484a65.png)

    ![](images/200/LabGuide200-36da5eac.png)

    ![](images/200/LabGuide200-2596f69d.png)

    **NOTE**: Copy and paste the commands from the OCI Console window -- the second command below is personalized with your cluster OCID. They are listed here for reference only.

    >mkdir -p $HOME/.kube

    >oci ce cluster create-kubeconfig --cluster-id <your-kubernetes-cluster-ocid\> --file $HOME/.kube/config

  - Your `kubeconfig` file was downloaded from OCI and stored in ~/.kube/config. In your _SSH session_, **run** `cat ~/.kube/config` to output the contents of the file. **Copy** the contents and **paste** them into a new text file on your local machine. Name the file `kubeconfig` and **Save** the file to your **container-workshop directory** (e.g. `~/container-workshop/` or `C:\Users\<username>\container-workshop\`)

    **NOTE**: Save the `kubeconfig` file as a plain text file, not as a .docx, .rtf, .html, etc.

    ![](images/200/LabGuide200-8d14ba10.png)

  - In order to interact with your cluster and view the dashboard, you will need to install the Kubernetes command line interface, `kubectl`. We will do that next.

  - To set your KUBECONFIG environment variable to the file for this cluster, use:

    `$ export KUBECONFIG=$HOME/.kube/config`

## **STEP 7**: Install and Test kubectl on your Virtual Machine

- The method you choose to install `kubectl`. 
  
    ```bash
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    ```

 - To set your KUBECONFIG environment variable to the file for this cluster, use:

    `$ export KUBECONFIG=$HOME/.kube/config`

- In your Virtual Machine terminal window , run the following commands to verify that `kubectl` is able to communicate with your cluster. You should see `cluster-info` print out the URL of the Kubernetes Master node and `get nodes` print out the IP address and status of each of the worker nodes.

    ```bash
    export KUBECONFIG=~/container-workshop/kubeconfig
    ./kubectl cluster-info
    ./kubectl get nodes
    ```

    ![](images/LabGuide200-397f4902.png)

    ![](images/200/kubctlnodes.png)

- Great! We've got Kubernetes installed and accessible.


