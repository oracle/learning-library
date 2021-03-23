# Setting Up RackWare DR Components
## Introduction
This lab walks through the steps for configuring the RackWare Migration Manager (RMM), which replicates the source APEX instance.

Estimated Lab Time: 45-60 minutes

### Objectives
- Import the RMM
- Configure the RMM to replicate to the source instance
- Setup the DR policy

### Prerequisites
- Successful completion of previous labs in this workshop

## **STEP 1:** Import RMM Image from Rackware
1.	Navigate to <a href="https://cloudmarketplace.oracle.com/marketplace/en_US/homePage.jspx" target="_blank">Oracle Marketplace</a>
2.	Search "RackWare" and select the "RackWare Migration Manager (RMM)"
    ![](./images/rmm-market.PNG)
3.	Click "Get App" and sign into your OCI Console
    ![](./images/oci-sign.PNG)
4.	Launch the instance in the target compartment (This should be the same compartment as the one that will contain the instances of the migrated servers.)
    ![](./images/launch.png)
5.	Enter a Name for the instance.\
    a.	e.g. dr_rackware_rmm
6.	Give the instance a shape appropriate for your deployment.
7.   In the ‘Add SSH Keys’ either upload your ssh key to connect to the instance after it is created or paste the key contents
    ![](./images/add-ssh-keys.png)

## **STEP 2:** Configure the RackWare Migration Components
Use the following **[guide](https://www.rackwareinc.com/rackware-rmm-oracle-marketplace-dr-march-2020)** to complete the RackWare deployment configuration. (Use the passthrough method)

## **STEP 3:** Create DR policy in RackWare
**After you have completed the RackWare guide you must make a DR policy in RackWare to keep the source & target machines synced.**
1. Start by navigating to the RackWare GUI and logging in with your RackWare admin credentials.
    ![](./images/gui.PNG)  

2. Under **DR** on the left-hand side select **Policies** and click the **+** button.
    ![](./images/dr-pol.PNG)

3. Enter a name and a frequency for syncing your machines. The rest of the fields are optional. Click **Create**.
    ![](./images/active.PNG)

4. From the RackWare GUI, locate the wave you replicated and click the blue name.
    ![](./images/rack-wave.PNG)

5. Click the blue ***No Policy*** button right of the DR label
    ![](./images/no-pol.PNG)

6. Select the DR Policy you just created from the dropdown and click Assign Policy.
        ![](./images/assign.PNG)

7. Use the left & right arrows to preform Failover & Fallback.
    ![](./images/failfall.PNG)  
    
You may now **proceed to the next lab.**

## Acknowledgements
- **Author** - Will Bullock
- **Last Updated by/date** Will Bullock, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

