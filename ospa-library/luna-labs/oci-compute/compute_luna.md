# Compute Service

**Description**

The workhorse of OCI is the compute instance.  Oracle offers Virtual Machine or Bare Metal instances in many shapes, from a single OCPU up to 24 OCPUs, catering to a variety of workloads and software architectures.  
This lab will walk you through the deployment of a virtual machine instance and accompanying infrastructure.  After the instance is deployed, you'll access it securely from your computer, attach external block storage, install a simple web-application, and terminate it when you're done.

**Lab Objectives**

- Deploy a Linux based virtual machine in the cloud
- Attach block volume storage to the instance
- Install and configure a simple web-application
- Terminate the instance and transfer the boot and block volumes to another instance
- Remove the instance and associated boot and block volumes

**Intended Audience**

- Beginner/Intermediate technical learners
- New to cloud
- New to Oracle Cloud Infrastructure

**Changelog**

- March 19, 2020 - version 1

## Part 1: Obtain your credentials and login

1.  To retrieve your tenancy and credentials, double click the desktop file named **Luna-Lab.html**.

![](media/image001.png " ")

*The page will open and you will find all the information you need to login to the OCI Cloud environment and get started with the lab.    Your details will be different but notice that you can copy each entry using the Copy button on the right of each field.*

![](media/image002.png " ")

2. Start by copying the **Username**.   *Don't try and hand type either the username or the password, they are system generated and very long!*  Then click on the **OCI Console** button to open the login screen to access your tenancy.  

Copy and paste the Username and Password credentials from the Luna Lab landing screen into the Oracle Cloud Account Sign In screen.  

3. Click the **Sign In** button.

![](media/image003.png " ")

**Note:** *You can use the right click Copy/Paste menu but if that doesn't work you can also use ```<CTRL><C> and <CTRL><V>``` to copy and paste.*

## Part 2: Create a Compute Instance 

In this section of the lab you will create a Virtual Machine compute instance.

1. Click on the OCI main navigation menu, choose **Compute** and from the fly out choose **Instances** 

![](media/image004.png " ")

2. At the bottom left, under **List Scope** choose your compartment.   You have been assigned a specific compartment for this lab environment.   It should be easily accessible by clicking the root, then clicking the '+' signs until you reach the assigned compartment.  Click on the compartment name.

![](media/image005.png " ")

3.  Click the **Create Instance** button to launch the compute instance.

![](media/image006.png " ")

The **Create Compute Instance** workflow will default to the most common selections.   You'll look at the the instance creation dialog as three sections, instance details, networking, and Adding SSH keys.

**Note:**  *As this lab focuses on creating an instance, and not on networking, you will not step through network or VCN creation.   We will allow the Create Instance dialog to automatically create the VCN for us with the proper routing and security list information.  For training on OCI networking, see the network and VNC Hands On Labs.*

4.  Click on **Create Compute Instance**.  

| **Field**                | **Recommended Information** |
| ------------------------ | ------------------------------------------------ |
|**Name:** | Accept the default or name your instance  |
|**Image Operating System:** | Oracle Linux 7.7 or latest |
|**Availability Domain:** |Choose any Availability Domain  |
|**Instance type:** | Virtual Machine |
|**Instance Shape:**|  Virtual Machine - VM.Standard2.1  |

![](media/image007.png " ")

5.  In the **Configure networking** section, verify that the proper department has been selected.   The dialog will create all of the required networking automatically.  Accept the default VCN name or create your own if you wish.   Be sure that the radio button for "ASSIGN A PUBLIC IP ADDRESS" has been selected.

| **Field**                | **Recommended Information** |
| ------------------------ | ------------------------------------------------ |
| **Virtual Cloud Network Compartment:** | Choose your assigned compartment |
| **Name:** | Accept the default or name your VCN |
| **Assign a Public IP Address:** | Selected |

![](media/image008.png " ")

And finally, the last two sections are the **Boot Volume** and **Add SSH Keys** sections.   Leave the boot volume section with the defaults.   Note the you can specify a custom size or data encryption.  Do not select anything at this time.

Next you'll need to create and paste SSH keys so that you can securely access the new instance.  

6.  Click on the Applications Menu at the top of your screen and choose **Terminal Emulator** to open up a terminal window in your desktop environment.

![](media/image009.png " ")

7.  From the system prompt, type in the command ```ssh-keygen``` and hit the return key.   Simply press the **return** key three times to accept the default file and path, as well as to create an empty passphrase.   The ssh-keygen command will create a public key, a private key, and a folder labeled .ssh to store them in.

![](media/image010.png " ")

In this next step, you'll display the contents of the public SSH key so that you can copy it and paste it into our compute instance creation dialog.    Type

8.  Type the following command in the terminal window.

```cat .ssh/id_rsa.pub```

![](media/image011.png " ")

9.  With the contents of the SSH key displayed, select the contents of the key, from the line starting with *ssh-rsa ...* to the last character.   Right click and choose **Copy** to copy the key contents to the clipboard.

![](media/image012.png " ")

10.  Return to the OCI Web console and find the *Add SSH Keys* section.   Choose the radio button labeled **Paste SSH Keys** and then paste the key you copied in the last step into the form.  Right click with your mouse and choose the **Paste** command or you can use the CTL-V keyboard command.

![](media/image013.png " ")

11.  After you've successfully pasted the SSH key, you can now click on the **Create** button to create the instance.

![](media/image014.png " ")

The instance will begin provisioning.  You should see the instance details screen with the orange icon indicating it's provisioning status.   Wait a few moments.  When it's finished, the icon will turn green and enter the *running* state.

![](media/image015.png " ")

## Part 3: Connect to the instance

1.  Examine the instance details screen.  Left click to drag and select the **Public IP Address** and right click or CTL-C to copy the IP address.  you'll need that to connect to the instance next.

![](media/image016.png " ")

2.  Return to the terminal window, or open a new one if you closed it earlier.   Type the following command to connect to the new instance via SSH.   This command uses the private SSH key you created earlier and is logging in as the default admin user, *opc*.

```ssh -i .ssh/id_rsa opc@<IP ADDRESS OF YOUR INSTANCE>```

Answer *yes* to the question about continuing your connection.    You should now be logged into your instance.

![](media/image017.png " ")

## Part 4: Install and configure a web server

In the next steps we will install and configure an Apache webserver via the Linux command line and verify that it's running and accessible over the public internet.

**Note** *Apache is the most commonly used Web server on Linux systems. Web servers are used to serve Web pages requested by client computers and commonly used to host customer applications.*
 
1.  Install the Apache web server.  Type the following command.

```# sudo yum install httpd -y```

![](media/image018.png " ")

2.  In the terminal window, type the following three commands to start the apache web server, enable the httpd processes, and check the web server configuration.

```sudo apachectl start```

```sudo systemctl enable httpd```

```sudo apachectl configtest```

![](media/image019.png " ")

3.  Type the following commands to enable http traffic to pass through the Linux firewall service.  Then reload the service.

```sudo firewall-cmd --permanent --zone=public --add-service=http```

```sudo firewall-cmd --reload```

![](media/image020.png " ")

4.  Create the landing page for your web server.  For standard http the default web page is normally named index.html.  you'll use the linux *echo* command to alter the default file in its default location.

```sudo bash -c 'echo This is my Web-Server running on OCI >> /var/www/html/index.html'```

![](media/image021.png " ")

## Part 5:  Test the connection to the web server

1. Open a new browser tab in the Firefox browser on your training session desktop.  Type `http://<public ip address of your instance>` into the URI locator and press enter.

**NOTE:** The connection should time-out because the OCI security list has not been altered to allow traffic to port 80.

2.  Navigate to the OCI Console and click on the services menu, choose **Networking > Virtual Cloud Networks**.

![](media/image022.png " ")

3.  Make sure your compartment is selected, then select the vcn that was created with your instance.  

![](media/image023.png " ")

4.  On the bottom left of the screen, click on **Security lists** and then click on the **Default Security List** for your vcn.

![](media/image024.png " ")

5.  Within the security list rules screen, click the blue button to **Add Ingress Rules**.

![](media/image025.png " ")

6.  In the dialog box, enter the following information to open port 80 on your instance.  Then click the **Add Ingress Rules** button.

| **Field**                | **Recommended Information** |
| ------------------------ | ------------------------------------------------ |
| **Source Type:** | CIDR |
| **Source CIDR:** | 0.0.0.0/0|
| **IP Protocol:** | TCP |
| **Source Port Range:** | All (default) |
| **Destination Port Range:** | 80 |

![](media/image026.png " ")

7. Return to your browser and open a new tab on your training session desktop.  Type `http://<public ip address of your instance>` into the URI locator and press enter.

![](media/image027.png " ")

## Part 6: You have successfully completed this lab.

You have successfully completed this lab.    Continue to explore the OCI environment or click the **End Session** button on the desktop browser window to end your session immediately.

![](media/image028.png " ")

Great job!   Come back and try this lab again or proceed to the next lab in the series to learn more about Oracle Cloud Infrastructure!


