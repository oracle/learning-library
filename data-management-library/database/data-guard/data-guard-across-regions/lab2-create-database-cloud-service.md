# Create your Primary Database with the Oracle Database Cloud Service

The Oracle Database Cloud Service automates the provisioning and management of the Oracle database in the cloud.  We will create the Oracle Database Cloud Service as the primary database in one of the cloud regions.  The standby database will be automatically created when we set Data Guard association later.

Estimated lab time:  5 minutes
Estimated wait time: 20 minutes to create database

### Objective
- Create the Oracle Database Cloud Service as the primary database

### Prerequisite
- VCN with private subnet


## STEPS
1. Select a region for your primary database.
2. Select the menu Oracle Databases then Bare Metal, VM, and Exadata.
3. Select your compartment.
4. Click Create DB System.
5. Ensure your compartment is selected.
6. Enter a name for your database for the UI display.
7. Keep the default Database image or change to the version you want.  

If you have more than one availability domain, select any one.

For the lab we will use a virtual machine with only one core.  

Data Guard supports RAC databases, but we'll use a single instance database in the lab.  

Standard Edition does not support Data Guard, select the other Enterprise editions.

![image-20210121184635385](./images/image-20210121184635385.png)



7. For faster provisioning for this lab, select Logical Volume Manager.

8. Use the default storage size.

9. Add your SSH public key.



![image-20210121184848646](./images/image-20210121184848646.png)



10. Select BYOL if you have an existing Oracle license to use.   If not, select License Included which means you are subscribing to a new database license.  If you are using a free credits account, you will not be charged.

11. Select your VCN you created earlier.

12. Select the private subnet.  Your databases should be provisioned in a private subnet for security.

13. Give it a hostname prefix.

14. Click Next



![image-20210121185143404](./images/image-20210121185143404.png)

15. Provide a database name, must be 8 characters or less.

16. Provide a strong password for your database sys user.

17. Select Transaction Processing or Data Warehouse.

18. Click Create DB System.  Your Oracle Database Cloud Service will be created in a few minutes.


![image-20210121185604333](./images/image-20210121185604333.png)

You may now proceed to the next lab.
