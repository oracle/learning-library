![](images/200/Picture200-lab.png)  
Updated: 08/28/2018

## Introduction

This is the first of several labs that are part of the WebLogic Server On-Prem to Cloud Workshop. This lab will walk you through the process of moving an existing Java On-Prem application into Oracle Application Container Cloud. It will create and deploy war file and deploy it to the Oracle Public Cloud.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
## Objectives

- Deploying the Application to the Oracle Application Cloud Service Instance
- Verifying the Application Deployment

# Redeploy both Components to Application Container Cloud Service

## Deploying the Application to the Oracle Application Cloud Service Instance

### **STEP 1**: Preparing the WAR file to be Deployed
- Click Application tab and open Terminal. 
  
    ![](images/200/Terminal.png)

- You need to pull latest code as follows.
  
    ![](images/200/pull_request.png)

- In the Projects pane in Oracle JDeveloper, right-click Project and select Deploy > New Deployment Profile.
   
    ![](images/200/war_1.png) 

- The New Deployment Profile is displayed. Select WAR file and click Next.
  
    ![](images/200/war_2.png) 

- The Create Deployment Profile is displayed. Select Profile Type to WAR file and click OK.

    ![](images/200/war_3.png) 

- In the Edit WAR Deployment Profile Properties, edit any changes and click OK.
    
    ![](images/200/war_4.png) 

- Right Click project and Click Deploy. Select recently created AlphaProductCatalog. 
  
    ![](images/200/SelectWarFile.png)

- Deploy AlphaProductCatalog is displayed. Select Deploy to War and click Next.    
    ![](images/200/war_5.png) 

- In the Summary page, verify the values and click Finish.
  Note: You can find generated war file as follows. 
    ![](images/200/Summary.png)

### **STEP 2**: Uploading the war file to the  Application Container Cloud Service

- Log into Oracle Cloud (https://cloud.oracle.com/en_US/sign-in). From Action Menu in the Application Container, select Open Service Control.
  
    ![](images/200/OpenACCS.png)

- In the Oracle Application Container Cloud, click Create Application.

    ![](images/200/1.png) 

- The Create Application is displayed. Select your application platform as JAVA EE.
  
    ![](images/200/2.png) 

- The Create Application is displayed. Enter a name for the application.
  
    ![](images/200/4.png) 

- Click Upload Archive button to upload generated war file and click Create.

    ![](images/200/6.png) 

## Verifying the Application Deployment

### **STEP 1**: Verification

- After Application Container Cloud Service Instance is created, click the link.

    ![](images/200/9.png) 

- Add /alpha-office-product-catalog/products.jsp to view Alpha Office Product Catalog website.

    ![](images/200/10.png) 

- You have successfully deployed the Java EE application using  Application Cloud Container Service. Click any product to view its static twitter popup.

    ![](images/200/10_1.png) 

### **STEP 2**: Scale instance in the Application Container Cloud Service

- Click overview tab inside AlphaOfficeProductCatalog instance.

    ![](images/200/11.png) 

- Increase instances and memory according to your requirements.

    ![](images/200/12.png) 

- Click Apply to proceed.

    ![](images/200/13.png) 

- Proceed with either Rolling Restart with no downtime or Concurrent Restart brief downtime and click apply. 

    ![](images/200/14.png) 

- Wait few minutes to progress activity.

    ![](images/200/15.png) 

- You have successfully scaled up/down AlphaOfficeProductCatalog Application Container Cloud Service Instance.

    ![](images/200/16.png) 


