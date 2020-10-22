# Prepare the OCI Account

## Introduction

In this lab we will prepare the OCI environment to provision WebLogic Server for Oracle Cloud Infrastructure from the Marketplace.

Estimated Lab Time: 5 minutes

### Objectives

In this lab you will:

- Create a Vault
- Create a Key
- Create a Secret to hold the WebLogic Admin password on OCI
- Copy the Secret OCID to use during the provisioning stage

### Prerequisites

For this lab you will need:

- An OCI account with a Compartment created

## **STEP 1:** Create a vault

1. Go to **Security -> Vault**

   <img src="./images/prereq-vault1.png" width="50%">

2. Make sure you are in the compartment where you want to deploy WebLogic

3. Click Create Vault

   <img src="./images/prereq-vault2.png"  width="100%">

4. Name the vault `WebLogic Vault` or a name of your choosing. Make sure the `private` option is **not checked** and click **Create Vault**

   <img src="./images/prereq-vault3.png" width="80%">

## **STEP 2:** Create a key in the vault

1. Once the vault is provisioned, click the vault

   <img src="./images/prereq-vault4.png" width="100%">

2. then click **Create Key**

   <img src="./images/prereq-key1.png" width="100%">

3. name the key `WebLogicKey` or a name of your choosing and click **Create Key**

   <img src="./images/prereq-key2.png" width="80%">

## **STEP 3:** Create a secret for the WebLogic admin password

1. Once the key is provisioned, click **Secrets**

   <img src="./images/prereq-secret1.png" width="60%">

2. then **Create Secret**

  <img src="./images/prereq-secret2.png" width="80%">

3. Name the **Secret** as `WebLogicAdminPassword`, select the `WebLogicKey` created at the previous step as the **Encryption Key**, keep the default `plaintext` option and type `welcome1` or any WebLogic compliant password (at least 8 chars and 1 uppercase or number) in the **Secret Content** text field, and click **Create Secret**

  <img src="./images/prereq-secret3.png" width="100%">

4. Click the `WebLogicAdminPassword` **Secret** you just created and **make a note** of its **OCID**

   <img src="./images/prereq-secret4.png" width="100%">

That is all that's needed to get started.

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
