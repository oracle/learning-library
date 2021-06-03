# Configure Integrations and load data into ADW using ODI

## Introduction

In this lab, you will configure and run the ODI integrations. For the EBS data source, you will use smart import in ODI and use an available mapping. For the ADW data source, you will create the mapping between the source and destination databases.  

Estimated Lab Time: 60 minutes

### Objectives

- Use Smart Import to create an integration that moves data from your EBS to the destination data warehouse.
- Create mappings to move data from database to ADW.
- Run integrations.

### Prerequisites

- Credentials and details of the EBS database, the source ADW, the target ADW and the ODI repositories.

## **STEP 1:** Use Smart Import to import mappings and other objects

1. Click on the **Designer** tab. Press the dropdown in the top right of the **Designer** pane as shown in the image below. Then, select **Import**.

    ![](./images/5.1.png " ")
    
2.	In the menu that opens up, select **Smart Import** and click on **OK**.

    ![](./images/5.2.png " ")
    
3.	Click on the magnifying glass icon to select the path to the **EBS_ODI_ADW.xml** file. We downloaded it to the home folder of the oracle user in step 1 of Lab 3. Hence, the path should be **/home/oracle/EBS_ODI_ADW.xml**. After finding the file, click on the **Next** button.

    ![](./images/5.3.png " ")
    
    ![](./images/5.4.png " ")
    
    ![](./images/5.5.png " ")

4.	Validate that the **Smart Import – Step 2 of 3** gets prompted with no issues. If yes, then click on **Next** and in the next window click on **Finish**. This will begin the smart import. The import should take around 5 minutes.

    ![](./images/5.6.png " ")
    
    ![](./images/5.7.png " ")
    
    ![](./images/5.8.png " ")
    
5.	Close the report that is displayed, once the process is complete.

    ![](./images/5.9.png " ")

## **STEP 2:** Update EBS Source Configuration

A data server stores information according to a specific technical logic which is declared into **physical schemas** attached to the data server itself. Every database server or group of flat files that is used in Data Integrator, must be declared as a data server. Smart Import allowed us to import a couple of data servers, but they need to be configured to point to the EBS instance that we spun up and the ADW we intend to use as target.

1. On the **Topology** tab, first hit the **Refresh** icon and then under **Physical Architecture**, expand **Technologies** and scroll down till you find **Oracle**. Expand **oracle** to find the 2 data servers that we just imported.

    ![](./images/5.10.png " ")
    
    ![](./images/5.11.png " ")
    
2. **Right click** on **EBS_SRC** and select **Open**.

    ![](./images/5.12.png " ")
    
3. In the **Definition** tab, enter the **User** and **Password** as **apps**. 

    ![](./images/5.13.png " ")
    
4. Click on **JDBC** and replace the IP address in the JDBC URL with the IP address of your EBS instance. Select **Test Connection**. Hit **Test** in the dialog box that shows up. A prompt stating **Successful Connection** should show up, if everything has been set up correctly. 

    ![](./images/5.14.png " ")
    
    ![](./images/5.15.png " ")
    
    ![](./images/5.16.png " ")
    
**Note:** In case the connection is not successful, ssh into the EBS instance as the oracle user and execute the following commands:  
    
        sudo su - oracle

        export ORACLE_HOME=/u01/install/APPS/12.1.0

        export ORACLE_SID=ebsdb

        export PATH=$ORACLE_HOME:$ORACLE_HOME/bin:$PATH
        
        sqlplus
    
        
Now, try logging in as the **apps** user. If you are successfully able to login, test the connection again. If not then you might have to debug the issue.

## **STEP 3:** Update Target Configuration

1. Similar to how you opened **EBS_SRC** in step 2, **right click** on **ADWC_TRG** and select **Open**. An error will show up complaining about missing credentials. Click on **OK** to close the dialog. Enter the details of the ADW that we spun up in Lab 1 as part of the stack. In the **Definition** tab, enter the details of the **ADMIN** user and click on the **magnifying glass** icon to select the ADW wallet file that we had secure copied (scp) onto the Desktop and select **Open**.

    ![](./images/5.17.png " ")
    
    ![](./images/5.18.png " ")
    
2. Select the high connection from the connection details dropdown and  save the connection by clicking on the **Save** button, right under the **Edit** menu.

    ![](./images/5.22a.png " ")
    
3. Click on the **Test Connection** button. If not already saved, ODI will prompt you to save the connection details. Save the details and continue. Hit **Test** in the dialog box that opens up. If everything is correct, you will see a successful connection dialog box. Click on **OK** to close it.
    
    ![](./images/5.19.png " ")
    
    ![](./images/5.20.png " ")
    
    ![](./images/5.16.png " ")
    
4. Expand the **ADWC_TRG** data server and double click the physical schema. 

    ![](./images/5.21.png " ")
    
5. Make sure that both the schema dropdowns, point to the **ADMIN** schema. If not, then select **ADMIN** and save the change.
    
    ![](./images/5.22.png " ")
    
    ![](./images/5.22a.png " ")
    
**Note:** Secure copying the ADW wallet onto the ODI instance is one of the easiest ways in which you can make the credential file of an ADW available to ODI. This method works for any ADW instance regardless of whether it is in the same compartment as the ODI instance or not. We will show an even easier method in Step 5, but it is applicable only to the ADW instances that share the compartment with the ODI instance.

## **STEP 4:** Configure and run the integration

1.  Return to the **Designer** tab and click on the refresh button. A project name **EBS_ADWC_Data_Migration** will appear.

    ![](./images/5.23.png " ")
    
2. Expand the project and the **First Folder** inside, to unveil **Packages**, **Mappings** and **Procedures**. Expand the **Mappings**.

    ![](./images/5.29.png " ")

3. **Right click** on the mapping **m_Full_d_V_MTL_CAT_B_KFV** and then click on ** Run** to execute the mapping. Press **OK** in the dialog box that appears. After a few seconds, another dialog box stating that the session has started will appear. Press **OK** again. This has to be repeated for the following 2 packages: **m_Full_d_V_PO_VENDORS**, **m_Full_d_V_PO_VENDOR_SITES**.

    ![](./images/5.30.png " ")
    
    ![](./images/5.31.png " ")
    
    ![](./images/5.32.png " ")
    
4. You can monitor the status of each mapping execution by navigating to the **Operator** tab, expanding **Date** and the day of your integration.

    ![](./images/5.33.png " ")
    
5. Return to the **Designer** tab and expand **Packages**. **Right click** on a package and then click on ** Run** to execute the package. Press **OK** in the dialog box that appears. After a few seconds, another dialog box stating that the session has started will appear. Press **OK** again. This has to be repeated for each of the packages, one-by-one.
    
    ![](./images/5.25.png " ")
    
    ![](./images/5.26.png " ")
    
    ![](./images/5.27.png " ")
    
6. You can monitor the status of each package execution, similar to how you monitored the execution of the mappings by navigating to the **Operator** tab. If you can't see the status of the package executions, hit **Refresh**.

    ![](./images/5.28.png " ")
    
7. On the **Designer** tab, expand **Procedures**. **Right click** on **CREATE_VIEW_ADW** procedure and then click on ** Run** to execute it. Press **OK** in the dialog box that appears. After a few seconds, another dialog box stating that the session has started will appear. Press **OK** again. You can monitor the status of the execution to know when it is complete.
    
    ![](./images/5.34.png " ")
    
    ![](./images/5.35.png " ")
    
    ![](./images/5.27.png " ")
    
    ![](./images/5.36.png " ")
    
**Note:** With the completion of this step, you have successfully executed an integration and moved data from EBS onto the target ADW. In addition, you have also created some views on top of the tables. We encourage EBS users to explore the data in the tables and views in the next lab.

## **STEP 5:** Set up another Data Server

1.  On the **Topology** tab, under **Physical Architecture**, expand **Technologies** and scroll down till you find **Oracle**. Right click on it and then choose **New Data Server**.

    ![](./images/5.10.png " ")
    
    ![](./images/5.40.png " ")
    
2. Click on the **Discover ADBs**, next to the **Test Connection**. This will detect all ADBs in the same compartment as the ODI instance, which is why you were asked to spin up the source ADW in the same compartment.

    ![](./images/5.41.png " ")
    
3. Now, select the ebs database. The **Data Server** screen will now be updated to use the Credential file for the ADW. Fill in the required details including: Connection Name, User (ADMIN), Password and select the high connection. Test the connection and save it, as well.

    ![](./images/5.42.png " ")
    
    ![](./images/5.43.png " ")

4. **Right Click** on the newly created **Data Server** and click on **New Physical Schema** to create a **Physical schema**. Choose the schema containing the tables that have to be transferred.

    ![](./images/5.37.png " ")
    
    ![](./images/5.44.png " ")

5. Click on the **Context** tab and configure a logical schema. Click on the **+** sign, under **Context**, select **Global** and then type **Source** as the name for your logical schema. Hit **Save**.

    ![](./images/5.45.png " ")
    
## **STEP 6:** Set up the Destination Data Server

1.  Right click on the **ADWC_TRG** data server and then click on **New Physical Schema** to create one. Choose the **EBS** schema, since that is where we have created our empty target tables.

    ![](./images/5.38.png " ")
    
    ![](./images/5.39.png " ")

2. Click on the **Context** tab and configure the second logical schema. Click on the **+** sign, under **Context**, select **Global** and then type **Destination** as the name for your logical schema. Hit **Save**.

    ![](./images/5.46.png " ")
    
## **STEP 7:** Create Models for Source and Destination Schemas

We will now create models based on the logical schema we created. 

1. Click on the **Designer** tab. Go down to the **Models** panel. Click on the **Folder Icon** to the right of **Models** and select **New Model**.

    ![](./images/5.47.png " ")

2. Give the model a name, choose **Oracle** as the **Technology**, select **Source** as the **Logical Schema** and choose **Oracle Default** as the **Action Group**. Save the model and click on **Reverse Engineer**. The Reverse Engineering should be complete in a matter of seconds.

    ![](./images/5.48.png " ")
    
3. Repeat this step for the Destination Model. This time set the **Logical Schema** to **Destination**. Reverse Engineering should take just a few seconds, here as well.

    ![](./images/5.49.png " ")

## **STEP 8:** Set up another Integration Project

Now that you have configured your connections to your source and destination, we will create the mapping and move the data between the two systems. An integration project is composed of several components. These components include organizational objects, such as folders, and development objects such as mappings or variables.

1. Under **Designer**, click **New Project** in the toolbar of the **Projects** section. Enter a Name for the project, and hit **Save**.

    ![](./images/5.50.png " ")
    
    ![](./images/5.51.png " ")

**Note:** For more about ODI integration projects, click [here](https://docs.oracle.com/middleware/1212/odi/ODIDG/projects.htm#ODIDG311).

## **STEP 9:** Design your Mapping and Run the Integration

1. Go back to the **Projects** section and expand your project. Under **First Folder**, **right click** on **Mappings** and create a new mapping with a name of your choosing. Make sure to deselect **Create Empty Data Set**.

    ![](./images/5.52.png " ")
    
    ![](./images/5.53.png " ")
    
2. Go to the **Models** section, expand the **Source** model and drag your tables to the mapping interface.
    
    ![](./images/5.54.png " ")

3. Similarly, drag over the tables from the destination model and place the source and their destination counterparts side-by-side. 

    ![](./images/5.55.png " ")
    
4. One-by-one connect the different counterparts together by name. **By name** matches the names of the source to the target. Leave everything as it is and select **OK**.

    ![](./images/5.56.png " ")
    
    ![](./images/5.57.png " ")

5. Click on the **Physical** tab and select the icon between the source and destination tables for each of the combinations and change the **Loading Knowledge Module** property to **LKM Oracle to Oracle (Built-In) GLOBAL**.

    ![](./images/5.58.png " ")

6. You are now ready to run the integration. Click on the green start button to run your integration. Click **OK** on the prompt that shows up.

    ![](./images/5.59.png " ")
    
    ![](./images/5.60.png " ")

7. You can monitor the status of the integration by navigating to the **Operator** tab. Upon successfully completion, your data should be in the target table.

    ![](./images/5.61.png " ")

You may now proceed to Lab 6.

## Acknowledgements
- **Authors** - Yash Lamba, April 2021
- **Contributor** - Srinidhi Koushik, April 2021
- **Last Updated By/Date** - Yash Lamba, April 2021

