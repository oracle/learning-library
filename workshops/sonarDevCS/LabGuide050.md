
<!-- ![](images/100/Picture100-lab.png)   -->

## Introduction

Welcome to the Automated Code Inspection workshop. This workshop will walk you through application lifecycle management with embedded code review using SonarQube. It will showcase how SonarQube can save time and improve code quality directly inside the agile development process.

**_To log issues_**, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Objectives

- Get Started With Oracle Cloud Infrastructure
- Create Developer Cloud instance
- Create VCN, compartment and compute instance.

## Setup trial account

### **STEP 1**: Acquire an Oracle Cloud Trial or Workshop Account

- Wait until you receive the following email before proceeding to the next steps in the lab. Please make note of your temporary password in this email.

    ![](images/050/100_1_1.png)

### **STEP 2**: Login to your Oracle Cloud Account

- From any browser, go to the URL:
    `https://cloud.oracle.com`

- click **Sign In** in the upper right hand corner of the browser

    ![](images/050/Picture100-1.png)


- Enter your identity domain and click **Next**

    **NOTE:** The **Identity Domain** should come from your Trial confirmation email.

    ![](images/050/1.png)

- Once your Identity Domain is set, enter your User Name and the Password you set after your confirmation e-mail and click **Sign In**

    ![](images/050/2.png)

- You will be presented with a Dashboard displaying the various cloud services available to this account.

    ![](images/050/3.png)

- Click on the hamburger menu on the top left corner and scroll down and click on **My Services Dashboard** which will take you to the service dashboard page.

     ![](images/050/4.png)

- If all your services are not visible, **click** on the **Customize Dashboard**.
  ![](images/050/5.png)

- You can add services to the dashboard by clicking **Show.** For this workshop, you will want to ensure that you are showing the **Developer** cloud services.

    ![](images/050/6.png)

- Click the **close button** at the top of the pop-up menu.

  ![](images/050/LabGuide050-874df83f.png)

### **STEP 3**: Create the Developer Cloud Service Instance

- Open the Hamburger menu in the top left corner of the page.

  ![](images/100/3.png)

- Within the services menu first click **Services** to expand the list. With the full list visible scroll to and select **Developer**.

  ![](images/100/4.png)

- Once you see the page, click on **Create Instance**

    ![](images/050/lab050_Devcs_1.png)

- In the form give the name to the Instance, we give it name Demo but you can choose whatever you prefer. In region select **No Preference**, click **Next**

    ![](images/050/lab050_Devcs_2.png)

- Confirm the details and click on **Create**

    ![](images/050/lab050_Devcs_3.png)

### **STEP 4**: Create Compartment

- Open the **Hamburger Menu** at the top of the page and **Select Compute** to navigate to the OCI Console.

    ![](images/050/LabGuide050-827bb0a9.png)

- Click on the hamburger menu on the top left and then scroll to **Identity** and then click **Compartments** .

    ![](images/050/lab100_Create_Compartment.png)

- Click on create compartment

    ![](images/050/lab100_Create_Compartment_1.png)

- Fill out the details Name, description and then click **Create Compartment**

    ![](images/050/lab100_Create_Compartment_2.png)


### **STEP 5**: Create VCN and Edit Security Rules

- Once the Compartment is ready, we will create VCN. Click on the hamburger menu on the top left, **Networking** and then click on **Virtual Cloud Networks**

    ![](images/050/lab100_Create_VCN_1.png)

- Make sure to select **sonarQube** compartment and then click on **Create Virtual Cloud Network**

    ![](images/050/lab100_Create_VCN_2.png)

- Add a Name for your VCN and select the second option **CREATE VIRTUAL CLOUD NETWORKS PLUS RELATED RESOURCES**

    ![](images/050/lab100_Create_VCN_3.png)

- Scroll down and click **Create Virtual Cloud Network**  

    ![](images/050/lab100_Create_VCN_3_1.png)

- Once you see the VCN created click select the close button to proceed.

    ![](images/050/LabGuide050-7d4bae3e.png)

- Click on **Security List**

    ![](images/050/lab100_Create_VCN_4.png)

- By default one security list is created when you create the VCN, click on it.

    ![](images/050/lab100_Create_VCN_5.png)

- Click on **Add Ingress Rules**.
    ![](images/050/9.png)

- Enter Source CIDR 0.0.0.0/0 and destination port range **9000,8080**. We are opening port 9000 which is default port for running SonarQube, which we will deploy in next lab, and port 8080 which is default for our web service which we will deploy in lab 400.

    ![](images/050/10.png)

- Once saved you can see the Ingress Rules as below.

    ![](images/050/11.png)


### **STEP 6**: Create SonarQube Instances

- Click on the hamburger menu on top right, then Compute and then click on **Instances**.

    ![](images/050/lab100_Create_Instance_1.png)

- Once you see the instances page, make sure to select right compartment and then click on **Create Instance**

    ![](images/050/lab100_Create_Instance_2.png)

- Give name of the instance, select availability domain.

    ![](images/050/lab100_Create_Instance_3.png)

- Paste the following public key.

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTmnQPppvuP15M5jzTrRoMzWpERDIV9r0Eq1mj+5rEkFpWaRHccgkGZRpjTBcqWn83UGG1bmffDdCy4EkWWydNu5Jll3L2MFrF9TBPg4Zj2Mh2V5x3DQoszypDHiGl7sp1z+LGYpPCmdPcuz/SrLbMrK22X6jHtEZJX56YfZ5FEVKiiOsq/Ae48zbxEUUKZAQ5YdWSLLiaOAmpMqe2qQvyiRiz0PAsQp8qP6pGjqxxMBZacZGlPCDurD6E5Xxh/V+TL8Q0X73N1FexlIuO4x5KoAJQdQQrSRETJuNRC1h7BNNAn9u0Jby9U0qo20UtgLQbpBSnb0FoLuwUxmPUpc/r varuny@Varuns-MacBook-Pro-2.local
```

   ![](images/050/lab100_Create_Instance_3_2.png)

- Click **Create**

    ![](images/050/lab100_Create_Instance_3_3.png)

### **STEP 7**: Create Java Web Service

  - Before we can launch a compute instance, we need an SSH key pair to use for authentication.let's work on creating an SSH key pair for our instance. The method of generating an SSH key pair will depend on your operating system.

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

      ![](images/200/LabGuide200-614f9c26.png)

      ![](images/200/LabGuide200-f0a8b7ba.png)

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

- Click on the hamburger menu on top right, then Compute and then click on **Instances**.

    ![](images/050/lab100_Create_Instance_1.png)

- Once you see the instances page, make sure to select right compartment and then click on **Create Instance**

    ![](images/050/lab100_Create_Instance_2.png)

- Give name of the instance, select availability domain.

    ![](images/050/labGuide050_createinstance.png)

- Paste the following public key.

- In the Add SSH Key area, click **Choose Files** and select the **ssh public key** you generated at the beginning of this step (e.g. `~/container-workshop/ssh-keys/ssh-key.pub`).

   ![](images/050/lab100_Create_Instance_3_2.png)

- Click **Create**

    ![](images/050/lab100_Create_Instance_3_3.png)

- **You are now ready to move to the next lab: [Lab 100](LabGuide100.md)**
