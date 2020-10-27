# Complete DR Configuration & Perform Failover
## Introduction
The final lab in this workshop will help you connect to the backup database and connect to the APEX instance replicated by RackWare (RMM).

Estimated Lab Time: 30-45 minutes

### Objectives
- Connect the target APEX instance to the backup database
- Failover to the backup database 
- Connect to the replicated APEX instance

### Prerequisites
- Succesful completion of all previous labs in this workshop

## **Step 1:** Connect the new instance to the Backup database
1. Start an ssh connection to the newly created instance.
2. Navigate to the root compartment and edit the *defaults.xml* file
    ```
    opc@<target-machine>$ sudo su -
    root@<target-machine>$ vi /home/oracle/conf/ords/defaults.xml
    ```
3. Change the db.hostname entry to relfect the IP of the backup database
    ![](./images/defaults-db.PNG)

4. Update the db.hostname in *ords_params.properties* file to reflect the IP of the backup database
    ```
    root@<target-machine>$ vi /home/oracle/params/ords_params.properties
    ```
    ![](./images/params-db.PNG)
5. Start the ORDS server on the target machine *(You must complete this step after each sync)*
    ```
    root@<target-machine>$ sudo su - oracle
    oracle@<target-machine>$ ./start_ords.sh
    ```
6. Create a .txt file with the following two lines and save to your local machine:
    ![](./images/excl.PNG)
7. From the RackWare GUI, locate the wave you replicated and click the blue name.
    ![](./images/rack-wave.PNG)
8. Click the blue edit box on the row of your host machine.
    ![](./images/edit.PNG)
9. Under **Sync Options**, select the **Browse** button under **Upload local File** & add the .txt file created in step 6. Click **Modify**
    ![](./images/sync.PNG)
*(This will make sure the new instance points to the backup database after every sync)*


## **Step 2:** Conduct the failover operation to activate the backup database

1. Navigate to the standby database
    ![](./images/db-nav.PNG)
2. Click the database name under the backup DB System
    ![](./images/db-name.PNG)
3. Under **Resources** on the left, choose Data Guard Associations. Click the three dots on the right and select **Failover**
    ![](./images/failover.PNG)
4. Enter the database password and click OK. The failover operation will take a few minutes to complete.
    ![](./images/db-pass.PNG)
5. Navigate back to the StandbyDatabase DB system and look at the Peer Role under Data Guard Associations. It shows Disabled Standby which also reaffirms that the failover was successful.
    ![](./images/pr-role.PNG)

## **Step 3:** Verify the APEX application changes in the new Instance
1. Navigate to the new APEX instance through a web browser i.e. https://<target-public-ip>:8888/ords/drpdb
2. Login with the same workspace & admin credentials created in step 3 & 5 of **Lab Guide 200**
    ![](./images/login.PNG)
3. Select the **App Builder** icon.
    ![](./images/app-build.PNG)
4. Run the **Sample Database Application** by pressing the play button next when you hover over the applications.
    ![](./images/hover.png)
5. Navigate to the **Products** using the shopping cart icon on the left to verify the "Hat" product was added.
    ![](./images/hat2.PNG)
    
**Congratulations! If you see the change reflected in the new instance, you have successfully created a Disaster Recovery setup using RackWare on OCI!**

## Acknowledgements
- **Author** - Will Bullock
- **Last Updated by/date** Will Bullock, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request. If you don't see the workshop listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

