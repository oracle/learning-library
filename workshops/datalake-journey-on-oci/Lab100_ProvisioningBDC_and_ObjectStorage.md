
![](./images/100/100.JPG)

# Lab 100: Provisioning Oracle Big Data Cloud

## Introduction

In this lab, you will learn how to provision a Oracle Big Data Cloud (BDC) cluster on Oracle Cloud Infrastructure (OCI).

The Oracle Big Data Cloud (BDC) enables you to rapidly, securely, and cost-effectively leverage the power of an elastic, integrated Big Data Infrastructure to unlock the value in Big Data. In this lab, we will walk you through the steps to quickly configure and create a Big Data Cloud instance. When done you will see how to view the configuration and layout of your instance using the Oracle Big Data Console.

Please direct comments to Stuti Deshpande (stuti.deshpande@oracle.com)

## Objectives

-   Get access to the Oracle Public Cloud
-   Learn how to create VCN, Subnet and Buckets on OCI
-   Learn how to create users and assign policies for access rules
-   Learn how to upload a file to the OCI Object Storage
-   Learn how to provision a BDC instance
-   Learn how to access your BDC instance

## Get Access to Oracle Public Cloud

Your first step is to get access to the Oracle Public Cloud. There are a couple of ways:

You may already have access to an the Oracle Public Cloud environment. Provided that you have the ability to create new instances of Big Data Cloud Service Compute Edition (BDC) and Oracle Event Hub Cloud Service (OEHCS) as well as the ability to upload files to the Storage Cloud, then you should be able to use your exisitng environment.

-   If you are a customer or prospect, you can sign-up for the free $300 Trial Account. Please refer to the instructions here: $300 Trial

-   If you are an Oracle employee, you can request a temporary environment from the GSE demo.oracle.com website ( a UCM-OCI Focus).

In any case, follow one of the above approaches to obtain access to an Oracle Public Cloud account with the ability (and quota) to create new instances.

# Section 1. Provisioning a BDC Instance on OCI

In this section you will be provisioning a BDC instance on OCI using the cloud console.

## Steps

### **STEP 1: Sign in to Oracle Cloud**

-   Go to [cloud.oracle.com](https://cloud.oracle.com), click **Sign In** to sign in with your Oracle Cloud account.

-   Enter your **Cloud Account Name** and click **My Services**.

![](./images/100/Image100-01.png)


-   Enter your Cloud **username** and **password**, and click **Sign In**.

![](./images/100/Image100-02.png)


### **STEP 2: Setup Container on OCI**

-   Once you are logged in, you are taken to the cloud dashboard where you can see all the services available to you. To access Oracle Cloud Infrastructure (OCI) dashboard, click on **Customize Dashboard**.

![](./images/100/Image100-03.png)

-  Find **Big Data Cloud** under Infrastructure and click on **Show**

![](./images/100/Image100-04.png)

-  Now you should see Compute service under your dashboard. Go ahead and click on **Big Data Cloud**. This will bring you to the service details page. Click on **Open Service Console** on top right of your screen to bring you to OCI dashboard.

![](./images/100/Image100-05.png)

-  Keep this Window open as we would need to spin up the BDC instance in the later stage.


To deploy our instance on OCI, there are couple of steps that you need to follow. You need to create VCN, which will be a private dedicated network where specific Users and Groups can access the resources within the network. We also create API signing keys and fingerprint which will allow user ti use keys to access the network, from the security perspective. We will be creating compartments and Object Storage Containers where we will upload the Bike Data.

If you are using MAC OS, you can run the commands to generate the API signing key and fingerprint by using the terminal itself. However, if you are using Windows OS, you will need to install Git Bash to run these commands. 

GitBash can be downloaded from here: https://git-scm.com/download/win


#### STEP 2.1: Create an API Signing Public and Private Key and Fingerprint


- Follow the instructions in “How to Generate an API Signing Key” from https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm, which essentially are:

```Shell
o	mkdir ~/.oci
o	openssl genrsa -out ~/.oci/oci_api_key.pem 2048
o	chmod go-rwx ~/.oci/oci_api_key.pem
o	openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
o	openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 -c
```

The last command will output a fingerprint that looks something like **12:34:56:78:90:ab:cd:ef:12:34:56:78:90:ab:cd:ef**  
Copy the finger print and save it in the “Assemble the info you need for BDC provisioning” section below.


![](./images/100/Image100-06.png)


- Leave the git bash window open as you will use again below when you add a public API key to a new user you create.

#### STEP 2.2: Create a default VCN for the OCI “Demo” Compartment

Click on Hamburger at the top left side of Dashboard and naviagte to "Compute" Services. You will be directed to the OCI Infrastructure interface, which looks like this:

![](./images/100/Image100-07.png)

- Click on the Menu at the top left Menu and Navigate to Networking and selct VCN option.

![](./images/100/Image100-08.png)

- From the drop down list int he compartment section, select "Demo".
If there are no compartments or you wish to create your own compartment, you can create one too. For this, Navigate to Compartments and Click on Create Compartment. Provide a "Name" for the compartment and you are good to go.

- Click on "Create Virtual Cloud Network"

![](./images/100/Image100-09.png)

- Choose Create Virtual Cloud Network plus Related Resources

- Leave the other defaults and click the button at the bottom

![](./images/100/Image100-10.png)


#### STEP 2.3: Create a Bucket for BDC in the OCI “Demo” Compartment

- In OCI Compute console, click on Storage.
- Choose the “Demo” compartment 
- Then click on Object Storage

![](./images/100/Image100-11.png)

- Create Bucket. Give it a name and  Choose Standard storage tier. Click Create Bucket.

![](./images/100/Image100-12.png)


#### STEP 2.4: Upload the User Journey bootstrap.sh for BDC to your new Bucket

- Click upload Object
- Upload bootstrap.sh (get the latest from [github](https://github.com/millerhoo/journey2-new-data-lake/raw/master/workshops/journey2-new-data-lake/files/100/bootstrap.zip)  Make sure your browser didn’t add silly windows CR/LF to the file)
- Use the menu next to bootstrap.sh to edit it and rename it to bdcsce/bootstrap/bootstrap.sh

![](./images/100/Image100-13.png)

#### STEP 2.5: Create a new user called “demo.user”

- Click on the Menu Hamburger and navigate to Identity tab, then click on Users.

![](./images/100/Image100-14.png)

- Click Create User
- Name the user demo.user and give it a description

![](./images/100/Image100-15.png)

**Copy the demo user’s OCID**

- Navigate to the demo.user
- Click Copy next to the OCID
- Save this as you will need it when you provision BDC

**Add a public key to demo.user**

- Navigate to demo.user and click Add Public Key
- Using “git bash”, run this command:  cat ~/.oci/oci_api_key_public.pem
- Using your mouse, Select and Copy text including the lines ----BEGIN and ----END
- Paste the text into the Add Public Key field and click Add

![](./images/100/Image100-16.png)

![](./images/100/Image100-17.png)

![](./images/100/Image100-18.png)


Make sure the fingerprint obtained in the first page matches the fingerprint generated when you add the Public Key to the User.

![](./images/100/Image100-19.png)

#### STEP 2.6: Add the demo.user to the Administrators Group

- Navigate to Identity tab, then click on Groups
- Click on the Administrators group
- Click on the Add User to Group button
- Pick the user from the drop-down.  Click Add

![](./images/100/Image100-20.png)

![](./images/100/Image100-21.png)

![](./images/100/Image100-22.png)


#### STEP 2.7: Add Policies which defines access rules for Users and Groups


- On OCI Console, Click on Menu Hamburger at top left an navigate to Identity and then click on Policies.

![](./images/100/Image100-23.png)

- Click on Create Policy. If the policies is already automatically created, then you need to cross check whether it covers all the access rules for users/groups.

![](./images/100/Image100-24.png)

- Give it a name, description and provide policy statements which will limit the access to resources for different users and groups.

Policies will be something like:

![](./images/100/Image100-25.png)

- You can add policy statements later to this policy by clicking on " Add Policy Statement".


#### STEP 2.8: Assemble the info you need for BDC provisioning:

- OCI Cloud Storage URL: for GSE, it will be 
https://objectstorage.us-ashburn-1.oraclecloud.com/

- OCI Cloud Storage Bucket URL: eg: oci://bdcsce@mytenancy/ where bdcsce is the bucket you created. mytenancy is your Tenancy
oci://DataLab@gse00014412/

- OCI Cloud Storage User OCID: see the section above called “Copy the demo user’s OCID”.  You should copy it here:

    ocid1.user.oc1..aaaaaaaaz4vgxgadbkwusq5teov2k4qk56h5riuxymxzlsq5djerd6xfuz4a

- OCI Cloud Storage PEM (private) Key (file):  This is created in the git bash scripts you ran.  If you followed the instructions, it will be stored on your laptop at:
C:\Users\USERNAME\.oci\oci_api_key.pem

- OCI Cloud Storage PEM Key Fingerprint: This is created in the git bash scripts you ran.  You should copy it here:

92:ea:37:3c:92:5f:9f:9e:a3:29:08:69:9a:f0:5b:94

### STEP 3: Provisioning BDC with the Storage Details from Step 2

- Navigate to Oracle Big Data Cloud Service Console and Click on "Create Instance".

- Provide details as follows:

![](./images/100/Image100-26.png)

- Click Next

- In the second step, you need to provide details for Cluster Configuration, Object Storage details, SSH keys and Associations (if any)

    - **For Cluster Confirguration**:

    ![](./images/100/Image100-27.png)

    -   Minimum number of nodes required for is 2. You can also spin up 3 node cluster.

    -   For Compute Shape, Navigate to your OCI Console to check the service limits of VM's in all the availability domains.

    ![](./images/100/Image100-32.png)


#### STEP 3.1: How to Check Service Limits?

- Click on Menu Hamburger on Top Left and Navigate to Administration. Select Tenancy Details.

- In the left section, Navigate to Service Limits. Click on "Compute" and a list will appear. 

- Check which VM shape listed in the drop down list of "Compute Shape" in the Cluster Configuration section. Select that Availability Somain and VM Shape.


    - **For Credentials**:

    ![](./images/100/Image100-28.png)

    If you already have the SSH Keys, you can reuse the existing one, else, you can create a new key pair and download the sshkeybundle.zip locally on your desktop, to perform SSH into the BDC VM nodes.

    You need to provide username and password for the instance access. This will be utilised when you will access the web based BDC Console to access Zeppelin.

    - **For Associations**:

    ![](./images/100/Image100-29.png)

    If you would like to associate your BDC instance with either Database Cloud Service, MySQL CS, or EventHub, you can check the checkboxes to directly associate BDC with these services. Oracle Big Data Cloud Platform provides you with out of box integration with these services.

    - **For Cloud Storage Credentials**:

    ![](./images/100/Image100-30.png)

    These will be the details from the Step 1 where we did the setup for the Cloud Storage Containers on OCI.

- Click Next

- Now, you are in the Confirmation screen. Review all the details that you have provided and confirm that the details are correct. If you wish to change any informationm, then click on "Back". Else, Click on Next.

![](./images/100/Image100-31.png)


At this point of time, your instance will start getting provisioned and within minutes your instance will be up and running.


**Congratulations!!** You just spinned up the Oracle BDC cluster along with Storage Container.
Once you have the Big Data Cloud Instance up and running, click on the hamburger sign at the right corner of the instance name and select **Big Data Cloud Console**. You will be redirected to the new window which is the Big Data Cloud Console.



**And you are all set.**

**You are now ready to move to the next lab.**


