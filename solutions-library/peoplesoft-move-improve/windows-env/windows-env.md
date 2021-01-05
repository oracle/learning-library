# Additional Lab: Provisioning Environments with Windows Clients

## Introduction

As a take home exercise, you can provision a PeopleSoft environment with a Windows client node. Follow the high level steps outlined below.

Estimated Lab Time: 3 hours

### Objectives
The purpose of this lab is to test your knowledge with Labs 1-7 and gain familiarity with the Windows client node.

### Prerequisites
- Complete Labs 1-7

## **STEP 1: Removing PUM Topology**
  Remove the PUM topology from the Environment Template that was used to provision in the previous section – Refer Step 2 in  Lab 6: Create a New Environment Template.

## **STEP 2: Editing PUM Topology**
  Edit the PUM topology and add a new Windows Client node.  Select an available shape. Refer Step 1 in Lab 4: Reviewing and Updating the Topology.  Hint - Click + to add a node. 

## **STEP 3: Editing Environment Template**
  Edit the Environment Template and re-add the PUM topology – Refer Step 2 in Lab 6: Creating a New Environment Template. Hint - Search for PUM topology. 

## **STEP 4: Configuring Topology Attributes**
  Configure the Custom Attributes of the topology in the template.  Ensure to select the Availability Domain which has the required shapes – Refer Step 3 in Lab 6: Creating a New Environment Template.

## **STEP 5: Creating New Environment**
  Create a new Environment using the newly modified template – Refer Lab 7: Creating Environment in PeopleSoft. 

  While entering windows password, make sure to follow following rules:

  - The Windows password must be at least 12 characters long. Additionally, the password must satisfy the following complexity rules:
  - Not contain the user's account name or parts of the user's full name that exceed two consecutive characters
  - Contain characters from three of the following four categories:
  - English uppercase characters (A through Z)
  - English lowercase characters (a through z)
  - Base 10 digits (0 through 9)
  - Non-alphabetic characters (for example, !, $, #, %)


## Acknowledgements
* **Authors** - Rich Konopka, Peoplesoft Specialist, Megha Gajbhiye, Cloud Solutions Engineer
* **Contributor** -  Sara Lipowsky, Cloud Engineer
* **Last Updated By/Date** - Sara Lipowsky, Cloud Engineer, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.