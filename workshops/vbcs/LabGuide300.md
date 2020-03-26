![](images/Picture-Title.png)

# Lab 300 - Creating a Mobile Application

## Introduction

This is the third of several labs that are part of the **Oracle Visual Builder Cloud Service workshop.** This lab will walk you through creating a mobile application and displaying inventory data.

## Objectives

- Create a mobile application
- Create mobile pages for an inventory items list and inventory items detail

## Required Artifacts

- This lab assumes that you have completed [Lab 100](LabGuide100.md) and [Lab 200](LabGuide200.md).

## Create the Application

### **STEP 1**: Add a Mobile App to Our Application

- In your application development console, click on **Mobile** icon in the far left panel.

  ![](images/300/moblieIcon.png)

- Click the button **"+ Mobile Application"** to create a new mobile application instance.

  ![](images/300/createMobileApp.png)

- You will be presented with the New Mobile Application window. In this window, name the mobile application ```InventoryMobileApp``` and choose the  bottom bar navigation style, then click **Finish**.

  ![](images/300/LabGuide300-93c6a76c.png)

- You will see the new app created with the name **item1-start**. To keep the page clean close all your web application pages.

  ![](images/300/LabGuide300-793ca291.png)

### **STEP 2**: Add Mobile App Pages

- At this point you should be seeing a view of your mobile application in the development console. We'll now begin adding pages to display an inventory overview and item details.

  ![](images/300/LabGuide300-6860aa88.png)

The steps to add pages will be familiar if you have completed the web application creation lab in this series. The main page for our application is created for us automatically, so we will begin by adding components to display our data.

- From the component list, drag a **List View** over to the mock phone and drop it on the page.

  ![](images/300/mobileListComponent.png)

- You should see the default list view component on your app. Next we'll customize the data displayed.

  ![](images/300/mobileListDefault.png)

- To associate our inventory data with the list, in the right panel select **Add Data**.

  ![](images/100/LabGuide100-6c8df0e9.png)

- Select the Inventory business object and click **Next**.

  ![](images/300/LabGuide300-09dc3b0e.png)

- Choose the top template at the top of the list and then click **Next**.

  ![](images/300/LabGuide300-9ef98630.png)

- For our **Fields** we will select data from the **Endpoint Structure** and drag them into the **Fields** boxes.
- **Position 2**: name
- **Position 3**: quantity
- **Position 4**: variant
- **Position 5**: reserved

  ![](images/100/LabGuide100-87f367eb.png)

- Your screen should look like the following before you click **NEXT**:

  ![](images/100/LabGuide100-6d1d401f.png)

- We don't need to define a query for our data, so we can click **Finish**.

  ![](images/100/finish.png)

- At this point we have a mobile application that will display our data. Press the **run** button to view your mobile application running in a new tab.

  ![](images/100/liveView.png)

- You should see the following.

  ![](images/300/mobileLive.png)

  Our app is displaying our data but our inventory/reserved counts aren't labeled. Let's add labels so users will know what these numbers mean. To do that we can customize the data displayed in our list view.

- Close the new tab you just opened.

- In the **Page Structure** panel select **Value 1 --> Paragraph**

  ![](images/300/LabGuide300-affb1449.png)

- In the right hand panel paste the following into the general tab. We will add a custom label to the list view so the data in the fields will accurately describe the inventory levels numeric values.

  ```
  [["Inventory: " + $current.data.quantity]]
  ```

  ![](images/100/LabGuide100-b7d1df3d.png)

- In the **Page Structure** panel select **Value 2 --> Paragraph**

  ![](images/300/LabGuide300-09af6987.png)

- In the right hand panel paste the following into the general tab.

  ```
  [["Reserved: " + $current.data.reserved]]
  ```

  ![](images/100/LabGuide100-b5eed900.png)


- Now our app displays a list of the available wines with their labeled inventory count and reserved count.

  ![](images/300/countsLabeled.png)

# Summary

  We have now created a mobile application in Visual Builder Cloud Service, added our business data. The next lab in the series will guide us through adding update and edit features to allow the app's users to update inventory counts from the app.

- You may proceed to [Lab 400](LabGuide400.md)
