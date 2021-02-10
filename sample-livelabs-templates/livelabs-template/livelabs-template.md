# LiveLabs Complete Template

*About this template: This file is used to demonstrate all of the features built into the LiveLabs conversion engine. Many of the features described here are optional and are so marked. Start with ![this Confluence page](https://confluence.oraclecorp.com/confluence/display/DBIDDP/Use+the+LiveLabs+Lab+Markdown+Template) and then follow it with ![this page](https://confluence.oraclecorp.com/confluence/display/DBIDDP/LiveLabs+Markdown+Template+New+Features+and+Fixed).*

## Introduction

*Describe the lab in one or two sentences, for example:* This lab walks you through the Steps to ...

*You may add an option video, using this format: [](youtube:YouTube video id)*

  [](youtube:zNKxJjkq0Pw)

Estimated Lab Time: n minutes

### Background
Enter background information here - this can include product information, or a technology overview, but also should cover what the workshop is about.

### Objectives

*List objectives for the lab - if this is the intro lab, list objectives for the workshop*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

*Use this section to describe any prerequisites, including Oracle Cloud accounts, set up requirements, etc.*

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

*This is the "fold" - below items are collapsed by default*

## **Step 1**: Standard LiveLabs image and text

<!-- Images -->

1. Standard method to include an image.

    ![](images/sample1.png)

    The image alt text is optional.

    ![image alt text](images/sample1.png)

2. Image with a link to the text description below it. This provides screen readers with an accessible way to "see" the image. The `sample1.txt` file must be added to the `files` folder.

    ![Image alt text](images/sample1.png "Image title")

3. Inline image icon ![Image alt text](images/sample2.png) click **Navigation**.

<!-- Text formatting -->

4. One example with bold **text**.

   If you add another paragraph, add 3 spaces before the beginning of the line to keep it in line with the numbered step.

5. Use tables sparingly:

 | Column 1 | Column 2 | Column 3 |
 | --- | --- | --- |
 | 1 | Some text or a link | More text  |
 | 2 |Some text or a link | More text |
 | 3 | Some text or a link | More text |

6. You can also include bulleted lists - make sure to indent 4 spaces:

   - List item 1
   - List item 2

7. Inline monospaced font is done with a single back ticks, for example `this is code`.

8. Code blocks are identified by three back ticks, indented to align with the step:

    ```
    This is a code block.
    ```

9. Use the copy function to allow your users to copy code snippets from LiveLabs into the clipboard.

    ```
  	<copy>Enclose the text you want to copy using the <copy> element.</copy>
    ```

10. Code snippets that include variables

  	```
    <copy>ssh -i <ssh-key-file></copy>
    ```

## **Step 2:** Optional Advanced features

<!-- files -->

1. Files that you want the reader to download:

  When the file type is not recognized by the browser, you can use this format:

  Download the [starter SQL code](files/starter-file.sql).

  When the file type is recognized by the browser, it will attempt to render it. So you can use this format to force the download dialog box:

  Download the [sample JSON code](files/sample.json?download=1).

  *Note: do not include zip files, CSV, PDF, PSD, JAR, WAR, EAR, bin or exe files - you must have those objects stored somewhere else. We highly recommend using Oracle Cloud Object Store and creating a PAR URL instead. See [Using Pre-Authenticated Requests](https://docs.cloud.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)*

2. You can also include a file in a copy block, or offer it as a download in a single Step. For example, download the [starter SQL code](files/starter-file.sql), or copy it from the block below:

    ```
    <copy>[](include:starter-file.sql)</copy>
    ```

  To support this feature, you need to specify the location of the files you are including in the manifest as key-value pairs:

    ```
    "workshoptitle": "The Title of the Workshop is defined in the manifest",
    "include": {"starter-file.sql":"../../data-load/files/starter-file.sql",
                "sample.json":"../../data-load/files/sample.json"},
    "tutorials": [
    ```

3. You can also inject Markdown files into your lab. For example, the next substep is injected from a file called `injected-step.md`:

[](include:injected-step.md)

<!-- images -->

3. You can override the default image scaling by applying manual controls over image sizes:

  No image sizing applied: `![](images/pic2.png)`

  ![](images/pic2.png)

  50% of the width and use auto height: `![](images/pic2.png =50%x*)`

  ![](images/pic2.png =50%x*)

  absolute width and height (500 pixel by 200 pixels): `![](./images/pic2.png =500x200)`

  ![](./images/pic2.png =500x200)

  50% for both width and height:  `![](./images/pic2.png =50%x50%)`

  ![](./images/pic2.png =50%x50%)


4. Conditional content example (type="livelabs")

    Select your compartment. <if type="livelabs">If you are using a LiveLabs environment, be sure to select the compartment provided by the environment. Leave Always Free unchecked,</if><if type="alwaysfree">Choose any compartment, select "Always Free",</if> and enter `SecretPassw0rd` for the ADMIN password, then click **Create Autonomous Database**.

    ![](images/atp-settings-1.png)
    <if type="livelabs">![](images/atp-settings-2-notaf.png)</if>
    <if type="alwaysfree">![](images/atp-settings-2.png)</if>
    ![](images/atp-settings-3.png)


5. This is an example of a segment of the Markdown file injected before rendering:

[](include:injected-step.md)

*At the conclusion of the lab add this statement:*
You may now [proceed to the next lab](#next).

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?  
<!-- optional: you can define a single support URL for a workshop in the manifest, for example:
"support": "https://community.oracle.com/tech/developers/categories/livelabsdiscussions",
-->
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
