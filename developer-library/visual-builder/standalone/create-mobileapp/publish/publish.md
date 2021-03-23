# Publish an Oracle Visual Builder Mobile Application

## Introduction

This tutorial shows you how to publish a mobile application.

### Estimated Lab Time:  10 minutes

### Background

After you successfully test the staged application, you can publish it and make the application live. Users who have the proper credentials can view the live application. You can’t make changes to an application once it's published. Instead, you must create and edit a new version.

## **STEP 1**: Publish the Application

These steps assume that you are already logged in to Oracle Visual Builder and are viewing the HR Application you created.

1.  In the Navigator, click the **Mobile Applications** ![](images/vbmpu_mob_mob_icon.png) tab.
2.  Click the **hrmobileapp** node, click the **Settings** tab, then the **Build Configurations** tab.
3.  Select the Android build configuration, click **Options** ![](images/vbmpu_menu_icon.png) and select **Edit**.
4.  From the **Build Type** drop-down list, select **Release**, then click **Save Configuration**.
5.  Do the same for the iOS build configuration, so that both your build configurations are set for release:

    ![](./images/vbmpu_pub_s3.png)

    **Note:** Remember that  for demonstration purposes, we're using the same builds for development and production. When defining your build configurations for a mobile application, make sure you create different builds for the different environments.  

6.  Click **Oracle Visual Builder** to return to the Visual Applications page:

    ![](./images/vbmca_homeicon.png)

7.  Click **Options** ![](./images/vbmpu_menu_icon.png) for the HR Application, and select **Publish**.
8.  In the Publish Application dialog box, select **Include data from Stage**, and click **Publish**.

    ![](./images/vbmpu_pub_s8.png)

    The schema and data from the staging database are copied to the live database. The application is now live.

9.  On the Visual Applications page, click **Live** and select **hrmobileapp**.

    ![](./images/vbmpu_pub_s9.png)

    The application opens in a browser simulator tab, where the user can view the start page of the mobile application. On the right is the QR code and installation file link for downloading and installing the mobile application on a supported device (Android and iOS).

    ![](./images/vbmpu_pub.png)

## Acknowledgements
**Author** - Sheryl Manoharan

**Last Updated** - February 2021
