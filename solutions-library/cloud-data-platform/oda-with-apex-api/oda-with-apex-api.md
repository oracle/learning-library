# Oracle Digital Assistant (ODA) with APEX APIs

<!-- Comment out table of contents
## Table of Contents
[Introduction](#introduction)
-->

## Introduction

In this lab, you will learn how to navigate to an Oracle Digital Assistant instance and design a Skill in which you will implement your APIs from the APEX portion of this workshop.  These APIs will be utilized in order to make REST calls to the Autonomous Data Warehouse to get information on store predictions.  These REST API calls will be tested through interacting with the chatbot dialogue.

### Objectives

-   Learn how to provision an Oracle Digital Assistant (ODA) instance
-   Learn how to design an Oracle Digital Assistant Skill
-   Learn how to implement REST APIs through Digital Assistant
-   Learn how to test Digital Assistant Dialogue

### Required Artifacts

-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
-   The estimated time to complete this lab is 20 minutes.

### Extra Resources
-   To learn more about Oracle Digital Assistant (ODA), feel free to watch the following video: [](youtube:byXa6tIgyKY)
-   Additionally, feel free to explore ODA's capabilities by clicking on this link: [ODA Overview](https://www.oracle.com/application-development/cloud-services/digital-assistant/)


## Part 0. Provisioning a Digital Assistant Instance

1. Inside of the OCI Console, click on the top left menu icon.

    ![](./images/1.png " ")

2. In the side menu, navigate to **Digital Assistant** under Data and AI.

    ![](./images/2.png " ")

3. On the Digital Assistant Instances screen, find the **Compartment** drop down on the left, and select the compartment of your choice from the drop down list.  Here, I am choosing the CloudDataWorkshop compartment.

    ![](./images/600new0.png " ")

4. Once you have selected the correct compartment, click on **Create Digital Assistant Instance**.

    ![](./images/600n1.png " ")

5. For the name of your Digital Assistant Instance, put **ODA_YOURINITIALS**.  For shape, select **Development**.  Next, click **Create**.

    ![](./images/600n2.png " ")
    
6. You will see that your instance is in the 'Creating' state.  Note: The instance should take a few minutes to provision.

   ![](./images/600n3.png " ")
   
7. Once your instance has successfully been provisioned, you will see it's state will change to 'Active'.

    ![](./images/600n4.png " ")
    
8. Once your instance is in the 'Active' state, you can **click** on the right side menu (denoted by three dots), then select **Service Console**.

    ![](./images/600n5.png " ")

9. Note: feel free to learn more about Oracle Digital Assistant (ODA) by clicking on the following text link: [ODA Overview](https://www.oracle.com/application-development/cloud-services/digital-assistant/)


## Part 1. Creating a Skill in Digital Assistant

### **Step 1:** Re-sign in to your Oracle Cloud Account.

1. After selecting Service Console, you will be prompted to enter your Cloud Tenant Name.  Here, enter your **Cloud Account Name** associated with your account.  Note: This is not your username, this is the name of your cloud tenancy.

    ![](./images/7.png " ")

2. Next, you will be taken to a login screen.  Here, enter your username and password, and click **Sign In**.

    ![](./images/8.png " ")

### **Step 2:** Import a Digital Assistant Skill

1. Once you are signed in, you will be taken to the Oracle Digital Assistant home page.  To begin, click the top left hamburger menu.

    ![](./images/9.png " ")

2. In this side menu, select **Development**, then click **Skills**.

    ![](./images/10.png " ")

3. Before Importing the skill in the next step, please make sure you **download** this file via this text link: [Download ODA Skill .zip here](./files/DemoDigitalAssistantSkill.zip)

4. On the skill, click on the **Import Skill** button in the top right corner.

    ![](./images/600n6.png " ")

5. From your Downloads folder, select the **DemoDigital AssistantSkill.zip** file that you just downloaded above.  Once you've selected this file, click **Import**.

6. It will take a few seconds, but after it is finished importing, you will see the Skill on your Skills page.  To start editing your Skill, click your **Demo Digital Assistant Skill**.  Hint: If you don't see your Skill show up in a minute or so, you might need to refresh your browser.

    ![](./images/600n7.png " ")
    
7. Your digital assistant is now imported! You are now ready to implement your APEX APIs.

## Part 2. Implement REST APIs into Digital Assistant to access data from ADW

### **Step 1:** Add REST API URLs to Digital Assistant Code

1. After clicking your skill, navigate to the **Flows** tab on the left menu.

    ![](./images/13.png " ")

2. Next, navigate to the 'states' section of the code where you can see **Set Trending Product API Value** and **Set Inventory Forecast API Value**.

    ![](./images/16full.png " ")

3. Let's start with the Trending Product API value.  Under the **setTrendingProductAPI** definition on line 38, you will see the **value** is set to "null" on line 42.  Replace "null" with your **Trending Product API URL** that you took note of from the APEX portion of this workshop.  IMPORTANT: Make sure to remove everything after the 'trendingProductAPI/', making sure to leave the / at the end.  Be sure to keep this URL inside the quotation marks to properly assign the value.

    ![](./images/16first.png " ")

4. Next, navigate to the **SetInventoryForecastingAPI** definition on line 50, shown in the image above.  On line 54, change the **value** from "null" to your **Inventory Forecast API URL** you took note of in the APEX portion of this workshop.  IMPORTANT: Make sure to remove everything after the 'inventoryForecastingAPI/', making sure to leave the / at the end.  Be sure to keep the URL inside of the quotation marks.

    ![](./images/16second.png " ")

5. After you have properly entered your API URLs, go ahead and click the **Validate** button in the top right corner.  

    ![](./images/14.png " ")

6. After a few seconds, click **Train**.  Keep the **Trainer Ht** intent selected along with **Entity**.  Next, click **Submit**.  Once your model is fully trained, you will see a checkmark next to the **Train** button.

    ![](./images/15.png " ")

### **Step 3:** Test API Calls in Digital Assistant Conversation Flow

1. To test the APIs you just implemented, click on the Skill Tester('Play') button on the bottom left of the side menu.

    ![](./images/17.png " ")

2. A chat screen will appear where you can begin testing your API calls through a conversation flow. Begin by typing "Hi".  The bot should respond to you with the response shown in the image below.  From here, follow the dialogue exactly as shown in the images below. When the bot responds with a list of different buttons, be sure to **click** on them to select your choices.  You will not need to do any typing to the bot aside from your initial "Hi": all you will need to do is respond by clicking the buttons that the chatbot sends you.

    ![](./images/18new.png " ")

    ![](./images/19new.png " ")

    ![](./images/20new.png " ")

3. You might notice that in the conversation with the chatbot, when you ask for 'Inventory Forecasting' and 'Trending Products', the bot takes a few extra seconds to respond to you.  This is because at this time, the bot is doing a REST API call to your ADW to retrieve the necessary data.

## Summary

-   In this lab, you provisioned Oracle Digital Assistant (ODA), imported/designed an Oracle Digital Assistant Skill, implemented REST APIs through Digital Assistant, and tested Digital Assistant Dialogue.

## Acknowledgements

- **Author** - NATD Solution Engineering - Austin Hub (Jess Rein, Philip Pavlov)
- **Last Updated By/Date** - Jess Rein, Solutions Engineer, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.    Please include the workshop name and lab in your request. 
