# Oracle Database Security Hands-On Labs - Part2 (Advanced)

## Objectives
**This workshop is the SECOND PART of the Hands-On Labs dedicated to the Oracle Database Security features and functionalities.**

These workshops give the user an opportunity to learn how to configure the DB Security features to protect and secure their databases from the Baseline to the Maximum Security Architecture (MSA).

This 2nd workshop is dedicated to the advanced features of the Database Security and it will cover following products and solutions:
- Oracle Advanced Security Option (ASO)
   - Oracle Transparent Data Encryption (TDE)
   - Oracle Data Redaction
- Oracle Database Vault (DV)
- Oracle Label Security (OLS)
- Oracle Data Masking and Subsetting (DMS)
- Oracle Audit Vault and Database Firewall (AVDF)
- Oracle Key Vault (OKV)

For more detail about the 1st workshop, please refer to the *Oracle Database Security Hands-On Labs - Part1 (Baseline)*.

## About this Workshop
Based on an OCI architecture, deployed in a few minutes with a simple internet connection, it allows you to test DB Security use cases in a complete environment already pre-configured by the Oracle DB Security PMs Team.

Now, **you no longer need important resources on your PC** (storage, CPU or memory), nor complex tools to master, **making you completely autonomous to discover** at your rhythm all new DB Security features, but also you can even now **make your own live demonstration** in front of your customers.

In this workshop, you will find details of the use cases and scenarios that we put at your disposal so that you can discover and learn more about Oracle DB Security solutions.

The complete architecture of the DB Security Hands-On Labs is composed of 4 VMs as below:

   ![](./images/dbseclab-v3-archi.png)

- DBSec-Lab VM (*Mandatory for all workshops: Baseline and Advanced workshops*)
- AV Server VM (*for Advanced workshop only*)
- DBF Server VM (*for Advanced workshop only*)
- OKV Server VM (*for Advanced workshop only*)

During this 2nd workshop, you'll use different resources to interact with these VMs:
- SSH Terminal Client
- Glassfish HR App
- Oracle Enterprise Manager 13c
- Oracle AVDF Web Console (*for AVDF labs only*)
- Oracle Golden Gate Web Console (*for AVDF labs only*)
- Oracle Key Vault Web Console (*for OKV labs only*)
- (Optionnally) SQL Developer

So that your experience of this workshop is the best possible, DO NOT FORGET to perform lab "*Initialze and Start the DBSecLab Environment*" to be sure that all these resources are correctly set!

The entire DB Security PMs Team wishes you an excellent workshop.

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Pedro Lopes, Gian Sartor, Rene Fontcha
- **Last Updated By/Date** - Hakim Loumi, 20th October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.