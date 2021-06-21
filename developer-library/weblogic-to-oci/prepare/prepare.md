# Prepare the OCI Account

## Introduction

We will prepare the OCI environment to provision WebLogic Server for Oracle Cloud Infrastructure from the marketplace.

Estimated Completion Time: 5 minutes.

### Objectives

- Create a Vault.
- Create a Key.
- Create a Secret to hold the WebLogic Admin password.
- Copy the Secret OCID to use during the provisioning stage.

### Prerequisites

- an OCI account with a compartment created.

## **STEP 1:** Create a Vault

1. Go to **Security -> Vault**.

   ![](./images/prereq-vault1.png " ")

2. Make sure you are in the compartment where you want to deploy WebLogic.

3. Click **Create Vault**.

   ![](./images/prereq-vault2.png " ")

4. Name the vault `WebLogic Vault` or a name of your choosing. Make sure the `private` option is **not checked** and click **Create Vault**.

   ![](./images/prereq-vault3.png " ")

## **STEP 2:** Create a Key in the Vault

1. Once the vault is provisioned, select the vault.

   ![](./images/prereq-vault4.png " ")

2. Click **Create Key**.

   ![](./images/prereq-key1.png " ")

3. Name the key `WebLogicKey` or a name of your choosing and click **Create Key**.

   ![](./images/prereq-key2.png " ")

## **STEP 3:** Create a Secret for the WebLogic Admin Password

1. Once the key is provisioned, click **Secrets**.

   ![](./images/prereq-secret1.png " ")

2. Click **Create Secret**.

  ![](./images/prereq-secret2.png " ")

3. Name the **Secret** as `WebLogicAdminPassword`, select the `WebLogicKey` created at the previous step as the **Encryption Key**, keep the default `plaintext` option and type `welcome1` or any WebLogic compliant password (at least 8 chars and 1 uppercase or number) in the **Secret Content** text field, and click **Create Secret**.

  ![](./images/prereq-secret3.png " ")

4. Click the `WebLogicAdminPassword` **Secret** you just created and **make a note** of its **OCID**.

   ![](./images/prereq-secret4.png " ")


That is all that's needed to get started.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020
