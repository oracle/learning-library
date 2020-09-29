# Additional Lab: Provision Environments with Windows Clients

## Introduction

As a take home exercise, you can provision a PeopleSoft environment with a Windows client node. Follow the high level steps outlined below.

## Steps:

1.	Remove the PUM topology from the Environment Template that was used to provision in the previous section – Refer step 2 in  Lab 700: Create a New Environment Template.

2.	Edit the PUM topology and add a new Windows Client node.  Select an available shape. Refer step 1 in Lab500: Review and Update a Topology.  Hint - Click + to add a node. 

3.	Edit the Environment Template and re-add the PUM topology – Refer step 2 in Lab 700: Create a New Environment Template. Hint - Search for PUM topology. 

4.	Configure the Custom Attributes of the topology in the template.  Ensure to select the Availability Domain which has the required shapes – Refer Step 3 in Lab 600: Create a New Environment Template.

5.	Create a new Environment using the newly modified template – Refer Lab 800: Create Environment. 

    While entering windows password, make sure to follow following rules:

    - The Windows password must be at least 12 characters long. Additionally, the password must satisfy the following complexity rules:
    - Not contain the user's account name or parts of the user's full name that exceed two consecutive characters
    - Contain characters from three of the following four categories:
    - English uppercase characters (A through Z)
    - English lowercase characters (a through z)
    - Base 10 digits (0 through 9)
    - Non-alphabetic characters (for example, !, $, #, %)


