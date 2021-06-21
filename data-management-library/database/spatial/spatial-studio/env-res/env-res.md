# Install Spatial Studio

## Introduction

This lab walks though the process of accessing Oracle Spatial Studio (Spatial Studio) from an Oracle LiveLabs Reservation. Your environment includes Spatial Studio and an Autonomous Database. On the first login to Spatial Studio you will provide connection information for your Autonomous Database. 

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:
* Download the Cloud Wallet for your Autonomous Database
* Perform 1st-time login to Spatial Studio supplying Autonomous Database connection info

### Prerequisites

* A completed LiveLabs Reservation for "Introduction to Oracle Spatial Studio" 

<!-- *This is the "fold" - below items are collapsed by default* -->

## **STEP 1**: Download Cloud Wallet for your Autonomous Database 

1. In Workshop Details, note your Cloud user name, password, Compartment, and Spatial Studio IP address. Then launch the Cloud Console.

 ![Image alt text](images/1-1.png "Image title")  


2. Sign-in using **Oracle Cloud Infrastructure Direct Sign-in** using your Cloud user name and initial password. You will be prompted to change the default password.

 ![Image alt text](images/1-2.png "Image title")  

3. Navigate to **Oracle Database** and then **Autonomous Database**.

 ![Image alt text](images/1-3.png "Image title") 

4. In the Compartment form on the left, start typing your Compartment name noted earlier. This will dynamically filter the Compartments list. Once listed, select your Compartment. Your Autonomous Database will then be listed. Click on the link to your Autonomous Database.

 ![Image alt text](images/1-4.png "Image title") 

5. Click on **Database Connection** and then **Download Wallet**. You will promoted for a wallet password. Enter any string as this password will not be used. Save the wallet to a convenient location on your laptop as you will use it in the next step.

 ![Image alt text](images/1-5.png "Image title") 

## **STEP 2**: Spatial Studio First-Time Login 

1. You will now use the Spatial Studio IP address you noted earlier. Open a new tab in your browser and navigate to **https://[your Spatial Studio IP address]:4040/spatialstudio**. For example, if your Spatial Studio IP address is 123.123.12.123 then you would navigate to https://123.123.12.123:4040/spatialstudio. Because your Spatial Studio instance is not configured with a signed SSL certificate you will see a browser-specific security warning. Accept the warning and proceed to the site. In a production environment a certificate would be configured and this would not occur. Log in with user **admin** and password **welcome1**.
   
 ![Image alt text](images/2-1.png "Image title")    
   
   
2. First-time login to Spatial Studio prompts you to enter database connection information for Spatial Studio's metadata repository. Click **Autonomous Database** and then **Next**. On the next scren, drag and drop the wallet file you downloaded previously and click **Ok**.

 ![Image alt text](images/2-2.png "Image title") 

3. You are now prompted for Automomous Database connection information. Enter the user **studio_repo**, password **Welcome1Welcome1**, and select the medium service level. 

 ![Image alt text](images/2-3.png "Image title")  

 Spatial Studio is now building its metadata tables in Autonomous Database. This will take roughly 30 seconds.

4. When Spatial Studio opens, the first-time login is complete and you are ready to proceed with the workshop.

 ![Image alt text](images/2-4.png "Image title")  

You may now [proceed to the next lab](#next).

## Learn More
* [Spatial Studio product page](https://oracle.com/goto/spatialstudio)

## Acknowledgements
* **Author** - David Lapp, Database Product Management
* **Last Updated By/Date** - David Lapp, Database Product Management, June 2021

