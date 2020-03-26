
# Docker Workshop - Trial Account Set Up

![](images/050Linux/Title050.png)

## Overview

What is Docker? What is a container?

- Docker is the company and containerization technology.
- [Docker Documentation](https://docs.docker.com)
- A container is a runtime instance of a docker image: [Container Documentation](https://docs.docker.com/glossary/?term=container)

Containers have been around for many years. Docker created a technology that was usable by mere humans, and was much easier to understand than before. Thus, has enjoyed a tremendous amount of support for creating a technology for packaging applications to be portable and lightweight.

### VM vs Container

![](images/050Linux/Picture025-1.png)

While containers may sound like a virtual machine (VM), the two are distinct technologies. With VMs each virtual machine includes the application, the necessary binaries and libraries and the entire guest operating system.

Whereas, Containers include the application, all of its dependencies, but share the kernel with other containers and are not tied to any specific infrastructure, other than having the Docker engine installed on it’s host – allowing containers to run on almost any computer, infrastructure and cloud.

**Note:** At this time, Windows and Linux containers require that they run on their respective kernel base, therefore, Windows containers cannot run on Linux hosts and vice versa.

## Introduction
In this lab we will obtain an Oracle Cloud Trial Account, create ssh key pairs, login into your Trial, create a VCN (Virtual Compute Network) and Compartment, create a new compute instance and finally install docker into the instance.

***To log issues***, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Objectives

- Obtain an Oracle Cloud Trial Account
- Create the baseline infrastructure to support a Compute instance
- Create a SSH key pair
- SSH into the instance: Install Docker and GIT

## Required Artifacts

- If running from Windows: [Putty and PuttyGen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

# Log into  your Trial Account and Create Infrastructure

You will create all required infrastructure components within your Trail account.

## Your Trial Account

### **Step 1**: Your Oracle Cloud Trial Account

- You have already applied for and received you're Oracle Cloud Trial Account and will change the default password...


### **STEP 2**: Log in to your OCI dashboard

- Once you receive the **Get Started with Oracle Cloud** Email, make note of your **Username, Password and Cloud Account Name**.

  ![](images/050Linux/0.1.png)

- From any browser go to. :

    [https://cloud.oracle.com/en_US/sign-in](https://cloud.oracle.com/en_US/sign-in)

- Enter your **Cloud Account Name** in the input field and click the **My Services** button. If you have a trial account, this can be found in your welcome email. Otherwise, this will be supplied by your workshop instructor.

  ![](images/050Linux/1.png)

- Enter your **Username** and **Password** in the input fields and click **Sign In**.

  ![](images/050Linux/2.png)

  **NOTE**: You may (probably) will be prompted to change the temporary password listed in the welcome email. In that case, enter the new password in the password field.

- In the top left corner of the dashboard, click the **hamburger menu** and click **Compute**.

  ![](images/050Linux/3.png)

### **STEP 3**: Create a Compartment

Compartments are used to isolate resources within your OCI tenant. User-based access policies can be applied to manage access to compute instances and other resources within a Compartment.

- Click the **hamburger icon** in the upper left corner to open the navigation menu. Under the **Identity** section of the menu, click **Compartments**

  ![](images/050Linux/69.png)

  ![](images/050Linux/70.png)

- Click **Create Compartment**

  ![](images/050Linux/7.png)

- In the **Name** field, enter any name you want. For this example we will be using the name `Demo` going forward. Enter a **Description** of your choice. Click **Create Compartment**.

  ![](images/050Linux/8.png)

- In a moment, your new Compartment will show up in the list.

  ![](images/050Linux/9.PNG)

### **STEP 4**: Create a Virtual Compute Network

We need a default VCN to define our networking within the `Demo` compartment (_Or the name you used for your compartment_). This is where Subnets and Security Lists, to name a couple get defined for each Availablity Domains in your Tenancy. Oracle Cloud Infrastructure is hosted in regions and availability domains. A region is a localized geographic area, and an availability domain is one or more data centers located within a region. A region is composed of several availability domains. Availability domains are isolated from each other, fault tolerant, and very unlikely to fail simultaneously. Because availability domains do not share infrastructure such as power or cooling, or the internal availability domain network, a failure at one availability domain is unlikely to impact the availability of the others.

All the availability domains in a region are connected to each other by a low latency, high bandwidth network, which makes it possible for you to provide high-availability connectivity to the Internet and customer premises, and to build replicated systems in multiple availability domains for both high-availability and disaster recovery.

- Click the **hamburger icon** in the upper left corner to open the navigation menu. Under the **Networking** section of the menu, click **Virtual Cloud Networks**

  ![](images/050Linux/10.PNG)

- Select your compartment from the LOV.

  ![](images/050Linux/10a.png)

- Click **Create Virtual Cloud Network**

  ![](images/050Linux/11.PNG)

- Fill in the follow values as highlighted below:

  ![](images/050Linux/12.PNG)

  ![](images/050Linux/13.PNG)

- Click **Create Virtual Cloud Network**

- Click **Close** on the details page:

  ![](images/050Linux/14.PNG)

- You will see:

  ![](images/050Linux/15.PNG)

### **STEP 5**: Add a Security List entry

A security list provides a virtual firewall for an instance, with ingress and egress rules that specify the types of traffic allowed in and out. Each security list is enforced at the instance level. However, you configure your security lists at the subnet level, which means that all instances in a given subnet are subject to the same set of rules. The security lists apply to a given instance whether it's talking with another instance in the VCN or a host outside the VCN.

- In the DockerVCN network click on **Security Lists**

  ![](images/050Linux/16.PNG)

- Click on **Default Security List for DockerVCN**

  ![](images/050Linux/18.PNG)

For the purposes of the upcoming Docker deployments we need to add five Ingress Rules that allow access from the Internet to ports 9080, 8002, 18002, 5600, and 8085. In a production environment only the UI port (8085) would typically be opened for access but the labs will have us test various other Application and Oracle centric functionality as we go, thus the need to open other ports.

- Click **Add Ingress Rule**

  **`NOTE: DO NOT EDIT AN ALREADY EXISTING RULE, ADD NEW ONES...`**

  ![](images/050Linux/19.PNG)

- In the Pop up dialog **Enter the following** and then click the **Add Ingress Rule** button.

  **NOTE: Leave all other values at default...**

  ```
  Source CIDR: 0.0.0.0/0
  Destination Port Range: 8085
  ```

  ![](images/050Linux/Linux050-c8ef545e.png)



- **Add four more Ingress Rules**

  ```
  Source CIDR: 0.0.0.0/0
  Destination Port Range: 9080
  ```

  ```
  Source CIDR: 0.0.0.0/0
  Destination Port Range: 8002
  ```

  ```
  Source CIDR: 0.0.0.0/0
  Destination Port Range: 18002
  ```

  ```
  Source CIDR: 0.0.0.0/0
  Destination Port Range: 5600
  ```

- When completed your Ingress Rules should look like:

  ![](images/050Linux/Linux050-a84ef9f4.png)

### **STEP 6**: Create SSH Key Pair (Linux or Mac client)

Before we create the Compute instance that will contain Docker and application deployments we need to create an ssh key pair so we'll be able to securely connect to the instance and do the Docker installation, etc.

**NOTE:** `This step focuses on key pair generation for Linux or Mac based terminal sessions. If your going to run your terminal sessions from a Windows client then skip to STEP 7`

- In a `Linux/Mac` client terminal window **Type** the following (**You don't have to worry about any passphrases unless you want to enter one**)

  ```
  ssh-keygen -b 2048 -t rsa -f dockerkey
  ```

- Your key pair is now in the current directory

  ![](images/050Linux/24.PNG)

  **NOTE for Linux and Mac Clients:** Just open up the pubic key file in an editor (vi) and select / copy the entire contents to be used in Step 8.   

  ![](images/050Linux/25-4.PNG)

### **STEP 7**: Create SSH Key Pair (Windows client)

For Windows clients this example will show the use of PuttyGen to generate the keypair. [Putty and PuttyGen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) are available for download.

- Run **PuttyGen** and click **Generate**

  ![](images/050Linux/25.PNG)

- Once the generation process completes click the **Save Private Key** button and save to a directory of your choice.

- If prompted to save without a passphrase click yes.

  ![](images/050Linux/25a.png)

  **NOTE:** `Do not save the public key as the format is not compatable with Linux openSSH.

- Instead, **Select the entire Public Key in the display and right-click copy**. `This content will be pasted into the Create Instance dialog in Step 8.`

  ![](images/050Linux/25-2.PNG)

### **STEP 8**: Create a Compute Instance

You will now create a Linux based Compute instance using the public key you just generated.

- Go back to your OCI console and from the hamburger menu in the upper left hand corner select **Compute-->Instances**

  ![](images/050Linux/26.PNG)

- Click **Create Instance**

 ![](images/050Linux/27.PNG)

- **You will (Select / Leave Default) or Type** the following in the `Create Compute Instance` section of the dialog:

  ```
  Name: Docker
  Availability Domain: AD 1 (Use default AD 1)
  Boot Volume: Oracle-Provided OS Image
  Image Operating System: Oracle Linux 7.6 (Default)
  Shape Type: Virtual Machine (Default)
  Shape: VM.Standard2.1 (Default)
  SSH Keys: Choose SSH Key Files
  ```

- Scroll down furthur on the page to add your PUBLIC SSH Key
**NOTE:** You will paste the public key you copied in Step 7 into the SSH KEY field by selecting the **Paste SSH Keys** radio button. `The public key should all be on ONE LINE`

  ![](images/050Linux/28.PNG)

- In the `Configure networking` section you will take ALL of the defaults as shown:

  ![](images/050Linux/29.PNG)

- Click **Create**

  After a few minutes you should see a running instance with a Public IP Address.

- `Make a note of the IP Address as we will be using this in the next step.`

  ![](images/050Linux/30.PNG)

### **STEP 9**: SSH into the Instance and install Docker

The last set up piece will be to SSH into the Compute image and install Docker and GIT.

- For a Windows client session bring up Putty, select the **Session** section and type in the IP address:

  ![](images/050Linux/31.PNG)

- Select the **Data** section and enter the following as the username:

  ```
  opc
  ```

  Screenshot:

  ![](images/050Linux/32.PNG)

- Select **SSH-->Auth** and browse to the Private Key you created back in Step 7:

  ![](images/050Linux/33.PNG)

- Click the **Open** button. You will presented the first time with am alert message. Click **Yes**

  ![](images/050Linux/35.PNG)

- You will logged into the Compute image:

  ![](images/050Linux/36.PNG)

- **NOTE: For Linux and Mac client sessions**: "cd" into the directory where your key pair is. Make sure the dockerkey file has the permissions of "600" (chmod 600 dockerkey) and ssh into the compute instance `substituting your IP address`.

  Example:

  ```
  cd <directory of your key pair>
  chmod 600 dockerkey
  ssh -i ./dockerkey opc@129.213.119.105
  ```

- Linux / Mac screenshot:

  ![](images/050Linux/37.PNG)

### **STEP 10**: Install and configure Docker and GIT

Docker and GIT are required for the subsuquent labs. You will install the Docker engine, enable it to start on re-boot, grant docker privledges to the `opc` user and finally install GIT.

- **Type** the following:

  ```
  sudo -s
  yum install docker-engine
  usermod -aG docker opc
  systemctl enable docker
  systemctl start docker
  ```

  **NOTE:** During the `yum install docker-engine` command press `Y` is asked if installation is ok.

- Screenshot at the end of the Docker installation:

  ![](images/050Linux/38.PNG)

  ![](images/050Linux/39.PNG)

- **Type** the following:

  ```
  yum install git
  ```

- Screenshot at the end of the GIT installation:

  ![](images/050Linux/40.PNG)

- **Type** the following to verify good installations:

  ```
  su - opc
  docker version
  docker images
  git --version
  ```

  ![](images/050Linux/41.PNG)

### **STEP 11**: Edit /etc/sysconfig/selinux

Set the server to Permissive mode and also ensure that permissive mode survives re-boots by editing `/etc/sysconfig/selinux`

- Using vi, change the SELINUX line to **permissive**. **Type** the following: (**NOTE**: You need to be the root user to edit this file)

  ```
  sudo -s
  vi /etc/sysconfig/selinux
  ```

  **NOTE:** If new to vi, press the letter `i` to edit text. To save press Escape, the type `:wq!`.

  ![](images/050Linux/42.PNG)

- Save the file and exit out of vi

- Now, **Type** the following:

  ```
  setenforce 0
  sestatus
  ```

- Verify that your server is in permissive mode.

  ![](images/050Linux/43.PNG)

- **Type** the following to exit out of `root` and go back and verify that you're now the `opc` user:

  ```
  exit
  whoami
  ```

  ![](images/050Linux/44.PNG)

**This completes the Set Up!**

**You are ready to proceed to [Lab 100](Linux100.md)**
