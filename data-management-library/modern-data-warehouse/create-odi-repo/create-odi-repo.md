# Create and Connect to ODI Repository

## Introduction

In this lab, you will create a master and a work repository, both of which are needed to run data integrations. After creating the work repository, you will connect to it. 

Estimated Lab Time: 30 minutes

### Objectives

- Create and connect to master and work repositories in ODI. 

### Prerequisites

- ADW and ODI instance created in Lab 1.
- ADW wallet file downloaded in Lab 1.
- Access to the following file: 
    - [ModernDW\_Schema.sql](https://objectstorage.us-ashburn-1.oraclecloud.com/p/zqaUA8691p3f_QwquDdNmlzVLy6cglVISPOmhfEd5k0qpHUemNDaaWC_XwLLSFw4/n/c4u03/b/data-management-library-files/o/modern-data-warehouse/ModernDW_Schema.sql)
    
## **STEP 1:** Create Empty Target Tables and ODI Schema in Autonomous Data Warehouse

1. Connect to the Autonomous Data Warehouse that we created as part of the ODI-ADW-OAC stack as the ADMIN user via SQL Developer. We downloaded the wallet to the local machine in the previous lab.

2. Run the commands below to create a schema for the metadata repository. We will call this schema **ODI**. Replace **MyPassword** in the first command with a password of your choosing.
    
        create user ODI identified by MyPassword;
    
        grant DWROLE to ODI;
    
        grant unlimited tablespace to ODI;
    
        grant PDB_DBA to ODI;   

3. Now, run the following commands to create **EBS** schema for the target tables. Replace **MyPassword** in the first command with a password of your choosing.

        create user EBS identified by MyPassword;
    
        grant DWROLE to EBS;
    
        grant unlimited tablespace to EBS;
    
        grant PDB_DBA to EBS;   
    
4. Connect to the ADW instance, again, but this time as the EBS user and execute the **ModernDW\_Schema.sql** script to create empty target tables for our integration under the EBS schema. 
   
## **STEP 2:** Create ODI Master Repository

In order to use ODI, we need to create a master and work repository. For this, we are going to use the Autonomous Data Warehouse that was spun up as part of the stack.

1. Return to ODI Studio.

    ![](./images/4.1.png " ")
    
2. Click on **File**, then **New**.

    ![](./images/4.2.png " ")
    
3. Select **Create a New Master Repository** and press **OK**.

    ![](./images/4.3.png " ")
    
4. From the **Technology** drop down, select **Oracle**. Select the **Use Credential File** option and click on the magnifying glass icon in front of the **Credential File** field. The file should be in **/home/Oracle/Desktop**. Thereafter, choose the high connection in the **Connection Details** drop down. The JDBC URL will get auto-populated. Now, enter **ODI** as the user and provide the password for the ODI schema. The DBA User would be ADMIN. Please enter its password, as well.

    ![](./images/4.4.png " ")
    
5. Click on **Test Connection**. If everything was done correctly, you should see a **Successful Connection** message. If not, then please fix the error and proceed. Now, click on **Next**.

    ![](./images/4.5.png " ")
    
6. On the **Authentication** page, enter **SUPERVISOR** as the **Supervisor User**, please provide the supervisor password and confirm it. Then, hit **Next**. Click on **Finish** on the final page.

    ![](./images/4.6.png " ")
    
    ![](./images/4.7.png " ")
    
7. ODI Studio will take 3-5 minutes to create the repository. Once it is done, you will see a prompt telling you that the creation was successful.

    ![](./images/4.8.png " ")
    
    ![](./images/4.9.png " ")

## **STEP 3:** Connect to Master Repository

1. Click on **Connect To Repository** and click on the **+** sign in the login prompt to create a new login. 
    
    ![](./images/4.10.png " ")

    ![](./images/4.11.png " ")

2. Provide a name to the login and enter **SUPERVISOR** as the user and provide the password for **SUPERVISOR**. In the Database Connection section, enter ODI as the user and provide the password to the ODI schema. From the driver list drop down, select **Oracle JDBC Driver** and select the **Use Credential File** check box. As done previously, select the ADW wallet in the credential file selector and choose the high connection. 

    ![](./images/4.12.png " ")
    
3. Test and connection and make sure that the test is successful, fixing any errors encountered along the way.

    ![](./images/4.13.png " ")

4. Now, select the **Login Name** that you just created. Enter **SUPERVISOR** in the user field and enter the password. Clicking **OK** will prompt you to enter the ADW wallet's password. Provide the password, click **OK** and you will find yourself logged into the Master Repository.

    ![](./images/4.14.png " ")
    
    ![](./images/4.15.png " ")
    
## **STEP 4:** Create a Work Repository

1. Click on the **Topology** tab. Expand the repositories section. Under the master repository, you will find Work Repositories. Right click and select **New Work Repository**.

    ![](./images/4.16.png " ")

2. In the connection properties, set the **Technology** drop down to **Oracle** and check the **Use Credential File** checkbox. Now, select the ADW wallet as the **Credential File** and choose the high connection. Finally, set **User** to ODI and provide the password to the ODI schema. Then, click **Next**.

    ![](./images/4.17.png " ")

3. Give the work repository a name of your choosing and set a password. You can leave the repository type set to **Development**. Hit **Finish** to get a confirmation dialog and agree to creating a login with a **Yes**.

    ![](./images/4.18.png " ")
    
    ![](./images/4.19.png " ")

4. Give a login name and select **OK**. This will throw a prompt asking for the ADW wallet's password. Provide the password and click on **OK**.

    ![](./images/4.20.png " ")
    
    ![](./images/4.21.png " ")

**Note:** The repository should be up and running in a couple of minutes.

![](./images/4.22.png " ")

## **STEP 5:** Connect to the Work Repository

1. Select the **Designer** tab and then disconnect from the master repository.
    
    ![](./images/4.23.png " ")

2. Click on **Connect to Repository** and choose the Work Repository in the **login name** drop down.

    ![](./images/4.24.png " ")
    
3. Enter **SUPERVISOR** as the user and provide its credentials. Click on **OK** to get connected to the work repository.

    ![](./images/4.25.png " ")

    ![](./images/4.26.png " ")

You may now proceed to Lab 5.

## Acknowledgements
- **Author** - Yash Lamba, Cloud Native Solutions Architect, January 2021
- **Last Updated By/Date** - Yash Lamba, April 2021
