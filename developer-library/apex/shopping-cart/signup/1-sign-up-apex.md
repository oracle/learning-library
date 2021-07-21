# Sign up for an Oracle APEX Workspace

## Introduction

Oracle Application Express (APEX) is a feature of Oracle Database, including the Autonomous Data Warehouse (ADW) and Autonomous Transaction Processing (ATP) services. To start, you will need to decide which Oracle Database you are going to use for the lab, and then create an APEX workspace in that database.

If you already have an APEX 21.1 Workspace provisioned you can skip this lab and go straight to (Lab 1) [Installing Sample Tables](?lab=1-installing-sample-tables)

### What is an APEX Workspace?
An APEX Workspace is a logical domain where you define APEX applications. Each workspace is associated with one or more database schemas (database users) which are used to store the database objects, such as tables, views, packages, and more. These database objects are generally what APEX applications are built on top of.

### Objectives
Access an Oracle APEX Workspace.

### What Do You Need?

- An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).



## **Option 1**: apex.oracle.com
Signing up for apex.oracle.com is simply a matter of providing details on the workspace you wish to create and then waiting for the approval email.

1. Go to [https://apex.oracle.com](https://apex.oracle.com)
2. Click **Get Started for Free**

    ![](images/get-started.png " ")

3. Scroll down until you see details for apex.oracle.com.  Click **Request a Free Workspace**

    ![](images/request-workspace.png " ")

3. On the Request a Workspace dialog, enter your Identification details – First Name, Last Name, Email, Workspace  
   *{Note: For workspace enter a unique name,
such as first initial and last name}*

    Click **Next**.

    ![](images/request-a-workspace.png " ")

3. Complete the remaining wizard steps.

4. Check your email. You should get an email from oracle- application-express_ww@oracle.com
within a few minutes.  
   *{Note: If you don’t get an email go
back to Step 3 and make sure to enter
your email correctly}*

    Within the email body, click **Create Workspace**

    ![](images/create-aoc-workspace.png " ")

3. Click **Continue to Sign In Screen**.
4. Enter your password, and click **Apply Changes**.
5. You should now be in the APEX Builder.

    ![](images/apex-builder.png " ")


## **Summary**

This completes the lab setup. At this point, you know how to create an APEX Workspace and you are ready to start building amazing apps, fast.

Go to [Installing Sample Tables](?lab=1-installing-sample-tables) to create data structures in your APEX Workspace.

## **Acknowledgments**

- **Author** - Mónica Godoy, Principal Product Manager
- **Contributors** - 
- **Last Updated By/Date** - Mónica Godoy, Principal Product Manager
## Need Help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
