# Unit 16: Migrating Application Development Between Environments

This exercise includes two hands-on-labs and uses the Demo Projects application.

**HOL 16-1 Importing an Application**: In this lab, you import an application along with the underlying database objects and seed data.

**HOL 16-2 Migrating your Application Development Between Environments:** In this lab, you export an application and then use SQL Workshop to export database objects and seed data.

Steps 3 through 15 in this lab are optional. You need a target APEX environment to perform these steps. To test these steps you might want to use a different Workspace. If you want to import the application in to the same Workspace, then you might have to choose a different application ID. Installing database objects and seed data will still fail, as they are already created.


## HOL 16-1: Importing an Application

In this lab, you import an application in to your Workspace. Along with the application definition, you also install the supporting objects.

This lab uses the application export file **demo projects app export-unit 15.sql** which is the application export file for HOL 15-5. If you have not performed any of the previous hands-on labs in this course, you can use the steps in this lab to create the corresponding application. You simply need to replace the application export file name in Step 2 with the one appropriate for that particular hands-on-lab.

**Note**:

-   The steps in this lab assume that you are importing an application within the same Workspace that you used in the previous hands-on labs. If you are importing the application in to a different Workspace (either on the same or different instance), the steps might slightly differ.
	
-   This lab assumes that you want to reuse the same application ID from the export file.
	
-   The underlying database objects and seed data for this application are packaged along with the application definition in a single file. After installing the application, you can view the installation scripts for the database objects and data by clicking **Supporting Objects** on the application home page.
	
-   Installation of supporting objects and seed data may fail if you already have the database objects created in your schema. If you do not need your existing objects and seed data, then you can simply run the **drop\_objects.sql** before proceeding with the steps in this lab. However, note that this script will completely delete all of your underlying database objects along with the data.

**Note**: If you want to take a backup of your existing application along with the database objects and seed data, perform steps 1 and 2 in HOL 16-2.

1.  Navigate to **App Builder** and click **Import**.
    ![imp1](images/hol16/image3.png)

2.  Click **Choose File**.
    Navigate to your working directory and double-click the **demo projects app export-unit 15.sql** file. Then, click **Next**.
    **Note**: To import any other APEX application export in to your Workspace, you select that file in this step.
    
    ![imp2](images/hol16/image4.png)

3.  On the File Import Confirmation page, click **Next**.

4.  For Install As Application, you can choose Auto Assign New Application ID. The steps might slightly differ if you select this option.
    However, in this lab, you select **Reuse Application ID 103 from Export File**.
    Click **Install Application**.
    ![imp4alt](images/hol16/image5.png)

5.  Click **Replace Application**.
    If you select Auto Assign New Application ID in Step 4, you do not see this warning.
    ![imp\_alt1](images/hol16/image6.png)

6.  On the Supporting Objects page, click **Next**.
    ![imp\_alt2](images/hol16/image7.png)

7.  On the Confirmation page, click **Install**.
    ![imp\_alt3](images/hol16/image8.png)

8.  The application is successfully installed now.
    Click **Run Application**.
    ![imp\_alt4](images/hol16/image9.png)
    **Note**: The installation of database objects and seed data may succeed or fail, depending on what database objects are already created. If installation fails, click **Install Summary**, and review the errors. The errors should relate to objects already existing, such as ORA-00955: name is already used by an existing object.


## HOL 16-2: Migrating your Application Development between Environments

In this lab, you export an application definition, underlying database objects along with the seed data.
Steps 3 through 15 are optional. After exporting application from the current development environment, you log in to the target Application Express environment, import the application and then load the tables along with data.

1.  From your current development environment, export an application. Navigate to App Builder and in the report, select the application you want to export. In this lab, you export the Demo Projects application that you created until HOL 15-5. Alternatively, you can export the application that you imported in HOL 16-1.



	a)  On your application home page, click **Export / Import**.
	    ![1a](images/hol16/image10.png)
	
	b)  Select **Export** and click Next.
	    ![1b](images/hol16/image11.png)
	
	c)  Make sure you select **Yes** for Export Private Reports and Export with Original IDs.
	    Click **Export**.
	    ![1c1](images/hol16/image12.png)
	    ![1c2](images/hol16/image13.png)
	
	d)  The application export file is saved in your local directory as a .sql file. You might want to rename the file.
	    Note: Depending on the browser, if you see a Save dialog, click **Save**.



2.  Now, you export database objects and data. Perform the following steps:

	a.  In your Workspace, click **SQL Workshop &gt; Utilities**.
	    Under Utilities, select **Generate DDL**.
	    ![2a](images/hol16/image14.png)
	
	b.  Click **Create Script**.
	    ![2b](images/hol16/image15.png)
	
	c.  Verify the Schema and click **Next**.
	    ![2c](images/hol16/image16.png)
	
	d.  For Output, select **Save As Script File**.
	    For Object Type, select **Table** and click **Next**.
	    ![2d](images/hol16/image17.png)
	
	e.  Select all of the relevant tables for this application.
	    Select the following tables:
	
	-   **DEMO\_PROJECTS**
		
	-   **DEMO\_PROJ\_COMMENTS**
		
	-   **DEMO\_PROJ\_CONSTRAINTS**
		
	-   **DEMO\_PROJ\_MILESTONES**
		
	-   **DEMO\_PROJ\_STATUS**
		
	-   **DEMO\_PROJ\_TASKS**
	
	-   **DEMO\_PROJ\_TASK\_LINKS**
		
	-   **DEMO\_PROJ\_TASK\_TODOS**
		
	-   **DEMO\_PROJ\_TEAM\_MEMBERS**
	
	    Click Generate **DDL**.
	    ![2e](images/hol16/image18.png)
	
	f.  For Script Name, enter a meaningful name, for example **Create Demo Project Tables**. Optionally enter a description. </br>
	
	   Click **Create Script**.
	
	g.  The DDL is now saved as a script under SQL Scripts.
	    Click the **Edit** icon (pencil) on the recently created script.
	
	h.  Click **Download**.
	    ![2g](images/hol16/image19.png)
	
	i.  Click **Save**.
	
	j.  Now, create a script to include trigger definitions and then download the script.
	    Repeat steps a through i and input the following:
	
	-   Select Trigger for Object Type
		
	-   Enter **Create Demo Projects Triggers** for script name.
		
	-   Select the following triggers:
		
		-   **biu\_demo\_proj\_status**
		
		-   **biu\_demo\_proj\_team\_members**
		
		-   **biu\_demo\_projects**
		
		-   **biu\_demo\_proj\_milestones**
		
		-   **biu\_demo\_proj\_tasks**
		
		-   **biu\_demo\_proj\_task\_todos**
		
		-   **biu\_demo\_proj\_task\_links**
		
		-   **biu\_demo\_proj\_comments**
	
	  ![2j](images/hol16/image20.png)
	
	
	k.  Now that you have both the DDL scripts created and downloaded, you need to unload the table data.
	    Under SQL Workshop &gt; Utilities, select **Data Workshop**.
	    ![2k](images/hol16/image21.png)
	
	l.  Under Data Unload, click **to XML**. </br>
	    ![2l](images/hol16/image22.png)
	
	m.  On the Unload to XML – Columns page, select the application table for **Table**. See step **e** above for the Demo Projects table list. </br>
	    Use the Ctrl key to select all of the columns in a table and click **Unload Data**.
	    ![2m](images/hol16/image23.png)
	
	n.  Enter a meaningful name for the file and click **Save**.
	
	o.  Repeat steps m and n for each of the Demo Projects application tables.
	


3.  You have exported the application definition, database objects and data from your current development environment. Now first navigate to the target APEX environment and install the application definition.
    Log into your target Application Express development environment and perform the following steps:


	a)  Navigate to **App Builder** and click **Import**
	
	b)  Click **Choose File**.
	    Navigate to your working directory and double-click the application export file. Then, click **Next**.
	
	c)  On the File Import Confirmation page, click **Next**.
	
	d)  For Install As Application, specify your choice for Application ID. The default is Auto Assign New Application ID.
	
	e)  Click **Install Application**. The application is successfully installed now.
	
	

4.  Log into your target Application Express development environment.

5.  Use SQL Workshop to load and run the script file, for creating the table and trigger definitions



	a)  Click SQL Workshop.
	
	b)  Click SQL Scripts.



6.  Upload the script to create the tables first.



	a)  Click **Upload**.
	
	b)  For File, click **Choose File**.
	
	c)  In the operating system File Browser, navigate to the subdirectory where you saved the table script file. Locate **Create Demo Project Tables.sql**, and double-click the file.
	
	d)  Click **Upload**.



7.  Click the **Run** icon to the right of the script you uploaded.
    Click Run Now.

8.  Click the View Results icon for the script you just ran.

9.  To create triggers, repeat steps 5 through 8 and select the **Create Demo Projects Triggers.sql**.

10.  Currently the tables you created do not have any data. Use the XML files you created to populate the tables.

     **Note**: The order in which the tables are populated is crucial, to ensure referential integrity does not prevent records loading.
     For example, loading any records into DEMO\_PROJECTS before loading the records into DEMO\_PROJ\_TEAM\_MEMERS will fail, as the ASSIGNEE column in DEMO\_PROJECTS must correspond to an existing record in DEMO\_PROJ\_TEAM\_MEMBERS.

    In the Application Express main toolbar, click the SQL Workshop Down Arrow, select Utilities and then select **Data Workshop**.

11.  Under Data Load, locate **XML Data**. Click **XML Data**.

12.  For Table, select **DEMO\_PROJ\_TEAM\_MEMBERS**.
    For File, click **Choose File**, locate the file for DEMO\_TEAM\_MEMBERS, and double-click the file.

13.  Click **Load Data**.

14.  Load data for all of the Demo Projects tables. Repeat steps 10 through 13 for each of the table.

15.  Now, you can run and review the application.


----------
![Snap3](images/hol16/image24.png)
