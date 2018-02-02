# Running an App in Oracle Mobile Cloud Service #

## ![](../common/img/32_begin.png) Before You Begin ##

This tutorial shows you how to import and run a mobile phone app with Oracle Mobile Cloud Service.

### Background ###

Oracle Mobile Application Accelerator (Oracle MAX) is a free mobile app. With it, you can create and publish iOS and Android mobile apps without writing a single line of code.

### What Do You Need? ###

* Access to an instance of Oracle Mobile Cloud Service
* Identity domain administration role
* The latest version of Oracle MAX for your Android or iPhone, downloaded from the Google Play Store or Apple App Store
* The sample [CRM Service](files/package-crm.zip) import package for Oracle Mobile Cloud Service
* The sample [phone app](files/package-crm-phone-app.zip) import package for Oracle Mobile Cloud Service


## ![](../common/img/32_1.png) Log In to Your Instance of Oracle Mobile Cloud Service ##

1. Log in to your cloud instance.
2. Click **Dashboard**.
3. Click **Customize Dashboard**.
4. Select **Show** for **Mobile Environment Service**.
5. Close the **Customize Dashboard** window.
6. In the **Mobile Environment Service** tile, click the **Action** menu ![](img/hamburger.png) and select **View Details**. 
7. On the **Service Details** page, click the **Service Instance URL** link. 
<br>![](img/t01_02_mcs_details.png)
<br>[Description of the illustration t01_02_mcs_details.png](files/t01_02_mcs_details.txt)

## ![](../common/img/32_2.png) Import the Backend Service ##

In this section, you import the customer relationship management (CRM) backend service that provides data to the mobile app.

1. If you aren't logged in to your instance of Mobile Cloud Service, log in now.
2. Click the **DEVELOPMENT** menu ![](img/t02_01_dev_menu.png), and then click **Applications**.
3. On the **Applications** page, click **Packages**. 
4. On the **Packages** page, click **New Import**. 
5. On the **Import** page, click **Choose a package file**. 
<br>![](img/t02_04_import_package_overlay.png)
<br>[Description of the illustration t02_04_import_package_overlay.png](files/t02_04_import_package_overlay.txt)
6. In the **Open File** dialog box, navigate to the path where you saved the `package-crm.zip` file and click **Open**. 
<br>![](img/t02_05_open_file_dialog_crm_pkg.png)
<br>[Description of the illustration t02_05_open_file_dialog_crm_pkg.png](files/t02_05_open_file_dialog_crm_pkg.txt)
7. On the **Import Package** page, confirm that the following message appears: `package-CRM.zip is loaded`.
8. For the following steps on the Import overlay, click Next: 
    * **Upload**
    * **Confirm**
    * **Import Results**
9. For the **Policies** step on the **Import** overlay, click **Skip**. The **CRM 3.7** package is imported and listed on the **Packages** page. 
<br>![](img/t02_07_imported_pkg.png)
<br>[Description of the illustration t02_07_imported_pkg.png](files/t02_07_imported_pkg.txt)

## ![](../common/img/32_3.png) Import the Phone App ##

1. If you aren't logged in to your instance of Oracle Mobile Cloud Service, log in now.
2. Click ![The DEVELOPMENT menu](img/t02_01_dev_menu.png), and then click **Applications**.
3. On the **Applications** page, click **Mobile Apps**. 
4. On the **Mobile Application Accelerator** page, click **New Application** and follow the steps in the **New Application Wizard** to create a dummy app. 
5. On the **Mobile Application Accelerator** page, click **Import**. 
6. On the **Import Application** page, click **Upload a MAX application package file**. 
<br>![](img/t03_03_import_overlay.png)
<br>[Description of the illustration t03_03_import_overlay.png](files/t03_03_import_overlay.txt)
7. In the **Open File** dialog box, navigate to the path where you saved `package-CRM-phone-app.zip` and click **Open**. 
<br>![](img/t03_04_open_file_dialog.png)
<br>[Description of the illustration t03_04_open_file_dialog.png](files/t03_04_open_file_dialog.txt)
8. On the **Import** Application page, confirm that the following message appears: `package-CRM-phone-app.zip: loaded and validated`.
9. Click **Import**. The mobile app is opened in the **Application Designer** on the **Mobile Application Accelerator** page. 

## ![](../common/img/32_4.png) Create a Mobile Test User ##
In this section, you create a mobile test user in Oracle Mobile Cloud Service. This user is required to test your mobile app.
1. If you aren't logged in to your Mobile Cloud Service instance, log in now.
2. Click ![The DEVELOPMENT menu](img/t02_01_dev_menu.png), and then click Applications.
3. On the **DEVELOPMENT** menu, click **Mobile User Management**. 
4. On the **Mobile User Management** page, click **Users**, and then click **New User**. 
<br>![](img/t04_02_user_mgt.png)
<br>[Description of the illustration t04_02_user_mgt.png](files/t04_02_user_mgt.txt)
5. On the **New User** page, enter the values for the following fields, and then click **Create**: 
    * **Username**
    * **Email**
    * **First Name**
    * **Last Name**

After the mobile test user is created, you receive an email message containing the user name and temporary password.

## ![](../common/img/32_5.png) Test the Mobile App in Oracle Mobile Cloud Service ##

1. If you aren't logged in in your instance of Oracle Mobile Cloud Service, log in now.
2. Click ![The DEVELOPMENT menu](img/t02_01_dev_menu.png), and then click **Applications**.
3. On the **Applications** page, click **Mobile Apps**. 
4. On the **Mobile Application Accelerator** page, click **CRM-OBELAB** (the sample app that you imported). 
5. On the **Application Designer** page, click **Test** ![The Test icon](img/t03_00_test_icon.png).
6. Enter your mobile test user name and password and click **Sign In**. 
7. Explore the mobile app in a web browser. When you finish, click **Back to Designer**. 
<br>![](img/t05_02_test_app_browser.png)
<br>[Description of the illustration t05_02_test_app_browser.png](files/t05_02_test_app_browser.txt)

## ![](../common/img/32_6.png) Test the Mobile App on Your Mobile Phone ##

1. On the **Application Designer** page, click **Test on Phone**. 
2. Click **BUILD TEST APPLICATION**. Wait until your mobile app builds. 
3. On the **Web Test** page, confirm that the quick response (QR) code appears: 
<br>![](img/t06_03_qr_code.png)
<br>[Description of the illustration t06_03_qr_code.png](files/t06_03_qr_code.txt)
4. On your mobile phone, tap the **Oracle MAX** icon ![The Oracle MAX icon on an Android mobile phone](img/t06_04_phone_app_icon.png). 
5. In the app, tap the add **(+)** icon and search for a MAX-powered app. 
<br>![](img/t06_05_max.png)
<br>[Description of the illustration t06_05_max.png](files/t06_05_max.txt)
<br>The MAX QR scanner loads. 
6. Point your mobile phone at the test QR code and scan it with the QR code scanner. After it's scanned, wait until the **CRM-OBELAB** app is downloaded and installed. 
7. On the sign-in screen, enter your user name and password, and click **Sign In**. 
8. Explore the mobile app on your mobile phone. 
<br>![](img/t06_08_mobile_app.png)
<br>[Description of the illustration t06_08_mobile_app.png](files/t06_08_mobile_app.txt)

## ![](../common/img/32_more.png) Want to Learn More? ##

* [Oracle Mobile Cloud Service: Get Started](https://docs.oracle.com/en/cloud/paas/mobile-cloud/index.html)
* [Assign MCS Team Member Roles](http://docs.oracle.com/en/cloud/paas/mobile-cloud/mcsua/set-service.html#GUID-2916A6ED-BA67-41D2-A88A-65CC3E9E18AB)
* [Create a Mobile App in Record Time with MAX!](http://www.oracle.com/webfolder/technetwork/tutorials/cloud/max_crm/max.html)
