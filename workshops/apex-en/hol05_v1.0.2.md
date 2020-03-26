# Unit 5: Developing Reports

This exercise includes three hands-on-labs.

**HOL 5-1 Creating a Classic Report**: In this hands-on-lab, you create a classic report region on the home page of the Demo Projects application.

**HOL 5-2 Creating an Interactive Report**: In this hands-on lab, you create a new database application and then using the Create Page wizard, you add an interactive report page.

**HOL 5-3 Creating an Interactive Grid**: In this hands-on lab, you use the Create Page wizard and add an interactive grid page in the Budget App application.


## HOL 5-1 Creating a Classic Report



In the Demo Projects application, you create a report that allows each Team Member to see their outstanding tasks.

1.  View the home page (Page 1) in page designer. If you are on the Home page, then click **Edit Page 1** in the Developer Toolbar.
    ![1a](images/hol05/image3.png)

2.  In the Rendering tree, right-click **Content Body** and select **Create Region**.
    ![1b](images/hol05/image4.png)

3.  In the property editor, under Identification, enter **My Outstanding Tasks** for Title. Select **Classic Report** for Type.
    ![1c](images/hol05/image5.png)

4.  In the property editor, under Source, copy and paste the following code for SQL Query.

      
          select p.name project
      
          , t.name task
      
	      , t.end_date
	      
	      from demo_proj_tasks t
	      
	      , demo_projects p
	      
	      , demo_proj_milestones m
	      
	      , demo_proj_team_members tm
	      
	      where p.id = t.project_id
	      
	      and m.id = t.milestone_id (+)
	      
	      and tm.id = t.assignee and nvl(t.is_complete_yn, 'N') = 'N'
	      
	      and upper(tm.username) = upper(:APP_USER)
	      
	      order by t.end_date
      

    **Note**: The where condition of username = :APP\_USER restricts the records to those assigned to the person running the application.
    ![1d](images/hol05/image6.png)

5.  In the Property Editor, locate Appearance &gt; Template Options and click **Use Template Defaults, Scroll - Default**.
    ![1e](images/hol05/image7.png)

6.  For General, enable **Remove Body Padding**, and for Body Height select **480px**. Click **OK**.
    ![1f](images/hol05/image8.png)

7.  Locate the Rendering tree. Under the My Outstanding Tasks region, click **Attributes**.

8.  Under Attributes, locate Template Options and click **Use Template Defaults, Enable, Enable**.
    ![1g](images/hol05/image9.png)

9.  For General, enable Stretch Report, and for Report Border, select No Outer Borders. Click **OK**.
    **Note**: Region Template Options (such as Body Height, Header, Style and so on) alter the overall presentation of a region. However, Attribute Template Options (such as Stretch Report, Row Highlighting and so on) alter the way the records within a region display.
    ![1h](images/hol05/image10.png)

10.  Click **Save**. Run the application to see how the Home page looks now. Click **Save and Run Page**. Your home page might look like:
    ![1](images/hol05/image11.png)

   In the Developer Toolbar, click **Home**.


## HOL 5-2 Creating an Interactive Report


In this lab, you create an interactive report on the HARDWARE table. You created this table in HOL 2-2. First, you create a database application and then you create the interactive report page.

1.  Create a database application. Perform the following steps:



    a)  Navigate to Application Builder. Click **Create**.

    b)  Click **Desktop**.

    c)  Enter **Hardware** for Name and click **Create Application**.
        ![2a](images/hol05/image12.png)

    d)  Click **Create Application**.



2.  Now, create an interactive report on the HARDWARE table. On the application home page, click **Create Page**.
    ![2b](images/hol05/image13.png)

3.  Select **Report** for Page Type, and click **Next**.

4.  Select **Interactive Report** and click **Next**. </br>
    ![2c](images/hol05/image14.png)

5.  For Page Attributes:

    -   Page Name: Enter **Hardware Interactive Report**

    -   Breadcrumb: Select Breadcrumb

    -   Parent Entry: Home

    Click **Next**.

6.  For Navigation Menu:

    -   Navigation Preference: Select **Create a new navigation menu entry**

    -   Parent Navigation Menu Entry: **Home**

    Click **Next**.

7.  Select **Hardware** for Table / View Name and click **Create**.

8.  Click **Save and Run Page**.

9.  Enter your Workspace username and password. Click **Sign In**. Your interactive report might look like:
    ![2](images/hol05/image15.png)
   In the Developer Toolbar, click **Home**.


## HOL 5-3 Creating an Interactive Grid


In this lab, you create an interactive grid on the PROJECT\_BUDGET table. You already created the Budget App application in HOL 3-2. Now, you create an interactive grid in the Budget App application.

1.  Navigate to **Application Builder**. In the report, select **Budget App**.
    ![3a](images/hol05/image16.png)

2.  Click **Create Page**. </br>
    ![3b](images/hol05/image17.png)

3.  Select **Report** and click **Next**.</br>

4.  Select **Interactive Grid** and click **Next**.</br>
    ![3c](images/hol05/image18.png)

5.  For Page Attributes, Enter **Project Budget Interactive Grid** for Page Name and click **Next**.

6.  For Navigation Menu:

    -   Navigation Preference: Select **Create a new navigation menu entry**

    -   New Navigation Menu Entry: **Interactive Grid**

    Click **Next**.

7.  On the Report Source dialog, note that you can set the Editing Enabled to Yes or No. In this lab, you accept the default, **No**.
    Select **Project\_Budget** for Table / View Name and click **Create**.
    ![3d](images/hol05/image19.png)

8.  Click **Save and Run Page**. The interactive grid displays. Your screen might look like:
    ![3](images/hol05/image20.png)

    In the Developer Toolbar, click **Home**.

----------

![Snap3.jpeg](images/hol05/image21.png)
