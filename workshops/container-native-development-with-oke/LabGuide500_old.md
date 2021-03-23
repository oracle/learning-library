![](images/500/header.png)  

## Introduction

This is the fifth lab that is part of the **Oracle Public Cloud Container Native Development workshop.** This workshop will walk you through the process of moving an existing application into a containerized CI/CD pipeline and deploying it to a Kubernetes cluster in the Oracle Public Cloud.

You will take on 2 personas during the workshop. The **Lead Developer Persona** will be responsible for configuring the parts of the automated build and deploy process that involve details about the application itself. The **DevOps Engineer Persona** will configure the parts of the automation involving the Kubernetes infrastructure. To containerize and automate the building and deploying of this application you will make use of Wercker Pipelines for CI/CD, OCI Registry for a container registry, and OCI Container Engine for Kubernetes for provisioning a Kubernetes cluster on Oracle Cloud Infrastructure.

During this lab, you will take on the **Lead Developer Persona** and extend your application using a serverless function. You will install an Fn Server on your Kubernetes cluster, download your function code from GitHub, try out your function locally, deploy your function to the Fn Server on Kubernetes, and test it in the product catalog application.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
## Objectives

**Extend Your Application Using a Function**

- Run Your Function Locally
  - Install Fn Server on Your Virtual Machine
  - Clone the Function Repository
  - Deploy the Function Locally
  - Test the Function Using curl
- Deploy Your Function to Fn on Kubernetes
  - Deploy Fn Server to Kubernetes
  - Deploy Your Function to Fn Server on Kubernetes
  - Test Your Function in the Product Catalog

## Required Artifacts
- The following lab requires:
  - an Oracle Cloud Trial Account
  - a [GitHub account](https://github.com/join)

# Extend Your Application Using a Function

## Provision VM

### **STEP 1**: Launch a Cloud Compute Instance for Cluster Management

  - Before we can launch a compute instance, we need two things: a Virtual Cloud Network to connect it to, and an SSH key pair to use for authentication. We could create a new VCN, but since the cluster wizard is already going to create one, we will just make use of that. So let's work on creating an SSH key pair for our instance. The method of generating an SSH key pair will depend on your operating system.

    **Mac/Linux**:

      - Open a terminal or shell window and run the following commands:

        ```bash
        <copy>
        cd container-workshop && mkdir ssh-keys && cd ssh-keys
        ssh-keygen -f ./ssh-key -N ""
        </copy>
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

  - Leave the Availability Domain, Image Source, and Instance Type settings at the defaults.

    ![](images/LabGuide200-026d5a7f.png)

  - In the Instance Shape field, click **Change Shape**. We will use a 2-OCPU VM, since we are using all of our available 1-OCPU VMs for Kubernetes worker nodes.

    ![](images/LabGuide200-e8686157.png)

  - In the Browse All Shapes pane, check the box next to **VM.Standard2.2** and click **Select Shape**.

    ![](images/LabGuide200-e02b046c.png)

  - In the Add SSH Key area, click **Choose Files** and select the **ssh public key** you generated at the beginning of this step (e.g. `~/container-workshop/ssh-keys/ssh-key.pub`).

    ![](images/LabGuide200-4b3f9759.png)

  - Make the following selections in the **Configure Networking** form:
    - In the VCN Compartment field, ensure **Demo** is selected.
    - In the VCN field, ensure **oke-vcn-quick-cluster1** is selected (if you changed the name of your cluster, the `cluster1` portion of these name will differ).
    - In the Subnet Compartment field, ensure **Demo** is selected.
    - In the Subnet field, select the subnet that begins with **oke-svclbsubnet-quick-cluster1**, which is in the **Public Subnets** section. Take care __not__ to select the subnet that begins with oke-subnet, as this one is a private subnet (not accessible from the internet).

    ![](images/LabGuide200-e67f88fa.png)

  - Make sure to select **Assign a public IP address**

    ![](images/200/LabGuide-instance-1.png)
  
  - Click **Create**

    ![](images/LabGuide200-68185e86.png)

  - You will be brought to the instance details page. Wait for your instance to transition from the Provisioning state to the **Running** state before proceeding.

    ![](images/LabGuide200-585fa5fe.png)

### **STEP 2**: SSH into your Compute instance 

  - Your instance should now be in the **Running** state. Let's SSH into the instance and install the command line utility that will let us interact with our cluster. Still on the instance details page, find the **Public IP Address** and copy it to the clipboard.
    ![](images/200/LabGuide200-3986ce91.png)

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

## Run Your Function Locally

### **STEP 3**: Install Fn Server on Your Virtual Machine

- We are going to use the virtual machine that you created in OCI as our local or development machine for Fn. Return to your **SSH session** either in PuTTY or your terminal window. If you have closed it, start a new one using the same method as you did in Lab 200 (e.g. `cd ~/container-workshop/ssh-keys; ssh -i ssh-key opc@<IP-Address-of-Your-VM>`);

  ![](images/500/LabGuide500-448b9fdc.png)

- From this point forward, all command line instructions should be run _inside your SSH session_, not in a command prompt/shell on your local machine. Switch to the `root` user in your SSH session and install the prerequisite packages (and a few extras) by running:

  ```bash
  sudo yum -y install docker-engine kubectl git caca-utils
  ```

  **NOTE**: Docker and kubectl are prerequisites of Fn. Git and caca-utils are used in this lab for downloading repositories from GitHub and displaying images in the terminal, respectively.

- Start Docker by running:

  ```bash
  sudo systemctl start docker
  ```

- **Add your user** to the Docker user's group by running:

  ```bash
  sudo usermod -aG docker $USER
  ```

- **Exit your SSH session** to have your group membership reevaluated:

  ```bash
  exit
  ```

- **Reestablish your SSH session** using the same command or method you used in the first instruction of this step.

  ```bash
  cd ~/container-workshop/ssh-keys; ssh -i ssh-key opc@<IP-Address-of-Your-VM>
  ```

- Now we're ready to install the Fn CLI onto our VM. Run:

  ```bash
  curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh
  ```

- Great, that was easy. Let's start a local Fn Server in the background that we can use for development. From a terminal, run:

  ```bash
  fn start --detach
  ```

  ![](images/LabGuide500-0c08a0fb.png)

- Verify that the server is running by checking the version. If a `Server version` is displayed, then the server is running and accessible.

  ```bash
  fn version
  ```

  ![](images/LabGuide500-e7511b95.png)

- Let's test the Fn server's HTTP response. Run the following to see if we get the expected 'Hello: World' response from Fn:

  ```bash
  curl localhost:8080
  ```

  ![](images/500/LabGuide500-8a6ed056.png)

- Looks good, let's move on to creating our first function.

### **STEP 4**: Clone the Function Repository

- Now we're ready to get a copy of the image resizing function and test it out on our local Fn Server. Clone the Git repository into your home directory using the following command.

  ```bash
  cd ~ && git clone https://github.com/derekoneil/image-resize.git && cd image-resize
  ```

  ![](images/500/10.png)

**NOTE**: Functions deployed to Fn are packaged in Docker containers. You can use any programming language to write your functions, and you can deploy them to any Fn Server -- local, running on your server, or hosted in the cloud. The function you just cloned actually involves no code at all, it is simply a Dockerfile that installs and executes the open source command line tool ImageMagick. Using functions like this is a quick and easy way to convert open source or command line tools to auto-scaling web services.

### **STEP 5**: Deploy the Function Locally

- Now that you have the function 'code', you can deploy it to the local Fn Server you started earlier by running the following commands in your terminal window:

  ```bash
  fn deploy --create-app --app imgconvert --local
  ```

  **NOTE**: The `--app imgconvert` tells Fn to create a new application named imgconvert and associate this function with it. In general, the application can be named anything you like, but by default the name will show up in the function URL. Since the product catalog application is expecting the app to be named `imgconvert`, don't alter the name.

  ![](images/500/11.png)

### **STEP 6**: Test the Function Using curl

- Before we can test our function, we must disable SELinux, as it interferes with the ability of Fn to run containers. Run these commands to **disable SELinux**

  ```bash
  sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
  sudo setenforce 0
  ```

- With the function deployed to our local Fn Server, we can use **curl** to test it. Execute the following command while still in the image-resize directory:

  ```bash
  curl -X POST --data-binary @"sample-image.jpg" -H "Content-Type: application/octet-stream" http://localhost:8080/t/imgconvert/resize128 > thumbnail.jpg
  ```

  ![](images/500/12.png)

- Since we are not using a graphical desktop, you may be wondering how we can make sure the returned image is really a valid image file at all. In the beginning of this lab you installed a package called `caca-utils`. Let's see what it can do:

  ```bash
  cacaview thumbnail.jpg
  ```

  ![](images/500/LabGuide500-e9dcb79c.png)

- Looks like an image alright! **Press q** to quit the viewer. Now that we've tested our function locally, it's time to set up a remote Fn Server on Kubernetes and deploy our function to the cloud.

## Deploy Your Function to Fn on Kubernetes

### **STEP 7**: Deploy Fn Server to Kubernetes

- We are going to use the Kubernetes Dashboard **Create An App** wizard to deploy Fn to Kubernetes. This is suitable for a test environment, but does not account for production best practices. For a production deployment, consider using [Helm](https://github.com/kubernetes/helm#install) and the [fn-helm chart](https://github.com/fnproject/fn-helm) to bring up your Fn Server.

- Log in to the [Kubernetes Dashboard](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/) from your local machine. If you have stopped it, restart `kubectl proxy`.

- Click the **Create** button

  ![](images/LabGuide500-76fe5ae1.png)

- Click the **Create An App** tab -- this gives us the form-based deployment and service creation page, rather than the pre-written yaml options.

  ![](images/LabGuide500-b020b936.png)

- Fill out the form with the following values. Then click **Show Advanced Options**

  - App name: **my-release-fn-api** (this name must match the URL that our Product Catalog application is looking for)
  - Container image: **fnproject/fnserver** (this is the official Fn Project Fn Server image)
  - Number of Pods: **1** (this can be customized)
  - Service: **External** (this will create a load balancer for our service)
  - Port: **80** (this must match the port that the Product Catalog will try to access)
  - Target Port: **8080** (this is the port that Fn is listening on inside its container)
  - Click **Show Advanced Options**

  ![](images/LabGuide500-060803f8.png)

- In the Advanced Options section, check the box for **Run as privileged**, then click **Deploy**

  ![](images/LabGuide500-f0380bee.png)

- On the Overview page, you will see your **new Deployment** being created:

  ![](images/LabGuide500-c4797741.png)

- We also expect a **Service** of type **Load Balancer** to be created. **Scroll down** to the **Services** table to check.

  ![](images/LabGuide500-bd521027.png)

- Click on the service name, **my-release-fn-api**. Look for the **External endpoints** field. If it is filled in with an IP address and port, your load balancer is finished provisioning. If it is not, wait a moment and refresh this page.

  ![](images/LabGuide500-fd6b90bf.png)

- We need this load balancer URL to set an environment variable that points your local Fn installation to the Fn Server we've deployed to the Kubernetes cluster. Right click the link and choose **Copy Link Location** to store it in your clipboard.

  ![](images/LabGuide500-7aa1aea2.png)

- In your _SSH session_ to your cloud VM, create an environment variable called `FN_API_URL`:

  ```bash
  export FN_API_URL=<Paste-URL-From-Clipboard>
  ```

  - **NOTE**: You can alternatively get the load balancer IP address from `kubectl`, which is useful for scripting and automation:  `export FN_API_URL=http://$(kubectl get svc --namespace default my-release-fn-api -o jsonpath='{.status.loadBalancer.ingress[0].ip}'):38080/`

  - Verify that the environment variable was set correctly by running the following command. Note that your IP address will differ from the screenshot. Ensure that your URL contains a **trailing forward slash**.

    `echo $FN_API_URL`

    ![](images/LabGuide500-aab88037.png)

### **STEP 8**: Deploy Your Function to Fn Server on Kubernetes

- In your _SSH session_, change directories to cloned function directory from **STEP 2**.

  ```bash
  cd ~/image-resize
  ```

  ![](images/500/LabGuide500-8c45e01e.png)

- Since we are pushing to a remote Fn Server, Fn will use Oracle's Docker registry, OCIR, as the container registry. We need to set the FN_REGISTRY environment variable to tell Fn which Docker Hub user to push to. In the following command, **replace `iad` with your OCI region** and **replace `<your-tenancy-name>`** with the name of your Oracle Cloud tenancy, found under the User menu in the OCI Console:

  ![](images/500/LabGuide500-e51e6a21.png)

  ```bash
  export FN_REGISTRY=iad.ocir.io/<your-tenancy-name>
  ```

  ![](images/500/LabGuide500-21bab048.png)

  **NOTE**: As you did in Lab 200, replace `iad` in the preceding URL with the correct abbreviation for your OCI region:

  ```
  London = lhr
  Frankfurt = fra
  Phoenix = phx
  Ashburn = iad
  ```

- In order to push our function Docker image into our OCI Registry, we will need to log in using the Docker CLI. The password we use to authenticate is an **OCI Auth Token**, just as we created for Wercker in Lab 200. Navigate to the **OCI Console** in a web browser on your local machine. Open your **User Settings** page by using the navigation menu to go to Identity->Users and select **View User Details** from the three-dots menu for your user.

  ![](images/LabGuide200-f1749ef3.png)

- In the Resources menu of the user settings page, click **Auth Tokens**. Then click **Generate Token**.

  ![](images/200/LabGuide200-8b775cc2.png)

  ![](images/200/LabGuide200-ae59e875.png)

- In the Description field, enter **Docker** and click **Generate Token**.

  ![](images/500/LabGuide500-dd88e19e.png)

- The token is displayed in the dialog box. Leave it open, you will copy it in the next instruction.

    ![](images/500/LabGuide500-68cfd98c.png)

- In your _SSH session_, run the following command, **substituting your OCI tenancy name and your Oracle Cloud username (probably your email address)** for `<your-tenancy-name> and <your-oracle-cloud-username>`, and  **replacing `iad` with your OCI region** :

  ```bash
  docker login -u <your-tenancy-name>/<your-oracle-cloud-username> iad.ocir.io
  ```

  **NOTE**: As you did in Lab 200, replace `iad` in the preceding URL with the correct abbreviation for your OCI region:

  ```
  London = lhr
  Frankfurt = fra
  Phoenix = phx
  Ashburn = iad
  ```

- You will be prompted for your registry password. Click the **Copy** link from the OCI Console browser window displaying your newly-generated Auth Token. Then **paste** the token into the password prompt in your SSH session and press enter.

  ![](images/500/LabGuide500-3ec3a74a.png)

- Now we're ready to **Deploy the function** (and application) to the remote Fn Server using the same command you used in **STEP 3**, but without the --local flag.

  ```bash
  fn deploy --create-app --app imgconvert
  ```

  ![](images/500/19.png)

- Now the function has been pushed to our _Private_ Docker repository in OCIR (since new repositories are private by default in OCIR). We could provide our Auth Token to the Fn Server running in Kubernetes to allow it to pull our image, but let's instead make our OCIR repository public, so that it can be pulled without authentication. Open the **OCI Console** website in a browser _on your local machine_. From the Developer Services section of the navigation menu, choose **Registry (OCIR)**

  ![](images/LabGuide500-fc970891.png)

- Click on **resize128**, the name of our function and our Docker repository

  ![](images/LabGuide500-696c3bde.png)

- From the Actions drop down, click **Change to Public**

  ![](images/LabGuide500-0b787344.png)

- Now, back in the _SSH session_, test the function using **curl**, but this time using the URL of the remote Fn Server:

  ```bash
  curl -X POST --data-binary @"sample-image.jpg" -H "Content-Type: application/octet-stream" ${FN_API_URL}t/imgconvert/resize128 > thumbnail-remote.jpg
  ```

  ![](images/500/20.png)

- Open **thumbnail-remote.jpg** (using the same method you used in the local test) to verify the function was successful (and then **press q** to exit the viewer):

  ```bash
  cacaview thumbnail-remote.jpg
  ```

  ![](images/500/LabGuide500-e9dcb79c.png)

- Our function is deployed and available on our remote Fn Server, which is running in our Kubernetes cluster. The last thing to verify is that the product catalog application is able to find and use our function. Let's test out the upload image feature.

### **STEP 9**: Test Your Function in the Product Catalog

- Open the **product catalog** website in a browser _on your local machine_. If you don't have the URL, you can look in the Kubernetes dashboard for the **external endpoint** of the product-catalog-service, or you can run the following command from your SSH session:

  ```bash
  echo http://$(kubectl get svc --namespace default product-catalog-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}'):$(kubectl get svc --namespace default product-catalog-service -o jsonpath='{.spec.ports[0].port}')
  ```

  ![](images/500/22.png)

- Click any of the **product images** to open the detail view.

  ![](images/500/23.png)

- In the **Upload an image** pane, click **Choose file**. Select any JPG or PNG image from your machine (or [load the sample image](https://github.com/derekoneil/image-resize/raw/master/sample-image.jpg), right click, and choose 'Save Image As' first) and click **open**.

  ![](images/500/24.png)

- You'll see a loading spinner in the upload pane while your browser uploads the full size image to the product catalog server. The product catalog server invokes your function (resolved using Kubernetes DNS service at the URL `http://my-release-fn-api/t/imgconvert/resize128`). The thumbnail is returned to the product catalog server, which passes it back to your browser to be displayed. If everything worked correctly, you will see the generated thumbnail displayed in the upload pane.

  ![](images/500/25.png)

- Congratulations! You've just used the Fn Project to create and deploy a new serverless function to extend your application!

**You have completed the Container Native Application Development Workshop**
