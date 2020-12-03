# Add GitHub Hosted Labs and Workshops to OHC

## Introduction
You need to add a link from your Oracle Help Center (OHC) page to a lab hosted on an Oracle GitHub repository. This lab details how to use Oracle Learning Library (OLL) administration tools to manage links and how to add a link to an OHC page.

### Objectives
* Create an OLL content entry for your lab.
* Create the Target URL for a Lab.
* Add the content entry link to OHC.

### What Do You Need?
* Required OLL privileges
* Required privileges to add your entry to OHC

This lab assumes that you have successfully completed the previous labs in the **Contents** menu on the right.

## **STEP 1:** Create an Oracle Learning Library Content Entry for the Lab
Every GitHub-hosted lab that will be accessed from the Oracle Help Center must be registered as a content entry in the Oracle Learning Library (OLL).
You must have OLL administrator privileges to view and edit content entries in OLL.
1. Log in to the [OLL Home page] (https://apexapps.oracle.com/pls/apex/f?p=44785:1) using your Oracle SSO credentials.
2. From your **User ID** drop-down, click **Administration**.
3. Under **Maintenance**, click **Content**.
4. Click **Content Entries**.
5. Click **Create**.
6. Enter the **Content Entry Details**. A few entries are highlighted here:
    * **Link**: Enter the complete URL for the lab on GitHub, for example, https://oracle.github.io/learning-library/workshops/adwc4dev/?version=Self-Guided&page=L100.md.

    ![](./images/content-entry-link.png " ")
    * **Type**: Select **OBE**. (Older labs were called Oracle By Example or tutorials.)

## **STEP 2:** Create the Target URL for a Lab

1. Log in to the [OLL Home page] (https://apexapps.oracle.com/pls/apex/f?p=44785:1) using your Oracle SSO credentials.
2. From your **User ID** drop-down, click **Administration**.
3. Under **Maintenance**, click **Content**.
4. Click **Content Entries**.
5. To find your the content entry for the lab, click on a header label in the table, click in the **Filter** field, begin typing what you're looking for, and then select the appropriate item.
6. Click **link** under **Copy This** to copy the content entry link.

  The content ID URL opens in your browser.

7. Save the URL, which you will use to create a link from an OHC page.

## **Step 3:** Add a Link to the Lab from Oracle Help Center
To add a link to a lab from an OHC Tutorials page:
1. Open the [Self Publishing OHC Interface Page V3 application](https://apex.oraclecorp.com/pls/apex/f?p=40100:1:101812173799316:::::).
2. In the **Search** field, enter your Product name and press **Enter**.
3. Edit the release page for your Product to which, you want to add the lab.
    [](./images/ohc-edit-Pages.png " ")
4. Click **Sections/Topics** and then click the name of the section where you want to add the lab to display the **Section** page.
    [](./images/ohc-section-topics.png " ")
5. Click **Topics** and then click **Create Topic**.

6. In the **Create Topic** section, enter the title of the lab and, in **Href**, enter the URL you created in "**STEP 2:** Create the Target URL for a Lab".

**This concludes this lab.**

## Want to Learn More?
* [Add GitHub Hosted Tutorials to OHC](https://confluence.oraclecorp.com/confluence/display/DBIDDP/Add+GitHub-Hosted+Tutorials+to+the+Oracle+Help+Center)

## Acknowledgements

* **Author:**
    * Anuradha Chepuri, Principal User Assistance Developer, Oracle GoldenGate

* **Reviewed by:**  
    * Aslam Khan, Senior User Assistance Manager, ODI, OGG, EDQ
    * Tom McGinn, Database and Database Cloud Service Senior Principal Product Manager, DB Development - Documentation
* **Last Updated By/Date:** Anuradha Chepuri, November 2020

## Need Help?  
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
