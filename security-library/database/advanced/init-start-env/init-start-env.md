# Initialize Environment

## Introduction
This lab will show you how to initialize and start the DBSecLab environment

### Objectives
-   Import the latest labs scripts from Oracle repository
-   Start all the DBSec-Lab components

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup (Free Tier and Paid Oracle Cloud Accounts Only)
    - Lab: Environment Setup

## **STEP 1**: Start all the DBSec-Lab components
Before performing the workshop, you have to start all the components!

1. Open a SSH session on your DBSec-Lab VM as Oracle User

      ````
    <copy>sudo su - oracle</copy>
      ````

2. Start DBSec-Lab Environement

      ````
    <copy>./start_DBSecLab.sh</copy>
      ````

**Note**: It can take up to 10 minutes (with 4 oCPUs)

Once it's started, check that all necessary labs resources are operational

3. From your web browser, make sure you have access the following resources:
   - **Oracle EM 13c**      : `https://<YOUR_DBSECLAB-VM_PUBLIC-IP>:7803/em`
   - **My HR Application** on Glassfish:
      - PDB1
        - Prod        : `http://<YOUR_DBSECLAB-VM_PUBLIC-IP>:8080/hr_prod_pdb1`
        - Dev         : `http://<YOUR_DBSECLAB-VM_PUBLIC-IP>:8080/hr_dev_pdb1`   (bg: red)
      - PDB2
        - Prod        : `http://<YOUR_DBSECLAB-VM_PUBLIC-IP>:8080/hr_prod_pdb2`  (menu: red)
        - Dev         : `http://<YOUR_DBSECLAB-VM_PUBLIC-IP>:8080/hr_dev_pdb2`   (bg: red & menu: red)
   - **Oracle AVDF** Web Console (for AVDF labs only) : `https://<YOUR_AVS-VM_PUBLIC-IP>`
   - **Oracle Key Vault** Web Console (for OKV labs only) : `https://<YOUR_OKV-VM_PUBLIC-IP>`

**Note**: In case of error, please check your **internet connection settings** (Web Application Firewall (WAF) or Web Proxy)

4. **Congratulations, now your environment is up and running and you can start performing the labs!**

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Pedro Lopes, Gian Sartor, Rene Fontcha
- **Last Updated By/Date** - Hakim Loumi, 2nd November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
