
# Creating a Database User

## Introduction

In this lab, you will create a database user.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

- Create the database user that you will use in the next lab
- Update the user's profile to grant access to load and store data
- Log in as the user

### Prerequisites

To complete this lab, you need to have the following:

- All previous labs successfully completed.

## **STEP 1:** Creating New Database Users

When you create a new data warehouse you automatically get an account called ADMIN that is your super administrator user. In the real world, you will definitely want to keep your data warehouse data completely separate from the administration processes. Therefore, you will need to know how to create separate new users and grant them access to your data warehouse. This section will guide you through this process using the &quot;New User&quot; wizard within the SQL Worksheet (one of the built-in tools in Autonomous Data Warehouse).

For this workshop we need to create one new user.

1. Navigate to the Details page of the Autonomous Database you provisioned in the &quot;Provisioning an ADW Instance&quot; lab. In this example, the database is named &quot;My Quick Start Lab.&quot; Launch **Database Actions** by clicking the **Tools** tab and then click the button to open the Database Actions home page.

  ![ALT text is not available for this image](images/2878884319.png)

2. Enter ADMIN for the username and click **Next**. On the next form, enter the ADMIN password - which is the one you entered when creating your Autonomous Data Warehouse.

  ![ALT text is not available for this image](images/2878884336.png)

3. On the Database Actions home page, click the **Database Users** card.

  ![ALT text is not available for this image](images/2878884369.png)

4.  You can see that your ADMIN user is listed as the current user.  On the right-hand side click the &quot;+ **Create User**&quot; button.

  ![ALT text is not available for this image](images/2878884398.png)

5. The **Create User**  form will appear on the right-hand side of your browser window. Use the settings below to complete the form:

 - username: **QTEAM**
 - password: make up your own suitably strong password.

    **NOTE - Rules for User Passwords** Autonomous Data Warehouse requires strong passwords. User passwords user must meet the following default password complexity rules:

    - Password must be between 12 and 30 characters long

    - Must include at least one uppercase letter, one lowercase letter, and one numeric character

    - Limit passwords to a maximum of 30 characters

    - Cannot contain the username

    - Cannot be one of the last four passwords used for the same username

    - Cannot contain the double quote (&quot;) character

    There is more information available in the documentation about password rules and how to create your own password rules, see here: [Create Users on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/manage-users-create.html#GUID-B5846072-995B-4B81-BDCB-AF530BC42847)

- Toggle the **REST Enable** button to **On** and accept the default alias which is automatically set to qteam - this allows the user access to our new data warehouse using the Database Actions tools.
- Leave the **Authorization required** toggle button as on/blue. 
- Leave the Graph button turned off.
- Leave the **Password Expired** toggle button as off (note this controls whether the user will be prompted to change their password when they next login).
- Leave the **Account is locked **toggle button as off. 

Next you will examine the form.

6.  When you examine the form, it should look like this:

  ![ALT text is not available for this image](images/2878884610.png)

7.  Click on the Granted Roles banner at the top of the form and add the role DWROLE by checking the box in the first column.

  ![ALT text is not available for this image](images/2878884644.png)

Notice that two additional roles have already been automatically assigned: **CONNECT** and **RESOURCE**.  

8.  Finally, click the **Create User** button at the bottom of the form.

## **STEP 2:** Updating User Profiles

The final step in this section is to grant our newly created user with access to load and store data (the next lab will step you through the process of loading data).

1.  From the user administration page, click the **hamburger menu** to open the **Database Actions** menu.

2.  Click on **Development** and then select **SQL**.

  ![ALT text is not available for this image](images/2861210865.png)

3.  Note that this will launch the **SQL** tool and display a **SQL worksheet**.

  ![ALT text is not available for this image](images/2861210866.png)

4.  Copy the command below into the worksheet on line 1: 

<pre>GRANT UNLIMITED TABLESPACE TO QTEAM;</pre>

5.  To run this command, which will grant the additional space privilege required by your database user, click the **green circle** icon:

  ![ALT text is not available for this image](images/2878884759.png)

6.  In the script output window at the bottom of your browser window, you should see the following message: **Grant succeeded** 

  ![ALT text is not available for this image](images/2878884854.png)

## **STEP 3:** Login As User QTEAM

Now you need to switch to working as the user QTEAM so you can start the next lab on data loading.

1. From the SQL Worksheet page, click the hamburger menu and in the Database Actions menu, click Administration, then Database Users.

  ![ALT text is not available for this image](images/2878885017.png)

2. Find the card for the user QTEAM and click on the box with the upward pointing arrow at the bottom of the card.

  ![ALT text is not available for this image](images/2878885042.png)

3. Enter the username QTEAM and the password you defined in Step 2 when you created this user.

  ![ALT text is not available for this image](images/2878885088.png)

4. This will launch the Database Actions home page.

  ![ALT text is not available for this image](images/2878885105.png)


Now you have connected to your Autonomous Data Warehouse with your new user. You are ready to go to the next lab!

## Learn More

See the documentation on [Managing Users on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/manage.html#GUID-AD7ACC07-AAF7-482A-8845-9C726B1BA86D). This topic describes administration tasks for managing users on Autonomous Database.

## Acknowledgements

- Created By/Date - Keith Laker, Product Manager, Autonomous Database, March 2021
- Contributors - Nilay Panchal, Rick Green, Patrick Wheeler, Marty Gubar, Bud Endress, Jayant Mahto, Mike Matthews
- Last Updated By - Brianna Ambler, June 2021
