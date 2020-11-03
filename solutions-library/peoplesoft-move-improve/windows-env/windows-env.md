# Additional Lab: Provisioning Environments with Windows Clients

## Introduction

As a take home exercise, you can provision a PeopleSoft environment with a Windows client node. Follow the high level steps outlined below.

Estimated Lab Time: 3 hours


## **STEPS**
1.	Remove the PUM topology from the Environment Template that was used to provision in the previous section – Refer Step 2 in  Lab 6: Create a New Environment Template.

2.	Edit the PUM topology and add a new Windows Client node.  Select an available shape. Refer Step 1 in Lab 4: Review and Update a Topology.  Hint - Click + to add a node. 

3.	Edit the Environment Template and re-add the PUM topology – Refer Step 2 in Lab 6: Create a New Environment Template. Hint - Search for PUM topology. 

4.	Configure the Custom Attributes of the topology in the template.  Ensure to select the Availability Domain which has the required shapes – Refer Step 3 in Lab 5: Create a New Environment Template.

5.	Create a new Environment using the newly modified template – Refer Lab 7: Create Environment. 

  While entering windows password, make sure to follow following rules:

    - The Windows password must be at least 12 characters long. Additionally, the password must satisfy the following complexity rules:
    - Not contain the user's account name or parts of the user's full name that exceed two consecutive characters
    - Contain characters from three of the following four categories:
    - English uppercase characters (A through Z)
    - English lowercase characters (a through z)
    - Base 10 digits (0 through 9)
    - Non-alphabetic characters (for example, !, $, #, %)


## Acknowledgements
**Authors** 
- Rich Konopka, PeopleSoft Specialist, October 2020
- Megha Gajbhiye, Cloud Solutions Engineer, October 2020

**Last Updated By/Date** 
- Sara Lipowsky, Cloud Engineer, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
