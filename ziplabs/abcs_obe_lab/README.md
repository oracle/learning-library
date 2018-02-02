# Developing a Business Application by Using Oracle Application Builder Cloud Service #

## ![](../common/img/32_begin.png) Before You Begin ##

This tutorial shows you how to quickly develop a business app by using Oracle Application Business Cloud Service. This tutorial takes approximately 15 minutes to complete.

### Background ###

Oracle Application Builder Cloud Service is a visual development tool for creating web and mobile apps by simply dragging and dropping user interface (UI) components onto a page. 

### What Do You Need? ###

* A desktop or laptop computer running Microsoft Windows 7 or later, Apple MacOS 10.9 or later, or Linux with a web browser
* Access to an instance of Oracle Application Builder Cloud Service

## ![](../common/img/32_1.png) Log In to Oracle Application Builder Cloud Service ##

1. Sign in to your Oracle Cloud account and change the temporary password, if you haven't already done so.
2. Log in to your Cloud instance.
3. Click **Dashboard**.
4. Click **Customize Dashboard**.
5. Select **Show** for **appbuilder** and close the dialog box.
6. In the **Application Builder** tile, click **Action** ![Action Menu](img/hamburger.png) and select **Open Service Console**.
<br>![](img/abcs-00.png)<br>
[Description of the illustration abcs-00.png](files/abcs-00.txt)

## ![](../common/img/32_2.png) Design the Application UI ##

1. On the **Oracle Application Builder Cloud Service** page, click **New Web Application**. 
2. On the **Create Application** page, enter `Books Tracker` in the **Application Name** field and click **Next**. 
3. In the **Application Template** field, select `Oracle Alta UI`, click **Next**, and then click **Finish**. 
4. From the main toolbar, click **Home** and then click **New Page**. 
5. In the **Create Page** wizard, in the **Page Title** field, enter `Book Catalog`, click **Edit**, and then click **Next**. 
<br>![](img/abcs-05.png)<br>
[Description of the illustration abcs-05.png](files/abcs-05.txt)
6. Click **New Business Object**, enter `Book_Catalog_BO` in the **Business Object Name** field, and click **Accept** ![Business object accept button](img/func_checkmark_16_ena.png). 
7. Click **Create** to save the changes.

## ![](../common/img/32_3.png) Add a Table Component to the Form ##

1. On the **Application Designer** page, in the **Filter Box** field of the components panel, enter `table`, and drag and drop the **table** component onto the **Book Catalog** form. 
<br>![](img/abcs-07.png)<br>
[Description of the illustration abcs-07.png](files/abcs-07.txt)
2. On the **Table Creation** Wizard page, select **Book_Catalog_BO** as the business object. 
<br>![](img/abcs-08.png)<br>
[Description of the illustration abcs-08.png](files/abcs-08.txt)
3. On the **Table Creation** Wizard page, click **New Field**. In the **New Field** dialog box, enter `Book Title` and click **finish** ![Accept button](img/func_checkmark_16_ena.png). Repeat these actions to add the `Author`, `ISBN`, and `Published Date` fields. 
4. In the **Available** list, drag and drop **Id** to the first position in the **Selected** list, and click **Finish**. 
<br>![](img/abcs-09.png)<br>
[Description of the illustration abcs-09.png](files/abcs-09.txt)
5. On the **Table Designer** page, click **Actions** (the hand icon) to open the list of available actions for the table.
6. On the **Application Designer** page, in the **Create Book_Catalog_BO** tile, click **Edit** ![Edit Action button](img/abcs-22.png). 
7. On the **Configure Action** page, in the **Save Book_Catalog_BO** tile, click **Remove this item (X)** to remove the save action. Click **Done**. 
8. On the **Application Designer** page, click **Test Application**![Test Application button](img/abcs-13.png) to run your web app on the **Runtime** page.
9. On your running **Book Catalog** web app page, click **Create**, enter the values for the following fields, and then click **Save and Close**: 
    * <code><strong>Book Title</strong>: Oracle ABCS For Beginners</code>
    * <code><strong>Author</strong>: Oracle Press</code>
    * <code><strong>ISBN</strong>: 123-456-789-0 </code>
    * <code><strong>Published Date</strong>: today's date </code>
    
The row is displayed in the books table on the **Book Catalog** page of your web app.
<br>![](img/abcs-12.png)<br>
[Description of the illustration abcs-12.png](files/abcs-12.txt)

## ![](../common/img/32_4.png) Complete and Test the App ##

1. On the **Runtime** page, click **Back To Designer**.
2. On the Application Designer page, click **Home**.
3. Clear **Filter**, click the picture component in the components panel, and then drag and drop it onto the Home page of your web app. 
<br>![](img/abcs-15.png)<br>
[Description of the illustration abcs-15.png](files/abcs-15.txt)
4. In the active window, click **select from Image Gallery**. 
5. On the **Image Gallery** tab, click **Application Menu**, click the **navi_library** image, and then click **Select**. 
<br>![](img/abcs-17.png)<br>
[Description of the illustration abcs-17.png](files/abcs-17.txt)
6. In the **Select from Image Gallery** dialog box, click **Create** ![Accept button](img/func_checkmark_16_ena.png). 
7. On the **Application Designer** page, click **Actions**, and then click **Add Action**. 
<br>![](img/abcs-18.png)<br>
[Description of the illustration abcs-18.png](files/abcs-18.txt)
8. On the **Configure Action** page, select **Navigate to Page** in the **Suggested** panel and drag and drop it onto the **THEN DO SOMETHING ELSE** section. 
<br>![](img/abcs-19.png)<br>
[Description of the illustration abcs-19.png](files/abcs-19.txt)
9. On the **Configure Action** page, select `Book Catalog` from the **Page to Open** drop-down list, and click **Done**. 
10. On the **Application Designer** page, click **Test Application** ![Test Application button](img/abcs-13.png). 
<br>Your running app should look like the following image:
<br>![](img/abcs-21.png)<br>
[Description of the illustration abcs-21.png](files/abcs-21.txt)


## ![](../common/img/32_more.png) Want to Learn More? ##
* Oracle Application Builder Cloud Service: Get Started

