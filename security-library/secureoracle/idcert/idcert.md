# Identity Certification

## Introduction

Identity certification is the process of reviewing user entitlements and access-privileges within an enterprise to ensure that users have not acquired entitlements that they are not authorized to have. It also involves either approving (certifying) or rejecting (revoking) each access-privilege. In this lab we will review user certification with custom reviewers.

The following use cases are available:

* User certification with custom reviewers

*Estimated Lab Time*:  60 minutes

### Objectives
- Become familiar with identity certifications

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Initialize Environment

## **STEP 1**: Validate Access to required components and applications
1. Make sure you can access the OIM Admin and Self Service consoles, Roundcube email client and My HR Application. The links below are also bookmarked on Firefox running on your remote desktop. Refer to *Lab: Initialize Environment* for more

    Oracle Identity Manager Admin Console:

    ```
    URL         http://secureoracle.oracledemo.com:14000/sysadmin
    User        xelsysadm
    Password    Oracle123
    ```

    Oracle Identity Manager Self Service:

    ```
    URL         http://secureoracle.oracledemo.com:14000/identity
    User        xelsysadm
    Password    Oracle123
    ```

    Email Web Client (Roundcube):

    ```
    URL         http://secureoracle.oracledemo.com/roundcubemail-1.4.1/
    User        admin
    Password    Oracle123
    Server      secureoracle.oracledemo.com
    ```

    My IGA Application

    ```
	URL         http://secureoracle.oracledemo.com:7001/ords/f?p=102
	User        xelsysadm
	Password    Oracle123
    ```

## **STEP 2**: User Certification with Custom Reviewers
User certification allows managers to certify employee access to roles, accounts, and entitlements. Typically, each manager in an organization reviews the access-privileges of the people who report directly to that manager. Alternatively, custom reviewers for user certifications can be specified by defining certification rules in the **`CERT_CUSTOM_ACCESS_REVIEWERS`** table in the Oracle Identity Manager database.

In the SecureOracle environment, My IGA Application contains a custom UI to maintain the **`CERT_CUSTOM_ACCESS_REVIEWERS`** table, so administrators can easily define custom reviewers.

1. Login to My IGA Application to define customer reviewers.

    E.g. Use the following link and credentials:

    ```
	URL         http://secureoracle.oracledemo.com:7001/ords/f?p=102
	User        xelsysadm
	Password    Oracle123
    ```

2. In the sidebar menu click on the **Custom Reviewers** option to open the Custom Reviewers page. Proceed to define custom reviewers and users as needed.

    E.g. For convenience a custom reviewer has been defined already along with two users who will be certified.

    ```
	MAP NAME         REVIEWER LOGIN   USER LOGIN   ACCESS TYPE
	2019 Q4 Review   MGRAFF           AHUTTON      User
	2019 Q4 Review   MGRAFF           AHUTTON      User
    ```

    **Note**: You are welcome to add additional reviewers and users. OIM will generate a certification task for each **Map Name**. For more details in rules and definitions please consult the official documentation under [Custom Reviewer for User Certifications](https://docs.oracle.com/en/middleware/idm/identity-governance/12.2.1.4/omusg/managing-identity-certification.html#GUID-941F44D2-1B30-4B0A-AF25-3BE0430C7F8A).

    ![](./images/img-custom-reviewer.png " ")

    Figure 1. Custom Reviewers

3. Proceed to sign out from My IGA Application.

4. Configure the certification options by login to OIM Self Service as administrator.

    E.g. Use the following link and credentials:

    ```
	URL         http://secureoracle.oracledemo.com:14000/identity
	User        xelsysadm
	Password    Oracle123
    ```

5. Go to **`Compliance -> Identity Certification -> Certification Configuration`** and validate the configuration as follow.

    E.g. Use the following configuration as reference:

    ```
    Password required on sign-off                : [checked]
    Allow comments on certify operations         : [unchecked]
    Allow comments on all non-certify operations : [checked]
    Verify employee access                       : [checked]
    Prevent self certification                   : [checked]
	                                               Alternate Reviewer : User Manager

    User and Account Selections         : Include any user with active accounts
    Allow advanced delegation           : [unchecked]
    Allow multi-phased review           : [unchecked]
    Allow reassignment                  : [unchecked]
    Allow auto-claim                    : [checked]
    Perform closed loop remediation     : [checked]

    Enable Interactive Excel            : [unchecked]
    Enable Certification Reports        : [checked]
    ```

6. Proceed to click the **Test Connection** button to test the communication with the BI Publisher component, if you make changes, save the changes otherwise click **Cancel** to close the page.

7. Proceed to create a certification definition. For your convenience we have already created a certification definition, as a reference the following table contains the parameters used in the definition.

    E.g. Parameters in certification definition:

    ```
    Name              : 2019 Q4 Review
    Type              : User
    Description       : Custom Reviewers Certification

    In Base Selection
    Only Users from Select Organization : Oracle Users
	                                      Finance
	                                      Sales
    Constrains                          : Users with Any Level of Risk

    In Content Selection
    Include users with no accounts      : [checked]

    Limit the role-assignments to certify for each user : All Roles
    Include accounts with no certifiable attributes     : [checked]

    Limit the application-instance-assignments to certify for each user : All Application Instances
    Limit the entitlement-assignments to certify for each user          : All Entitlements

    In Configuration
    Accept the defaults settings

    In Reviewers
    Reviewer                        : Custom Access Reviewer
    Custom Access Reviewer Map Name : 2019 Q4 Review

    In Incremental
    Accept the defaults settings

    In Summary, review results
    Name              : 2019 Q4 Review
    Description       : Custom Reviewers Certification
    Type              : User
    Reviewer          : Custom Access Reviewer
    Incremental       : No
    Base Selection    : 3 Organizations Selected

	Users with Any Level of Risk
    Content Selection : All Roles
	                    All Application Instances
	                    All Entitlements
    ```

    **Note**: Notice the section **Reviewers** where we have specified the map name **`2019 Q4 Review`** defined in the **`CERT_CUSTOM_ACCESS_REVIEWERS`** table. After a certification definition is created, OIM offers the option to automatically create a job for the new certification. In the above example OIM created job **`Cert_2019 Q4 Review`**.

8. Proceed to run the certification, do so by login into OIM Self Service as user **XELSYSADM**. Go to **`Compliance -> Identity Certification -> Definitions`**.

9. Select certification **`2019 Q4 Review`** and click the **Run Now** button.

10. OIM will start the certification task and notify the reviewer in this case user **MGRAFF**. You can login to the Email Web Client (Roundcube) to review the email notification.

    E.g. Use the following link and credentials

    ```
	URL         http://secureoracle.oracledemo.com/roundcubemail-1.4.1/
	User        mgraff
	Password    Oracle123
	Server      secureoracle.oracledemo.com
    ```

    ![](./images/img-cert-email.png " ")

    Figure 2. Certification Email

11. Proceed to Login to OIM Self Service as user **MGRAFF**. Go to **`Self Service -> Certifications`**. In the **Pending Certifications** page the new certification will be listed, proceed to click in the link name **`2019 Q4 Review [Molly Graff]`** to review and certify the users.

    ![](./images/user-certifications.png " ")

    Figure 3. User Certification

12. Once all the users are certified by default OIM will prompt the reviewer **MGRAFF** to enter her credentials to sign off the certification task.

13. Proceed to sign out from OIM Self Service.

## **Appendix**: About Custom Reviewers
You can define your own custom access reviewer for user certifications by specifying certification rules for specific user accounts, roles, entitlements, or application instances, or a combination of these entities, with a particular reviewer. In addition, you can group the certification rules and assign a map name to the certification rule to specify a reviewer for that map name.

These rules can be defined in the **`CERT_CUSTOM_ACCESS_REVIEWERS`** table in Oracle Identity Manager database.

The following conditions must be met for using the custom access reviewer for user certification feature:
* Reviewer table does not support any wildcards for any of the fields/columns.
* Reviewer table has mappings defined for each and every user to be included in certification.
* Application instance information is required for all account and entitlement mappings.
* Only one instance of default reviewer and alternate reviewer mapping is allowed per map name.

In the SecureOracle environment, My IGA Application contains a custom UI to maintain the **`CERT_CUSTOM_ACCESS_REVIEWERS`** table, so administrators can easily define custom reviewers, this option is available under **Custom Reviewers** option in My IGA Application menu.

Additional details can be found in the official documentation under [Custom Reviewer for User Certifications](https://docs.oracle.com/en/middleware/idm/identity-governance/12.2.1.4/omusg/managing-identity-certification.html#GUID-941F44D2-1B30-4B0A-AF25-3BE0430C7F8A).

You may now *proceed to the next lab*.

## Learn More About Identity and Access Management
Use these links to get more information about Oracle Identity and Access Management:
- [Oracle Identity Management Website](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.4/index.html)
- [Oracle Identity Governance Documentation](https://docs.oracle.com/en/middleware/idm/identity-governance/12.2.1.4/index.html)
- [Oracle Access Management Documentation](https://docs.oracle.com/en/middleware/idm/access-manager/12.2.1.4/books.html)

## Acknowledgements
- **Author** - Ricardo Gutierrez, Solution Engineering - Security and Management
- **Contributors** - Rene Fontcha
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
