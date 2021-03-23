# Get Started with OML4Py on Autonomous Database

## Introduction
This lab walks you through the steps to create a Zeppelin notebook and connect to the Python interpreter.

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will learn how to:
<if type="freetier">* Provision an autonomous database
* Create an OML user</if>
* Access OML Notebooks
* Create a Zeppelin Notebook
* Familiarize with the Zeppelin Notebook toolbar
* Familiarize with the Zeppelin Notebook interpreter bindings
* Familiarize with the Zeppelin Notebook interpreters
* Connect to the Python Interpreter
* Verify Connection to the Autonomous Database
* View help files

<if type="freetier">### Prerequisites
* Sign up for a free tier Oracle Cloud account.

_Note: You may see differences in account details (eg: Compartment Name is different in different places) as you work through the labs. This is because the workshop was developed using different accounts over time._
</if>

<if type="livelabs">## **Step 1:** Launch the workshop

*Note: it takes approximately 20 minutes to create your workshop environment.*

1. After you receive the e-mail stating that your environment is ready, go back to the My Reservations page and click **Launch Workshop**.

    ![](images/my-reservations.png)

2. Make a mental note of the compartment name assigned to you. Click **Copy Password** to copy your initial password. Note that this is also the admin password for your Autonomous Data Warehouse instance, so save the password for later use. Then click **Launch Console**.

    ![](images/launch-page.png)

3. On the login page, use the Oracle Cloud Infrastructure direct sign-in, paste the password and click **Sign In**.

    ![](images/login-console.png)

4. Change your password by pasting the initial password in the **Current Password** field, **New Password** field and **Confirm Password** field.

    ![](images/change-password.png)

5. Click on the menu icon and then select Autonomous Data Warehouse from the menu.

    ![](images/open-adw.png)

6. Select the compartment assigned to you from the **List Scope menu** and then click the ADW instance.

    ![](images/select-compartment.png)

    ![](images/adw-instance.png)

</if>

<if type="freetier">## **Step 1:** Provision an Autonomous Database

To provision an Autonomous Database:

1. Click the hamburger menu, search for **Autonomous Data Warehouse**, and click on it.

    ![](images/create-adw.png)

2. From the Oracle Cloud Infrastructure Console, on the Autonomous Database page choose your region and select a compartment.

3. Click **Create Autonomous Database**.

    ![](images/create-autonomous-db.png)

4. Provide basic information for the Autonomous Database.

    Enter a user-friendly display name for the ADB instance to easily identify the resource. The display name does not have to be unique.

    ![](images/create-autonomous-db-1.png)

5. For Workload Type, click **Data Warehouse**.

6. For Deployment, select **Shared Infrastructure**.

7. For Database configuration, select the following:

    - **Choose database version:** Select the database version. The available database version is **19c**.
    - **OCPU Count:** Enter 1. This is number of CPU cores for your database.
    - **Storage (TB):** Specify the storage you wish to make available to your database, in terabytes. Enter 1 TB.
    - **Auto Scaling:** By default auto scaling is enabled to allow the system to automatically use up to three times more CPU and IO resources to meet workload demand.

    ![](images/create-adw-config.png)

8. For Administrator credentials, enter and re-confirm a password.

9. For Network Access, select Allow Secure access from everywhere.

    ![](images/create-adw-network.png)

10. For License, select **License Included**.

    ![](images/create-adw-license.png)

11. Click **Create Autonomous Database**. The Autonomous Data Warehouse instance starts provisioning. Click **Autonomous Data Warehouse** again from the hamburger menu to see a list of Autonomous Database in your console.

12. Click the ADW instance you just created.

    ![](images/adb_instance.png)
</if>

## **Step 2**: Create an OML User

An administrator creates a new user account and user credentials for Oracle Machine Learning in the User Management interface.
**Note:** You must have the administrator role to access the Oracle Machine Learning User Management interface. To create a user account:
    
1. On the Autonomous Database Details page, click **Service Console.**

    ![](images/service_console.png)

2. On the Service Console click **Administration.**
    ![](images/administration.png)

3. Click **Manage Oracle ML Users** to open the Oracle Machine Learning User Administration page.
    ![](images/manage_oml_users.png)
4. Click **Create** on the Oracle Machine Learning User Administration page.
    <if type="freetier">![](images/create_option.png)</if>
    <if type="livelabs">![](images/create_option_livelabs.png)</if>

5. In the Create User page, enter the following details to create the user:
    ![](images/create_user_page.png)
    <if type="freetier">
    - **Username:** Enter `omluser` for username. Using this username, the user will log in to an Oracle Machine Learning instance.
    - **First Name:** Enter the first name of the user.
    - **Last Name:**  Enter the first name of the user.
    - **Email Address:** Enter the email ID of the user.
    - Select the option **Generate password and email account details to user. User will be required to reset the password on first sign in.** to auto generate a temporary password and send an email with the account credentials to the user.
    If you select this option, you need not enter values in the **Password** and **Confirm Password** fields; the fields are grayed out.
    - **Password:** Enter a password for the user, if you choose to create a password for the user.
    This option is disabled if you select the Generate password... option to auto generate a temporary password for the user.
    - **Confirm Password:** Enter a password to confirm the value that you entered in the Password field.
    By doing so, you create the password for the user. The user can change the password when first logging in.
    </if>
    <if type="livelabs">
    - **Username:** Enter `omluser2` for username. You use this user later in the workshop to learn how to grant datastore access to a user.
    - **Email Address:** Enter an email ID for the user.
    - Untick the **Generate password and email account details to user. User will be required to reset the password on first sign in.** option.
    You do not select this option, because you want to specify your own password. If you select this option, you need not enter values in the **Password** and **Confirm Password** fields; the fields are grayed out.
    - **Password:** Enter `AAbbcc123456` for password.
    - **Confirm Password:** Enter the same password again.
    </if>

6. Click **Create.** 

<if type="livelabs">
    ![](images/omluser_2.png)
</if>

<if type="freetier">
7. Repeat step 5 and 6 to create `omluser2` user. You use this user later in the workshop to learn how to grant datastore access to a user.

    ![](images/omluser_2.png)
</if>


## **Step 3:** Access Oracle Machine Learning Notebooks

You create notebooks in Oracle Machine Learning Notebooks. You can access Oracle Machine Learning Notebooks from Autonomous Database.

1. From the tab on your browser with your ADW instance, click **Service Console**, then select **Development** from the left.

    ![](images/service-console.png)

    ![](images/service-console-development.png)

2. Click **Oracle Machine Learning Notebooks**.

    ![](images/open-oml-notebooks.png)

3. <if type="livelabs">Sign in with the **omluser** using the password `AAbbcc123456`.</if><if type="freetier">Enter your `omluser` credentials and click **Sign in.**</if>

    ![](images/signin-to-oml.png)

4. Click on **Notebooks** from the Quick Actions menu.

    ![](images/open-notebooks.png)


<if type="freetier">## **Step 4:** Create Tables and Views, and Grant Access

This workshop uses tables and views which need to be created before proceeding with the workshop. To create these tables and views:

1. Download the [Run Me First notebook](./lab0_run_me_first.json?download=1). This notebook contains the scripts for creating tables and views, and granting required access.

2. In the Notebooks page click **Import** and select the `lab0_run_me_first.json` notebook file.

3. Click on the notebook to open it after it is successfully imported.

    ![](images/import-notebook.png)

4. Click the **Run all paragraphs** ![](images/run-all-paragraphs.png =20x*) icon, and then click **OK** to confirm.

5. Wait until all the paragraphs have finished running and you see your current time in the last paragraph.

    ![](images/last-paragraph.png)

The prerequisite scripts have run successfully.

</if>

<if type="livelabs">## **Step 4:** Create a Zeppelin Notebook</if>
<if type="freetier">## **Step 5:** Create a Zeppelin Notebook</if>

A notebook is a web-based interface for data analysis, data discovery, data visualization and collaboration. To create a notebook:
1. <if type="freetier">Click the hamburger menu, search for Notebooks, and click on it. </if>In the Notebooks page, click **Create.** The Create Notebook window appears.

    ![](images/create-notebook-1.png)

2. In the **Name** field, provide a name for the notebook.
3. In the **Comments** field, enter comments, if any.
4. In the **Connections** field, select a connection in the drop-down list. By default, the `Global` connection group is assigned.
5. Click **OK.** The notebook is created and it opens in the notebook editor.

    ![](images/create-notebook-2.png)

**Note:** For Oracle Autonomous Database, a connection is automatically established provided you have the appropriate interpreter binding specified and import the oml package.    

<details><summary>Familiarize with the Zeppelin Notebook toolbar</summary>
The Zeppelin notebook toolbar contains buttons to run code in paragraphs, for configuration settings, and display options.

For example, it displays the current status and the number of users connected to the notebook. It also contains a menu item for keyboard shortcuts and options to show or hide the markdown editor and paragraph output. Additional settings are shown in the illustration here.
    ![](images/notebook_toolbar.png)
</details>

<details><summary>Familiarize with the OML Notebook interpreter bindings</summary>
Oracle Machine Learning notebooks contain an internal list of bindings to fetch data from the database or another data source, such as Oracle Cloud Object Storage. For this lab, we set the interpreter binding to connect to the ADW database and run queries.

Click the interpreter bindings icon in the upper right-corner of the Notebook to view the list of available interpreter bindings.
  ![](images/interpreter_bindings.png)

The default service is low. Click to bind or unbind an interpreter. Drag-and-drop individual interpreter binding settings up or down to order which binding will be used by default. The first interpreter on the list becomes the default. Those highlighted in blue are active.
</details>

<details><summary>Familiarize with the Zeppelin interpreters</summary>
An interpreter is a plug-in that allows you to use a specific data processing language in your Oracle Machine Learning notebook. You can add multiple paragraphs, and each paragraph can be connected to different interpreters such as SQL or Python.

You create different paragraphs with different interpreters based on the code you want to run in the paragraphs. The interpreter is set at the top of the paragraph.
The available interpreters are:

  - `%sql` - To call the SQL interpreter and run SQL statements
  - `%script` - To call and run PL/SQL scripts
  - `%md` - To call the Markdown interpreter and generate static html from Markdown plain text
  - `%python` - To call the Python interpreter and run Python scripts
</details><p/>

<if type="livelabs">## **Step 5:** Connect to the Python Interpreter</if>
<if type="freetier">## **Step 6:** Connect to the Python Interpreter</if>

To run Python commands in a notebook, you must first connect to the Python interpreter. This occurs as a result of running your first `%python` paragraph. To use OML4Py, you must import the `oml` module, which automatically establishes a connection to your database.
In an Oracle Machine Learning notebook, you can add multiple paragraphs, and each paragraph can be connected to different interpreters such as SQL or Python. This example shows you how to:

* Connect to a Python interpreter to run Python commands in a notebook
* Import the Python modules - oml, pandas, numpy, and matplotlib
* Check if the `oml` module is connected to the database

**Note:** `z` is a reserved keyword and must not be used as a variable in `%python` paragraphs in Oracle Machine Learning Notebooks. You will see `z.show()` used in the examples to display Python object and proxy object content.

1. Open the notebook and click the interpreter bindings icon. View the available interpreter bindings.  The "low" priority binding runs operations serially (no parallelism). You can drag-and-drop individual interpreter binding settings up or down to order which binding will be used by default. Those highlighted in blue are active. Click to toggle to inactive.

    ![](images/interpreter_bindings.png)

    The available interpreter bindings are:
    - `%sql` - To call the SQL interpreter and run SQL statements
    - `%script` - To call and run PL/SQL scripts
    - `%md` - To call the Markdown interpreter and generate static html from Markdown plain text
    - `%python` - To call the Python interpreter and run Python scripts

2. To connect to the Python interpreter, type `%python` at the top of a new paragraph in your notebook.
   You are now ready to run Python scripts in your notebook.

3. To use OML4Py module, you must import the oml module. Type the following Python command to import the   oml module, and click the run icon. Alternatively, you can press Shift+Enter keys to run the notebook.   

    ```
    %python
    <copy>import oml</copy>
    ```

    ![](images/import_oml.png)

<if type="livelabs">## **Step 6:** Verify Connection to the Autonomous Database</if>
<if type="freetier">## **Step 7:** Verify Connection to the Autonomous Database</if>

Using the default interpreter bindings, OML Notebooks automatically establishes a database connection for the notebook.  

1. To verify the Python interpreter has established a database connection through the `oml` module, run the command:

    ```
    %python
    <copy>oml.isconnected()</copy>
    ```
    ![](images/oml_connected.png)

    Once your notebook is connected, the command returns `True`.         


<if type="livelabs">## **Step 7:** View Help Files</if>
<if type="freetier">## **Step 8:** View Help Files</if>


The Python help function is used to display the documentation of packages, modules, functions, classes, and keywords. The help function has the following syntax:
    ```
    help([object])
    ```

For example,
  - To view the help files for the `oml.create` function, type:
    ```
    %python
    <copy>
    help(oml.create)</copy>
    ```

  - To view the help files for `oml` package, type:

    ```
    %python
    <copy>
    help(oml)</copy>
    ```  

## Learn More

* [Get Started with Oracle Machine Learning for Python](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/get-started-with-oml4py.html#GUID-B45A76E6-CE48-4E49-B803-D25CA44B09ED)
* [Oracle Machine Learning Notebooks](https://docs.oracle.com/en/database/oracle/machine-learning/oml-notebooks/)


## Acknowledgements
* **Author** - Moitreyee Hazarika, Principal User Assistance Developer
* **Contributors** -  Mark Hornick, Senior Director, Data Science and Machine Learning; Marcos Arancibia Coddou, Product Manager, Oracle Data Science; Sherry LaMonica, Principal Member of Tech Staff, Advanced Analytics, Machine Learning
* **Last Updated By/Date** - Tom McGinn and Ashwin Agarwal, March 2021
