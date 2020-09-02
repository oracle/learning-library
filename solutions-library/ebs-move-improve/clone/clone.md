# Clone Your Oracle E-Business Suite Environment

## Introduction
In this 15 mins lab, we will use the Cloning feature of Oracle E-Business Suite Cloud Manager to clone your Oracle E-Business Suite environment.

## Step 1. Access the Clone Environment Page

1. Navigate to the Cloud Manager Environments page.

2. For ebsholenv1, click Action and select Clone. Enter Details (see screenshot and points below)
![](./images/1.png " ")

3. Enter the following values for the clone details:

  a) Environment Name: ebsholenv2

  b) Source Apps Password: apps

  c) Source WebLogic Server password: welcome1

4. Choose Load Balancer as a Service (LBaaS) by selecting the Deploy New Load Balancer check box.

5. Then, you must also select a shape in the Load Balancer Shape field. Select 100 mbps

6. Enter these values for the following Web Entry properties.

  a) rotocol: https

  b) Domain: example.com

  c) Port: 443

  d) Web Access IP/CIDR: 0.0.0.0/0

7. Click Submit.

8. You can check the status of the activity to clone the environment in the Activities page. The new environment is listed on the Environments page.

## Step 2. Configure Local Host Files for the Cloned Environment and Log in to Oracle E-Business Suite

1. In the Oracle Cloud Infrastructure console, find the IP address for the Oracle E-Business Suite web entry point by navigating to Networking > Load Balancers.

2. On the Load Balancers page, you will find a load balancer named ebsholenv2-lbaas. Obtain the public IP address of this load balancer and record in your ```Key-Data.txt``` file.

3. Edit the local hosts file on your laptop and add an entry. 

  a. For Windows users 

    i. Navigate to Notepad in your start menu. 

    ii. Hover over Notepad, right-click, and select the option “Run as Administrator.” 

    iii. In Notepad, navigate to File > Open. 

    iv. And browse to ```C:\\Windows\System32\drivers\etc.``` 

    v. Find the file ```hosts```. 

    ![](./images/2.png " ")

    vi. In the hosts file, scroll down to the end of the content. 

    vii. Add the following entry to the very end of the file: ```<ip_address> ebsholenv1.example.com``` 

    viii. Save the file. 

  b.For Mac users 

    i. Open a Terminal Window. 

    ii. Enter the following command: ```sudo vi /etc/hosts``` 

    iii. Go to the last line and add the following entry: ```<ip_address> ebsholenv1.example.com``` 

    iv. save the file 

4. Log in to Oracle E-Business Suite:

  a. In your browser, navigate to the following URL: https://ebsholenv2.example.com /OA_HTML/AppsLocalLogin.jsp 

  b. When prompted, accept the warning concerning the certificate coming from an unauthorized certificate authority as we are using a self-signed certificate. (You will change the certificate with your own when executing this procedure outside of this hands-on lab.) 

  c. On this page, you will log in to Oracle E-Business Suite with the credentials you generated in Lab 4, part 3.
  ![](./images/3.png " ")

## Acknowledgements

- **Last Updated By/Date** - Santiago Bastidas, Product Management Director, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 