
<p align="center">
  <img width="650" height="300" src="./media/banner.png">
</p>

# Getting Started

# Appendix

&nbsp;&nbsp;&nbsp;&nbsp;[Create VBCS Instance](#create-vbcs-instance)


# Lab Purpose and Rules

These labs are designed to provide you with an introduction to using
Visual Builder to create Web and Mobile applications and to prepare you
to demonstrate Visual Builder to customers or to use Visual Builder to
demonstrate other products to Oracle’s customers.

Here are some general guidelines that will help you get the most from
these lab exercises.

  - Read through an entire exercise before executing any of the steps.
    Becoming familiar with the expected flow will enhance your learning
    experience.

  - Ask before you do. If you have any questions, please ask the
    instructor before you march down a path that may lead to wasting
    your time.

  - Follow the steps as shown in the Lab Guide. This is a live
    environment. If you want to do something that is not in the labs,
    ask the lab instructor first. In particular, do not create, delete,
    or alter any cloud objects without asking first.

  - There is no prize for finishing first; there is no penalty for
    finishing last. The goal is to gain a firm understanding of Oracle
    Visual Builder.

  - Ask questions freely. The only dumb questions are those that are not
    asked.



# Create VBCS Instance

As part of the lab, we expect learns to create the VBCS instance before the session delivery.
If you are creating a new instance either for the lab purposes or a customer demonstration, please follow the next steps; the process is simple but require several minutes to complete.

In this lab you will make sure you can access the VBCS instance for your
classroom and supporting lab files.

First, go to cloud.oracle.com, click on **View Accounts** and select **Sign in to cloud**

![](./media/cloudoracle.png)

Enter your tenant account

![](./media/tenant.png)

On the login screen select SSO and provide your credentials *(Contact your tenant admin if you are using a different login mechanism)*


![](./media/credentials.png)

![](./media/credentials_2.png)

Once in the main dashboard, open the **General Menu** located at the top left hand side of the screen, select **Platform Services**, and click on **Visual Builder**

![](./media/vb_dashboard.png)


1.  Log into your tenancy using cloud.oracle.com; be sure it has been
    provisioned to allow Visual Builder Cloud Service and the database
    and object storage instances also required.  
    (check with your tenancy admin if unsure)


3.  From the “Visual Builder” service box there are two ways to open a
    service console.

![](./media/image_a_3.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.1.1 – Visual Builder service

One method is to click on the box’s “Visual Builder” text to display an
overview page.

![](./media/image_a_7.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.1.2 – Visual Builder Overview

From the overview page, click the “Open Service Console” button to
continue.

![](./media/image_a_8.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.1.3 – Open Service Console button

Another method is to click the **General Menu** icon
![](./media/image_a_9.png) in the lower-right corner of the  “Visual Builder” service box to display a menu.

![](./media/image_a_3.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.2.1 – Visual Builder service box

Select “Open Service Console” from the menu.

![](./media/image_a_10.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.2.2 – Visual Builder service menu

4.  If you have not created any services the Service Console prompts you
    to begin the process.

**DO NOT** CLICK “CREATE INSTANCE” at this time, we will be using
“Quick Starts” (see step 5).

![](./media/image_a_11.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.4.1 – Create Instance invitation

If Visual Builder instances already exist they will be shown in a table.

![](./media/image_a_12.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.4.2 – VBCS existing instance(s)

**DO NOT** CLICK “CREATE INSTANCE” at this time, we will be using “Quick Starts” (see step 5).

5.  Visual Builder provides a “Quick Starts” capability to build an
    instance complete with supporting database and object storage. Click
    the “Quick Starts” button to get started it is located in the
    upper-right portion of the Service Console display inside the big
    blue bar.

![](./media/image_a_13.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.5.1 – Quick Starts button When presented with the “QuickStarts” panel; provide an instance name and click the “Start” button to begin the process.
 
![](./media/image_a_14.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.5.2 – QuickStarts page Creation should take place in less than five minutes.
 
![](./media/image_a_15.png) 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.5.3 – Create button
 
That’s it, you’ve created an instance that can support many VBCS applications and user.


NOTE:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If others will be sharing your VBCS instance you will need to use Oracle Identity Cloud Service (IDCS)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to make sure they have 'ServiceDeveloper' (Visual Builder Administrator) role for your instance if they are developers or 'ServiceAdministrator' (Visual Builder Administrator) role if they need to administer other's applications.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;See Oracle Documentation for more information.


[Return to Main Page](README.md)
