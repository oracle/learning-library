# Prepare the OCI account

## Introduction

We will prepare the OCI environment to provision WebLogic Server for Oracle Cloud Infrastructure (OCI) from the Oracle Cloud Marketplace.

Estimated Completion Time: 5 minutes.

### Objectives

- Create a Vault.
- Create a Key.
- Create a Secret to hold the WebLogic Admin password.
- Create a Secret to hold the OCI Docker Image Registry Auth Token.
- Copy the Secret OCIDs to use during the provisioning stage.

### Prerequisites

- An OCI account with a compartment created.

## **STEP 1:** Create a vault

1. On the **Security** menu, click **Vault**.

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

## **STEP 4:** Create an Auth Token to Access OCI Registry

1. On the **User** menu, click **User Settings** then click **Auth Tokens** on the left menu.

   ![](./images/auth-token.png " ")

2. Click **Generate Token**.

3. Give it a name like **OCIR**.

4. Click **Generate Token**.

5. Copy the **output** of the token to clipboard.

## **STEP 5:** Create a Secret with the Auth Token

1. On the **Security** menu, click **Vault** then **Secrets**.

2. Click **Create Secret**.

3. Name it **OCIR**.

4. Use the *same key* (`WebLogicKey`).

5. Paste the **Auth Token** created and copied to clipboard earlier as the **Secret Contents**.

6. Click **Create Secret**.

7. Click the **OCIR** secret you created and make a note of the **OCID** of the secret for later use.

That is all that's needed to get started.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020
