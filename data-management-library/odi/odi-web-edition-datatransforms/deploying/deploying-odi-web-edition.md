
# Deploying ODI Web Edition

## Introduction

Oracle Data Integrator (ODI) is Oracle's industry-leading, enterprise-class data integration tool. It features an extract-load-transform (ELT) architecture, which delivers very high performance, scalability and reliability because it uses the target database to execute transformations. Why do an **E** and an **L** if all you want to do is a **T**? That's the problem with legacy ETL tools with server-based architectures that require data to be extracted for processing (transformation) and reloaded afterwards. ODI Web Edition brings this power and pedigree to a wider user base through the Data Transforms tool, which provides a simple drag and drop low-code environment for creating data integration projects.

ODI Web Edition needs to be deployed from OCI Marketplace before we can use Data Transforms. In this lab we will go through the steps to create an  ODI Web Edition instance.

Estimated Lab Time: 60 minutes

### Objectives

In this lab, you will:

- Create an ODI Web Edition instance

- Register it with Autonomous Database so that Data Transforms can be launched from the Database Tools page

### Prerequisites

To complete this lab, you need to have the following:

- Autonomous Database, which will host repository for ODI Web Edition

- SSH Key

- OCI privileges (work with your tenancy administrator)

    - Available resource in OCI to create VCN, Stack and Compute instance

    - Privilege to create VCN

    - Privilege to create OCI dynamic group and policies

- Privilege to create an OCI compartment or access to a compartment

- Knowledge of basic concepts of OCI console navigation 

## **STEP 1:** Create OCI Policies for ODI Web Edition Deployment

1. **NOTE:** If you have already been provided a compartment then skip this step. For the remaining steps, replace compartment name `odi` with your assigned compartment name. Create a compartment `odi` where ODI Web Edition related artifacts will be created. Make sure you have a privilege to create a compartment or request your administrator to give you a compartment. Use this compartment for the rest of the lab. Navigate to **Identity & Security > Compartments** and create a compartment. 

    ![ALT text is not available for this image](images/3018124962.jpg)

2. **NOTE:** If you have already been provided a compartment then skip this step. Create a compartment named `odi`. If you already have access to a compartment provided by your administrator then skip creation. You should also copy the OCID of your compartment since it is needed in the next step.

    ![ALT text is not available for this image](images/3018124982.jpg)

3. Navigate to **Identity & Security > Dynamic Groups**.

    ![ALT text is not available for this image](images/3018125018.jpg)

4. Create a dynamic group `odi`; to include matching rules for instances in a specified compartment. Replace the OCID of your compartment in the example. For example:

    ALL {[instance.compartment.id](http://instance.compartment.id) = 'ocid1.compartment.oc1..aaaaaaaabgr34tpuanpvq6xfb667nsmy2jz45zj6dexojhxdsv4mjayem3cq'}

    ![ALT text is not available for this image](images/3018124858.jpg)

5. Navigate to **Identity & Security > Policies**.

    ![ALT text is not available for this image](images/3018125033.jpg)

6. Select your compartment under **List Scope** and click **Create Policy**.

    ![ALT text is not available for this image](images/3018125047.jpg)

7. Create a policy named `odi_policies`.

    ![ALT text is not available for this image](images/3018125065.jpg)

8. Click on `odi_policies` to add policies. Use the manual editor.

    Set policy at your compartment level. All ADW/ATP instances in the compartment where the ODI instance is created will be accessed during deployment. Copy and paste the policies below in the editor window and click **Create**.

    **NOTE:** If you are working on a different compartment then replace `odi` with your compartment name.

    Set up the following policy:

    Allow dynamic-group odi_group to inspect autonomous-database-family in compartment odi

    Allow dynamic-group odi_group to read autonomous-database-family in compartment odi

    Allow dynamic-group odi_group to inspect compartments in compartment odi

    **Note:** If you want ODI web to be able to access autonomous databases in other compartments in your tenancy, you will need to set additional policy statements at the root level of your tenancy. In this case, all ADW/ATP instances from the tenancy where ODI instance is created will be accessed during deployment.

    Allow dynamic-group odi_group to inspect autonomous-database-family in tenancy

    Allow dynamic-group odi_group to read autonomous-database-family in tenancy

    Allow dynamic-group odi_group to inspect compartments in tenancy

    ![ALT text is not available for this image](images/3018125118.jpg)

## **STEP 2:** Deploy ODI Web Edition

1. Starting from the OCI console, navigate to the OCI Marketplace, as follows (and as shown in the screenshot below):

    - Be sure that you are working in the same OCI Region as your Autonomous Database. (In the example below, that is US West (Phoenix))

    - From the Hamburger menu at the top left, select Marketplace, then **All Applications**

    - Under **Filters** on the left, specify:
        - Publisher: Oracle
        - Category: Data Integration
        - Price: Free

    - Of the cards that match these criteria, select **Data Integrator: Web Edition**

    ![ALT text is not available for this image](images/3018104742.png)

2. In the details screen that appears, you should review and (if suitable) accept the Oracle Terms of Use. Then press **Launch Stack**. 

    ![ALT text is not available for this image](images/3018104743.png)

3. What follows is a simple fill-in-the-blanks dialog to configure the OCI software stack appropriately. In the **Stack Information** section, provide a name and description for this software stack. You can ignore the target compartment in this dialog, but it's important to specify this appropriately in the next dialog. 

    ![ALT text is not available for this image](images/3018104744.png)

4. The **Configure Variables** section is a rather long form, broken up here into three separate screenshots. 

    **Important**: In the **General Settings** section, be sure to specify the same TARGET COMPARTMENT as you used to deploy your Autonomous Database.

    ![ALT text is not available for this image](images/3018104745.png)

5. In the **Oracle Data Transforms Instance Settings** section, enter your own OCI Public key into the field SSH PUBLIC KEY. You'll also need to specify a password for ORACLE DATA TRANSFORMS VNC PASSWORD. 

    ![ALT text is not available for this image](images/3018104746.png)

6. In the **New Oracle Data Transforms Metadata Repository** section, pick the name of your Autonomous Database from the pick list at the top. (This pick list is populated with names of Autonomous Databases in the same Compartment as you're using here. This is why it was important to pick the Target Compartment carefully in the **General Settings** section above.)

    **Important**: Be sure to check the box next to REGISTER ORACLE DATA TRANSFORMS WITH THE AUTONOMOUS DATABASE, DATABASE ACTIONS PAGE. This is what puts the Data Transforms card on your Database Actions page. 

    ![ALT text is not available for this image](images/3018104747.png)

7. Next comes the **Review** section. Be sure to check the values specified here, so that the stack is deployed successfully. Go back and make any corrections necessary. When you're satisfied, press **Create**. 

    ![ALT text is not available for this image](images/3018104748.png)

    **Important**: What follows is a two-part deployment process:

    * Deployment of the OCI components. This may take around 10 minutes. Data Transforms is still not ready to use at this stage!

    * Deployment of the ODI components in your Autonomous Database. This may take around 30-40 minutes. 

    Because of the time required to set up Data Transforms completely, this is an ideal time to take a 10 min break from the workshop. We suggest a walk, a nice meal, or perhaps a coffee break. 

8. During Phase 1 (deployment of OCI components), you'll see a dialog similar to this:

    ![ALT text is not available for this image](images/3018104749.png)

9. When the OCI components of the stack are successfully deployed, the status icon will turn green, as follows:

    **NOTE:** This can take several minutes to finish.

    ![ALT text is not available for this image](images/3018104750.png)In this window, you can view the progress of the stack deployment log, if you're interested. 

    **NOTE:** After the stack is successfully deployed, your compute instance is created. However, ODI deployment script is running in the background  to do the following:

    - **Installing ODI Web Edition software**

    - **Creating repository in ADW**

    - **Starting ODI agents**

  **All the above steps take around 30-40 minutes to finish. You can come back after 30 minutes and check for Data Transforms using direct URL as shown in Step 3. If it is not ready then give it another 10 minutes.**

  **In order to check the progress of the deployment script, one need to login to VNC viewer to the compute instance and check the log file. This is beyond the scope of this workshop. To keep steps simple, we simply wait for 30-40 minutes and launch the Data Transforms tool.** 

## **Step 3:** Launch The Data Transforms Tool

Data Transforms tool can be launched by two methods:

- Direct URL from a browser

- Data Transforms card in Autonomous Database tools page.


1. In order to find the URL we need to access the application properties in OCI stack created in previous step. In the OCI Control plane, from the hamburger menu select **Resource Manager – Stacks**, as follows:

    ![ALT text is not available for this image](images/3018104751.png)

2. In the screen that appears, click on the name of the stack.

    ![ALT text is not available for this image](images/3018104752.png)

3. Then click on the tab for **Application Information**:

    ![ALT text is not available for this image](images/3018104783.png)

4. The page that appears provides both private and public URLs for accessing **Oracle Data Integrator - Web Edition** directly.  

    ![ALT text is not available for this image](images/3018104789.png) 

5. You can also launch **Data Transforms** from Autonomous Database. You'll see a card for a fully pre-configured connection to your Autonomous Database. Click the **DATA TRANSFORMS** card.

    ![ALT text is not available for this image](images/3018124770.png)

6. You will see the login screen for the Data Transforms tool. Specify username **SUPERVISOR** and the password that you provided in the ODI Web Edition deployment. Click **Connect**.

    ![ALT text is not available for this image](images/3018123500.png)Follow the next lab for using Data Transforms to create a data flow.

## Conclusion

In this section we've covered the following topics:

- Deploying ODI Web Edition compute instance from OCI Marketplace

- Register Data Transforms tool to Autonomous Database Tools page

- Launch Data Transforms tool

## Acknowledgements

- **Authors** - Jayant Mahto, ADB Product Management
- **Contributors** - Patrick Wheeler, Mike Matthews, ADB Product Management
- **Last Updated By/Date** - Jayant Mahto, Brianna Ambler June 2021
