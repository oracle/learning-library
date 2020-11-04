# Work with Data Auditing

## Introduction

This chapter describes how to work with audit tools in Enterprise Data Quality. The demonstration environment includes several example on EDQ Audit tools. In this chapter you will learn how to create the following mappings:

### Objectives
* No Data Check
* Pattern Check
* List Check

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Access and Configure EDQ
    - Lab: Data Profiling
    - Lab: Reference Data
    
## **STEP 1:** No Data Check

### Auditing Data

We will now begin to create a new Process for Auditing our US Customer data. The reference data we just created in the past few steps will be utilized by some of the out-of-the-box "Audit Processors" within our Audit (data checking) Process
1.	Return to the "Project Browser" in the left side of your "Director" window, and underneath your project right-click on “Processes” and click “New Process…”

    ![](./images/image1200_73.png " ")
 
2.	Select “US Customer Data”, then click “Next”. Click “Next” on the next screen (we will not add any profiling here). Provide the following Data:
    - Name: Auditing Customer Data
    - Description: Auditing Customer Data  <Not Mandatory>

    Click “Finish” to continue

    ![](./images/image1200_74.png " ")

3.	As with the first process we created, a "Reader Processor" is automatically added to the "Project Canvas". In the "Tool Palette" find the “Audit” category.

4.	First, drag and drop a “No Data Check” processor onto the "Process Canvas". 

    ![](./images/image1200_75.png " ")

5.	Right click on the "No Data Check" processor and select “Rename” to re-name it to “Email Populated” and press the enter key. 

    ![](./images/image1200_76.png " ")

    ![](./images/image1200_77.png " ")

6.	Drag and Drop the end triangle from the “Reader” to your newly named “Email Populated” audit processor. The "Email Populated" configuration dialog appears

    ![](./images/image1200_78.png " ")
 
7.	Select “eMail” from “Available Attributes” and click the button to add it to “Selected Attributes”, click "OK" 
 
    ![](./images/image1200_79.png " ")

8.	Click the “Run” icon in the toolbar (top of the Project Canvas) to run the process. Once it finishes, select the “Email Populated” audit processor to view the results

    ![](./images/image1200_80.png " ")

**Note: If desired, we can continue to develop this process using one or more of the end point output data stream triangles from the Processor by choosing “Data”, “No Data” or “All".**

## **STEP 2**: Pattern Check

1.	Now, find the “Pattern Check” processor in the Tool Palette. Drag and drop it into the canvas and rename it to “Zip Code in Right Format” by double clicking on processor.

    ![](./images/image1200_81.png " ")

2.	Connect the “All” end triangle from “Email Populated” to the “Zip Code in Right Format” processor. The configuration dialog for the "Pattern Check" processor appears.

3.	Select “ZIP” from “Available Attributes” as the “Field for validation” using the ">" icon

    ![](./images/image1200_82.png " ")

4.	Click the “Options” tab at the top of the dialog box, then click the "..."  button in the “Valid Patterns” section in the middle of the window

    ![](./images/image1200_83.png " ")

5.	Uncheck “Filter by Category” in the “Select Resource” applet. This is where you will select the Reference Data we created for the different types of valid zip codes. Click on “Valid Zip Patterns”, then click “OK” 

    ![](./images/image1200_84.png " ")

6.	In the section under “Valid Patterns”, click the drop-down box to change “Categorize unmatched as” to “Invalid”, then click “OK” to continue

    ![](./images/image1200_85.png " ")

7.	Click the “Run” icon in the toolbar (top of the Project Canvas) to run the process. Once it finishes, click the “Zip Code in Right Format” processor to view the results

    ![](./images/image1200_86.png " ")

    Notice that there are 5362 Valid Records and 76 Invalid Records. That is, there are 76 records that fail the rule, that is they do not match the patterns “NNNNN” or “NNNNNpNNNN”.

## **STEP 3**: List Check

1.	Return to the "Tool Palette" and find the “List Check” processor. Drag and drop it onto the "Project Canvas"

    ![](./images/image1200_87.png " ")
 
2.	Link the “All” triangle from “Zip Code in Right Format” to the “List Check” processor, the “List Check” dialog comes up; select “Gender” in “Available Attributes” and click on the ">' icon to add it to the “Selected Attributes”.

3.	Click the “Options” tab in the top of the dialog box to add reference data. On the section “Valid Values” click on the "..." button 

    ![](./images/image1200_88.png " ")

4.	Select the “Valid Genders” reference data, then click “OK” to continue

    ![](./images/image1200_89.png " ")

5.	Click “OK” to close the “List Check” dialog box.

6.	Double-click the “List Check” processor to rename it to “Check for Valid Gender”.

7.	 Finally, click the “Run” icon to start the process

We now have a better understanding of our data and its issues. Next step is create a process that will fix those issues.

## Acknowledgements
* **Author** - Ravi Lingam, Sri Vishnu Gullapalli, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Sri Vishnu Gullapalli, NA Technology, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
