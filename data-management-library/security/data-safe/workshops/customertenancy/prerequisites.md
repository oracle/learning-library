
# Prerequisites for the Customer Tenancy

## Introduction

To complete the Oracle Data Safe labs in your own tenancy in Oracle Cloud Infrastructure, you require access to an Oracle Data Safe environment. As a regular Oracle Cloud user, you do not have the necessary permissions in Oracle Cloud Infrastructure to set up your own environment. The environment needs to be set up by your tenancy administrator. The setup instructions are [here](?lab=set-up-oracle-data-safe-environment).

Estimated Lab Time: 5 minutes


### Objectives


In this lab, you'll:

- Request access to an Oracle Data Safe service in your tenancy
- Sign in to a region of your tenancy by using your Oracle Cloud account credentials



### Prerequisites

Your tenancy administrator needs to set up an Oracle Data Safe environment for you before you can work through the labs in the Oracle Data Safe Workshop. After the environment is set up, you should have the following items:

- An Oracle Cloud account in your tenancy.
- A compartment in your tenancy. During the labs, you create an Autonomous Database in the compartment and register it with Oracle Data Safe. By using your own compartment, the tenancy administrator can ensure that only you can access your database and save Oracle Data Safe resources to the compartment. In the labs, this compartment is referred to as "your compartment."
- An Oracle Data Safe service that you can access in a region of your tenancy.
- Privileges to use all of the Oracle Data Safe features, including User Assessment, Security Assessment, Activity Auditing, Data Discovery, and Data Masking.



## **STEP 1** Request access to Oracle Data Safe

1. Send your email address to your tenancy administrator and request a user account in your tenancy and access to Oracle Data Safe.

2. Send your tenancy administrator the instructions on how to set up an Oracle Data Safe environment for you. The instructions are [here](?lab=set-up-oracle-data-safe-environment).



## **STEP 2** Sign in to the Oracle Cloud Infrastructure Console by using your Oracle Cloud account credentials

After the Oracle Data Safe environment is set up by your tenancy administrator, you should receive an email from Oracle with instructions on how to sign in to your tenancy.


1. Access the Oracle email that was sent to you with the sign-in information for your Oracle Cloud user account. The email provides two links to the Oracle Cloud Infrastructure Console (you can use either link), your tenancy name, and your user name.

2. Obtain your password to the tenancy from your tenancy administrator.

3. When you're ready to sign in, click the **Sign in to your new user account** link. The **Oracle Cloud Infrastructure Sign In** page is displayed. Your tenancy name is already filled in for you.


4. Under **Oracle Cloud Infrastructure**, in the **USER NAME** field, enter your Oracle Cloud user name.


5. In the **PASSWORD** field, enter the temporary password provided to you by your tenancy administrator.


6. Click **Sign In**.

7. If prompted by your browser to save the password, click **Never**.



8. If this is the first time that you are signing in to the Oracle Cloud Infrastructure Console, you are prompted to change your password. Enter your temporary password and your new password, and then click **Save New Password**. After you sign in, the message **Email Activation Complete** is displayed.





You are ready to begin the labs. Start with the [**Introduction**](?lab=introduction).


If you have a question during this workshop, you can use the **[Autonomous Data Warehouse Forum](https://cloudcustomerconnect.oracle.com/resources/32a53f8587/summary)** on **Cloud Customer Connect** to post questions, connect with experts, and share your thoughts and ideas about Oracle Data Safe. Are you completely new to the **Cloud Customer Connect** forums? Visit our **[Getting Started forum page](https://cloudcustomerconnect.oracle.com/pages/1f00b02b84)** to learn how to best leverage community resources.




## Learn More

- [ Oracle Cloud Infrastructure documentation - Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm)


## Acknowledgements

* **Author** - Jody Glover, Principal User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, October 15, 2020


## See an issue?

Please submit feedback using this <a  href="https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1" >form</a>. Please include the **workshop name**, **lab**, and **step** in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the **Feedback Comments** section.
