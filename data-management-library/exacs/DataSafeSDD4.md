# Create a Sensitive Type and Sensitive Category with Oracle Data Safe

## Introduction
Using Oracle Data Safe, create your own sensitive type and sensitive category.

To log issues and view the Lab Guide source, go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository.

## Objectives
In this lab, you learn how to do the following:
  - Create your own sensitive type in Oracle Data Safe
  - Create your own sensitive category in Oracle Data Safe

## Challenge
In this lab, you create a sensitive type that discovers department IDs in your ExaCS database. Before you create the sensitive type, investigate the `DEPARTMENT_ID` column in your database.

Follow these general steps:
1. Sign in to the Oracle Data Safe Console in your region.
2. Review the predefined sensitive types in the Oracle Data Safe Library. Check if there is a sensitive type that discovers department IDs.
3. Connect to your ExaCS database as the SYS user with SQL Developer.
4. In SQL Developer, inspect the `HCM1.DEPARTMENTS.DEPARTMENT_ID` column. Inspect its type, size, and data. Analyzing the data helps you to define patterns for your sensitive type.
5. In the Oracle Data Safe Console, create a sensitive type by using the **Create Like** option to model your sensitive type after **Employee ID Number**. Save your sensitive type as **<username> Custom Department ID Number** in a custom sensitive category named **<username> Sensitive Category**.

## Steps

### Step 1: Sign in to the Oracle Data Safe Console for your region

- From the navigation menu, click **Data Safe**

![](./images/dbsec/datasafe/login/navigation.png " ")

- You are taken to the **Registered Databases** Page.
- Click on **Service Console**

![](./images/dbsec/datasafe/login/service-console.png " ")

- You are taken to the Data Safe login page. Sign into Data Safe using your credentials.

![](./images/dbsec/datasafe/login/sign-in.png " ")

### Step 2: Review the predefined sensitive types in the Oracle Data Safe Library

- In the Oracle Data Safe Console, click the **Library** tab, and then click **Sensitive Types**. The **Sensitive Types** page is displayed. On this page you can view predefined sensitive types and manage your own sensitive types.

![](./images/dbsec/datasafe/discovery/library-types.png " ")

- Scroll through the list and become familiar with the different sensitive types available. The list contains `predefined` sensitive types only.

![](./images/dbsec/datasafe/discovery/sensitive-types-page.png " ")

- Move the **Hide Oracle Predefined** slider to the right.
The list removes the Oracle defined sensitive types, showing only the ones that you have defined.

![](./images/dbsec/datasafe/discovery/sensitive-custom3.png " ")

- Move the slider back to the left.
- To find out how many sensitive types exist in the Library, scroll to the bottom of the page. The list contains 128 items.
- To sort the list by sensitive category, position your cursor over the **Sensitive Type Category** header, and then click the arrow.
- To sort the list by sensitive types, position your cursor over the **Sensitive Type Name** header, and then click the arrow.
- To view the definition for a sensitive type, click directly on any one of the sensitive types. The **Sensitive Type Details** dialog box is displayed.

![](./images/dbsec/datasafe/discovery/sensitive-types-bank.png " ")
- View the sensitive type's short name, description, column name pattern (regular expression), column comment pattern (regular expression), column data pattern (regular expression), the search pattern semantic (And or Or), the default masking format associated with the sensitive type, and the sensitive category and resource group to which the sensitive type belongs.
- Click **Close** to close the dialog box.
- To check if there is a sensitive type that discovers department IDs, in the search field, enter **Department**.
The search finds **Department Name**, but nothing for department IDs.

![](./images/dbsec/datasafe/discovery/sensitive-department.png " ")

- Clear the search field, and then press **Enter** to restore the list.
- Keep this page open because you return to it later in the lab.

### Step 3: Connect to your ExaCS database as the SYS user with SQL Developer

Please visit [Lab 4: Configuring a development system for use with your EXACS database](?lab=lab-4-configure-development-system-for-use) for instructions to securely configure ExaCS to connect using Oracle SQL Developer, SQLXL and SQL*Plus.

### Step 4: In SQL Developer, analyze the HCM1.DEPARTMENTS.DEPARTMENT_ID column in your ExaCS database to help you figure out how to create a sensitive type for it

- In SQL Developer, run the following command to connect to PDB1 pluggable database:

```
<copy>ALTER SESSION SET CONTAINER=YOUR_PDB_NAME;</copy>
```
- Run the following script:

```
<copy>SELECT * FROM HCM1.DEPARTMENTS;</copy>
```
- Notice that the department ID values are 10, 20, 30, up to 270.

### Step 5: In the Oracle Data Safe Console, create a sensitive type and sensitive category

- Return to the **Sensitive Types** page in the Oracle Data Safe Console.
- Click **Add**.<br>
The **Create Sensitive Type** dialog box is displayed.

![](./images/dbsec/datasafe/discovery/sensitive-custom.png " ")

- From the **Create Like** drop-down list, select **Employee ID Number**.
- In the **Sensitive Type Name** field, enter **<username> Custom Department ID Number**.
- In the **Sensitive Type Short Name** field, enter **Custom Dept ID**.
  - It is helpful to use a word like "Custom" when naming your own sensitive types to make them easier to search for and identify.
- In the **Sensitive Type Description** field, enter **Identification number assigned to departments. Examples: 10, 20, 30...1000**.
- In the **Column Name Pattern** field, enter:

```
<copy>(^|[_-])(DEPT?|DEPARTMENT).?(ID|NO$|NUM|NBR)</copy>
```
- In the **Column Comment Pattern** field, enter:

```
<copy>(DEPT?|DEPARTMENT).?(ID|NO |NUM|NBR)</copy>
```
- In the **Column Data Pattern** field, enter:

```
<copy>^[0-9]{2,4}$</copy>
```
- For **Search Pattern Semantic**, select **And**.
- In the **Default Masking Format** field, enter **Identification Number**.
- In the **Sensitive Category** field, enter **<username> Sensitive Category**. If you do not specify a sensitive category, the category is automatically named "Uncategorized."
- Select your resource group.
- Click **Save**.<br>
Your sensitive type is included in the list and is available in the Data Discovery wizard.

![](./images/dbsec/datasafe/discovery/sensitive-custom2.png " ")

- Move the **Hide Oracle Predefined** slider to the right to view your custom sensitive type in the list.

### All Done!
