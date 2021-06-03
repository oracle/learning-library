# Provision and Configure EBS, and Prepare All Data Sources

## Introduction

In this lab, you will provision an EBS instance and the associated networking resources. Thereafter, you will configure the EBS instance and insert data into the EBS database. You will also provision an Autonomous Database and load data into it.

Estimated Lab Time: 60 minutes

### Objectives

- Provision an EBS instance on OCI from OCI Marketplace.
- Connect to the EBS instance, configure it and then load data into EBS.
- Provision an Autonomous Database to act as a data source and load data into it.

### Prerequisites

- Terminal on Unix/Linux or Putty on Windows.
- Access to the following files:
    - [etl\_audit\_tbl.sql](https://objectstorage.us-ashburn-1.oraclecloud.com/p/FBxg5-Eac3jlPXPddxo9FYHPJxUDmC1lJ3PIfG-koiFTCBKr-sUzOdqrQVOiIySm/n/c4u03/b/data-management-library-files/o/modern-data-warehouse/etl_audit_tbl.sql)
    - [controlling\_project\_expenditure.sql](https://objectstorage.us-ashburn-1.oraclecloud.com/p/1-UhNagNzes6rDY22uGAR6-CpnJvOAxY6h6YsWX8JTjQpbPVaJeijwJdkKJ3vtVJ/n/c4u03/b/data-management-library-files/o/modern-data-warehouse/controlling_project_expenditure.sql)
    
**Note:** Please download the files above before continuing.

## **STEP 1:** Create a new security list and a public subnet in VCN

In order to keep the ODI instance and the EBS instance that we are about to provision in separate subnets, we will create a new public subnet in the virtual cloud network (VCN) that was created in Lab 1.

1. Return to the **Associated Resources** tab of the Stack to get to the VCN. In our case, the VCN is on page 2, so we navigate to page 2 and then open the VCN's page in a new tab.

    ![](./images/2.1.png " ")
    
    ![](./images/2.2.png " ")
    
    ![](./images/2.3.png " ")
    
2. In the **Resources** panel on the left side of the screen, click on **Security Lists** and then click on the **Create Security List** button.
    
    ![](./images/2.4.png " ")
    
    ![](./images/2.5.png " ")
    
3. In the form that opens up, provide a name to the security list, let the compartment stay unchanged and then click on **Another Ingress Rule** button.
    
    ![](./images/2.6.png " ")
    
4. We shall be creating 2 ingress rules as shown in the images below. 

    ![](./images/2.7.png " ")
    
    ![](./images/2.8.png " ")
    
5. Similarly, click on the **Another Egress Rule** button and add the egress rule as shown in the image below.

    ![](./images/2.9.png " ")
    
    ![](./images/2.10.png " ")

6. Now, hit the **Create Security List** button. Once the form closes, click on **Subnets** in the panel on the left. Thereafter, click on the **Create Subnet** button.

    ![](./images/2.11.png " ")
    
    ![](./images/2.12.png " ")
    
    ![](./images/2.13.png " ")
    
7. In the panel that opens up, give a name to the subnet. Use the same compartment that you have been using for this lab. For the **CIDR Block** enter **10.0.10.0/24** or any other non-overlapping CIDR range. Choose the bastion-route-table as the route table for the subnet. Now, scroll down and select the security list that you created a few minutes ago to associate it with the subnet. Finally, click on the **Create Subnet** button.
    
    ![](./images/2.14.png " ")
    
    ![](./images/2.15.png " ")
    
    ![](./images/2.16.png " ")
    
## **STEP 2:** Provision EBS on OCI
    
1. Go to navigation menu using the menu button in the top left. Scroll down to the **Solutions and Platform** section. Under **Marketplace**, select **All Applications**.
    
    ![](./images/2.17.png " ")

2. Once on the marketplace home page, type **Oracle E-Business Suite** in the search bar and click on the search button. Thereafter, select an **Oracle E-Business Suite Demo Install Image**. At the time of writing, version 12.2.8 and 12.2.9 were available and 12.2.8 was selected.

    ![](./images/2.18.png " ")
    
3. Let the default version be selected in the **Version** dropdown in the panel on the top right. Keep using the same compartment. Agree to the **Oracle Terms and Restrictions** by clicking on the check box. Now, select **Launch Instance**.

    ![](./images/2.19.png " ")

4. Provide a name to the instance and set the compartment. Leave the **Availability Domain**, **Image** and **Shape** as they are. 

    ![](./images/2.20.png " ")

5. In the **Networking section**, make sure the **Select existing virtual cloud network** option is selected. Choose the VCN that was created by the stack. Now, select the ebs subnet that you created earlier in this lab. Make sure that the **Assign a public IP address** option is selected.
	
    ![](./images/2.21.png " ")

6. For the SSH keys, you may choose to use your own ssh keys or you could use ask OCI to generate a pair for you. We will upload our public key and proceed. After this, check the **Specify a custom boot volume size** checkbox and enter 375 for the **Boot volume size**. Now, click on **Create**.

    ![](./images/2.22.png " ")
    
7. The instance will be provisioned in a few minutes. Please make a note of the public IP address for future reference. 

    ![](./images/2.23.png " ")

## **STEP 3:** SSH into the EBS instance and configure EBS

1. Open a terminal and scp the **etl_audit_tbl.sql** file onto the EBS instance with the following command:

    <copy>scp -i &lt;path_to_private_key&gt; &lt;path_to_etl_audit_tbl.sql&gt; opc@&lt;ebs_instance_public_ip&gt;:</copy>

2. Login to the EBS instance as the opc user using the following command:
    
        ssh -i <path_to_private_key> opc@<ebs_instance_public_ip>
        
3. Now, switch to the root user and move the **etl_audit_tbl.sql** file into the home directory of the **oracle** user and make oracle user the owner of the file. The file will be used towards the end of this lab. 
        
        sudo su
        
        mv /home/opc/etl_audit_tbl.sql /home/oracle/etl_audit_tbl.sql
        
        chown oracle /home/oracle/etl_audit_tbl.sql
        
4. As the root user, execute the updatehosts.sh script.
         
        /u01/install/scripts/updatehosts.sh
        
    ![](./images/2.32.png " ")
    
5. Use **vi** to add the public ip of the EBS instance against the hostname in the hosts file, as shown in the image below. The vi keyboard command to edit is **i**. After the edit, save the file by pressing **escape + :wq**. 
    
        vi /etc/hosts

    ![](./images/2.29.png " ")
    
6. Update all the presently installed packages to their latest available versions using the yum command. You will be asked to agree to the download in a couple of minutes. Enter **y** to agree to the download. The entire process should take approximately 20 minutes. While you wait, you can proceed to Step 4 and Step 5 of this lab. If you choose to do so, please remember to come back and finish the rest of Step 3.
        
        yum update

    ![](./images/2.30.png " ")
    
    ![](./images/2.31.png " ")
    
7. After the update, restart the machine. You will have to ssh back into the machine.

        shutdown -r
    
8. Now, execute the following commands in the order given below.

        sudo su - oracle

        cd /u01/install/APPS
        
        ./scripts/startdb.sh
        
        chmod 744 EBSapps.env
        
        ./EBSapps.env run
        
        mkdir -p ~/logs

        cd  ~/logs
        
    ![](./images/2.33.png " ")
    
9. Execute the following command and when prompted for a password, enter a password of your choosing for the SYSADMIN user.
        
        sh /u01/install/APPS/scripts/enableSYSADMIN.sh
        
    ![](./images/2.34.png " ")
  
10. Similar to the previous command, execute the following command and when prompted for a password, enter a password of your choosing for the DEMO user.

        sh /u01/install/APPS/scripts/enableDEMOusers.sh
        
    ![](./images/2.35.png " ")
 
11. Now, execute the following command and enter the values given below for the prompted questions. The entire process will take approximately 5 minutes.

        sh /u01/install/scripts/configwebentry.sh
        
        Enter the Web Entry Protocol (Eg: https/http): http
        Enter the Web Entry Host Name(Eg: public): apps
        Enter the Web Entry Domain Name:(Eg: example.com): example.com
        Enter the Web Entry Port:(Eg: 443/80): 8000 
        Enter the ORACLE_SID:(Eg: EBSDB): ebsdb 
        Running AutoConfig to complete the configuration
        Enter the APPS user password:  apps
    
    ![](./images/2.36.png " ")  

12. Use the exit command to logout from the oracle user.

13. Now, switch to the root user and execute the given commands.

        sudo su root
        
        iptables -F
        
        firewall-cmd --permanent --zone=public --add-port=1521/tcp
        
        exit
        
    ![](./images/2.39.png " ")
        
14. As the oracle user, execute the following commands:

        sudo su - oracle

        export ORACLE_HOME=/u01/install/APPS/12.1.0

        export ORACLE_SID=ebsdb

        export PATH=$ORACLE_HOME:$ORACLE_HOME/bin:$PATH
    
15. Login to the database as the **apps** user using sqlplus. You should be able to access the database and connect to it.

        sqlplus

        Enter user Name: **apps**
        Enter Password : **apps**
        
    ![](./images/2.41.png " ")

16. Execute the SQL script etl_audit_tbl.sql to create the required tables. 
    
        @/home/oracle/etl_audit_tbl.sql

    ![](./images/2.42.png " ")
    
## **STEP 4:** Provision Autonomous Data Warehouse

1. Go to the navigation menu using the menu button in the top left.

    ![](./images/2.43.png " ")

2. Choose **Autonomous Data Warehouse** from the **Oracle Database** section.

    ![](./images/2.44.png " ")

3. Click on the **Create Autonomous Database** button.

    ![](./images/2.45.png " ")

4. Choose the same compartment as that of the ODI stack. This is a must because a few of our instructions in the later labs depend on this, so please make sure you use the same compartment. Enter the **Display Name** and also enter a name for the **Database**. Leave everything else set to the default values.

    ![](./images/2.46.png " ")

5. Scroll down and provide a password for the administrator.

    ![](./images/2.47.png " ")

6. If a license type is not selected by default, make the appropriate selection. Thereafter, hit **Create Autonomous Database**.

    ![](./images/2.48.png " ")

7. The database should be up and running in a couple of minutes. 

    ![](./images/2.49.png " ")

8. Initiate download of the wallet file by clicking on the **DB Connection** button. In the dialog box that opens, click on **Download Wallet**. You will be prompted to enter a password for the wallet file. This password has no relation with the database password, so feel free to choose any password. Hit **Download**.

    ![](./images/2.50.png " ")
    
    ![](./images/2.51.png " ")
    
    ![](./images/2.52.png " ")
        
## **STEP 5:** Creating Tables in Database

1. Use SQL Developer to connect to your newly created Autonomous Database. Instructions for connecting to an Autonomous Database via SQL Developer can be found [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/connect-sql-dev182.html#GUID-14217939-3E8F-4782-BFF2-021199A908FD).

2. Now, go ahead and run the **controlling\_project\_expenditure.sql** script to create the tables.

3. The following tables should be visible: COST, COUNTRY\_FORECAST, PPM\_BUDGET\_VS\_ACTUAL, PPM\_ROLLED\_UP, STEEL\_TARIFF, STEEL\_TOTAL\_COST\_FORECAST.

**Note:** If you haven't completed step 3, please return and complete it now.

You may now proceed to Lab 3.

## Acknowledgements
- **Author** - Srinidhi Koushik, Manager, Technology Hub, April 2021
- **Contributor** - Yash Lamba, April 2021
- **Last Updated By/Date** - Yash Lamba, May 2021
