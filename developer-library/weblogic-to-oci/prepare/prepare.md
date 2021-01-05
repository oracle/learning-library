# Prepare the OCI Account

## Introduction

In this lab we will prepare the OCI environment to provision WebLogic Server for Oracle Cloud Infrastructure from the Marketplace.

Estimated Lab Time: 5 minutes

### Objectives

In this lab you will:

- Create a Vault
- Create a Key
- Create a Secret to hold the WebLogic Admin password
<if type="oke">
- Create a Secret to hold the OCI Docker Image Registry Auth Token
</if>
- Copy the Secret<if type="oke">s</if> OCID<if type="oke">s</if> to use during the provisioning stage

### Prerequisites

For this lab you will need:

- An OCI account with a Compartment created

## **STEP 1:** Create a vault

1. Go to **Security -> Vault**

   ![](./images/prereq-vault1.png =50%x*)

2. Make sure you are in the compartment where you want to deploy WebLogic

3. Click Create Vault

   <img src="../../../prepare/images/prereq-vault2.png"  width="100%">

4. Name the vault `WebLogic Vault` or a name of your choosing. Make sure the `private` option is **not checked** and click **Create Vault**

   ![](./images/prereq-vault3.png =80%x*)

## **STEP 2:** Create a key in the vault

1. Once the vault is provisioned, click the vault

   ![](./images/prereq-vault4.png)

2. then click **Create Key**

   ![](./images/prereq-key1.png)

3. name the key `WebLogicKey` or a name of your choosing and click **Create Key**

   ![](./images/prereq-key2.png =80%x*)

## **STEP 3:** Create a secret for the WebLogic admin password

1. Once the key is provisioned, click **Secrets**

   ![](./images/prereq-secret1.png =60%x*)

2. then **Create Secret**

  ![](./images/prereq-secret2.png =80%x*)

3. Name the **Secret** as `WebLogicAdminPassword`, select the `WebLogicKey` created at the previous step as the **Encryption Key**, keep the default `plaintext` option and type `welcome1` or any WebLogic compliant password (at least 8 chars and 1 uppercase or number) in the **Secret Content** text field, and click **Create Secret**

  ![](./images/prereq-secret3.png)

4. Click the `WebLogicAdminPassword` **Secret** you just created and **make a note** of its **OCID**

   ![](./images/prereq-secret4.png)

<if type="oke">
## **STEP 4:** Create an Auth Token to access OCI Registry

1. Go to **User -> User Settings** and click **Auth Tokens** on the left menu

   ![](./images/auth-token.png =60%x*)

2. Click **Generate Token**

3. Give it a name like **OCIR**

4. Click **Generate Token**

5. Copy the **output** of the token to clipboard

## **STEP 5:** Create a Secret with the Auth Token

1. Go back to the **Security -> Vault -> Secrets** 

2. Click **Create Secret**

3. Name it **OCIR**

4. Use the *same key* (`WebLogicKey`)

5. Paste the **Auth Token** created and copied to clipboard earlier as the **Secret Contents**

6. Click **Create Secret**

7. Click the **OCIR** secret you created and make a note of the **OCID** of the Secret for later use.
</if>

That is all that's needed to get started.

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Weblogic). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
