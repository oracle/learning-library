![](./media/image1.png)

## Class of SE - HOL Part 1 - Cloud access and locating your compartment
Contents

[Section 1. Overview](#overview)

[Section 2. Oracle Cloud Account](#oracle-cloud-account)

[Section 3. Locate Your Compartment](#locate-your-compartment)


## 
#
# Overview

This lab will introduce you to the Oracle Cloud Infrastructure service.
In part one we'll login and verify that our accounts are working and setup correctly. 
Then we'll create a compartment that will contain the resources we'll create as the course progresses.  This lab is designed to be a step by step introduction to the basic OCI services.

## Objectives

1.  Obtain and access an Oracle Cloud Account

2.  Locate your Compartment

## Requirements

  - Supported web browswer
  - Internet access
  - Pre-provisioned cloud account
  
  ## Lab Purpose and Requirements

The purpose of this workshop is to familiarize attendees with the feature functionality of Oracle Cloud Infrastructure. It is assumed that attendees have a solid understanding of basic related concepts such as familiarity with Linux administration, basic network principles, and data storage technologies.

To optimize your experience there are some general guidelines that will help you get the most from these lab exercises.

  - **Read through an entire exercise before executing any of the steps.** 
  Merely following the screen shots or script files without understanding the flow will diminish your learning experience.

  - **Follow the steps as shown in the workshop manual.**
    Don’t freestyle during the labs. This is a live environment. If you want to do something that is not in the labs, ask the lab instructor first. In particular, do not create, delete, or alter any database objects without asking first.

  - **There is no prize for finishing first; there is no penalty for finishing last.** 
  The goal is to gain a firm understanding of Oracle Cloud Infrastructure.

  - **Ask questions freely.** 
  The only dumb questions are those that are not asked.

# Oracle Cloud Account
[Back to top](#Class-of-SE---HOL-Part-1---Cloud-access-and-locating-your-compartment)

1.  Sign in to the Oracle Cloud

![](./media/image04.png)
*<p align="center">Figure 1: Sign in to the Oracle Cloud </p>*

2.  Use the tenancy provided by your instructor.  Click the next button.

![](./media/image02.png)
*<p align="center">Figure 2: Tenancy </p>*

There are two ways you can potentially access the Oracle Cloud, by using your Oracle SSO or by using an IDS user account created for lab purposes only.

  3.  For internal Oracle trainings you will use your SSO login.

![](./media/image03.png)
*<p align="center">Figure 3: Oracle Single Sign On </p>*

  4.  For external trainings an IDS username and password have been created in advance.  Your login information will be sent via email. Look for an email from Oracle Cloud.

![](./media/image6.png)

*<p align="center">Figure 4: Sample email </p>*


5.  Click the link in the email to access your
    services directly. Use the ***userid*** and ***temporary password***
    from the email to login. You will be asked to change your password.
    Be prepared with a strong password that meets the security criteria.

**Note:** *Your username will be your Oracle email address.*

> ![](./media/image8.png)

*<p align="center"> Figure 5: Cloud Account login screen</p>*

> ![](./media/image9.png)

*<p align="center"> Figure 6: Password reset screen</p>*

> ***Password Criteria:***

  - *Password must have at least 12 characters*
  - *Password cannot exceed 40 characters*
  - *Password cannot contain the First or Last Name of the user*
  - *Password cannot contain the user name*
  - *Password must have at least 1 lower case character*
  - *Password must have at least 1 upper case character*
  - *Password must have at least 1 numeric character*
  - *Cannot repeat the last 4 passwords*

**Note 1:** *If you <span class="underline">haven’t received an
introduction email</span> you can login directly and request a password reset. Open a browser and navigate to:* <span class="underline">
<https://cloud.oracle.com/en_US/sign-in>.</span> *Use the ‘**Can’t Sign
In**’ link to reset your password, a password reset link will be sent to
your email.  The initial invitation will expire within 24 hours.  If your login offer has expired, contact an admin.*

**Note 2:** *You cannot reset your SSO password with the 'Can't sign in?' link.  If SSO isn't working for you, see your administrator.*

![](./media/image10.png)

*<p align="center"> Figure 7: Reset password</p>*

3.  After you’ve successfully logged in, you should arrive at the Guided
    Journey screen. Choose the hamburger icon at the top left of the
    screen click **Services**, and choose **Compute.**  This will take you to the OCI interface.

![](./media/image11.png)

*<p align="center"> Figure 8: Guided Journey Screen</p>*

# Locate your compartment
[Back to top](#Class-of-SE---HOL-Part-1---Cloud-access-and-locating-your-compartment)

Compartments are logical containers used to isolate resources within your OCI tenancy.    When working with OCI, creating compartments for resource organization is highly recommended.  

There is an absolute limit on OCI compartments and due to the large number of students who will be taking this HOL at the same time, we've created compartments in advance.  You should create your resources in the compartment labeled for your hub location.  

- Austin-Hub
- Bangalore-Hub
- Burlington-Hub
- Reston-Hub
- SantaMonica-Hub

Please create your resources like VCN and instances within the hub compartment name that matches your physical location.  

For more information on Compartments, like best practices and examples, see the [documentation](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm).

1.  Click the **hamburger icon** in the upper left corner to open the navigation menu. Under the **Identity** section of the menu, click **Compartments**

![](./media/image12.png)

*<p align="center"> Figure 9: OCI Console Compartments menu</p>*

2. Click on the **Training** compartment

![](./media/image13a.png)

*<p align="center"> Figure 10:  Choose Compartment</p>*

3.  Locate the compartment name that matches your physical training location and utilize this compartment for the following exercises.  

![](./media/image14a.png)

*<p align="center"> Figure 11: Create compartment dialog</p>*

4.  If you want to view the compartment details, change the compartment name, or delete the compartment, click the ellipses and choose an option.

![](./media/image16.png)

*<p align="center"> Figure 12: Compartment options</p>*

![](./media/image99.png)

This lab segment is complete.    If there is time left before the next lecture, browse the OCI cloud interface and familiarize yourself with the layout and basic services.  Wait for the instructor to let you know when to begin section 2.

[Back to top](#Class-of-SE---HOL-Part-1---Cloud-access-and-locating-your-compartment)

##