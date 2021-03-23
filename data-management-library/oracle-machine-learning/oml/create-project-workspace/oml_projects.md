# Oracle® Cloud Create Projects and Workspaces in Oracle Machine Learning Notebooks

  This lab walks you through the steps to create a project and a
  workspace in Oracle Machine Learning Notebooks.

  **Note:** The initial workspaces and the default project are
  created by the Oracle Machine Learning service automatically
  when you log in to Oracle Machine Learning for the first time.
  The term default applies to the last project that you work on,
  and it is stored in the browser cache. If you clear the cache,
  then there would be no default project selected. Then you must
  select a project to work with notebooks.

  This lab explains the steps to create your own project, and
  optionally your workspace.  

  This lab takes approximately 10 minutes to complete.

### Background
A project is a container for storing your notebooks and other objects such as dashboards and so on. A workspace is a virtual space where your projects reside, and multiple users with the appropriate permission type can work on different projects. While you may own many projects, other workspaces and projects may be shared with you.

### What Do You Need?

* Access to your Oracle Machine Learning account

## Access your Oracle Machine Learning Account

  To gain access to your Oracle Machine Learning account, contact the Oracle Machine Learning administrator to create your account. The administrator creates the Oracle Machine Learning account, and provides you the account details in an email.


1. Click the URL provided by your Oracle Machine Learning
  administrator. This opens the Oracle Machine Learning Sign In
  page.
2. In the Sign In page, enter the Tenant and Database name
  provided by your administrator.

    ![login1.png](images/login1.png "login1.png")


3. Click **Continue**.
4. In the next Sign In page, enter your Username and Password provided to you and click **Sign In**.

    ![login2.png](images/login2.png "login2.png")

4. After you log in, change the password immediately by
  clicking **Change Password** in the top right corner of the Oracle
  Machine Learning home page, as shown in the screenshot.

  ![changepassword.png](images/changepassword.png "changepassword.png")


## Create Project in Oracle Machine Learning

To create a project:

1. On the top right corner of the Oracle Machine Learning home
  page, click the project workspace drop-down list. The project
  name and the workspace, in which the project resides, are
  displayed here. In this screenshot, the project name is <i>USER1
  Project</i>, and the workspace name is <i>USER1 Workspace.</i>
  If a default project exists, then the name of the default
  project is displayed here. To choose a different project,
  click **Select Project**.

    ![new_project.png](images/new_project.png "new_project.png")

2. To create a new project, click **New Project**. The Create Project dialog box opens.

    ![create_workspace.png](images/create_workspace.png "create_workspace.png")

3. In the **Name** field, provide a name for your project.
4. In the **Comments** field, enter comments, if any.
5. To choose a different workspace, click the down arrow next
  to the **Workspace** field and select a workspace from the
  drop-down list. Your project <i>Project A</i> is assigned to
  the selected workspace. In this example, the <i>USER1 Workspace</i> is selected.
6. Click **OK**. This completes the task of creating a project and assigning it to a workspace. In this example, the assigned workspace is <i>USER1 Workspace.</i>

## Create Workspace in Oracle Machine Learning

To create a workspace:

1. On the top right corner of the Oracle Machine Learning homepage, click the project workspace drop-down list and click **Select Project**. The Select Project dialog box opens.

   ![select_project.png](images/select_project.png "select_project.png")

2. In the Select Project dialog box, click on **USER1 Workspace** and then click **Create**. The Create Project dialog box opens.

   ![select_project_create.png](images/select_project_create.png "select_project_create.png")

3. In the Create Project dialog box, enter Project B in the <b>Name</b>
  field, and click the plus icon <img src="./img/add.png" alt="add icon">
  next to the **Workspace** field. The Create Workspace
  dialog box opens.

   ![create_workspace_ab.png](images/create_workspace_ab.png "create_workspace_ab.png")

 4. In the Create Workspace dialog box, enter <i>Workspace A </i>in the **Name** field.

   ![workspace_ab.png](images/workspace_ab.png "workspace_ab.png")

 5. In the **Comments** field, enter comments, if any.

 6. Click **OK.** This completes the task of creating your workspace, and brings you back to the Create Project dialog box.

 7. In the Create Project dialog box, click **OK**. This
   brings you back to the Select Project dialog box. Here, you
   can view all the workspace and the projects in it. The project
   and workspace that you created in step 3 through 6 is listed
   in the Select Workspace dialog box, as shown in the screenshot
   here.

   ![select_project_workspace.png](images/select_project_workspace.png "select_project_workspace.png")

  8. Click **OK.** This completes the task of creating a project and a workspace, and assigning the project to the workspace.

  9. To delete a workspace, click **Manage Workspace** in the Project Workspace drop-down list.

  10. In the Manage Workspace dialog box, select the workspace you want to delete and click **Delete**.
  This deletes the selected workspace along with all the projects in it.

   ![manage_workspace_delete.png](images/manage_workspace_delete.png "manage_workspace_delete.png")


## Want to Learn More?

* [Using Oracle Machine Learning](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/omlug/index.html)

## Acknowledgements
* **Author** : Mark Hornick, Sr. Director, Data Science / Machine Learning PM, Moitreyee Hazarika, Principal User Assistance Developer, DB Development - Documentation

* **Last Updated By/Date**: Dimpi Sarmah, September 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
