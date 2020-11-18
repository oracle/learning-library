# Work with Reference Data

## Introduction

This chapter describes how to work with reference data in Enterprise Data Quality. The demonstration environment includes importing and creating a reference data. 

*Estimated Lab Time* - 15 minutes

### Objectives
In this chapter you will learn the following:
* How to generate reference data 
* How to copy reference data

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


## **STEP 1**:  Generate Reference Data
    
### Generate Reference Data 

We will take advantage of the results generated while we were profiling the data to create reference data that will be used later.

1.	Click on the “Frequency Profile Country, DoB, and Gender” processor, then click on the "Gender" tab in the bottom left corner of the "Results Browser" panel.
2.	Hold down CTRL key and click on the M and F values.

    ![](./images/image1200_55.png " ")

3.	Right-click and select “Create Reference Data”. 

    ![](./images/image1200_57.png " ")

4.	The "New Reference Data" dialog appears. Rename the attribute name to “Gender”, click “Next”.

    ![](./images/image1200_56.png " ")
 
5.	Add “Gender” to the Lookup Column using the ">" button, then click “Next”. Click “Next” on the next two screens to keep the defaults.

    ![](./images/image1200_58.png " ")

6.	Provide the following information:
    - Name: Valid Genders
    - Description: Valid Genders

    then click “Finish”.
 
    ![](./images/image1200_59.png " ")

7.	The "Reference Data Editor" appears next. Here, you can modify the reference data to add rows or delete rows. EDQ comes with many different types of reference data out of the box which can dramatically speed up the time it takes to create data check processes. Click "OK" to return to the "Project Canvas".

    ![](./images/image1200_60.png " ")

8.	Next, we will need to create Reference Data for the valid types of ZIP codes. To easily create this reference data, we will use the results of the "Pattern Profiler"; click the "Pattern Profiler" processor and view the results in "Results Browser" panel.

    **Note**: "N" signifies a number, "p" signifies punctuation, "a" signifies an alpha character, and "_" signifies a space.

    ![](./images/image1200_61.png " ")
 
9.	This is pattern information from which we can create reference data. Since we want 5 digits or 5 digits followed by 4 digits, CTRL click on "NNNNN" and "NNNNNpNNNN" then right-click on either one and select “Create Reference Data”.

    ![](./images/image1200_62.png " ")

10.	The "New Reference Data" dialog appears. Rename the attribute name to “Zip Pattern” and click “Next”.

    ![](./images/image1200_63.png " ")

11.	Add “Zip Pattern” to the Lookup Column using the ">" icon, then click “Next”. Click “Next” on the next two screens to keep the defaults.

    ![](./images/image1200_64.png " ")
 
12.	Provide the following information:
    - Name: Valid Zip Patterns
    - Description: Valid Zip Patterns
then click “Finish”.

    ![](./images/image1200_65.png " ")

13.	The "Reference Data Editor" appears next. Click "OK" to return to the "Project Canvas".

    ![](./images/image1200_66.png " ")
 

## **STEP 2**: Copy Reference Data
Now, we will copy reference data previously created into our project, which will be used in further labs. 

1. Go to browser and download the Examples project from the link <a href='./images/Examples.dxi'> Examples.dxi </a>.

2. Click on "File" in Director and select "Open Package File...". Browse to the appropriate directory and select the examples.dxi file.

    ![](./images/image1200_67.png " ")

3. Select the Downloaded Examples.dxi file in the pop up box and click open.

4.	In the “Project Browser” find a project titled “Examples”, expand it.

5.	Expand the “Reference Data” item and right-click on “City to Country Mappings” then select “Copy”.

    ![](./images/image1200_68.png " ")
 
6.	Return to your project (Exploring Customer Data) and find the “Reference Data” item, right-click and select “Paste”.

    ![](./images/image1200_69.png " ")

7.	Repeat these steps to copy “Country Variants” and “US Common Titles1” under “Reference Data” of your project (Exploring Customer Data).

    ![](./images/image1200_70.png " ")

8.	In the “Reference Data” section of your project (Exploring Customer Data), click on “City to Country Mappings”. Notice in the “Results Browser” that this is a two column Reference Data set. The “City” (yellow) column signifies the Lookup Column, similar to the two sets of reference data we created in previous steps for “Gender” and “Zip Code”. The “Country” (green) column signifies the Return Column. This means, wherever the Lookup Column value contains data, the “City to Country Mappings” Reference Data set can be used to return the “Country” that “City” is in. This will help us standardize the values found in the “Country” column.
 
     ![](./images/image1200_71.png " ")

9.  Right click on the Examples.dxi package and select "Close Package File". This action will close the package file in EDQ director.

    ![](./images/image1200_72.png " ")

This Completes your lab on reference data. Let's use this reference data in our next lab.

You may now *proceed to the next lab*. 

## Acknowledgements
* **Author** - Ravi Lingam, Sri Vishnu Gullapalli, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Sri Vishnu Gullapalli, NA Technology, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
