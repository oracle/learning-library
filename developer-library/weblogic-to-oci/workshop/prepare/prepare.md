# Prepare the OCI account

## Introduction

In this lab we will prepare the OCI environment to provision WebLogic Server for Oracle Cloud Infrastructure from the Marketplace.

## **Step 1:** Create a **Vault**

- 1.1. Go to **Security -> Vault**

   <img src="./images/prereq-vault1.png" width="50%">

- 1.2. Make sure you are in the compartment where you want to deploy WebLogic

- 1.3. Click **Create Vault**

   <img src="./images/prereq-vault2.png"  width="100%">

- 1.4. Name the vault `WebLogic Vault` or a name of your choosing. Make sure the `private` option is **not checked** and click **Create Vault**

   <img src="./images/prereq-vault3.png" width="80%">

## **Step 2:** Create a **Key** in the vault

- 2.1. Once the vault is provisioned, click the vault

   <img src="./images/prereq-vault4.png" width="100%">

- 2.2. then click **Create Key**

   <img src="./images/prereq-key1.png" width="100%">

- 2.3. name the key `WebLogicKey` or a name of your choosing and click **Create Key**

   <img src="./images/prereq-key2.png" width="80%">

## **Step 3:** Create a **Secret** for the WebLogic admin password

- 3.1. Once the key is provisioned, click **Secrets**

   <img src="./images/prereq-secret1.png" width="60%">

- 3.2. then **Create Secret**

  <img src="./images/prereq-secret2.png" width="80%">

- 3.3. Name the **Secret** as `WebLogicAdminPassword`, select the `WebLogicKey` created at the previous step as the **Encryption Key**, keep the default `plaintext` option and type `welcome1` or any WebLogic compliant password (at least 8 chars and 1 uppercase or number) in the **Secret Content** text field, and click **Create Secret**

  <img src="./images/prereq-secret3.png" width="100%">

- 3.4. Click the `WebLogicAdminPassword` **Secret** you just created and make a note of its **OCID**

   <img src="./images/prereq-secret4.png" width="100%">

That is all that's needed to get started.

**Note:**
If we were migrating a JRF domain (which is not the case here), the Virtual Cloud Network as well as subnets and Security Lists and an Operational Database would need to be provisioned before attempting to provision the WebLogic domain with the Marketplace.


## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, July 30 2020

## See an issue?

Please submit feedback using this <a href="https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1" target="_blank">form</a>. 

Please include the <em>workshop name</em>, <em>lab</em> and <em>step</em> in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the <em>Feedback Comments</em> section.    Please include the workshop name and lab in your request.
